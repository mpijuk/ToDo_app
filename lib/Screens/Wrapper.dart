import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Screens/Home/Home.dart';
import 'package:todo/Screens/Authenticate/Authenticate.dart';
import 'package:todo/Models/CustomUser.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);

    // return either Home or Authenticate widget
    if(user == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}