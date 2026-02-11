import 'package:clapcastflutter/ressources/app_color.dart';
import 'package:clapcastflutter/ressources/app_theme.dart';
import 'package:clapcastflutter/starting/domain/starting_notifier.dart';
import 'package:clapcastflutter/starting/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard/presentation/dashboard_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StartingNotifier()),
      ],
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashScreen(),
          "/dashboard_screen": (context) => const DashboardScreen(),
          //"/search_screen": (context) => const SearchScreen(),
        },
        title: 'Flutter Demo',
        theme: AppTheme.themeData,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _error = false;

  void _incrementCounter() {
    _error = false;
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    } else {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.cyan50,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: AppTheme.bodyLargeBold),
            if (_error)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Pas en dessous de 0",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 32),
          TextButton(
            onPressed: _decrementCounter,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              if (_counter >= 5) {
                Navigator.of(context).pushNamed("/dashboard_screen");
              } else {
                _incrementCounter();
              }
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
