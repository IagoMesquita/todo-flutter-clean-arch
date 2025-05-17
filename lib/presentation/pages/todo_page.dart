import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/data/repositories/todo_repository_impl.dart';
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
    final firestore = FirebaseFirestore.instance;
    final ToDoRepository repository = ToDoRepositoryImpl(firestore);
    
    return BlocProvider(
      create: (_) => ToDoCubit(

        getToDos: GetToDos(repository),
        addToDo: AddToDo(repository),
        toggleToDo: ToggleToDo(repository),
        deleteToDo: DeleteToDo(repository),
      )..fetchToDos(),
      child: Scaffold(
        
      ),
    );
  }
}
