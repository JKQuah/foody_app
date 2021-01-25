import 'package:flutter/material.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/services/authService.dart';
import 'package:foody_app/view/indexView.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 3,
                child: Center(
                  child: Image(
                    image: AssetImage("assets/app_logo.png"),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: AppConstants.EMAIL_LABEL,
                    contentPadding: const EdgeInsets.all(16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          color: AppColors.PRIMARY_COLOR, width: 1.5),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppConstants.EMAIL_ERROR_MSG;
                    } else {
                      this.email = value;
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: AppConstants.PASSWORD_LABEL,
                    contentPadding: const EdgeInsets.all(16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          color: AppColors.PRIMARY_COLOR, width: 1.5),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppConstants.PASSWORD_ERROR_MSG;
                    } else {
                      this.password = value;
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: AppColors.ACCENT_COLOR,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Center(
                child: FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      Map<String, String> login =
                          await AuthService().login(email, password);
                      print(login['tokens']);
                      if (login['token'] != "false") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyHomePage(token: login['token'])),
                        );
                      } else {
                        print("error");
                      }
                    } else {
                      print("missing");
                    }
                  },
                  child: Text(
                    AppConstants.LOGIN_BUTTON_LABEL,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  color: AppColors.PRIMARY_COLOR,
                  height: 50.0,
                  minWidth: 200.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(""),
              )
            ],
          ),
        ),
      ),
    );
  }
}
