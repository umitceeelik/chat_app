import 'package:chat_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String username,
    required String email,
    required String token,
    required String profileImage,
  }) : super(
          id: id,
          username: username,
          email: email,
          token: token,
          profileImage: profileImage,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      token: json['token'] ?? '',
      profileImage: json['profile_image'] ?? 'https://randomuser.me/api/portraits/men/11.jpg',
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'username': username,
  //     'email': email,
  //   };
  // }
}