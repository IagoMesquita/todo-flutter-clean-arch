import 'package:equatable/equatable.dart';

class ToDo extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool isDone;

  const ToDo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.isDone,
  });

  @override
  List<Object> get props => [id, title, description, createdAt, isDone];
}

// A entidade (Entity) na camada Domain representa um modelo de negócio puro, sem dependência de banco, framework ou Firebase.
// 'E a entidade do domínio, limpa, usada por Use Cases.

// extends [Equatable]	Faz com que objetos ToDo possam ser comparados por valor, e não por ponteiro
// get props => [...]	Define os atributos usados na comparação (==) e hashCode automaticamente

