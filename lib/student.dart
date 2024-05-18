import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class StudentScreen extends StatelessWidget {
  final DatabaseReference _attendanceRef = FirebaseDatabase.instanceFor(
          databaseURL:
              'https://attendancemanagementsyst-c8325-default-rtdb.firebaseio.com',
          app: Firebase.app())
      .reference()
      .child('attendancemanagementsystem');

  void markAttendance(BuildContext context, bool isPresent) {
    String attendanceStatus = isPresent ? 'Present' : 'Absent';

    // Generate a unique student ID
    String? studentId = _attendanceRef.push().key;

    _attendanceRef.child(studentId!).set({
      'student_id': studentId, // Use the generated student ID
      'attendance_status': attendanceStatus,
      'timestamp': DateTime.now().toUtc().toString(),
    }).then((_) {
      // Provide feedback to the student
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Attendance Marked as $attendanceStatus')),
      );
    }).catchError((error) {
      // Handle any errors that occur during the process
      print("Error marking attendance: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error marking attendance')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent[700],
      appBar: AppBar(
        title: Text('Mark Attendance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mark Your Attendance:',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              child: Text('Present'),
              onPressed: () => markAttendance(context, true),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Text('Absent'),
              onPressed: () => markAttendance(context, false),
            ),
          ],
        ),
      ),
    );
  }
}
