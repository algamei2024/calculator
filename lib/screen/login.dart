import 'dart:ffi';

import 'package:calculator/screen/calculate.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  static const MaterialRoute = "login";
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  //--------------------------
  int index = 0;
  _buildPopupMenuItem(String menuTitle, IconData iconData) {
    index++;
    return PopupMenuItem(
      value: index,
      child: Row(children: [
        Icon(iconData, color: Colors.black),
        Text(menuTitle),
      ]),
    );
  }

//-----------------------------
  _buildOnSelected(id) {
    switch (id) {
      case 1:
        SharedAppData(child: Text("Calculater"));
        break;
      case 3:
        Navigator.of(context).pop();
        break;
    }
  }

//=============================
  _buildTextField(fieldController, String feildLableTxt, String fieldHinttxt) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: fieldController,
        decoration: InputDecoration(
          label: Text(feildLableTxt),
          labelStyle: TextStyle(color: Colors.white),
          hintText: fieldHinttxt,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Design - 2"),
        actions: [
          Icon(Icons.screen_rotation_rounded),
          PopupMenuButton(
            elevation: 20,
            shadowColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Color.fromARGB(255, 198, 205, 230),
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem>[
                _buildPopupMenuItem("Share", Icons.share),
                _buildPopupMenuItem("Upload", Icons.upload),
                _buildPopupMenuItem("Exit", Icons.exit_to_app_rounded),
              ];
            },
            onSelected: (id) => _buildOnSelected(id),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //-------
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.person_rounded,
                        size: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                      radius: 50,
                      backgroundColor: Colors.green,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            //---------
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 76, 142, 175),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50))),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTextField(
                          emailController, "Email", "Enter Your Email"),
                      SizedBox(
                        height: 10,
                      ),
                      _buildTextField(passwordController, "Password",
                          "Enter Your Password"),
                      SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          if (emailController.text == "a" &&
                              passwordController.text == "123") {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                clac.materialRoute, (route) => false);
                          }
                        },
                        icon: Icon(Icons.next_plan),
                        iconSize: 50,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
