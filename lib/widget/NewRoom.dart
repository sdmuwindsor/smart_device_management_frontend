import 'package:flutter/material.dart';
import 'package:smart_device_management_frontend/HomePage.dart';
import 'package:smart_device_management_frontend/Rooms.dart';

class NewRoom extends StatelessWidget {
  // const NewRoom({super.key});
  NewRoom({Key? key, required this.RoomName}) : super(key: key);

  String RoomName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(RoomName),
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
                return const Room();
              }),
            ); // do something
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.room_rounded),
              title: Text(RoomName),
            )
          ],
        ),
      ),
    );
  }
}
