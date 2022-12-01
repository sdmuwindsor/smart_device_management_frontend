// import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart' hide Size;
import 'package:smart_device_management_frontend/HomePage.dart';
import 'package:smart_device_management_frontend/Profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smart_device_management_frontend/UserDetails.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  var _deviceName;
  _AddDeviceState() {
    selectedCategory = DeviceCategory[0];
  }
  final _deviceController = TextEditingController();
  final _deviceRatingController = TextEditingController();

  final DeviceCategory = [
    "Thermostat",
    "Light"
  ];
  String selectedCategory = "TV";

  List<dynamic> RoomSelection = UserDetails.rooms;

  String selectedRoom = (UserDetails.rooms)[0]['name'];
  int selectedRoomId = (UserDetails.rooms)[0]['id'];

  // void _updateText() {
  //   // setState(() {
  //   //   _deviceName = val;
  //   // });
  // }

  void addDevice() async {
    final jsonBody = {
      "room_id": selectedRoomId,
      "name": _deviceController.text,
      "category" : selectedCategory,
      "power_rating" : int.parse(_deviceRatingController.text)
    };

    print(jsonBody);

    Map<String, String> requestHeaders = {
      "accept": "application/json",
      "Content-Type": "application/json"
    };
    print(jsonBody);
    final response = await http.post(
        Uri.parse("http://20.232.108.27:8000/devices/"),
        headers: requestHeaders,

        body: jsonEncode(jsonBody));

    print(response);
    if (response.statusCode == 200) {
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
        title: const Text('Add New Device'),
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
                labelText: 'Device Name',
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
              controller: _deviceRatingController,
              decoration: InputDecoration(
                labelText: 'Device Rating',
                // icon: Icon(Icons.verified_user_outlined),
                prefixIcon: Icon(Icons.star_border),
                border: OutlineInputBorder(),
              ),
            ),
            // Text("Device Name is ${_deviceController.text}"),
            SizedBox(
              height: 20.0,
            ),
            DropdownButtonFormField(
              value: selectedCategory,
              items: DeviceCategory.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedCategory = val as String;
                });
              },
              icon: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.black,
              ),
              dropdownColor: Colors.white54,
              decoration: InputDecoration(
                  labelText: "Device Category",
                  prefixIcon: Icon(
                    Icons.category_outlined,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20.0,
            ),
            DropdownButtonFormField(
              // value: selectedRoom,
              items: RoomSelection.map((e) {
                return DropdownMenuItem(
                  value: e['name'],

                  child: Text(e['name']),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  RoomSelection.map((e) {
                    if(e['name'] == val) {
                      selectedRoomId = e['id'];
                      selectedRoom = e['name'];
                    }
                  });
                });
              },
              icon: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.black,
              ),
              dropdownColor: Colors.white54,
              decoration: InputDecoration(
                  labelText: "Select the Room",
                  prefixIcon: Icon(
                    Icons.room_outlined,
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
          addDevice();
        },
        child: Text(
          "Add Device".toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
