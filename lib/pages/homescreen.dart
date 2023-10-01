import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
