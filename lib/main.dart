import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo/Screens/Wrapper.dart';
import 'API/Authentication.dart';
import 'Models/CustomUser.dart';
import 'package:todo/Provider/TodoProvider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static String title = "ToDo";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => TodoProvider()),
        StreamProvider<CustomUser?>.value(value: Authentication().user, initialData: null,),
      ],
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.green[100],
        ),

        home: const Wrapper(),
      ),
    );
  }
}

