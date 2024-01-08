import 'package:sanyar/training_info.dart';
import 'package:flutter/material.dart';

class Page8 extends StatefulWidget {
  Page8({Key? key}) : super(key: key);

  @override
  _Page8State createState() {
    return _Page8State();
  }
}

class _Page8State extends State<Page8> {
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
      appBar: AppBar(title: Text('welcome to Back day'),centerTitle: true,backgroundColor: Colors.grey),
      body:ListView.builder(itemBuilder: (itemBuilder,position){
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Border color
                width: 2.0, // Border width
              )),
          margin: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 250,height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('${back[position].image}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Container(
                      width: 100,height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${back[position].name}'),
                          SizedBox(height: 8,),
                          Text('${back[position].duration}'),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              IconButton(onPressed: (){}, icon:Icon(Icons.sports_gymnastics,))
            ],
          ),
        ) ;
      },itemCount: back.length,),
    );
  }
}