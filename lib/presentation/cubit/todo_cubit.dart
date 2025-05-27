import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/domain/usecases/params/create_todo_params.dart';
import 'package:todo_clean_arch/domain/usecases/add_todo.dart';
import 'package:todo_clean_arch/domain/usecases/delete_todo.dart';
import 'package:todo_clean_arch/domain/usecases/get_todos.dart';
import 'package:todo_clean_arch/domain/usecases/toggle_todo.dart';
import 'package:todo_clean_arch/presentation/cubit/todo_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  final GetToDos getToDos;
  final AddToDo addToDo;
  final ToggleToDo toggleToDo;
  final DeleteToDo deleteToDo;

  ToDoCubit({
    required this.getToDos,
    required this.addToDo,
    required this.toggleToDo,
    required this.deleteToDo,
  }) : super(ToDoInitial());

  Future<void> fetchToDos() async {
    emit(ToDoLoading());

    try {
      final todos = await getToDos();
      emit(ToDoLoaded(todos));
    } catch (e) {
      print(e);
      emit(ToDoError('Error ao carragar as tarefas'));
    }
  }

  Future<void> createToDos(CreateTodoParams todoParams) async {
    try {
      await addToDo(todoParams);
      await fetchToDos(); //atualiza a lista
    } catch (e) {
      print(e);
      emit(ToDoError('Error ao adicionar tarefa'));
    }
  }

  Future<void> removeToDo(String id) async {
    try {
      await deleteToDo(id);
      await fetchToDos();
    } catch (e) {
      print(e);
      emit(ToDoError('Error ao deletar uma tareda de ID: $id'));
    }
  }

  Future<void> toggleToDoCompletion(String id) async {
    try {
      await toggleToDo(id);
      await fetchToDos();
    } catch (e) {
      print(e);
      emit(ToDoError('Erro ao atualizar a tareda'));
    }
  }
}
