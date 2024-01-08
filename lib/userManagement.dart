import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class userManagement extends StatefulWidget {
  @override
  _userManagementState createState() => _userManagementState();
}

class _userManagementState extends State<userManagement> {
  List<User> users = [];
  List<User> displayedUsers = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse("http://192.168.56.1/mobileproject/fetchusers.php"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["users"] != null) {
          setState(() {
            users = (data["users"] as List)
                .map((user) => User.fromJson(user))
                .toList();
            displayedUsers = List.from(users);
          });
        }
      } else {
        print("Failed to fetch users: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }


  Future<void> deleteUser(String userId) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.56.1/mobileproject/deleteusers.php"),
        body: {"id": userId},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["status"] == "Success") {
          fetchUsers();
        } else {
          print("Failed to delete user: ${data["error"]}");
        }
      } else {
        print("Failed to delete user");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> modifyUser(User user) async {
    User? selectedUser;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController emailController =
        TextEditingController(text: user.email);
        final TextEditingController roleController =
        TextEditingController(text: user.role);

        return AlertDialog(
          title: Text('Modify User Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<User>(
                hint: Text('Select a user'),
                value: selectedUser,
                onChanged: (User? newValue) {
                  setState(() {
                    selectedUser = newValue;
                    emailController.text = newValue?.email ?? '';
                    roleController.text = newValue?.role ?? '';
                  });
                },
                items: users.map<DropdownMenuItem<User>>((User user) {
                  return DropdownMenuItem<User>(
                    value: user,
                    child: Text(user.email),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.email, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.black),
                ),
              ),
                  controller: emailController),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(
                labelText: 'Role',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.person, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.black),
                ),
              ),
                  controller: roleController),
            ],
          ),
          actions: [
            TextButton(

              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.black),),
            ),
            TextButton(
              onPressed: () async {
                if (!EmailValidator.validate(emailController.text)) {
                  _showSnackBar("Please enter a valid email address.");
                  return;
                }

                if (roleController.text != 'admin' && roleController.text != 'user') {
                  _showSnackBar("Role can only be 'admin' or 'user'");
                  return;
                }

                await http.post(
                  Uri.parse('http://192.168.56.1/mobileproject/modifyusers.php'),
                  body: {
                    'id': selectedUser?.id ?? '',
                    'email': emailController.text,
                    'role': roleController.text,
                  },
                );

                fetchUsers();

                Navigator.of(context).pop();
              },
              child: Text('Save', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  Future<void> addUser() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController emailController = TextEditingController();
        final TextEditingController passwordController = TextEditingController();
        final TextEditingController roleController = TextEditingController();

        return AlertDialog(
          title: Text('Add New User'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email:'),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter email',
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.email, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.black),
                  ),

                ),
              ),
              SizedBox(height: 10),
              Text('Password:'),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text('Role:'),
              SizedBox(height: 10),
              TextField(
                controller: roleController,
                decoration: InputDecoration(
                  hintText: 'Enter role (admin or user)',
                  labelText: 'Role',
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.person, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel',style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () async {
                if (!EmailValidator.validate(emailController.text)) {
                  _showSnackBar("Please enter a valid email address.");
                  return;
                }

                if (roleController.text != 'admin' && roleController.text != 'user') {
                  _showSnackBar("Role can only be 'admin' or 'user'");
                  return;
                }

                final response = await http.post(
                  Uri.parse('http://192.168.56.1/mobileproject/addusers.php'),
                  body: {
                    'email': emailController.text,
                    'password': passwordController.text,
                    'role': roleController.text,
                  },
                );

                final data = json.decode(response.body);
                _showSnackBar(
                    data["status"] == "Success" ? "User added successfully" : "Failed to add user");
                final userIdResponse = await http.post(
                  Uri.parse('http://192.168.56.1/mobileproject/getUserId.php'),
                  body: {'email': emailController.text},
                );

                final userIdData = json.decode(userIdResponse.body);
                final userId = userIdData['userId'];

                // Add default enrollment data for the new user
                await addDefaultEnrollment(userId);
                fetchUsers();

                Navigator.of(context).pop();
              },
              child: Text('Add User', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }
  Future<void> addDefaultEnrollment(String userId) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/mobileproject/addDefaultEnrollment.php'),
        body: {
          'userId': userId,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

      } else {
        print("Failed to add default enrollment data: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  Future<void> showEnrollmentsDialog(String userId) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.56.1/mobileproject/getEnrollments.php"),
        body: {"userId": userId},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["enrollments"] != null) {
          List<Enrollment> enrollments = (data["enrollments"] as List)
              .map((enrollment) => Enrollment.fromJson(enrollment))
              .toList();

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Enrollments for ${userId}'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var enrollment in enrollments)
                      Text(
                        'Days: ${enrollment.daysPerMonth}\n'
                            'PT: ${enrollment.wantPT}\n'
                            'Classes: ${enrollment.classes}\n',
                      ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close', style: TextStyle(color: Colors.black)),
                  ),
                ],
              );
            },
          );
        } else {
        }
      } else {
        print("Failed to fetch enrollments:");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> editEnrollments(User user) async {
    String userId = user.id;
    int daysPerMonth = user.daysPerMonth ?? 0;
    bool wantPT = user.wantPT ?? false;
    List<String> classes =
    (user.classes != null && user.classes.isNotEmpty) ? user.classes!.split(",") : [];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit Enrollments for ${userId}'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Days Per Month: ${daysPerMonth ?? 0}'),
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
                  Text('Want Personal Trainer: ${(wantPT ?? false) ? 'Yes' : 'No'}'),
                  Switch(
                    activeColor: Colors.grey,
                    value: wantPT ?? false,
                    onChanged: (value) {
                      setState(() {
                        wantPT = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Select Classes:'),
                  CheckboxListTile(
                    activeColor: Colors.grey,
                    title: Text("Pilates"),
                    value: classes.contains("Pilates"),
                    onChanged: (value) {
                      setState(() {
                        value ?? false ? classes.add("Pilates") : classes.remove("Pilates");
                      });
                    },
                  ),
                  CheckboxListTile(
                    activeColor: Colors.grey,
                    title: Text("Zumba"),
                    value: classes.contains("Zumba"),
                    onChanged: (value) {
                      setState(() {
                        value ?? false ? classes.add("Zumba") : classes.remove("Zumba");
                      });
                    },
                  ),
                  CheckboxListTile(
                    activeColor: Colors.grey,
                    title: Text("Yoga"),
                    value: classes.contains("Yoga"),
                    onChanged: (value) {
                      setState(() {
                        value ?? false ? classes.add("Yoga") : classes.remove("Yoga");
                      });
                    },
                  ),
                  CheckboxListTile(
                    activeColor: Colors.grey,
                    title: Text("Aerobics"),
                    value: classes.contains("Aerobics"),
                    onChanged: (value) {
                      setState(() {
                        value ?? false ? classes.add("Aerobics") : classes.remove("Aerobics");
                      });
                    },
                  ),
                  CheckboxListTile(
                    activeColor: Colors.grey,
                    title: Text("Kickboxing"),
                    value: classes.contains("Kickboxing"),
                    onChanged: (value) {
                      setState(() {
                        value ?? false ? classes.add("Kickboxing") : classes.remove("Kickboxing");
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () async {
                    await modifyEnrollments(userId, daysPerMonth, wantPT, classes);

                    Navigator.of(context).pop();
                  },
                  child: Text('Save', style: TextStyle(color: Colors.black)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> modifyEnrollments(String userId, int daysPerMonth, bool wantPT, List<String> classes) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/mobileproject/modifyenrollments.php'),
        body: {
          'userId': userId,
          'daysPerMonth': daysPerMonth.toString(),
          'wantPT': wantPT ? "1" : "0",
          'classes': classes.join(","),
        },
      );

      if (response.statusCode == 200) {
        fetchUsers();
      } else {
        print("Failed to modify enrollments: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text(
          'Fitness Users',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterUsers(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedUsers.length,
              itemBuilder: (context, index) {
                User user = displayedUsers[index];
                return ListTile(
                  title: Text(user.email),
                  subtitle: Text('${user.role}\n'
                      'Days: ${user.daysPerMonth}, PT: ${user.wantPT}, Classes: ${user.classes}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          editEnrollments(user);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[700],
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Edit Enrollments"),
                      ),
                      SizedBox(width: 8), // Add some spacing
                      ElevatedButton(
                        onPressed: () {
                          deleteUser(user.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[700],
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Delete"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (users.isNotEmpty) {
                    modifyUser(users.first);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Modify User Details'),
              ),
              ElevatedButton(
                onPressed: () {
                  addUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Add New User'),
              ),
            ],
          ),
        ],

      ),
    );
  }

  void filterUsers(String query) {
    List<User> filteredUsers = users
        .where((user) =>
    user.email.toLowerCase().contains(query.toLowerCase()) ||
        user.role.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      displayedUsers = filteredUsers;
    });
  }
}

class User {
  final String id;
  final String email;
  final String role;
  final int daysPerMonth;
  final bool wantPT;
  final String classes;

  User({
    required this.id,
    required this.email,
    required this.role,
    required this.daysPerMonth,
    required this.wantPT,
    required this.classes,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      email: json['email'],
      role: json['role'],
      daysPerMonth: json['daysPerMonth'] != null ? int.parse(json['daysPerMonth']) : 0,
      wantPT: json['wantPT'] == '1',
      classes: json['classes'] ?? '',
    );
  }
}




class Enrollment {
  final int daysPerMonth;
  final bool wantPT;
  final String classes;

  Enrollment({
    required dynamic daysPerMonth,
    required dynamic wantPT,
    required this.classes,
  })  : daysPerMonth = daysPerMonth is int
      ? daysPerMonth
      : daysPerMonth is String
      ? int.parse(daysPerMonth)
      : 0,
        wantPT = wantPT is bool
            ? wantPT
            : wantPT is String
            ? wantPT.toLowerCase() == 'true'
            : false;

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      daysPerMonth: json['daysPerMonth'] ?? 0,
      wantPT: json['wantPT'] ?? false,
      classes: json['classes'] ?? '',
    );
  }
}
