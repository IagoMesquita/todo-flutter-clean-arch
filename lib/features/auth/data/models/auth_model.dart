class AuthModel {
  final String uid;
  final String phoneNumer;

  AuthModel({
    required this.uid,
    required this.phoneNumer,
  });

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      uid: map['uid'] ?? '',
      phoneNumer: map['phoneNumber'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'phoneNumber': phoneNumer};
  }
}
