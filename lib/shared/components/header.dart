import 'package:flutter/cupertino.dart';

class Header extends StatelessWidget {

  const Header({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x80E9EFFF),
            Color(0x80A7B1E9),
          ],
        ),
        // borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: child,
    );
  }
}
