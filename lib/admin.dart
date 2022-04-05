import 'package:flutter/material.dart';
import 'package:login_siswa/main.dart';

import 'main.dart';

class Admin extends StatefulWidget {
  final String username;

  const Admin({required this.username});
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Admin"),
              SizedBox(height: 20,),
              Text("Welcome : ${widget.username}"),
              SizedBox(height: 20,),
              RaisedButton(
                onPressed: (){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login())
                  );
                },
                child: Text("Keluar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}