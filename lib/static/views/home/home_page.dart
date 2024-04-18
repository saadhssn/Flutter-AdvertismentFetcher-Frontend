// ignore_for_file: prefer_const_literals_to_create_immutables, unused_local_variable, sort_child_properties_last
// ignore_for_file: prefer_const_constructors, unused_import
import 'package:advertisment_fetcher/static/views/home/account_page.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../utils/my_colors.dart';
import '../../utils/my_style.dart';

import '../../widgets/cards/advertisment_card.dart';
import '../../widgets/cards/categories_card.dart';
import '../../widgets/my_text.dart';
import '../../widgets/search_textfield.dart';
import 'CameraPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // for navbar tab switching
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    //HEIGHT-WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColor.white1,
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: height * 0.05),
                      MyText(
                        text: "Hey!",
                        textStyle: MyStyle.black1_30_800,
                      ),
                      MyText(
                        text: "Find your advertisment!",
                        textStyle: MyStyle.grey6_15_500,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              SearchTextField(),
              SizedBox(height: height * 0.03),
              Row(
                children: [
                  Column(
                    children: [
                      MyText(
                        text: "Categories",
                        textStyle: MyStyle.black1_20_800,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              CategoriesCard(
                images: [
                  'images/car_image.png',
                   'images/home_image.png',
                  'images/cart_image.png',
                  'images/watch_image.png',
                ],
                texts: ["Cars", "Houses", "Accessories", "Watches"],
              ),
              SizedBox(height: height * 0.03),
              AdCard()
            ],
          ),
        ),
      ),
      //Bottom Navigation bar
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey[650],
        selectedItemColor: MyColor.blue3,
        // unselectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 14),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          if(index==2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>AccountPage())
            );
          }
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
      //Floating action button
      floatingActionButton: SizedBox(
        height: height * 0.06,
        child: FloatingActionButton(
          onPressed: () {
            // Navigate to another page when the button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraPage()), // Replace CameraPage with your desired page
            );
          },
          child: Icon(Icons.camera_alt, size: 22),
          backgroundColor: MyColor.blue3,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
