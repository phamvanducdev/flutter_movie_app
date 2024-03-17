import 'package:firebase_auth/firebase_auth.dart';

class UserDto {
  final String uid;
  final String? email;
  final String? displayName;

  UserDto({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  factory UserDto.fromAuthUser(User user) {
    return UserDto(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
    );
  }

  factory UserDto.fromMap(Map<String, dynamic> json) {
    return UserDto(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
    );
  }
  Map<String, dynamic> toMap() => {
        'uid': uid,
        'email': email,
        'displayName': displayName,
      };
}
