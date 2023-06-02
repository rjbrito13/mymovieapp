import 'package:flutter/material.dart';

class HoveringWidget extends StatefulWidget {
  const HoveringWidget({super.key});

  @override
  State<HoveringWidget> createState() => _HoveringWidgetState();
}

class _HoveringWidgetState extends State<HoveringWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: const Text("Hover Button"),
        onTap:(){},
        onHover:(val){} 
         /*val--->true when user brings in mouse
         val---> false when brings out his mouse*/
    );
  }
}