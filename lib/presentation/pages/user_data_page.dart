import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({super.key});

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneControle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados do Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(46),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    !value!.contains('@') ? 'Informe um email valido' : null,
              ),
              TextFormField(
                controller: _phoneControle,
                decoration: const InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) =>
                    value!.length < 11 ? 'Telefone invalido' : null,
              ),
              const SizedBox(height: 26),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Salvar lógica aqui
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Dados atualizados')),
                    );
                  }
                },
                child: const Text('Editar'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Excluir conta (lógica futura)
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Apagar conta'),
                      content: const Text('Deseja realmente apagar sua conta?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Apagar conta lógica
                            Navigator.pop(context);
                          },
                          child: const Text('Apagar'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  'Apagar dados',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
