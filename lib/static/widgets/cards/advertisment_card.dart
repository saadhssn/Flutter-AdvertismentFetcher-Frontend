// ignore_for_file: prefer_const_literals_to_create_immutables, unused_local_variable
// ignore_for_file: prefer_const_constructors, unused_import
import 'package:flutter/material.dart';

import '../../utils/my_colors.dart';
import '../../utils/my_style.dart';
import '../my_text.dart';

class AdCard extends StatelessWidget {
  const AdCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //HEIGHT-WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.3,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              height: height * 0.09,
              decoration: BoxDecoration(
                color: MyColor.white1,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    // spreadRadius: 3,
                    blurRadius: 7,
                    // offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.all(8)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      MyText(
                        text: "Advertisment 1!",
                        textStyle: MyStyle.black1_16_000,
                      ),
                      SizedBox(
                          height: 4), // Add some spacing between the two texts
                      MyText(
                        text: "20/12/23",
                        textStyle: MyStyle.grey1_15_000,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
