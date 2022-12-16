import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homestay_raya/registrationscreen.dart';
import 'package:homestay_raya/splashscreen.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  var screenHeight, screenWidth, cardwitdh;

  get User => null;

  get _goLogin => null;

  get _goHome => null;

  @override
  void initState() {
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      cardwitdh = screenWidth;
    } else {
      cardwitdh = 400.00;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
          child: SingleChildScrollView(
              child: SizedBox(
        width: cardwitdh,
        child: Column(
          children: [
            Card(
                elevation: 8,
                margin: const EdgeInsets.all(8),
                child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                            controller: _emailEditingController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) => val!.isEmpty ||
                                    !val.contains("@") ||
                                    !val.contains(".")
                                ? "enter a valid email"
                                : null,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(),
                                icon: Icon(Icons.email),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.0),
                                ))),
                        TextFormField(
                            controller: _passEditingController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(),
                              icon: Icon(Icons.password),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.0),
                              ),
                            )),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                  saveremovepref(value);
                                });
                              },
                            ),
                            Flexible(
                              child: GestureDetector(
                                onTap: null,
                                child: const Text('Remember Me',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              minWidth: 115,
                              height: 50,
                              elevation: 10,
                              onPressed: _loginUser,
                              color: Theme.of(context).colorScheme.primary,
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ]),
                    ))),
            GestureDetector(
              onTap: _goLogin,
              child: const Text(
                "No account? Create One",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: _goHome,
              child: const Text("Go back Home", style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ))),
    );
  }

  void _loginUser() {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in the login credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }

    String _email = _emailEditingController.text;
    String _pass = _passEditingController.text;
    http.post(Uri.parse("${Config.SERVER}/php/login_user.php"),
        body: {"email": _email, "password": _pass}).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        var user = User.fromJson(jsonResponse['data']);
        print(user.phone);
        //User user = User(id: jsonResponse['data']['name'],email: jsonResponse['email'],name: "",phone: "",address: "",regdate: "");
        Navigator.push(context,
            MaterialPageRoute(builder: (content) => splashScreen(user: user)));
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
    });
  }

  void loadPref() {}

  void saveremovepref(bool value) {}
}
