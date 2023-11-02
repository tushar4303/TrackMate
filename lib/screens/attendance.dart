import 'package:flutter/material.dart';
import 'package:trackmate/screens/datatable.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FilterableDataTable()), // Replace SecondPage with the name of the widget or class for the page you want to navigate to.
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black, // Text color
                    ),
                    child: const Text(
                      "Get Attendance Details",
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
}
