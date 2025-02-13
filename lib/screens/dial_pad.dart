import 'package:flutter/material.dart';


class DialPadScreen extends StatefulWidget {
  @override
  _DialPadScreenState createState() => _DialPadScreenState();
}

class _DialPadScreenState extends State<DialPadScreen> {
  String _dialedNumber = '';
  String _selectedCountryCode = '+91';

  // List of country codes with flags
  final List<Map<String, String>> _countries = [
    {"code": "+1", "flag": "🇺🇸"},  // USA
    {"code": "+44", "flag": "🇬🇧"}, // UK
    {"code": "+91", "flag": "🇮🇳"}, // India
    {"code": "+61", "flag": "🇦🇺"}, // Australia
    {"code": "+49", "flag": "🇩🇪"}, // Germany
    {"code": "+81", "flag": "🇯🇵"}, // Japan
  ];

  void _addDigit(String digit) {
    setState(() {
      _dialedNumber += digit;
    });
  }

  void _deleteDigit() {
    setState(() {
      if (_dialedNumber.isNotEmpty) {
        _dialedNumber = _dialedNumber.substring(0, _dialedNumber.length - 1);
      }
    });
  }

  Widget _buildDialButton(String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _addDigit(text),
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.blueGrey.shade800 // Dark mode color
                : Colors.blueGrey.shade300, // Light mode color
          ),
          height: 80,
          width: 80,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 26,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      body: Column(
        children: [
          SizedBox(height: 50),

          // Country Code Selector with Flag
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: DropdownButton<String>(
              dropdownColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.blueGrey.shade900
                  : Colors.white,
              value: _selectedCountryCode,
              onChanged: (newValue) {
                setState(() {
                  _selectedCountryCode = newValue!;
                });
              },
              items: _countries.map<DropdownMenuItem<String>>((Map<String, String> country) {
                return DropdownMenuItem<String>(
                  value: country["code"],
                  child: Row(
                    children: [
                      Text(country["flag"]!, style: TextStyle(fontSize: 20)), // Display flag
                      SizedBox(width: 10),
                      Text(
                        country["code"]!,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Display Dialed Number
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: Text(
              '$_selectedCountryCode $_dialedNumber',
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),

          SizedBox(height: 20),

          // Dial Pad
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRow(['1', '2', '3']),
                _buildRow(['4', '5', '6']),
                _buildRow(['7', '8', '9']),
                _buildRow(['*', '0', '#']),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Call Button
                    IconButton(
                      onPressed: () {
                        print("Calling $_selectedCountryCode$_dialedNumber");
                      },
                      icon: Icon(Icons.call, color: Colors.green, size: 40),
                    ),
                    SizedBox(width: 50),

                    // Delete Button
                    IconButton(
                      onPressed: _deleteDigit,
                      icon: Icon(Icons.backspace, color: Colors.red, size: 30),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: digits.map((digit) => _buildDialButton(digit)).toList(),
    );
  }
}
