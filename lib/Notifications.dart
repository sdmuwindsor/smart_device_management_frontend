import 'package:flutter/material.dart';
import 'package:smart_device_management_frontend/HomePage.dart';
import 'package:smart_device_management_frontend/Profile.dart';
import 'package:http/http.dart' as http;
import 'package:smart_device_management_frontend/UserDetails.dart';
import 'dart:convert';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  int currentPage = 0;

  // List<Widget> pages = const [
  //   MyHomePage(title: 'HomePage'),
  //   NotificationPage()
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  List<dynamic> notifications = [];

  Future<String> getNotifications() async {
    final response_notification = await http.get(
        Uri.parse("http://20.232.108.27:8000/notifications/get_user_notifications/"+UserDetails.userId.toString()),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json"
        });
    print('kjnsdfkjnsdf');
    print(response_notification.body);
    notifications = json.decode(response_notification.body);
    // List<dynamic> hard_coded = [{
    //   "notification_title":"Your Device is Crashing",
    //   "notification_body": "Please check your Smart Light. Seems like its using high power"
    // }, {
    //   "notification_title":"Your Device is working",
    //   "notification_body": "Please check your Smart Light. Seems like its using high power"
    // }];
    // notifications = hard_coded;
    print(notifications);
    return Future.value("Data download successfully"); // return your response
  }
  @override
  Widget build(BuildContext context) {

    List<Widget> getNotificationList() {
      List<Widget> childs = [];
      for(var i = 0; i < notifications.length; i++){
        childs.add(new Container(
            margin : const EdgeInsets.only(bottom: 10),
          // height: 100,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10),
            border: Border(
              bottom: BorderSide( //                    <--- top side
                color: Colors.black,
                width: 3.0,
              ),
            ),
            color: Colors.white,
          ),
          // margin: const EdgeInsets.only(r),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle_notifications, color: Colors.black),
                        Text(
                          notifications[i]['title'],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin : const EdgeInsets.only(left: 25),
                        child: Text(
                          notifications[i]['message'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ]
                ),
              )
        ),);
      }
      return childs;
    }

    return FutureBuilder<String>(
      future: getNotifications(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text(""));
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Notifications'),
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
                body: Container(
                    child: SingleChildScrollView(
                        child: Center(
                          // Center is a layout widget. It takes a single child and positions it
                          // in the middle of the parent.
                          child: Column(
                            // Column is also a layout widget. It takes a list of children and
                            // arranges them vertically. By default, it sizes itself to fit its
                            // children horizontally, and tries to be as tall as its parent.
                            //
                            // Invoke "debug painting" (press "p" in the console, choose the
                            // "Toggle Debug Paint" action from the Flutter Inspector in Android
                            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                            // to see the wireframe for each widget.
                            //
                            // Column has various properties to control how it sizes itself and
                            // how it positions its children. Here we use mainAxisAlignment to
                            // center the children vertically; the main axis here is the vertical
                            // axis because Columns are vertical (the cross axis would be
                            // horizontal).
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 20.0),
                                height: MediaQuery.of(context).size.height - 50,
                                color: Colors.white,
                                child: ListView(
                                  // scrollDirection: Axis.horizontal,
                                  children: getNotificationList(),
                                ),
                              ),
                            ],
                          ),
                        ))),
                bottomNavigationBar: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      child: NavigationBar(
                        destinations: const [
                          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                          NavigationDestination(
                              icon: Icon(Icons.person), label: 'Profile'),
                        ],
                        onDestinationSelected: (int index) {
                          setState(() {
                            currentPage = index;
                            if (currentPage == 1) {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return Profile();
                                }),
                              );
                            }
                            if (currentPage == 0) {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return MyHomePage(
                                    title: 'Homepage',
                                  );
                                }),
                              );
                            }
                          });
                        },
                        selectedIndex: currentPage,
                        backgroundColor: Colors.white,
                      ),
                    )));
          }
        }
      },
    );
  }
}
