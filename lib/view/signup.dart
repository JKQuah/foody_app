import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foody_app/view/login.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/view/loginView.dart';
import 'package:foody_app/view/user/createProfile.dart';
import 'package:http/http.dart';

import '../resource/app_colors.dart';
import '../utils/HTTPUtils.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String _signupusername;
  String _signupemail;
  String _signuppassword;
  String _signupconfirmpassword;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static final String signupURL = AppConstants.baseURL + "/users";

  final TextEditingController suemailCtl = TextEditingController();
  final TextEditingController suusernameCtl = TextEditingController();
  final TextEditingController supassCtl = TextEditingController();
  final TextEditingController suconfirmpassCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 35.0),
                SizedBox(
                  height: 135.0,
                  child: Image.asset(
                    "assets/app_logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty.';
                      }
                      if (value.contains('@')) {
                        return null;
                      }
                      return 'Please enter valid email address';
                    },
                    onSaved: (value) => _signupemail = value,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email Address")),
                SizedBox(height: 10.0),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty.';
                      }
                      if (value.contains('abcd')) {
                        return 'Username has been taken up. Please enter another username.';
                      }
                      return null;
                    },
                    onSaved: (value) => _signupusername = value,
                    decoration: InputDecoration(labelText: "New Username")),
                SizedBox(height: 10.0),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty.';
                      }
                      return null;
                    },
                    onSaved: (value) => _signuppassword = value,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "New Password")),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field cannot be empty.';
                    } else if (value != _signuppassword) {
                      return 'Please enter the same password as above';
                    }
                    return null;
                  },
                  onSaved: (value) => _signupconfirmpassword = value,
                  obscureText: true,
                  decoration:
                      InputDecoration(labelText: "Confirm New Password"),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                    color: AppColors.PRIMARY_COLOR,
                    child: Text(
                      AppConstants.SIGNUP_BUTTON_LABEL,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    height: 50.0,
                    minWidth: 200.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () async {
                      // save the fields..
                      final form = _formKey.currentState;
                      form.save();

                      String requestUrl = signupURL;
                      Map<String, String> headers =
                          await HTTPUtils.getHeaders();
                      headers["Content-Type"] =
                          'application/json; charset=UTF-8';
                      Response res = await post(
                        requestUrl,
                        headers: headers,
                        body: jsonEncode(<String, String>{
                          "email": _signupemail,
                          "username": _signupusername,
                          "password": _signuppassword
                        }),
                      );
                      dynamic body = jsonDecode(res.body);
                      if (res.statusCode == 201) {
                        // ignore: deprecated_member_use
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            backgroundColor: AppColors.ACCENT_COLOR,
                            content: Text(
                                "Account has been successfully created!")));
                        HTTPUtils.saveJWToken(body['token']);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileCreate()),
                        );
                        // throw Exception("Error at Login");
                        suemailCtl.text = "";
                        suusernameCtl.text = "";
                        supassCtl.text = "";
                        suconfirmpassCtl.text = "";
                      } else if (res.statusCode == 400) {
                        Map<String, dynamic> json = jsonDecode(res.body);
                        String errMsg = (json["error"] as String);
                        print(123123);
                        print(errMsg);
                        // wrong password
                        suemailCtl.text = "";
                        suusernameCtl.text = "";
                        supassCtl.text = "";
                        suconfirmpassCtl.text = "";
                        // ignore: deprecated_member_use
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            backgroundColor: AppColors.DANGER_COLOR,
                            content: Text(errMsg)));
                      } else {
                        // throw Exception("Error at Login");
                        suemailCtl.text = "";
                        suusernameCtl.text = "";
                        supassCtl.text = "";
                        suconfirmpassCtl.text = "";
                      }
                    }),
                Divider(),
                FlatButton(
                  color: AppColors.ACCENT_COLOR,
                  child: Text(
                    AppConstants.LOGIN_BUTTON_LABEL,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                  height: 50.0,
                  minWidth: 200.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
