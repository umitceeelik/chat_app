
class UserEntity {
  final String id;
  final String email;
  final String username;
  final String token;
  final String profileImage;

  UserEntity({
    required this.id,
    required this.email,
    required this.username,
    this.token = '',
    required this.profileImage,
  });
  
}