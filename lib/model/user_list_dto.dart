class UserListDTO{
  int id;
  String username;
  String imageUrl;

  UserListDTO({
    this.id,
    this.username,
    this.imageUrl,
});

  factory UserListDTO.fromJson(Map<String, dynamic> json) {
    return UserListDTO(
      id: json['id'] as int,
      username: json['username'] as String,
      imageUrl: json['media_link'] as String
    );
  }


}