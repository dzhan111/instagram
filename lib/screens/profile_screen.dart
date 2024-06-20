import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text('username'),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage('https://plus.unsplash.com/premium_photo-1717916843908-7bbee16bad20?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8'),
                      radius: 40
                      ),
                    Expanded(
                      flex: 1,
                      child: Row(mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildStatColumn(20, "posts"),
                        buildStatColumn(150, "followers"),
                        buildStatColumn(20, "following"),
                      ],
                      ),
                    )
                  ]
                  


                  ),

                
              ],
            )
          )
          ]
      ),


    );
  }

  Column buildStatColumn(int num, String label) {
    return Column( 
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(num.toString(), 
        style: const TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.bold,),),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(label, 
          style: const TextStyle(
            fontSize: 15, 
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            ),
          ),
        ),

      ],
    );
  }
}