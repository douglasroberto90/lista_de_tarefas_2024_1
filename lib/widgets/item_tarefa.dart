import 'package:flutter/material.dart';

class ItemTarefa extends StatefulWidget {
  ItemTarefa({required this.nomeTarefa, super.key});

  String nomeTarefa;

  @override
  State<ItemTarefa> createState() => _ItemTarefaState();
}

class _ItemTarefaState extends State<ItemTarefa> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.error),
          Text(widget.nomeTarefa),
          Checkbox(value: false, onChanged: (bool){} ),
        ],
      ),
    );
  }
}
