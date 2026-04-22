import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List lista = [];
  int index = 0;
  bool mostrarMenu = false;

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    final jsonString = await rootBundle.loadString(
      'assets/mockup/funcionarios.json',
    );

    final data = json.decode(jsonString);

    setState(() {
      lista = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (lista.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final f = lista[index];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Funcionários"),
        backgroundColor: const Color.fromARGB(255, 15, 38, 88), // azulPrincipal
      ),
      body: Container(
        color: const Color.fromARGB(255, 248, 250, 252), // fundo
        child: Column(
          children: [
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                setState(() {
                  mostrarMenu = !mostrarMenu;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255), // branco
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(blurRadius: 8, color: Colors.black12),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      f["nome"],
                      style: const TextStyle(
                        color: Color.fromARGB(255, 51, 65, 85), // texto
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 25, 63, 144),
                    ),
                  ],
                ),
              ),
            ),

            if (mostrarMenu)
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 226, 232, 240), // borda
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10, color: Colors.black12),
                  ],
                ),
                child: SizedBox(
                  height: 200,
                  child: ListView(
                    children: List.generate(lista.length, (i) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        title: Text(
                          lista[i]["nome"],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 51, 65, 85),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            index = i;
                            mostrarMenu = false;
                          });
                        },
                      );
                    }),
                  ),
                ),
              ),
            const SizedBox(height: 20),

            Card(
              color: const Color.fromARGB(255, 255, 255, 255), // branco
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.all(60),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        f["avatar"],
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      f["nome"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 30, 64, 175), // azulEscuro
                      ),
                    ),

                    Text(
                      f["cargo"],
                      style: const TextStyle(
                        color: Color.fromARGB(255, 51, 65, 85),
                      ),
                    ),
                    Text(
                      "R\$ ${f["salario"]}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 37, 99, 235),
                      ),
                    ),
                    Text(
                      "Contratado em: ${f["dataContatacao"]}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 51, 65, 85),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 37, 99, 235),
                  ),
                  onPressed: index > 0 ? () => setState(() => index--) : null,
                  child: const Text("Anterior"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 37, 99, 235),
                  ),
                  onPressed: index < lista.length - 1
                      ? () => setState(() => index++)
                      : null,
                  child: const Text("Próximo"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
