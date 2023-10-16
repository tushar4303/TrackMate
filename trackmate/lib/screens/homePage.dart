import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trackmate/screens/verify.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>(); // key for form
  String selectedName = "Select Name"; // For the name dropdown
  String selectedSubject = "Select Subject"; // Initial value matches an item
  DateTime selectedDate = DateTime.now(); // For the date selector
  String selectedTimeSlot = "Select Time Slot"; // For the time slot dropdown

  List<String> names = [
    "Select Name",
    "Prof. Janhavi Bairkerikar",
    "Prof. Mrudul Arkadi",
    "Prof. Prasad Padalkar",
    // Add more name options here
  ];

  List<String> subjects = [
    "Select Subject",
    "IOE",
    "STQA",
    "MIS",
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
  bool isAttendanceStarted = false; // Track whether attendance is started

  late Timer timer; // Define the timer as a late variable

  @override
  void initState() {
    super.initState();
    // Initialize the timer with a dummy value
    timer = Timer(Duration(seconds: 0), () {});
    // Start a timer to update the UI every second
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    stopwatch.reset();
    if (timer.isActive) {
      timer.cancel(); // Cancel the timer when disposing the widget
    }
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
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 1,
                  child: Text('Verify'),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Verify()),
                );
              }
            },
            icon: Icon(Icons.more_vert), // Three-dot icon
          ),
        ],
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
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "Select Name"),
                  value: selectedName,
                  items: names.map((String name) {
                    return DropdownMenuItem<String>(
                      value: name,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedName = newValue!;
                      // Add logic here to auto-select the subject based on the name
                      if (selectedName == "Prof. Janhavi Bairkerikar") {
                        selectedSubject =
                            "IOE"; // Set the corresponding subject
                      } else if (selectedName == "Prof. Mrudul Arkadi") {
                        selectedSubject =
                            "MIS"; // Set the corresponding subject
                      } else if (selectedName == "Prof. Prasad Padalkar") {
                        selectedSubject =
                            "STQA"; // Set the corresponding subject
                      } else {
                        selectedSubject =
                            "Select Subject"; // Reset subject if none matches
                      }
                    });
                  },
                  validator: (value) {
                    if (value == "Select Name") {
                      return "Please select a name";
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
                        if (isAttendanceStarted) {
                          stopwatch.stop();
                          stopwatch.reset();
                          timer
                              .cancel(); // Stop the timer when stopping attendance
                        } else {
                          stopwatch.start();
                          timer =
                              Timer.periodic(Duration(seconds: 1), (Timer t) {
                            setState(() {});
                          }); // Start the timer when starting attendance
                        }
                        isAttendanceStarted =
                            !isAttendanceStarted; // Toggle the state
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          isAttendanceStarted ? Colors.red : Colors.black,
                    ),
                    child: Text(
                      isAttendanceStarted
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
                  child: isAttendanceStarted
                      ? Column(
                          children: [
                            Center(
                              child: Text(
                                "Time Elapsed: ${stopwatch.elapsed.inHours}:${(stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
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
