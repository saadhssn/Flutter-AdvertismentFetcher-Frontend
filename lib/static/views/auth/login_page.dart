// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously, unnecessary_null_comparison, avoid_print, unused_element, use_key_in_widget_constructors, must_be_immutable

import 'package:advertisment_fetcher/static/views/auth/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/LoginService.dart';
import '../home/UserModel.dart';
import '../home/home_page.dart';
import '../home/userProvider.dart';
// ignore_for_file: prefer_const_constructors, unused_import

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // /LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final LoginService apiService = LoginService();

  final GlobalKey<FormFieldState<String>> passwordKey = GlobalKey();

  bool obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void _login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    //Authenticate user
    final response = await apiService.loginUser(email, password);
    print(response);
    if (response != null) {
      final sp = await SharedPreferences.getInstance();
      await sp.setString(('access_token'), response);
      print("ACcessToken here=>" + sp.getString('access_token')!);
      print('login successful');

      final userResponse=await apiService.getUserInfo(response);
      print(userResponse);
if(userResponse!=null){
  final userModel = UserModel(
    id: userResponse['id'],
    firstName: userResponse['firstName'],
    lastName: userResponse['lastName'],
    email: userResponse['email']

  );
  Provider.of<userProvider>(context, listen: false).setUser(userModel);
}
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print('Invalid credential');
    }
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 60),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          // labelText: 'Email',
                          // labelStyle: TextStyle(
                          //     color: Colors.blue,
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.bold),
                          // hintText: 'example@gmail.com',
                          // hintStyle:
                          //     TextStyle(color: Colors.blue, fontSize: 15),
                          // enabledBorder: UnderlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.blue)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          hintText: 'Enter your email or phone number',
                          hintStyle: TextStyle(color: Colors.grey[350]),
                          prefixIcon:
                              Icon(Icons.email, color: Colors.grey[500]),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        key: passwordKey,
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          //   labelText: 'Password',
                          //   labelStyle: TextStyle(
                          //       color: Colors.blue,
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.bold),
                          //   hintText: '*****',
                          //   hintStyle:
                          //       TextStyle(color: Colors.blue, fontSize: 15),
                          //   suffixIcon: IconButton(
                          //     icon: Icon(
                          //       obscurePassword
                          //           ? Icons.visibility
                          //           : Icons.visibility_off,
                          //       color: Colors.blue,
                          //     ),
                          //     onPressed: () {
                          //       _togglePasswordVisibility(); // Toggle the password visibility
                          //     },
                          //   ),
                          //   enabledBorder: UnderlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.blue)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.grey[350]),
                          prefixIcon: Icon(Icons.lock, color: Colors.grey[500]),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey[500],
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {
                                  // "Remember me" checkbox functionality can't be implemented as a stateless widget.
                                },
                              ),
                              Text(
                                'Remember me',
                                style: TextStyle(
                                    color: Colors.blue[300], fontSize: 16),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // Implement the "Forgot password" functionality here
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                  color: Colors.blue[300], fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      FractionallySizedBox(
                        widthFactor: 0.99,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            child: Text('Login')),
                      ),
                      SizedBox(height: 20),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => SignUpScreen()));
                      //   },
                      //   child: Text(
                      //     "Don't have an account? Sign up",
                      //     style: TextStyle(
                      //       color: Colors.grey[600],
                      //
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Sign up",
                                style: TextStyle(
                                  color: Colors.blue[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Widget buildRememberMe(){
//   return Row(
//     children: [
//       Checkbox(value: false,onChanged: (value){},),
//       Text("Remember me", style: TextStyle(
//         color:Colors.blue[300],
//       ),)
//     ],
//   );
// }
//
// Widget buildForgotPassword(){
//   return Align(
//     alignment: Alignment.centerRight,
//       child: TextButton(
//         onPressed: (){},
//         child: Text("Forgot Password?",style:
//           TextStyle(color: Colors.blue[300]),),
//
//       ),
//   );
// }
