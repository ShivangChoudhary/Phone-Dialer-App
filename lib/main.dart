import 'package:flutter/material.dart';
import 'package:phone_dialer_app/screens/block_screen.dart';
import 'package:phone_dialer_app/screens/call_history.dart';
import 'package:phone_dialer_app/screens/contacts_screen.dart';
import 'package:phone_dialer_app/screens/dial_pad.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeMode = await getThemeMode();
  runApp(MyApp(themeMode: themeMode));
}

Future<ThemeMode> getThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  return isDarkMode ? ThemeMode.dark : ThemeMode.light;
}

class MyApp extends StatefulWidget {
  final ThemeMode themeMode;
  const MyApp({Key? key, required this.themeMode}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.themeMode;
  }

  void toggleTheme() async {
    final newThemeMode =
    _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setState(() {
      _themeMode = newThemeMode;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', newThemeMode == ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Dialer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: MainScreen(toggleTheme: toggleTheme),
    );
  }
}

class MainScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const MainScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DialPadScreen(),
    CallHistoryScreen(),
    ContactsScreen(),
    BlockListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Dialer'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white, // Background color adapts to theme

        selectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.lightBlueAccent
            : Colors.blueAccent, // Better visibility for selected item

        unselectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade400
            : Colors.grey.shade600, // Ensures unselected items are readable

        showUnselectedLabels: true, // Ensures all labels are visible
        type: BottomNavigationBarType.fixed, // Prevents shifting effect

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dialpad),
            label: 'Dial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.block),
            label: 'Blocked',
          ),
        ],
      ),

    );
  }
}
