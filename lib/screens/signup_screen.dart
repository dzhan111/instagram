import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameConstroller = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameConstroller.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }


  void signUpUser () async { 
    if (_image == null) {
        showSnackBar("Please select an image.", context);
        return;
    }
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text, 
      password: _passwordController.text,
      username:_usernameConstroller.text ,
      bio:_bioController.text,
      file: _image! ,
    );
    if(res != 'success') {
      showSnackBar(res, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Container(), flex: 2),
            //svg image
            // ignore: deprecated_member_use
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(height: 64),


            //circular widget to show PFP
            Stack(
              children: [
                _image != null ? CircleAvatar(
                  radius: 64,
                  backgroundImage: MemoryImage(_image!),
                ): 
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png'
                      ),
                ),
                Positioned(
                  bottom: -10, 
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage, 
                    icon: const Icon(
                      Icons.add_a_photo),),)
              ],
            ),
             const SizedBox(height: 64),
            TextFieldInput(
                textEditingController: _usernameConstroller,
                isPass: false,
                hintText: 'Enter your username',
                textInputType: TextInputType.text),
            const SizedBox(height: 24),
            TextFieldInput(
                textEditingController: _emailController,
                isPass: false,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress),
            //text email
            const SizedBox(height: 24),
            //password
            TextFieldInput(
                textEditingController: _passwordController,
                isPass: true,
                hintText: 'Enter your password',
                textInputType: TextInputType.text),
            const SizedBox(height: 24),
            TextFieldInput(
                textEditingController: _bioController,
                isPass: false,
                hintText: 'Enter your bio',
                textInputType: TextInputType.text),
            const SizedBox(height: 24),

            //signup button
            InkWell(
              onTap: signUpUser,
              child: _isLoading ? 
                const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                  
                ): Container(
                child: const Text("Sign up"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(child: Container(), flex: 2),

            //sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Already have an Account? "),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Log in ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
