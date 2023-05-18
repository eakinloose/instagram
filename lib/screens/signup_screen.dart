import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/dimensions.dart';
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

  //dispose controllers
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _passwordController.dispose();
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
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg"),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {},
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
                onTap: () {},
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
                  child: const Text("Sign Up"),
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
                        "Sign In.",
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
