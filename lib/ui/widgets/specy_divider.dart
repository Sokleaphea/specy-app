import 'package:flutter/material.dart';

class SpecyDivider extends StatelessWidget {
  const SpecyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1, 
      height: 20,
      color: Colors.grey,
      margin: const EdgeInsets.symmetric(horizontal: 10), // spacing
    );
  }
}