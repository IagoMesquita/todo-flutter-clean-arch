



import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String phoneNumber;
  final String? name;
  final String? email;

  const UserModel({
    required this.uid,
    required this.phoneNumber,
    this.name,
    this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      name: map['name'],
      email: map['email'],
    );
  }

  Map<String, dynamic>toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email
    };
  }
factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
  final data = doc.data();
  if (data == null) {
    throw StateError('Documento do usuário com id ${doc.id} está vazio.');
  }
  return UserModel.fromMap(data);
}
}
