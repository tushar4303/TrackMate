import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>(); // key for form
  String name = "";
  String selectedSubject = "Select Subject"; // For the subject dropdown
  DateTime selectedDate = DateTime.now(); // For the date selector
  String selectedTimeSlot = "Select Time Slot"; // For the time slot dropdown

  List<String> subjects = [
    "Select Subject",
    "Math",
    "Science",
    "History",
    "English",
    // Add more subject options here
  ];

  List<String> timeSlots = [
    "Select Time Slot",
    "09:00-10:00 am",
    "10:00-11:00 am",
    "11:15-12:15 pm",
    "12:15-01:15 pm",
    // Add more time slot options here
  ];

  // Stopwatch instance to record time
  final Stopwatch stopwatch = Stopwatch();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // Start a timer to update the UI every second
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    stopwatch.reset();
    timer.cancel(); // Cancel the timer when disposing the widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: formKey, // key for form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.04),
                Text(
                  "Here to ",
                  style: TextStyle(fontSize: 30, color: Colors.black87),
                ),
                Text(
                  "Get Started!",
                  style: TextStyle(fontSize: 30, color: Colors.black87),
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Enter your name"),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return "Enter correct name";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "Select Subject"),
                  value: selectedSubject,
                  items: subjects.map((String subject) {
                    return DropdownMenuItem<String>(
                      value: subject,
                      child: Text(subject),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSubject = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == "Select Subject") {
                      return "Please select a subject";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "Select Time Slot"),
                  value: selectedTimeSlot,
                  items: timeSlots.map((String timeSlot) {
                    return DropdownMenuItem<String>(
                      value: timeSlot,
                      child: Text(timeSlot),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTimeSlot = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == "Select Time Slot") {
                      return "Please select a time slot";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                GestureDetector(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != selectedDate)
                      setState(() {
                        selectedDate = pickedDate;
                      });
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Select Date",
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (stopwatch.isRunning) {
                          stopwatch.stop();
                          stopwatch.reset();
                        } else {
                          stopwatch.start();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          stopwatch.isRunning ? Colors.red : Colors.black,
                    ),
                    child: Text(
                      stopwatch.isRunning
                          ? "Stop Attendance"
                          : "Start Attendance",
                      textScaleFactor: 1.15,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: stopwatch.isRunning
                      ? Column(
                          children: [
                            Center(
                              child: Text(
                                "Time Elapsed: ${stopwatch.elapsed.inHours}:${(stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                          ],
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
