import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:smart_device_management_frontend/Animation/FadeAnimation.dart';
import 'package:smart_device_management_frontend/HomePage.dart';
import 'package:smart_device_management_frontend/Login.dart';
import 'package:smart_device_management_frontend/model/user.dart';
import 'package:smart_device_management_frontend/utils/user_preferences.dart';
import 'package:smart_device_management_frontend/widget/textfield_widget.dart';
import 'package:smart_device_management_frontend/UserDetails.dart';

class Profile extends StatelessWidget {
  User user = UserPreferences.myUser;
  @override
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  Profile({super.key});

  Widget build(BuildContext context) {
    void UserProfile() async {
      final jsonBody = {
        "first_name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      };

      Map<String, String> requestHeaders = {
        "accept": "application/json",
        "Content-Type": "application/json"
      };

      final response = await http.post(
          Uri.parse("http://127.0.0.1:8001/users/login"),
          headers: requestHeaders,
          body: jsonEncode(jsonBody));

      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('User Profile'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 248, 248, 248),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return const MyHomePage(title: 'HomePage');
                }),
              ); // do something
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                // child: Text(
                                //   "Profile Up",
                                //   style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 40,
                                //       fontWeight: FontWeight.bold),
                                // ),
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  // padding: EdgeInsets.all(30.0),
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  // physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                // Container(
                                //   padding: EdgeInsets.all(8.0),
                                //   decoration: BoxDecoration(
                                //       border: Border(
                                //           bottom: BorderSide(
                                //               color: Colors.grey.shade100))),
                                //   child: TextField(
                                //     controller: nameController,
                                //     decoration: InputDecoration(
                                //         border: InputBorder.none,
                                //         label: Text("Full Name"),
                                //         hintText: user.name,
                                //         hintStyle:
                                //             TextStyle(color: Colors.grey[400])),
                                //   ),
                                // ),
                                TextFieldWidget(
                                  label: 'Full Name',
                                  text: UserDetails.userName,
                                  onChanged: (name) {},
                                ),
                                // Container(
                                //   padding: EdgeInsets.all(8.0),
                                //   decoration: BoxDecoration(
                                //       border: Border(
                                //           bottom: BorderSide(
                                //               color: Colors.grey.shade100))),
                                //   child: TextField(
                                //     controller: emailController,
                                //     decoration: InputDecoration(
                                //         border: InputBorder.none,
                                //         hintText: "Email Address",
                                //         hintStyle:
                                //             TextStyle(color: Colors.grey[400])),
                                //   ),
                                // ),
                                const SizedBox(height: 7),
                                TextFieldWidget(
                                  label: 'Email Name',
                                  text: UserDetails.userEmail,
                                  onChanged: (email) {},
                                ),
                                // Container(
                                //   padding: EdgeInsets.all(8.0),
                                //   child: TextField(
                                //     controller: passwordController,
                                //     obscuringCharacter:
                                //         '*', //added obscuringCharacter here
                                //     obscureText: true,
                                //     decoration: InputDecoration(
                                //         border: InputBorder.none,
                                //         hintText: "Password",
                                //         hintStyle:
                                //             TextStyle(color: Colors.grey[400])),
                                //   ),
                                // )
                                const SizedBox(height: 7),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          2,
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromARGB(255, 219, 73, 73),
                                  Color.fromARGB(153, 221, 63, 63),
                                ])),
                            child: Center(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return LoginPage();
                                      }),
                                    ); // do something
                                  },
                                  child: Text(
                                    "Log Out",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
