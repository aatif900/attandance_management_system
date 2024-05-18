import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final DatabaseReference _attendanceRef = FirebaseDatabase.instanceFor(
    databaseURL:
        'https://attendancemanagementsyst-c8325-default-rtdb.firebaseio.com',
    app: Firebase.app(),
  ).reference().child('attendance');

  List<Map<dynamic, dynamic>> _attendanceList = [];

  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  void _fetchAttendanceData() {
    _attendanceRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        List<Map<dynamic, dynamic>> tempList = [];
        data.forEach((key, value) {
          tempList.add(value);
        });
        setState(() {
          _attendanceList = tempList;
          _loading = false;
          _error = false;
        });
      } else {
        setState(() {
          _loading = false;
          _error = true;
        });
        print('Data received is not a Map or is null');
      }
    }, onError: (error) {
      setState(() {
        _loading = false;
        _error = true;
      });
      print('Error retrieving data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent[700],
      appBar: AppBar(
        title: Text('Attendance Summary'),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _error
              ? Center(
                  child: Text(
                    'Error fetching attendance data.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : _attendanceList.isNotEmpty
                  ? ListView.builder(
                      itemCount: _attendanceList.length,
                      itemBuilder: (context, index) {
                        final attendanceData = _attendanceList[index];
                        return ListTile(
                          title: Text(
                            'Student ID: ${attendanceData['student_id']}',
                          ),
                          subtitle: Text(
                            'Status: ${attendanceData['attendance_status']}',
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text('No attendance records available.'),
                    ),
    );
  }
}
