class UserModel {
  String email;
  String username;
  String gender;
  String address;
  String password;
  String retypePassword;

  UserModel({
    this.email,
    this.username,
    this.gender,
    this.address,
    this.password, //TODO:Hash the password
    this.retypePassword,
  });
}
