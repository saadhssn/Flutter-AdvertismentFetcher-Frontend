// ignore_for_file: prefer_const_constructors

import 'package:advertisment_fetcher/static/utils/my_colors.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColor.white1,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search, color: MyColor.grey1),
          ),
          Expanded(
            child: TextField(
              cursorColor: MyColor.grey6,
              decoration: InputDecoration(
                hintText: "Search for an ad",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
