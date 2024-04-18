// ignore_for_file: prefer_const_literals_to_create_immutables, unused_local_variable
// ignore_for_file: prefer_const_constructors, unused_import
import 'package:flutter/material.dart';

import '../../utils/my_colors.dart';
import '../../utils/my_style.dart';
import '../my_text.dart';

class CategoriesCard extends StatefulWidget {
  final List<String> images;
  final List<String> texts;

  const CategoriesCard({
    required this.images,
    required this.texts,
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesCard> createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  int selectedCardIndex = 0;
  @override
  Widget build(BuildContext context) {
    //HEIGHT-WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          bool isSelected = index == selectedCardIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCardIndex = index;
              });
            },
            child: SizedBox(
              width: width * 0.37,
              child: Center(
                child: Container(
                  width: width * 0.3,
                  decoration: BoxDecoration(
                    color: isSelected ? MyColor.blue3 : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // spreadRadius: 5,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Image.asset(
                          widget.images[index],

                          fit: BoxFit
                              .contain, // Replace with your image asset path
                          width: 100,
                          height: 100,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      MyText(
                        text: widget.texts[index],
                        // text: "Cars",
                        textStyle: isSelected
                            ? MyStyle.white1_12_700
                            : MyStyle.black1_11_500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
