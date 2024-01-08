import 'package:sanyar/page1.dart';
import 'package:sanyar/page3.dart';
import 'package:flutter/material.dart';


class page2 extends StatefulWidget {
  page2({Key? key}) : super(key: key);

  @override
  _page2State createState() {
    return _page2State();
  }
}

class _page2State extends State<page2> {
  TextEditingController controller = new TextEditingController();
  String txt = 'Welcome';
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

                Text('Every step, every rep, brings you closer to the best version of yourself.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),),
               Container(
                 width: 300,
                 height: 300,
                 color: Colors.grey,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Text('Please enter your name',style: TextStyle(),),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 15),
                       child: TextField(
                         controller: controller,
                         decoration:
                         InputDecoration(
                         labelText:'Enter your name: ' ,
                           labelStyle: TextStyle(color: Colors.black),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(8),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderSide:
                             BorderSide(color: Colors.black),
                           ),
                          ),

                       ),
                     )
                   ],
                 ),
               ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder){
                    if(controller.text.isEmpty)
                      return page1();
                      else
                      return page3();
                  },settings: RouteSettings(arguments: controller.text)));
                }, child: Text('Next Step',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),

              ],
            ),
          ),
        ),
      ),

    );
  }
}
