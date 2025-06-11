import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/features/auth/data/repositories/auth_repostory_impl.dart';
import 'package:todo_clean_arch/features/auth/domain/repositories/auth_repository.dart';
import 'package:todo_clean_arch/features/auth/domain/usecases/get_current_user.dart';
import 'package:todo_clean_arch/features/auth/domain/usecases/logout.dart';
import 'package:todo_clean_arch/features/auth/domain/usecases/send_phone_code.dart';
import 'package:todo_clean_arch/features/auth/domain/usecases/verify_code.dart';
import 'package:todo_clean_arch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_clean_arch/features/auth/presentation/pages/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authRepository = AuthRepositoryImpl(
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
  );

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(
        getCurrentUserUseCase: GetCurrentUserUseCase(authRepository),
        sendPhoneCodeUseCase: SendPhoneCodeUseCase(authRepository),
        verifyCodeUseCase: VerifyCodeUseCase(authRepository),
        logoutUseCase: LogoutUseCase(authRepository),
      )..checkAuhStatus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthPage(),
      ),
    );
  }
}
