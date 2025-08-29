import 'package:flutter/material.dart';

class RecomendationsComponent extends StatelessWidget {
  final String inputText;
  final IconData icon;
  final Color color;
  final List<String> recomendations;

  const RecomendationsComponent({
    super.key,
    required this.inputText,
    required this.icon,
    required this.color,
    required this.recomendations,
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
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(icon),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    inputText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: recomendations.length * 30,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recomendations.length,
                      itemBuilder: (context, index) {
                        return Text(
                          "- ${recomendations[index]}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
