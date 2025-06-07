import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_clean_arch/features/auth/presentation/cubit/auth_state.dart';
import 'package:todo_clean_arch/features/auth/presentation/pages/pin_page.dart';
import 'package:todo_clean_arch/features/todo/presentation/pages/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkAuhStatus();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthCodeSent) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PinPage(verificationId: state.verificationId),
            ),
          );
        } else if (state is AuthAuthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
            (_) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Sua ToDo',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Numero de telefone',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o numero';
                        } else if (!RegExp(r'^\d{2}9\d{8}$').hasMatch(value)) {
                          return 'Numero invalido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().requestPhoneCode(
                                _phoneNumberController.text.trim(),
                              );
                        }
                      },
                      child: const Text('Continuar'),
                    ),
                    if (state is AuthError)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
