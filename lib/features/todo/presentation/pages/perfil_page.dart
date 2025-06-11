import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_clean_arch/features/auth/presentation/cubit/auth_state.dart';
import 'package:todo_clean_arch/features/auth/presentation/pages/auth_page.dart';
import 'package:todo_clean_arch/features/todo/presentation/pages/about_page.dart';
import 'package:todo_clean_arch/features/todo/presentation/pages/user_data_page.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      if (state is AuthLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: const Text('Dados do Usuario'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const UserDataPage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: const Text('Sobre'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutPage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<AuthCubit>().singOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthPage()),
                    (_) => false,
                  );
                  print('Botao Sair');
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sair'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red),
              )
            ],
          ),
        ),
      );
    });
  }
}
