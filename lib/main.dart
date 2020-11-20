import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/calculator.dart';
import 'package:provider/provider.dart';
import "appTheme.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var currentTheme = prefs.getString("theme") ?? "light";
    runApp(
      ChangeNotifierProvider(
        create: (_) => AppTheme(currentTheme),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getData() async {
    final prefs = await SharedPreferences.getInstance();
    final String appTheme = (prefs.getString('theme') ?? "light");
    Provider.of<AppTheme>(context, listen: false).changeTheme(appTheme);
  }

  @override
  Widget build(BuildContext context) {
    /// ENFORCE DEVICE ORIENTATION PORTRAIT ONLY
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    final themeNotifier = Provider.of<AppTheme>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme() == "dark"
          ? ThemeData.dark().copyWith(
              primaryColor: Colors.black, scaffoldBackgroundColor: Colors.black)
          : ThemeData.light().copyWith(
              primaryColor: Colors.white,
            ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Basic Calculator',
              style: TextStyle(
                  color: Provider.of<AppTheme>(context, listen: false)
                              .getTheme() ==
                          "dark"
                      ? Colors.white
                      : Colors.black),
            ),
            iconTheme: new IconThemeData(
                color: themeNotifier.getTheme() == "dark"
                    ? Colors.white
                    : Colors.black),
            elevation: 0.2,
            actions: <Widget>[
              IconButton(
                icon: themeNotifier.getTheme() == "dark"
                    ? Icon(
                        Icons.wb_sunny,
                      )
                    : Icon(Icons.brightness_2),
                onPressed: () async {
                  String currentTheme = themeNotifier.getTheme();
                  final prefs = await SharedPreferences.getInstance();
                  if (currentTheme == "light") {
                    prefs.setString("theme", "dark");
                    themeNotifier.changeTheme("dark");
                  } else if (currentTheme == "dark") {
                    prefs.setString("theme", "light");
                    themeNotifier.changeTheme("light");
                  }
                  setState(() {
                    getData();
                  });
                },
              ),
            ],
          ),
          body: MainCal(),
        ),
      ),
    );
  }
}

