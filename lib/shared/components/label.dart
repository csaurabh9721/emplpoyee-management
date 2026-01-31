import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({super.key, required this.str});
  final String str;

  @override
  Widget build(BuildContext context) {
    return Text(str,style: Theme.of(context).textTheme.titleMedium,);
  }
}
