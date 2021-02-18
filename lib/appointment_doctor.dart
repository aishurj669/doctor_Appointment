import 'dart:convert';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class Doctor_Appoint extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Doctor_Session();
  }
}

class Doctor_Session extends State {
  final String url = "assets/user.json";
  List<dynamic> allData = [];
  List<dynamic> appointmentData = [];
  Map<String, dynamic> appointment;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    this.getjsondata();
  }

  // ignore: missing_return
  Future<String> getjsondata() async {
    String jsonData =
        await DefaultAssetBundle.of(context).loadString("assets/user.json");
    final jsonResult = json.decode(jsonData);

    // print(jsonResult)
    allData = jsonResult;
    appointmentData = allData;
    setState(() {});
  }

  getSelectedDateAppointments() {
    // for (var i = 0; i < appointmentData.length; i++) {
    //   Map<String, dynamic> appItem = appointmentData[i];
    //   if (appItem['appointmentDate'] == _selectedValue.toString()) {
    //     appointment = appItem;
    //     print(appItem);
    //   }
    // }

    appointmentData = allData.where((element) {
      print(element);
      Map<String, dynamic> appItem = element;
      return appItem['Date'] == _selectedValue.toString();
    }).toList();
    setState(() {});
  }

  DateTime _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: ListView(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height / 4.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 25,
              child: Container(
                padding: EdgeInsets.all(15.0),
                height: MediaQuery.of(context).size.height * .65,
                color: Colors.blueAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .15,
                          // width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              // border: Border.all(color: Colors.white),
                              shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtfPvMO9-U9HSAnOlWvfumKZq21ohP5I66yw&usqp=CAU"),
                          ),
                        ),
                        SizedBox(
                          width: 9.0,
                        ),
                        Text(
                          "Welcome Dr.Scilaris",
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .apply(color: Colors.white, fontWeightDelta: 2),
                        ),
                        SizedBox(
                          width: 90,
                        ),
                        Icon(
                          Icons.segment,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 5.0,
                          )
                        ],
                      ),
                      child: TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide.none),
                            fillColor: Colors.white,
                            suffixIcon: Icon(Icons.search),
                            hintText: "Search Patients",
                            filled: true),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Stack(children: [
        Container(
            height: MediaQuery.of(context).size.height - 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent),
        // SizedBox(
        //   height: 30,
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.blue,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                // New date selected
                setState(() {

                  _selectedValue = date;
                  getSelectedDateAppointments();
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Positioned(
          top: 90,
          child: Container(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ListView(children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "HEASC 54-DEAN (4)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                SizedBox(height: 20),
                Container(
                  child: Stack(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height - 82.0,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent),
                      Positioned(
                          top: 75.0,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(45.0),
                                    topRight: Radius.circular(45.0),
                                  ),
                                  color: Colors.white),
                              height:
                                  MediaQuery.of(context).size.height - 100.0,
                              width: MediaQuery.of(context).size.width)
                      ),
                      appointmentData != null && appointmentData.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.black,
                              ),
                              shrinkWrap: true,
                              itemCount: appointmentData.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> item =
                                    appointmentData[index];
                                return ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    leading: Icon(
                                      Icons.bookmark,
                                      color: Colors.green,
                                    ),
                                    title: Text(item["Patient_Name"]),
                                    subtitle: Text(item["doctor_Name"] +
                                        "\n" +
                                        item["status"]),
                                    trailing: Column(children: [
                                      Text(item["time"]),
                                      //Text(item["Dictation"]),
                                      Spacer(),
                                      RichText(
                                        text: TextSpan(
                                          text: '• ',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '' +
                                                  "" +
                                                  "" +
                                                  item["Dictation"],
                                            ),
                                          ],
                                        ),
                                      )
                                    ]));
                              },
                            )
                          : Divider(
                              color: Colors.white,
                            ),
                    ],
                  ),
                ),
              ])),
        )
      ])
    ]));
  }
}
