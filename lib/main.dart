import 'dart:convert';

import 'package:flutter/material.dart';

// import http.dart plugin that was previously entered into pubspec.yaml
import 'package:http/http.dart' as http;
import 'package:login_siswa/admin.dart';
import 'package:login_siswa/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Flutter",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // variable for saving data from data json which derive from php code in the file login.php
  late String username, password, status;
  
  String alert = "Ready for Login";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();

  // method for login process
  void loginProcess() async {

    if(_formKey.currentState!.validate()){
      // 10.0.2.2 is ip address from android studio's emulator

      var response;
      var dataUser = json.decode(response.body);

      if(dataUser.length < 1){
        // if data user is empty or 0
        setState(() {
          alert = "You can't login";
        });
      }else{
        setState(() {
          username = dataUser[0]["username"];
          password = dataUser[0]["password"];
          status = dataUser[0]["status"];
        });

        // move the page according to user status
        if(status == "admin"){
          // use navigator push replacement so that user can not go back to login page
          Navigator.pushReplacement(context, 
            MaterialPageRoute(builder: (context) => Admin(username: username,))
          );
        }else{
          Navigator.pushReplacement(context, 
            MaterialPageRoute(builder: (context) => User(username: username,))
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 158, 192, 255),
        child: ListView(
          children: <Widget>[
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black87,
                shape: BoxShape.circle
              ),
              child: Center(
                child: Icon(Icons.person, size: 50, color: Colors.white,),
              ),
            ),
            SizedBox(height: 15,),

            Text("Absensi Siswa SD Cempaka Putih", style: TextStyle(fontSize: 20, color: Colors.black87),),

            SizedBox(height: 15,),

            Text(alert, style: TextStyle(color: Colors.red),),

            SizedBox(height: 15,),

            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: usernameInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)
                      ),
                      prefixIcon: Icon(Icons.person, size: 40,),
                      hintText: "Enter your username",
                      hintStyle: TextStyle(color: Colors.black87),
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.black87),
                    ),
                  ),
              
                  SizedBox(height: 20,),

                  TextFormField(
                    controller: passwordInput,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)
                      ),
                      prefixIcon: Icon(Icons.lock, size: 40,),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: Colors.black87),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Card(
                    color: Colors.black87,
                    elevation: 5,
                    child: Container(
                      height: 50,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: (){
                          loginProcess();
                        },
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )
          ],
        ),
      ),
    );
  }
}