import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Import the intl package
import 'package:lottie/lottie.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final formKey = GlobalKey<FormState>();

  Future<void> sendAttendanceData(String name, String subject, DateTime date,
      String timeSlot, String rollNo) async {
    final url = 'http://10.0.4.222:3000/markAttendance';

    // Format the date in the "yyyy-MM-dd" format
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    setState(() {
      currentAnimation = 'assets/animation_lnt3k4x9.json';
      currentText = 'Place finger on sensor';
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'TeacherName': name,
          'Subject': subject,
          'TimeSlot': timeSlot,
          'Date': formattedDate,
          'RollNo': rollNo,
        }),
      );

      if (response.statusCode == 200) {
        print("Supposed to reach here");
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        String message = jsonResponse['message'];

        // Call changeAnimation to update the UI based on the message
        changeAnimation(message);
      } else {
        // Request failed
        print('Failed to send attendance data: ${response.statusCode}');
        Fluttertoast.showToast(
          msg: 'Error: Failed to send attendance data',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } catch (e) {
      print('Error sending attendance data: $e');
      Fluttertoast.showToast(
        msg: 'Error: $e',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  String currentAnimation = 'assets/animation_lnt3k4x9.json';
  String currentText = "Place finger on sensor";

  String selectedName = "Select Teacher's Name";
  String selectedSubject = "Select Subject";
  DateTime selectedDate = DateTime.now();
  String selectedTimeSlot = "Select Time Slot";

  final TextEditingController rollNoController = TextEditingController();

  void changeAnimation(String message) {
    print(message);
    if (message == "Session is active, student exists, attendance recorded.") {
      setState(() {
        currentAnimation = 'assets/success.json';
        currentText = 'Marked Successfully';
      });
    } else if (message == "Fingerprint doesn't match. Please retry.") {
      setState(() {
        currentAnimation = 'assets/failed.json';
        currentText = 'Verification Failed';
      });
    } else {
      setState(() {
        currentAnimation = 'assets/unknown.json';
        currentText = 'Unknown Response';
      });
    }
    // Pop the old dialog and show a new one with the updated animation
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAttendanceDialog(
          currentAnimation: currentAnimation,
          currentText: currentText,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.04),
                Text(
                  "Mark your ",
                  style: TextStyle(fontSize: 30, color: Colors.black87),
                ),
                Text(
                  "attendance for",
                  style: TextStyle(fontSize: 30, color: Colors.black87),
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                DropdownButtonFormField<String>(
                  decoration:
                      InputDecoration(labelText: "Select Teacher's Name"),
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
                      if (selectedName == "Prof. Janhavi Bairkerikar") {
                        selectedSubject = "IOE";
                      } else if (selectedName == "Prof. Mrudul Arkadi") {
                        selectedSubject = "MIS";
                      } else if (selectedName == "Prof. Prasad Padalkar") {
                        selectedSubject = "STQA";
                      } else {
                        selectedSubject = "Select Subject";
                      }
                    });
                  },
                  validator: (value) {
                    if (value == "Select Teacher's Name") {
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
                  height: height * 0.04,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: rollNoController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Roll No',
                    hintText: 'Enter your Roll No',
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Show the custom dialog with the initial animation
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAttendanceDialog(
                              currentAnimation: currentAnimation,
                              currentText: currentText,
                            );
                          });

                      // Send attendance data to the API
                      await sendAttendanceData(
                        selectedName,
                        selectedSubject,
                        selectedDate,
                        selectedTimeSlot,
                        rollNoController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                    ),
                    child: Text(
                      "Mark your attendance",
                      textScaleFactor: 1.15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  List<String> names = [
    "Select Teacher's Name",
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
}

class CustomAttendanceDialog extends StatelessWidget {
  final String currentAnimation;
  final String currentText;

  CustomAttendanceDialog({
    required this.currentAnimation,
    required this.currentText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 1,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 48, right: 64, left: 64, bottom: 32),
            child: Lottie.asset(currentAnimation),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0, right: 24, left: 24, bottom: 16),
            child: Text(
              currentText,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
