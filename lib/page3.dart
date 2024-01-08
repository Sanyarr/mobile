import 'package:sanyar/page4.dart';
import 'package:flutter/material.dart';


class page3 extends StatefulWidget {
  page3({Key? key}) : super(key: key);

  @override
  _page3State createState() {
    return _page3State();
  }
}

class _page3State extends State<page3> {
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
    String name = ModalRoute.of(context)?.settings.arguments as String;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Welcome'),
        centerTitle: true,
        backgroundColor: Colors.grey,),
      body: Center(
        child: Container(

          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background2.jpg'),
               fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text('Hello $name, welcome to your fitness journey! See you soon at our center!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.grey,
                  child: Center(child: Text('Whether you\'re here to break a sweat, set new goals, or find inspiration, I\'m here to support you. Let\'s embark on this empowering adventure together. Get ready to unleash your full potential! I added some exercises for you for days when you do not feel like hitting the gym but still want to move those muscles!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  )),
                ),
                ElevatedButton( style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                ),onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder){
                    return page4();
                  }));
                }, child: Text('Let\'s start',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

