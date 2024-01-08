import 'package:sanyar/page2.dart';
import 'package:flutter/material.dart';


class page1 extends StatefulWidget {
  page1({Key? key}) : super(key: key);

  @override
  _page1State createState() {
    return _page1State();
  }
}

class _page1State extends State<page1> {

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
       body: Center(
        child: Container(

          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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

               Text(
                 'Transform your sweat into strength, your effort into progress. Embrace the journey and conquer your fitness goals!',
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                   color: Colors.white,
                 ),
               ),

               ElevatedButton(
                 onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
                     return page2();
                   }));
                 },
                 style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                 ),
                 child: Text('Get Started',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
               )
             ],
           ),
         ),
        ),
      ),

    );

  }
}
