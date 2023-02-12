

import 'package:flutter/material.dart';

class UpdateScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('update'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Please update to the latest Version',style: TextStyle(fontSize: 20),),),
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextButton(onPressed: (){

              }, child: Text('Update',style: TextStyle(fontSize: 20,color: Colors.white),),),
            ),
          )
        ],
      ),
    );
  }
}
