import 'package:app_ui/pages/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mysql1/mysql1.dart';

class Homescreen extends StatefulWidget {
  final MySqlConnection connection;

  const Homescreen({Key? key, required this.connection}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen> {
  bool isHidden = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String username = '';
  String password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 261,
                height: 261,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/logo.png')))),
          ),
          const SizedBox(height: 28),
          Text(
            'MUNICIPALITY OF MINGLANILLA',
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'MARKET OFFICE',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 76),
          Text(
            'USERNAME',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 50,
            width: 350,
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
          ),
          const SizedBox(height: 25),
          Text(
            'PASSWORD',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 50,
            width: 350,
            child: TextField(
              controller: passwordController,
              obscureText: isHidden,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: InkWell(
                  onTap: () {
                    _togglePasswordVisible();
                  },
                  child: const Icon(
                    Icons.visibility,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Container(
            height: 60,
            width: 350,
            decoration: const BoxDecoration(
                color: Color(0xFFF5C61F),
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    _checkCredentials();
                  },
                  child: Text(
                    'LOG IN',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                )),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: 350,
            height: 17,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'OR',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF81ABC3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 45),
          Text(
            'FORGOT PASSWORD',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'SHOW HINT',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      )),
    );
  }

  void _togglePasswordVisible() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  void _checkCredentials() async {
    // Get the input values from the text fields
    String inputUsername = usernameController.text;
    String inputPassword = passwordController.text;

    try {
      // Perform the database query to check if the credentials exist
      final results = await widget.connection.query(
        'SELECT * FROM users WHERE username = ? AND password = ?',
        [inputUsername, inputPassword],
      );

      if (results.isNotEmpty) {
        // Credentials are correct
        // Navigate to the Mainscreen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Mainscreen(),
          ),
        );
      } else {
        // Credentials are incorrect
        // Display an error message
        _showMessage('Invalid user');
      }
    } catch (e) {
      // Handle database errors
      print('Database error: $e');
      // Display an error message
      _showMessage('Database error');
    }
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
