import 'package:flutter/material.dart';
import 'package:smart_device_management_frontend/HomePage.dart';
import 'package:smart_device_management_frontend/Profile.dart';
import 'package:smart_device_management_frontend/Rooms.dart';
import 'package:smart_device_management_frontend/widget/NewRoom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smart_device_management_frontend/UserDetails.dart';

class AddNewRoom extends StatefulWidget {
  const AddNewRoom({super.key});

  @override
  State<AddNewRoom> createState() => _AddNewRoomState();
}

class _AddNewRoomState extends State<AddNewRoom> {
  var _RooomName;
  _AdddeviceState() {
    selectedRoomCategory = RoomCategory[0];
  }

  final _deviceController = TextEditingController();
  TextEditingController roomController = new TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _deviceController.addListener(() {});
  // }
  final RoomCategory = ["Bedroom", "Living Room", "Kitchen", "Bathroom"];
  String selectedRoomCategory = "Bedroom";

  void addRoom() async {
    final jsonBody = {
        "user_id": UserDetails.userId,
        "name": _deviceController.text
    };

    Map<String, String> requestHeaders = {
      "accept": "application/json",
      "Content-Type": "application/json"
    };

    final response = await http.post(
        Uri.parse("http://20.232.108.27:8000/rooms/"),
        headers: requestHeaders,

        body: jsonEncode(jsonBody));

    if (response.statusCode == 200) {
      final response_rooms = await http.get(
          Uri.parse("http://20.232.108.27:8000/rooms/get_user_rooms/"+(UserDetails.userId).toString()),
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json"
          });
      List<dynamic> user_rooms = json.decode(response_rooms.body);
      UserDetails.rooms = user_rooms;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyHomePage(title: "Smart Device Management")));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: const Text("Something Went Wrong"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add New Room'),
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
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _deviceController,
              decoration: InputDecoration(
                labelText: 'Room Name',
                // icon: Icon(Icons.verified_user_outlined),
                prefixIcon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            // Text("Device Name is ${_deviceController.text}"),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Room Owner',
                // icon: Icon(Icons.verified_user_outlined),
                prefixIcon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            // Text("Device Name is ${_deviceController.text}"),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'No. of Roommates',
                // icon: Icon(Icons.verified_user_outlined),
                prefixIcon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            // Text("Device Name is ${_deviceController.text}"),
            SizedBox(
              height: 20.0,
            ),
            DropdownButtonFormField(
              value: selectedRoomCategory,
              items: RoomCategory.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedRoomCategory = val as String;
                });
              },
              icon: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.black,
              ),
              dropdownColor: Colors.white54,
              decoration: InputDecoration(
                  labelText: "Room Types",
                  prefixIcon: Icon(
                    Icons.category_outlined,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20.0,
            ),
            addBtn(context),
          ],
        ),
      ),
    );
  }

  OutlinedButton addBtn(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            minimumSize: Size(200, 50), backgroundColor: Colors.white),
        onPressed: () {
          addRoom();
        },
        child: Text(
          "Add Room".toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
