import 'package:flutter/material.dart';

class RoundedContainerCard extends StatelessWidget {
  const RoundedContainerCard({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
