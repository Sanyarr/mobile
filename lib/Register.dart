import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanyar/userManagement.dart';
import 'enrollmentPage.dart';
import 'page2.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ));
  }

  Future register() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      _showSnackBar("Please fill in all fields.");
      return;
    }

    if (!EmailValidator.validate(email.text)) {
      _showSnackBar("Please enter a valid email address.");
      return;
    }

    var url = Uri.parse("http://192.168.56.1/mobileproject/register.php");
    var response = await http.post(url, body: {
      "email": email.text,
      "password": password.text,
    });

    print(response.body);

    var data = json.decode(response.body);
    if (data is List<dynamic>) {
      if (data.contains("Success")) {
        _showSnackBar("Registration successful");
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
          return enrollmentPage(userEmail: email.text);
        }));
      } else {
        _showSnackBar("Unexpected response format. Please try again.");
      }
    } else {
      if (data.containsKey("error")) {
        _showSnackBar(data["error"]);
      } else if (data.containsKey("success")) {
        _showSnackBar(data["success"]);
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
          return enrollmentPage(userEmail: email.text);
        }));
      }
    }
  }

  Future login() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      _showSnackBar("Please fill in all fields.");
      return;
    }

    if (!EmailValidator.validate(email.text)) {
      _showSnackBar("Please enter a valid email address.");
      return;
    }

    var url = Uri.parse("http://192.168.56.1/mobileproject/login.php");
    var response = await http.post(url, body: {
      "email": email.text,
      "password": password.text,
    });

    var data = json.decode(response.body);
    if (data.containsKey("status") && data["status"] == "Success") {
      String role = data["role"];
      _showSnackBar("Login successful as $role");

      if (role == "admin") {
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
          return userManagement();
        }));
      } else {
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
          return page2();
        }));
      }
    } else {
      _showSnackBar("Invalid email or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text(
          'Welcome to our fitness app, please login or signup to continue',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/background3.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[200]?.withOpacity(0.7),
          ),
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Welcome',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle:
                        TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black),
                        ),
                      ),
                      controller: email,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black), // Change the color to your desired color
                        ),
                      ),
                      controller: password,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),),
                            elevation: 50.0,
                            hoverColor: Colors.grey[850],
                            color: Colors.grey[700],
                            child: Text('Register',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            onPressed: () {
                              register();
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),),
                            elevation: 50.0,
                            hoverColor: Colors.grey[850],
                            color: Colors.grey[700],
                            child: Text('Login',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            onPressed: () {
                              login();
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}