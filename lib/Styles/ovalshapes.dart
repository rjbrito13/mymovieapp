import 'package:flutter/material.dart';

class OvalShape extends StatefulWidget {
  final String category;

  const OvalShape({Key? key, required this.category}) : super(key: key);

  @override
  State<OvalShape> createState() => _OvalShapeState();
}

class _OvalShapeState extends State<OvalShape> {
 

  @override
  Widget build(BuildContext context) {
     final category = widget.category;

    return Container(
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(40),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  width: 70,
  height: 28,
  child:  Center(
          child: Text(
            category,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
);
    
  }
}