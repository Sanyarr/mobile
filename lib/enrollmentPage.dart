import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanyar/page2.dart';

class enrollmentPage extends StatefulWidget {
  final String userEmail;

  const enrollmentPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _enrollmentPageState createState() => _enrollmentPageState();
}

class _enrollmentPageState extends State<enrollmentPage> {
  int daysPerMonth = 0;
  bool wantPT = false;
  List<String> selectedClasses = [];

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<String> getUserId(String email) async {
    var url = Uri.parse("http://192.168.56.1/mobileproject/getUserId.php");
    var response = await http.post(url, body: {"email": email});

    var data = json.decode(response.body);
    return data["userId"];
  }

  int calculatePrice() {
    int basePrice = daysPerMonth * 2;
    int ptPrice = wantPT ? 100 : 0;
    int classesPrice = selectedClasses.length * 20;
    return basePrice + ptPrice + classesPrice;
  }

  Future<void> enroll() async {
    String userId = await getUserId(widget.userEmail);
    int totalPrice = calculatePrice();

    var url = Uri.parse("http://192.168.56.1/mobileproject/enrollments.php");
    var response = await http.post(url, body: {
      "userId": userId,
      "daysPerMonth": daysPerMonth.toString(),
      "wantPT": wantPT ? "1" : "0",
      "classes": selectedClasses.join(","),
      "totalPrice": totalPrice.toString(),
    });

    var data = json.decode(response.body);
    if (data.containsKey("status") && data["status"] == "Success") {
      _showSnackBar("Enrollment successful");
    } else {
      _showSnackBar("Enrollment failed");
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
      return page2();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text(
          'Gym Enrollment',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Days Per Month: ${daysPerMonth * 2}\$",
              style: TextStyle(fontSize: 18),
            ),
            Slider(
              activeColor: Colors.grey,
              inactiveColor: Colors.grey[900],
              value: daysPerMonth.toDouble(),
              onChanged: (value) {
                setState(() {
                  daysPerMonth = value.toInt();
                });
              },
              min: 0,
              max: 30,
              divisions: 30,
              label: daysPerMonth.toString(),
            ),
            SizedBox(height: 20),
            Text(
              "Want Personal Trainer: ${wantPT ? 'Yes' : 'No'}",
              style: TextStyle(fontSize: 18),
            ),
            Switch(
              activeColor: Colors.grey,
              value: wantPT,
              onChanged: (value) {
                setState(() {
                  wantPT = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              "Select Classes:",
              style: TextStyle(fontSize: 18),
            ),
            CheckboxListTile(
              activeColor: Colors.grey,
              title: Text("Pilates"),
              value: selectedClasses.contains("Pilates"),
              onChanged: (value) {
                setState(() {
                  value!
                      ? selectedClasses.add("Pilates")
                      : selectedClasses.remove("Pilates");
                });
              },
            ),
            CheckboxListTile(
              activeColor: Colors.grey,
              title: Text("Zumba"),
              value: selectedClasses.contains("Zumba"),
              onChanged: (value) {
                setState(() {
                  value!
                      ? selectedClasses.add("Zumba")
                      : selectedClasses.remove("Zumba");
                });
              },
            ),
            CheckboxListTile(
              activeColor: Colors.grey,
              title: Text("Yoga"),
              value: selectedClasses.contains("Yoga"),
              onChanged: (value) {
                setState(() {
                  value!
                      ? selectedClasses.add("Yoga")
                      : selectedClasses.remove("Yoga");
                });
              },
            ),
            CheckboxListTile(
              activeColor: Colors.grey,
              title: Text("Aerobics"),
              value: selectedClasses.contains("Aerobics"),
              onChanged: (value) {
                setState(() {
                  value!
                      ? selectedClasses.add("Aerobics")
                      : selectedClasses.remove("Aerobics");
                });
              },
            ),
            CheckboxListTile(
              activeColor: Colors.grey,
              title: Text("Kickboxing"),
              value: selectedClasses.contains("Kickboxing"),
              onChanged: (value) {
                setState(() {
                  value!
                      ? selectedClasses.add("Kickboxing")
                      : selectedClasses.remove("Kickboxing");
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                enroll();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Enroll"),
            ),
            SizedBox(height: 20),
            Text(
              "Total Price: ${calculatePrice()}\$",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
