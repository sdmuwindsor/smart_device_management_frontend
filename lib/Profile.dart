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
                const SizedBox(height: 5),
                // Container(
                //   height: 100,
                //   child: Stack(
                //     children: <Widget>[
                //       Positioned(
                //         child: FadeAnimation(
                //             1.6,
                //             Container(
                //               margin: EdgeInsets.only(top: 50),
                //               child: Center(
                //                 // child: Text(
                //                 //   "Profile Up",
                //                 //   style: TextStyle(
                //                 //       color: Colors.white,
                //                 //       fontSize: 40,
                //                 //       fontWeight: FontWeight.bold),
                //                 // ),
                //                 child: Icon(
                //                   Icons.person,
                //                   size: 40,
                //                 ),
                //               ),
                //             )),
                //       )
                //     ],
                //   ),
                // ),
                Padding(
                  // padding: EdgeInsets.all(30.0),
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  // physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        1.8,
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.6),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://www.clipartmax.com/png/middle/257-2572603_user-man-social-avatar-profile-icon-man-avatar-in-circle.png",
                                  ))),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      FadeAnimation(
                          2,
                          Container(
                            child: TextFieldWidget(
                              label: 'Full Name',
                              text: UserDetails.userName,
                              onChanged: (name) {},
                            ),
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      FadeAnimation(
                          2,
                          Container(
                            child: TextFieldWidget(
                              label: 'Email Name',
                              text: UserDetails.userEmail,
                              onChanged: (email) {},
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
