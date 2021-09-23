import 'package:flutter/material.dart';
import 'package:productivity_app/constants/colors.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged onChanged;

  const SearchBox({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20 / 4, // 5 top and bottom
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColorShadow,
            offset: Offset(0, 3),
            blurRadius: 4,
            spreadRadius: 1,
          )
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: kPrimaryTextColor),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'Search',
          icon: Icon(Icons.search),
          hintStyle: TextStyle(color: kSecondaryTextColor),
        ),
      ),
    );
  }
}
