import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/data/repositories/todo_repository_impl.dart';
import 'package:todo_clean_arch/domain/repositories/todo_repository.dart';
import 'package:todo_clean_arch/domain/usecases/add_todo.dart';
import 'package:todo_clean_arch/domain/usecases/delete_todo.dart';
import 'package:todo_clean_arch/domain/usecases/get_todos.dart';
import 'package:todo_clean_arch/domain/usecases/toggle_todo.dart';
import 'package:todo_clean_arch/presentation/cubit/todo_cubit.dart';
import 'package:todo_clean_arch/presentation/pages/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;
  final ToDoRepository repository = ToDoRepositoryImpl(firestore);

  runApp(
    BlocProvider(
      create: (_) => ToDoCubit(
        getToDos: GetToDos(repository),
        addToDo: AddToDo(repository),
        toggleToDo: ToggleToDo(repository),
        deleteToDo: DeleteToDo(repository),
      )..fetchToDos(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ToDoPage(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
