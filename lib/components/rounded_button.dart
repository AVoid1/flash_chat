import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {required this.colour, required this.onPress, required this.title});

  final String title;
  final Color colour;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Material(
        elevation: 5,
        color: colour,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200,
          height: 42,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
