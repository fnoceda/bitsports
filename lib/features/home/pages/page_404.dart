import 'package:flutter/material.dart';

class Page404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            Spacer(),
            Text(
              '404',
              style: TextStyle(fontSize: 200),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
