import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/domain/usecases/params/create_todo_params.dart';
import 'package:todo_clean_arch/presentation/cubit/todo_cubit.dart';
import 'package:todo_clean_arch/presentation/cubit/todo_state.dart';
import 'package:todo_clean_arch/presentation/pages/todo_detail_page.dart';

import 'package:todo_clean_arch/data/repositories/todo_repository_impl.dart';
import 'package:todo_clean_arch/domain/repositories/todo_repository.dart';
import 'package:todo_clean_arch/domain/usecases/add_todo.dart';
import 'package:todo_clean_arch/domain/usecases/delete_todo.dart';
import 'package:todo_clean_arch/domain/usecases/get_todos.dart';
import 'package:todo_clean_arch/domain/usecases/toggle_todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final repository = ToDoRepositoryImpl(firestore);
    
    return BlocProvider(
        create: (_) => ToDoCubit(
              getToDos: GetToDos(repository),
              addToDo: AddToDo(repository),
              toggleToDo: ToggleToDo(repository),
              deleteToDo: DeleteToDo(repository),
            )..fetchToDos(),
        child: Scaffold(
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ToDoDetailPage(todo: todo),
                          ),
                        );
                      },
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (_) {
                          context
                              .read<ToDoCubit>()
                              .toggleToDoCompletion(todo.id);
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
              if (newTodo != null &&
                  newTodo['title']!.isNotEmpty &&
                  newTodo['description']!.isNotEmpty) {
                context.read<ToDoCubit>().createToDos(
                      CreateTodoParams(
                        title: newTodo['title']!,
                        description: newTodo['description']!,
                      ),
                    );
              }
            },
            child: const Icon(Icons.add),
          ),
        ));
  }

  Future<Map<String, String>?> _showAddDialog(BuildContext context) async {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nova tarefa'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, {
              'title': titleController.text,
              'description': descriptionController.text
            }),
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
