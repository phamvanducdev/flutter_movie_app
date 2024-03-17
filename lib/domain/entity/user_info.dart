import 'package:flutter_movie_app/data/dto/user_dto.dart';

class UserInfo {
  final String uid;
  final String? email;
  final String? displayName;

  UserInfo({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  factory UserInfo.fromUserDto(UserDto dto) => UserInfo(
        uid: dto.uid,
        email: dto.email,
        displayName: dto.displayName,
      );
}
