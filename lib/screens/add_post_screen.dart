import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
  //   return Center(
  //     child: IconButton(
  //       icon: const Icon(Icons.upload),
  //       onPressed: (){},),
  //   );
  // }


    return Scaffold(
      appBar:  AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
          ),
          title: const Text("Post to"),
          centerTitle: false,
          actions: [
            TextButton(onPressed: (){}, child: const Text('Post', style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              ),))
          ],
        ),
        body: Column( 
          children: [
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage:
                   NetworkImage(
                    'https://plus.unsplash.com/premium_photo-1714051661316-4432704b02f8?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: TextField( 
                    decoration: const InputDecoration(
                      hintText: "Write a caption.",
                      border: InputBorder.none,

                    ),
                    maxLines: 8,
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: AspectRatio(
                    aspectRatio: 487/451,
                    child: Container(
                      decoration: BoxDecoration( 
                        image: DecorationImage( 
                          image: NetworkImage(
                            'https://plus.unsplash.com/premium_photo-1714051661316-4432704b02f8?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                          ),
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                        )
                      ),
                    )
                  ),
                ),
                const Divider(),
              ],
              
            ),
            
          ],
        )
    );
  } 
}