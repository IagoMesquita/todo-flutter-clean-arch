import 'package:flutter/material.dart';
import 'package:todo_clean_arch/domain/entities/todo.dart';

class ToDoDetailPage extends StatelessWidget {
  final ToDo todo;

  const ToDoDetailPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Descrição:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(todo.description.isEmpty ? 'Sem descrição' : todo.description),
            const SizedBox(height: 12),
            Text(
              'Criado em: ${_formatDate(todo.createdAt)}',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(value: todo.isDone, onChanged: null),
                Text(todo.isDone ? 'Concluida' : 'Pendente'),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Data desconecida';

    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
