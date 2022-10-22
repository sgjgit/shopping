import 'package:flutter/material.dart';
import 'package:shopping/CONSTANTS/constants.dart';

class TT extends StatefulWidget {
  const TT({super.key});

  @override
  State<TT> createState() => _TTState();
}

class _TTState extends State<TT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableListView.builder(
          itemBuilder: (context, index) {
            return Container(
              height: 25,
              width: 50,
              margin: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.green,
              key: ValueKey(index),
              child: Text("$index"),
            );
          },
          itemCount: 10,
          onReorder: (o, n) {
            yellow(o);
            green(n);
          }),
    );
  }
}
