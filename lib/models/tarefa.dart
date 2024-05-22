import 'dart:convert';

class Tarefa{
  Tarefa({required this.titulo, required this.realizado});

  String titulo;
  bool realizado;

  static Map<String,String> paraJson(Tarefa tarefa){
    Map<String,String> json =
    {
      "titulo":tarefa.titulo,
      "realizado":tarefa.realizado.toString(),
    };
    return json;
  }

  static Tarefa deJson (Map<String, dynamic> json){
    Tarefa tarefa = Tarefa(titulo: json["titulo"]!,
        realizado: json["realizado"]=="true"? true : false);
    return tarefa;
  }
}