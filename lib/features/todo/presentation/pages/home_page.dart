import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo_clean_arch/features/todo/domain/usecases/add_todo.dart';
import 'package:todo_clean_arch/features/todo/domain/usecases/delete_todo.dart';
import 'package:todo_clean_arch/features/todo/domain/usecases/get_todos.dart';
import 'package:todo_clean_arch/features/todo/domain/usecases/toggle_todo.dart';
import 'package:todo_clean_arch/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:todo_clean_arch/features/todo/presentation/pages/perfil_page.dart';
import 'package:todo_clean_arch/features/todo/presentation/pages/todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    final firestore = FirebaseFirestore.instance;
    final repository = ToDoRepositoryImpl(firestore);

    final todoCubit = ToDoCubit(
      getToDos: GetToDos(repository),
      addToDo: AddToDo(repository),
      toggleToDo: ToggleToDo(repository),
      deleteToDo: DeleteToDo(repository),
    )..fetchToDos();

    _pages = [
      BlocProvider<ToDoCubit>.value(
        value: todoCubit,
        child: const ToDoPage(),
      ),
      const PerfilPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) => setState(() => _currentIndex = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil')
        ],
      ),
    );
  }
}
