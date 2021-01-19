class UserModel {
  String email;
  int id;
  String imageUrl;
  String username;
  String gender;
  String address;
  String password;
  String retypePassword;

  UserModel({
    this.email,
    this.id,
    this.imageUrl,
    this.username,
    this.gender,
    this.address,
    this.password, //TODO:Hash the password
    this.retypePassword,
  });
}
