import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/tarefa.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tarefa> tarefas = [];
  TextEditingController controllerTarefa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de tarefas"),
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
                    decoration: InputDecoration(
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
                        });
                      },
                      child: Text("ADD")),
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
      child: CheckboxListTile(
          secondary:
              tarefas[index].realizado ? Icon(Icons.check) : Icon(Icons.error),
          title: Text(tarefas[index].titulo),
          value: tarefas[index].realizado,
          onChanged: (checked) {
            setState(() {
              tarefas[index].realizado = checked!;
            });
          }),
      direction: DismissDirection.startToEnd,
      background: Container(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete),),
        decoration: BoxDecoration(color: Colors.red),
      ),
      onDismissed: (direction) {
        setState(() {
          tarefas.removeAt(index);
        });
      },
    );
  }
}
