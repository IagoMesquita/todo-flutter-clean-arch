import 'package:todo_clean_arch/data/models/todo_model.dart';
import 'package:todo_clean_arch/domain/entities/todo.dart';

extension TodoMapper on ToDoModel {
  // (Esse faz sentido)
  /// 🔁 Converte o model para a entidade do domínio
  ToDo toEntity() {
    return ToDo(
      id: id,
      title: title,
      description: description,
      createdAt: createdAt,
      isDone: isDone,

    );
  }
}

extension ToDoEntityMapper on ToDo {
  // Converte entidade para model, útil se quiser salvar no Firebase
  ToDoModel fromEntity(ToDo todo) {
    return ToDoModel(
      id: todo.id,
      title: todo.title,
      description: description,
      createdAt: createdAt,
      isDone: todo.isDone,
    );
  }
}
