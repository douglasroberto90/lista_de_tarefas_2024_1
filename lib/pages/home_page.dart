import 'package:flutter/material.dart';
import 'package:lista_de_tarefas_2024_1/repositories/repositorio.dart';
import '../models/tarefa.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tarefa> tarefas = [];
  TextEditingController controllerTarefa = TextEditingController();
  Repositorio rep = Repositorio();

  @override
  void initState() {
    super.initState();
    rep.recuperarDados().then((dados) => setState(() {
          tarefas = dados;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista de tarefas"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: controllerTarefa,
                    decoration: const InputDecoration(
                      label: Text("Nova tarefa"),
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Tarefa tarefa = Tarefa(
                              titulo: controllerTarefa.text, realizado: false);
                          tarefas.add(tarefa);
                          controllerTarefa.clear();
                          rep.salvarDados(tarefas);
                        });
                      },
                      child: const Text("ADD")),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: tarefas.length, itemBuilder: contruirItem),
            ),
          ],
        ));
  }

  Widget contruirItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        decoration: const BoxDecoration(color: Colors.red),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: Icon(Icons.delete, color: Colors.white,),
          ),
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          Tarefa tarefaRemovida = tarefas[index];
          int indiceDaTarefaRemovida = index;
          tarefas.removeAt(index);
          rep.salvarDados(tarefas);
          final snackBar = SnackBar(
            content: Text("A tarefa ${tarefaRemovida.titulo} foi apagada"),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(label: "Desfazer",
                onPressed: (){
              setState(() {
                tarefas.insert(indiceDaTarefaRemovida, tarefaRemovida);
                rep.salvarDados(tarefas);
              });
            }
            ),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });

      },
      child: CheckboxListTile(
          secondary:
              tarefas[index].realizado ? const Icon(Icons.check) : const Icon(Icons.error),
          title: Text(tarefas[index].titulo),
          value: tarefas[index].realizado,
          onChanged: (checked) {
            setState(() {
              tarefas[index].realizado = checked!;
              rep.salvarDados(tarefas);
            });
          }),
    );
  }
}
