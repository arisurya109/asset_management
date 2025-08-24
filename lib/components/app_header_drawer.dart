import 'package:flutter/material.dart';

class AppHeaderDrawer extends StatelessWidget {
  const AppHeaderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      height:
          MediaQuery.of(context).viewPadding.top +
          AppBar().preferredSize.height,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.teal, width: 1)),
      ),
      child: const Text(
        'Asset Managament',
        style: TextStyle(
          fontSize: 20,
          color: Colors.teal,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
