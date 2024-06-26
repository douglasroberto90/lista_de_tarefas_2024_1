import 'dart:convert';
import '../models/tarefa.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<List<Tarefa>> recuperarDados() async {
    prefs = await SharedPreferences.getInstance();
    List<Tarefa> tarefas = [];
    List<String>? tarefasEmString = prefs.getStringList('ListaDeTarefas');
    if (tarefasEmString!=null){
      for (String tarefa in tarefasEmString){
        Map<String,dynamic> json = jsonDecode(tarefa);
        //tarefas.add(Tarefa.deJson(json));
        Tarefa task = Tarefa.deJson(json);
        tarefas.add(task);
      }
    }
    return tarefas;
  }

}