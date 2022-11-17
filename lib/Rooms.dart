import 'package:flutter/material.dart';
import 'package:smart_device_management_frontend/AddNewRoom.dart';
import 'package:smart_device_management_frontend/HomePage.dart';
import 'package:smart_device_management_frontend/UserDetails.dart';


class Room extends StatefulWidget {
  const Room({super.key});

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {

  List<dynamic> rooms = UserDetails.rooms;
  @override
  Widget build(BuildContext context) {

    List<Widget> getList() {
      List<Widget> childs = [];
      for(var i = 0; i < rooms.length; i++){
        childs.add(new Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          child:  Center(
            child: Text(
              rooms[i]['name'],
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),);
      }
      return childs;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rooms'),
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
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return const AddNewRoom();
              }),
            );
          },
          child: const Icon(Icons.add)),
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
          children: <Widget> [
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 20.0),
              height: 5000,
              child: ListView(
                children: getList(),
              ),
            )
          ],
        ),
      ))),
    );
  }
}
