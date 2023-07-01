import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
            elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
        colorScheme:
            const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Hello'),
          ),
          body: Column(
            children: [
              const Center(child: Text('Flutter Demo Home Page')),
              Builder(
                builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AuthScreen.routeName);
                      },
                      child: const Text('click'));
                }
              ),
            ],
          )),
    );
  }
}
