import 'package:flutter/material.dart';
import 'package:smart_device_management_frontend/BarChart.dart';

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
  int _selectedIndex = 0;
  void _onItemTapped(int index) {

  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: SingleChildScrollView(
            child:Center(
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
              child: const Text('Category', style: TextStyle(fontSize: 20, color: Colors.black), textAlign: TextAlign.left,),
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
                    child: const Center(child: Icon(Icons.tv,size: 80,)),
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(right: 10.0),
                    child: const Center(child: Icon(Icons.thermostat,size: 80,)),
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(right: 10.0),
                    child: const Center(child: Icon(Icons.lightbulb,size: 80,)),
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(right: 10.0),
                    child: const Center(child: Icon(Icons.add,size: 80,)),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 20.0),
              width: (MediaQuery.of(context).size.width),
              child: const Text('Rooms', style: TextStyle(fontSize: 20, color: Colors.black), textAlign: TextAlign.left,),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 20.0),
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(right: 10.0),
                    child: const Center(child: Text("Bedroom 1", style: TextStyle(fontSize: 20, color: Colors.black),)),
                  ),
                  Container(
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(right: 10.0),
                    child: const Center(child: Text("Living Room", style: TextStyle(fontSize: 20, color: Colors.black))),
                  ),
                  Container(
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(right: 10.0),
                    child: const Center(child: Text("Bedroom 2",style: TextStyle(fontSize: 20, color: Colors.black))),
                  ),
                  Container(
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(right: 10.0),
                    child: const Center(child: Icon(Icons.add,size: 80,)),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 20.0),
              width: (MediaQuery.of(context).size.width),
              child: const Text('Metrics', style: TextStyle(fontSize: 20, color: Colors.black), textAlign: TextAlign.left,),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              width: (MediaQuery.of(context).size.width),
              child: BarChartSample3()
            ),
          ],
        ),
      )),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.black,
                backgroundColor: Colors.white,

                onTap: _onItemTapped,
              ),
            )
        )
    // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}