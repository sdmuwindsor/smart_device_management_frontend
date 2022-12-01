import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:smart_device_management_frontend/AddNewDevice.dart';
import 'package:smart_device_management_frontend/DashboardBarChart.dart';
import 'package:smart_device_management_frontend/Animation/FadeAnimation.dart';
import 'package:smart_device_management_frontend/Category.dart';
import 'package:smart_device_management_frontend/Notifications.dart';
import 'package:smart_device_management_frontend/Profile.dart';
import 'package:smart_device_management_frontend/AddNewRoom.dart';
import 'package:smart_device_management_frontend/ShowCategoryDevices.dart';
import 'package:smart_device_management_frontend/ShowDevices.dart';
import 'package:smart_device_management_frontend/utils/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smart_device_management_frontend/UserDetails.dart';
import 'package:pie_chart/pie_chart.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  void initState() {

  }
  List<dynamic> rooms = UserDetails.rooms;

  Map<String, double> dataMap = {
    "Light": 5,
    "Thermostat": 3,
  };

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];

  @override
  Widget build(BuildContext context) {

    List<Widget> getRoomList() {
      List<Widget> childs = [];
      for(var i = 0; i < rooms.length; i++){
        childs.add(new Container(
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          margin: const EdgeInsets.only(right: 10.0),
          child:  GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return ShowDevices(roomId: rooms[i]["id"].toString());
                }),
              );
            },
            child: Center(
                child: Text(
                  rooms[i]['name'],
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ))
          ),
        ),);
      }
      childs.add(new Container(
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        margin: const EdgeInsets.only(right: 10.0),
        // child: const Center(
        //     child: Icon(
        //   Icons.add,
        //   size: 80,
        // )),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return const AddNewRoom();
              }),
            );
          },
          child: const Center(
              child: Icon(
                Icons.add,
                size: 80,
              )),
        ),
      ));
      return childs;
    }
    final user = UserPreferences.myUser;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Smart Device Management'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 248, 248, 248),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const NotificationPage();
                  }),
                ); // do something
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return const AddDevice();
                }),
              );
            },
            child: const Icon(Icons.add)),
        // body: Center(
        //   child: pages.elementAt(_selectedIndex),
        // ),
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
                        margin: const EdgeInsets.only(left: 20.0, top: 20.0),
                        width: (MediaQuery.of(context).size.width),
                        child: const Text(
                          'Category',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20.0, top: 20.0),
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.only(right: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (BuildContext context) {
                                      return ShowCategoryDevices(categoryId: "thermostat");
                                    }),
                                  );
                                },
                                child: const Center(
                                    child: Icon(
                                      Icons.thermostat,
                                      size: 80,
                                    )),
                              )
                            ),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.only(right: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (BuildContext context) {
                                      return ShowCategoryDevices(categoryId: "light");
                                    }),
                                  );
                                },
                                child: const Center(
                                    child: Icon(
                                      Icons.lightbulb,
                                      size: 80,
                                    )),
                              )
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20.0, top: 20.0),
                        width: (MediaQuery.of(context).size.width),
                        child: const Text(
                          'Rooms',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20.0, top: 20.0),
                        height: 120,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: getRoomList(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20.0, top: 20.0),
                        width: (MediaQuery.of(context).size.width),
                        child: Container(
                          child: Row(
                            children: <Widget> [
                              const Text(
                                'Metrics',
                                style: TextStyle(fontSize: 20, color: Colors.black),
                                textAlign: TextAlign.left,
                              )
                            ],
                          )

                        )
                      ),
                      Container(
                          margin:
                          const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                          width: (MediaQuery.of(context).size.width),
                          child: BarChartSample3()
                      ),
                      Container(
                          height: 200,
                          color: Color(0xff203858),
                          margin:
                          const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                          width: (MediaQuery.of(context).size.width),
                          child: PieChart(
                            dataMap: dataMap,
                            animationDuration: Duration(milliseconds: 800),
                            chartLegendSpacing: 32,
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            colorList: colorList,
                            initialAngleInDegree: 0,
                            chartType: ChartType.disc,
                            ringStrokeWidth: 40,
                            legendOptions: LegendOptions(
                              showLegendsInRow: true,
                              legendPosition: LegendPosition.bottom,
                              showLegends: true,
                              legendShape: BoxShape.circle,
                              legendTextStyle: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                                decimalPlaces: 0
                            ),
                            // gradientList: ---To add gradient colors---
                            // emptyColorGradient: ---Empty Color gradient---
                          )
                      ),
                    ],
                  ),
                ))),
        // bottomNavigationBar: Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.only(
        //           topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        //       boxShadow: [
        //         BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        //       ],
        //     ),
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(30.0),
        //         topRight: Radius.circular(30.0),
        //       ),
        //       child: BottomNavigationBar(
        //         items: const <BottomNavigationBarItem>[
        //           BottomNavigationBarItem(
        //             icon: Icon(Icons.home),
        //             label: 'Home',
        //           ),
        //           BottomNavigationBarItem(
        //             icon: Icon(Icons.person),
        //             label: 'Profile',
        //           ),
        //         ],
        //         currentIndex: _selectedIndex,
        //         selectedItemColor: Colors.black,
        //         backgroundColor: Colors.white,
        //         onTap: _onItemTapped,
        //       ),
        //     )),
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
              // floatingActionButton: FloatingActionButton(
              //   onPressed: _incrementCounter,
              //   tooltip: 'Increment',
              //   child: const Icon(Icons.add),
              // ), // This trailing comma makes auto-formatting nicer for build methods.
            )));
  }
}
