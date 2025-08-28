import 'package:flutter/material.dart';

class LocationComponent extends StatelessWidget {
  final String locationName;
  const LocationComponent({super.key, required this.locationName});

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.sizeOf(context).width;
    return Container(
      width: screenSize - screenSize / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
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
          Icon(Icons.location_pin),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  locationName,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
