import 'package:flutter/material.dart';

class StatusAlert extends StatelessWidget {
  const StatusAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height - 50,
          left: MediaQuery.of(context).size.width - 25,
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            color: Colors.amberAccent,
            height: 100,
          ),
        )
      ],
    );
  }
}
