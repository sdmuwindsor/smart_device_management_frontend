import 'package:smart_device_management_frontend/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:smart_device_management_frontend/HomePage.dart';
import 'package:smart_device_management_frontend/SignUp.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smart_device_management_frontend/UserDetails.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:intl/intl.dart';

class LoginPage extends StatelessWidget {
  @override
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Widget build(BuildContext context) {
    void loginUser() async {
      context.loaderOverlay.show();
      final jsonBody = {
        "username": emailController.text,
        "password": passwordController.text
      };

      Map<String, String> requestHeaders = {
        "accept": "application/json",
        "Content-Type": "application/json"
      };

      final response = await http.post(
          Uri.parse("http://20.232.108.27:8000/users/login"),
          headers: requestHeaders,
          body: jsonEncode(jsonBody));

      if (response.statusCode == 200) {
        Map<String, dynamic> user_data = json.decode(response.body);
        UserDetails.userId = user_data['id'];
        UserDetails.userName = user_data['first_name'];
        UserDetails.userEmail = user_data['email'];
        final response_rooms = await http.get(
            Uri.parse("http://20.232.108.27:8000/rooms/get_user_rooms/"+(UserDetails.userId).toString()),
            headers: {
              "accept": "application/json",
              "Content-Type": "application/json"
            });
        List<dynamic> user_rooms = json.decode(response_rooms.body);
        UserDetails.rooms = user_rooms;
        var now = (new DateTime.now());
        var formatter = new DateFormat('yyyy-MM-dd');
        String startData = formatter.format(now);
        startData = startData+" 00:00:00";
        var sevenDay = (new DateTime.now()).subtract(Duration(days: 7));
        String endData = formatter.format(sevenDay);
        endData = endData+" 00:00:00";
        final response_consumption = await http.get(
            Uri.parse("http://20.232.108.27:8000/users/get_power_consumption_by_date/"+"?start_date="+endData+"&end_date="+startData+"&user_id="+(UserDetails.userId).toString()),
            headers: {
              "accept": "application/json",
              "Content-Type": "application/json"
            });
        List<dynamic> powerConsumption = json.decode(response_consumption.body);
        UserDetails.powerConsumption = powerConsumption;
        context.loaderOverlay.hide();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MyHomePage(title: "Smart Device Management")));
      } else {
        context.loaderOverlay.hide();
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: const Text("Username or Password Incorrect"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  color: Colors.deepPurple,
                  padding: const EdgeInsets.all(14),
                  child: const Text("OK"),
                ),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: LoaderOverlay(
          child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
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
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email Address",
                                        hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: passwordController,
                                    obscuringCharacter:
                                    '*', //added obscuringCharacter here
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                        2,
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: Center(
                              child: GestureDetector(
                                  onTap: () {
                                    if (emailController.text == "" ||
                                        passwordController.text == "") {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          content: const Text(
                                              "Username and Password is Required"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Container(
                                                color: Colors.deepPurple,
                                                padding:
                                                const EdgeInsets.all(14),
                                                child: const Text("OK"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      loginUser();
                                    }
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          1.5,
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                              },
                              child: Text(
                                "Dont have an Account ? Sign Up",
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1)),
                              ))),
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
