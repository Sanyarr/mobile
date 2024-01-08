import 'package:sanyar/page5.dart';
import 'package:sanyar/page6.dart';
import 'package:sanyar/page8.dart';
import 'package:flutter/material.dart';

import 'Page7.dart';

class page4 extends StatefulWidget {
  page4({Key? key}) : super(key: key);

  @override
  _page4State createState() {
    return _page4State();
  }
}

class _page4State extends State<page4> {
  String txt='Choose Your Workout';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('$txt'),centerTitle: true,backgroundColor: Colors.grey,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                // Action to perform when the container is tapped
                Navigator.of(context).push(MaterialPageRoute(builder: (builder){
                  return Page5();
                }));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Leg Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                // Action to perform when the container is tapped
                Navigator.of(context).push(MaterialPageRoute(builder: (builder){
                  return Page6();
                }));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Chest Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),Center(
    child: GestureDetector(
    onTap: () {
    // Action to perform when the container is tapped
      Navigator.of(context).push(MaterialPageRoute(builder: (builder){
        return Page7();
      }));
    },
                child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                child: Text(
                'Arms Day',
                style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                ),
                ),
                ),
                ),
                ),
                ),
                      Center(
            child: GestureDetector(
              onTap: () {
                // Action to perform when the container is tapped
                Navigator.of(context).push(MaterialPageRoute(builder: (builder){
                  return Page8();
                }));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Back Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}

