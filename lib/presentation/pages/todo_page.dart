import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/data/repositories/todo_repository_impl.dart';
import 'package:todo_clean_arch/domain/entities/todo.dart';
import 'package:todo_clean_arch/domain/params/create_todo_params.dart';
import 'package:todo_clean_arch/domain/repositories/todo_repository.dart';
import 'package:todo_clean_arch/domain/usecases/add_todo.dart';
import 'package:todo_clean_arch/domain/usecases/delete_todo.dart';
import 'package:todo_clean_arch/domain/usecases/get_todos.dart';
import 'package:todo_clean_arch/domain/usecases/toggle_todo.dart';
import 'package:todo_clean_arch/presentation/cubit/todo_cubit.dart';
import 'package:todo_clean_arch/presentation/cubit/todo_state.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sua lista de tarefas'),
      ),
      body: BlocBuilder<ToDoCubit, ToDoState>(
        builder: (context, state) {
          if (state is ToDoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ToDoError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ToDoLoaded) {
            if (state.todos.isEmpty) {
              return const Center(
                child: Center(child: Text('Nenhum tarefa listada !')),
              );
            }

            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];

                return ListTile(
                  leading: Checkbox(
                    value: todo.isDone,
                    onChanged: (_) {
                      context.read<ToDoCubit>().toggleToDoCompletion(todo.id);
                    },
                  ),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration:
                          todo.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<ToDoCubit>().removeToDo(todo.id);
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink(); // estado inicial
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await _showAddDialog(context);
          // print('Nao tem texto: $title');
          if (title != null && title.trim().isNotEmpty) {
            // print('Tem texto: $title');
            context.read<ToDoCubit>().createToDos(CreateTodoParams(title));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<String?> _showAddDialog(BuildContext context) async {
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nova tarefa'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Digite o titulo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
