import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/domain/usecases/params/create_todo_params.dart';
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
          final newTodo = await _showAddDialog(context);
          // print('Nao tem texto: $title');
          if (newTodo != null &&
              newTodo['title']!.isEmpty &&
              newTodo['description']!.isEmpty) {
            // print('Tem texto: $title');
            context.read<ToDoCubit>().createToDos(
                  CreateTodoParams(
                    title: newTodo['title']!,
                    description: newTodo['descriptio']!,
                  ),
                );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Map<String, String>?> _showAddDialog(BuildContext context) async {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nova tarefa'),
        content: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Digite o titulo'),
            ),
            TextField(
              controller: descriptionController,
              decoration:
                  const InputDecoration(hintText: 'Descreva sua tarega'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(
                context, {titleController.text, descriptionController.text}),
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
