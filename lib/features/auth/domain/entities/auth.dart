import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  
  final String uid;
  final String phoneNumer;

  Auth({
   required this.uid,
    required this.phoneNumer
  });


  
  
  @override
  List<Object> get props => [uid, phoneNumer];
  
}