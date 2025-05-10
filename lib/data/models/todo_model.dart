import 'package:todo_clean_arch/domain/entities/todo.dart';

class ToDoModel extends ToDo {
  const ToDoModel({
    required String id,
    required String title,
    required bool isDone,
  }) : super(id: id, title: title, isDone: isDone);

  factory ToDoModel.fromMap(Map<String, dynamic> map, String id) {
    return ToDoModel(
      id: id,
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone
    };
  }

  /// 🔁 Converte o model para a entidade do domínio
  ToDo toEntity() {
    return ToDo(
      id: id, 
      title: title,
      isDone: isDone
    );
  }

  /// (opcional) Converte entidade para model, útil se quiser salvar no Firebase
  // factory ToDoModel.fromEntity(ToDo todo) {
  //   return ToDoModel(
  //     id: todo.id,
  //     title: todo.title,
  //     isDone: todo.isDone,
  //   );
  // }
}

// Este model é responsável por converter entre Firebase/JSON e a entidade ToDo.

//🔁 Esse model será usado para conversar com o Firebase (ou outra fonte de dados).
// fromMap() lê os dados vindos do banco, toMap() prepara os dados para envio.

// ToDoModel é um Data Model, fica na camada data/, e faz conversão para/da entidade
// Nota: Equivalente a um DTO + Mapper, usado na camada data/ para ler e gravar dados no Firebase, BD...



// 🔁 2. E o fromMap/toMap? Seriam como fromEntity/toEntity?
// Exatamente!

// fromMap() → como fromDto() ou fromJson()

// toMap() → como toDto() ou toJson()

// Você poderia sim separar isso em Mappers puros se quisesse seguir mais fielmente o estilo Java. 
//Mas como em Dart/Flutter é comum usar factory constructors e métodos direto na classe Model, fica mais compacto.