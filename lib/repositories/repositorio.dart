

import 'dart:convert';

import '../models/tarefa.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Repositorio{

    late SharedPreferences prefs;

  Future<void> salvarDados(List<Tarefa> tarefas) async {
    prefs = await SharedPreferences.getInstance();
    List<String> listaParaSalvar =[];
    for (Tarefa tarefa in tarefas){
      Map<String,String> json = Tarefa.paraJson(tarefa);
      String tarefaEmString = jsonEncode(json);
      listaParaSalvar.add(tarefaEmString);
    }
    prefs.setStringList("ListaDeTarefas", listaParaSalvar);
  }

  List<Tarefa> recuperarDados(){
    List<Tarefa> tarefas = [];
    return tarefas;
  }

}