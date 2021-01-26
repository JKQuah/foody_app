import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foody_app/view/signup.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/view/homeView.dart';
import 'package:http/http.dart';

import '../resource/app_colors.dart';
import '../utils/HTTPUtils.dart';
import 'homeView.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;
  static final String loginURL = AppConstants.baseURL + "/users/login";

  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController passCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Builder(builder: (BuildContext context) {
          return new Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 85.0),
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "assets/app_logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 65.0),
                  TextFormField(
                      controller: emailCtl,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field cannot be empty.';
                        }
                        if (value.contains('@')) {
                          return null;
                        }
                        return 'Please enter correct email address';
                      },
                      onSaved: (value) => _email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email Address")),
                  SizedBox(height: 15.0),
                  TextFormField(
                      controller: passCtl,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field cannot be empty.';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password")),
                  RaisedButton(
                      child: Text("LOGIN"),
                      onPressed: () async {
                        // save the fields..
                        final form = _formKey.currentState;
                        form.save();

                        String requestUrl = loginURL;
                        Map<String, String> headers =
                            await HTTPUtils.getHeaders();
                        headers["Content-Type"] =
                            'application/json; charset=UTF-8';
                        Response res = await post(
                          requestUrl,
                          headers: headers,
                          body: jsonEncode(<String, String>{
                            "email": _email,
                            "password": _password
                          }),
                        );
                        if (res.statusCode == 200) {
                          Map<String, dynamic> json = jsonDecode(res.body);
                          //save token
                          HTTPUtils.saveJWToken(json["token"]);
                          // navigate to home page
                          //need to ask quah
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => HomeView()),
                          );
                        } else if (res.statusCode == 400) {
                          // wrong password
                          emailCtl.text = "";
                          passCtl.text = "";
                          Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: AppColors.DANGER_COLOR,
                              content: Text(
                                  "The email address or password are entered wrongly! Please try again.")));
                        } else {
                          // throw Exception("Error at Login");
                          emailCtl.text = "";
                          passCtl.text = "";
                        }
                      }),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                      child: Text("SignUp / Register with Us"),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      }),
                ],
              ),
            ),
          );
        }));
  }
}
