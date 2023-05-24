// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/responsive/mobile_screen_layout.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/responsive/web_screen_layout.dart';

import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/dimensions.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/widgets/text_field_input.dart';
import 'package:instagram/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  // input controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _profileImage;

  bool _isLoading = false;

  //dispose controllers
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _passwordController.dispose();
  }

  void selectImage() async {
    Uint8List pickedImage = await pickImage(ImageSource.gallery);

    setState(() {
      _profileImage = pickedImage;
    });
  }

  void _resetForm() {
    _emailController.clear();
    _usernameController.clear();
    _passwordController.clear();
    _bioController.clear();
  }

  void _signupUser() async {
    String? response;

    if (_emailController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _bioController.text.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    response = await Authmethods().signupUser(
      email: _emailController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      file: _profileImage!,
    );

    setState(() {
      _isLoading = false;
    });

    if (response != "success") {
      showSnackBar(response, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const ResponsiveLayout(
            webLayout: WebScreenLayout(),
            mobileLayout: MobileScreenLayout(),
          ),
        ),
      );
    }

    _resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //TopSpace
              Flexible(flex: 2, child: Container()),
              //svg image
              SvgPicture.asset(
                "assets/instagram.svg",
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                height: 64,
              ),
              largeSpace,
              //Widget to accept and show our selected file
              Stack(
                children: [
                  _profileImage != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_profileImage!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://avatars.mds.yandex.net/i?id=84f3491b83f3b830f6e1fb1b19c74a75573eccb9-8495915-images-thumbs&n=13"),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              mediumSpace,
              //Email input
              TextFieldInput(
                hintText: "Enter your email",
                isPassword: false,
                keyboardType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              smallSpace,
              //Username input
              TextFieldInput(
                hintText: "Choose a Username",
                isPassword: false,
                keyboardType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              smallSpace,
              //Password input
              TextFieldInput(
                hintText: "Enter your password",
                isPassword: true,
                keyboardType: TextInputType.text,
                textEditingController: _passwordController,
              ),
              smallSpace,
              //Bio input
              TextFieldInput(
                hintText: "About Me",
                isPassword: false,
                keyboardType: TextInputType.multiline,
                textEditingController: _bioController,
              ),
              mediumSpace,
              //Submit Button
              InkWell(
                onTap: _signupUser,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: blueColor,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: primaryColor,
                        ))
                      : const Text("Sign Up"),
                ),
              ),

              //Bottom Space
              Flexible(flex: 2, child: Container()),
              //Go to sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Text("Already have an account? "),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const LoginScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
