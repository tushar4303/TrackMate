class Attendance {
  final int attendanceId;
  final int userId;
  final int sessionId;
  final String name;
  final int rollNo;
  final int year;
  final String branch;

  Attendance({
    required this.attendanceId,
    required this.userId,
    required this.sessionId,
    required this.name,
    required this.rollNo,
    required this.year,
    required this.branch,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      attendanceId: json['attendance_id'],
      userId: json['user_id'],
      sessionId: json['session_id'],
      name: json['name'],
      rollNo: json['roll_no'],
      year: json['year'],
      branch: json['branch'],
    );
  }
}
