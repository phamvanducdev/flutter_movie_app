import 'package:flutter/material.dart';

class AboutInfo extends StatelessWidget {
  final String title;
  final String description;

  const AboutInfo({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Color(0xFF9C9C9C), fontSize: 12.0),
        ),
        const SizedBox(height: 4.0),
        Text(
          description,
          style: const TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
