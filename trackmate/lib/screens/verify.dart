import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final formKey = GlobalKey<FormState>(); // key for form

  List<String> verifiedRollNumbers = [
    "64",
    "25",
    "16",
    "43",
    "42",
    "54"
  ]; // Add your verified roll numbers

  String currentAnimation = 'assets/animation_lnt3k4x9.json';
  String currentText = "Place finger on sensor";

  String selectedName = "Select Teacher's Name"; // For the name dropdown
  String selectedSubject = "Select Subject"; // Initial value matches an item
  DateTime selectedDate = DateTime.now(); // For the date selector
  String selectedTimeSlot = "Select Time Slot"; // For the time slot dropdown

  final TextEditingController rollNoController = TextEditingController();
  String apiResponse = ""; // To store the API response

  void _handleApiCall() {
    String rollNo = rollNoController.text;
    print("Roll Number: $rollNo"); // Add this line for debugging
    // Introduce a delay of 4 seconds before changing the animation
    Future.delayed(Duration(seconds: 4), () {
      changeAnimation(rollNo, verifiedRollNumbers);
    });
  }

  void changeAnimation(String rollNumber, List<String> verifiedRollNumbers) {
    print("Here aagya");
    if (verifiedRollNumbers.contains(rollNumber)) {
      print("Here bhi aagya");
      setState(() {
        currentAnimation = 'assets/success.json'; // Play the success animation
        currentText = 'Marked Successfully';
      });
    } else {
      setState(() {
        currentAnimation = 'assets/failed.json'; // Play the failed animation
        currentText = 'Verification Failed';
      });
    }
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
                  keyboardType:
                      TextInputType.number, // Set the keyboard type to number
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
                    onPressed: () {
                      // Call changeAnimation before showing the dialog
                      changeAnimation(
                          rollNoController.text, verifiedRollNumbers);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAttendanceDialog(
                              currentAnimation: currentAnimation,
                              currentText: currentText,
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                    ),
                    child: const Text(
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

class CustomAttendanceDialog extends StatefulWidget {
  final String currentAnimation;
  final String currentText;

  // Constructor to receive animation and text data
  CustomAttendanceDialog(
      {required this.currentAnimation, required this.currentText});

  @override
  _CustomAttendanceDialogState createState() => _CustomAttendanceDialogState();
}

class _CustomAttendanceDialogState extends State<CustomAttendanceDialog> {
  // Use widget.currentAnimation and widget.currentText to access the data
  String currentAnimation = "";
  String currentText = "";
  bool verificationSuccessful = false; // To track verification status

  @override
  void initState() {
    super.initState();
    // Initialize currentAnimation and currentText in this class
    currentAnimation = widget.currentAnimation;
    currentText = widget.currentText;

    // Simulate the verification process with a delay
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        verificationSuccessful = true; // Set to true to show result animations
      });
    });
  }

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
    if (verificationSuccessful) {
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
              padding:
                  EdgeInsets.only(top: 48, right: 64, left: 64, bottom: 32),
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
    } else {
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
              padding:
                  EdgeInsets.only(top: 48, right: 64, left: 64, bottom: 32),
              child: Lottie.asset('assets/animation_lnt3k4x9.json'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, right: 24, left: 24, bottom: 16),
              child: Text(
                "Place finger on sensor",
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
}
