import 'package:flutter/material.dart';
import 'package:smart_device_management_frontend/DeviceDetail.dart';
import 'package:flutter/material.dart';
import 'package:smart_device_management_frontend/AddNewRoom.dart';
import 'package:smart_device_management_frontend/HomePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowDevices extends StatefulWidget {
  final String roomId;
  const ShowDevices({super.key, required this.roomId});

  @override
  State<ShowDevices> createState() => _ShowDevicesState(this.roomId);
}

class _ShowDevicesState extends State<ShowDevices> {
  String roomId;
  _ShowDevicesState(this.roomId);
  List<dynamic> devices = [];

  Future<String> downloadData() async {
    final response_device = await http.get(
        Uri.parse("http://20.232.108.27:8000/devices/get_room_devices/" + this.roomId),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json"
        });
    devices = json.decode(response_device.body);
    return Future.value("Data download successfully"); // return your response
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> getList() {
      List<Widget> childs = [];
      for (var i = 0; i < devices.length; i++) {
        childs.add(
          new Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
            child: GestureDetector (
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return DeviceDetail(deviceId: devices[i]['id'].toString());
                  }),
                );
              },
              child: Center(
                child: Text(
                  devices[i]['name'],
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ),
        );
      }
      return childs;
    }

    return FutureBuilder<String>(
      future: downloadData(), // function where you call your api
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
                title: const Text('Devices'),
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
      },
    );
  }
}
