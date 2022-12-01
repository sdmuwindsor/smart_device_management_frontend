import 'package:flutter/material.dart';
import 'package:smart_device_management_frontend/AddNewRoom.dart';
import 'package:smart_device_management_frontend/DevicePowerConsupmtionDetail.dart';
import 'package:smart_device_management_frontend/HomePage.dart';
import 'package:smart_device_management_frontend/UserDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smart_device_management_frontend/BarChart.dart';
import 'package:smart_device_management_frontend/LineChart.dart';
import 'package:intl/intl.dart';

class DeviceDetail extends StatefulWidget {
  final String deviceId;
  const DeviceDetail({super.key, required this.deviceId});

  @override
  State<DeviceDetail> createState() => _DeviceDetailState(this.deviceId);
}

class _DeviceDetailState extends State<DeviceDetail> {
  String deviceId;
  _DeviceDetailState(this.deviceId);
  var device = {};


  Future<String> downloadData() async {
    var now = (new DateTime.now());
    var formatter = new DateFormat('yyyy-MM-dd');
    String startData = formatter.format(now);
    startData = startData+" 00:00:00";
    var sevenDay = (new DateTime.now()).subtract(Duration(days: 7));
    String endData = formatter.format(sevenDay);
    endData = endData+" 00:00:00";
    print("http://20.232.108.27:8000/devices/" + this.deviceId.toString()+"?start_date="+endData+"&end_date="+startData);
    final response_device = await http.get(
        Uri.parse("http://20.232.108.27:8000/devices/" + this.deviceId.toString()+"?start_date="+endData+"&end_date="+startData),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json"
        });
    device = json.decode(response_device.body);
    print(device);
    DevicePowerConsumptionDetail.brightness = device['brightness'];
    DevicePowerConsumptionDetail.powerConsumption = device['power_consumption'];
    print(DevicePowerConsumptionDetail.powerConsumption);
    return Future.value("Data download successfully"); // return your response
  }

  @override
  Widget build(BuildContext context) {

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
                title: Text(device['details']['name']),
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
                                margin:
                                const EdgeInsets.only(left: 20.0, top: 20.0,right: 20.0),
                                width: (MediaQuery.of(context).size.width),
                                child: Text("Power Consumption")
                            ),
                            Container(
                                margin:
                                const EdgeInsets.only(left: 20.0, top: 20.0,right: 20.0),
                                width: (MediaQuery.of(context).size.width),
                                child: BarChartSample3()
                            ),
                            Container(
                                margin:
                                const EdgeInsets.only(left: 20.0, top: 20.0,right: 20.0),
                                width: (MediaQuery.of(context).size.width),
                                child: Text("Brightness Level")
                            ),
                            Container(
                                margin:
                                const EdgeInsets.only(left: 20.0, top: 20.0,right: 20.0),
                                width: (MediaQuery.of(context).size.width),
                                child: LineChartSample2()
                            ),
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
