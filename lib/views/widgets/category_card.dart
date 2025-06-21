import 'package:final_project/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  CategoryCard({
    super.key,
    required this.catName,
    required this.catIcon,
    required this.currentCat,
  });
  String catName;
  IconData catIcon;
  String currentCat;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 20),
      color: currentCat != catName ? Config.primaryColor : Config.clickedColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FaIcon(catIcon, color: Colors.white),
            const SizedBox(width: 20),
            Text(
              catName,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
