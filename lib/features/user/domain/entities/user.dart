import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String phoneNumber; 
  final String? name;
  final String? email;

  const User({
    required this.uid,
    required this.phoneNumber,
    this.name,
    this.email
  });

  @override
  List<Object?> get props => [uid, phoneNumber, name, email]; 
  
}