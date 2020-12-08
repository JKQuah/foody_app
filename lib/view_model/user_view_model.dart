import 'package:foody_app/model/user_model.dart';

class UserViewModel {
  UserModel _userModel;

  UserViewModel({UserModel user}) : _userModel = user;

  String get email {
    return _userModel.email;
  }

  String get username {
    return _userModel.username;
  }

  String get gender {
    return _userModel.gender;
  }

  String get address {
    return _userModel.address;
  }

  String get password {
    return _userModel.password;
  }
}
