import 'package:flutter/material.dart';

class HomePageComponent extends StatelessWidget {
  final String inputText;
  final IconData icon;
  final Color color;
  const HomePageComponent({
    super.key,
    required this.inputText,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.sizeOf(context).width;
    return Container(
      width: screenSize - screenSize / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(icon),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  inputText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
