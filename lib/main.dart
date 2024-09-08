import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vehicle Monitoring',
      theme: ThemeData(
        primaryColor: const Color(0xFFFFFAF3), // Primary color
        scaffoldBackgroundColor: const Color(0xFFFFFAF3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFFAF3),
          iconTheme: IconThemeData(color: Color(0xFF111111)),
          titleTextStyle: TextStyle(
            color: Color(0xFF111111),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF111111)),
          bodyMedium: TextStyle(color: Color(0xFF111111)),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF111111)),
      ),
      home: const LoginPage(), // Set the LoginPage as the initial route
      debugShowCheckedModeBanner: false,
    );
  }
}

// LoginPage
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Color(0xFF111111))),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Color(0xFF111111)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Color(0xFF111111)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111111), // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, navigate to the HomePage
                    Get.off(const HomePage());
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Color(0xFFFFFAF3)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HomePage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedVehicle = 'Tata Motors';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<String>(
          value: selectedVehicle,
          dropdownColor: const Color(0xFFFFFAF3),
          items: <String>['Tata Motors', 'Mahindra'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Color(0xFF111111))),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedVehicle = value!;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Get.to(const ProfilePage(), transition: Transition.leftToRight);
          },
        ),
      ),
      body: buildVehicleMonitoringScreen(),
    );
  }

  Widget buildVehicleMonitoringScreen() {
    return Column(
      children: [
        Image.asset(
          selectedVehicle == 'Tata Motors'
              ? 'assets/images/tata_motors.png'
              : 'assets/images/mahindra.png',
          height: 200,
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(20.0),
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: [
              buildTireInfo('32°C', 'PSI: 30', 'Front Left', false),
              buildTireInfo('31°C', 'PSI: 31', 'Front Right', false),
              buildTireInfo('80°C', 'PSI: 28', 'Rear Left', true),
              buildTireInfo('28°C', 'PSI: 30', 'Rear Right', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTireInfo(String temp, String psi, String label, bool isError) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            temp,
            style: TextStyle(
              color: isError ? Colors.red : const Color(0xFF111111),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            psi,
            style: const TextStyle(fontSize: 16, color: Color(0xFF111111)),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// ProfilePage
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Color(0xFF111111)),
        ),
      ),
      body: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Hi, Amarnath'),
              accountEmail: Text('amarnath@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFFFFAF3),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFF111111)),
              title: const Text('Home', style: TextStyle(color: Color(0xFF111111))),
              onTap: () {
                // Navigate to Home
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFF111111)),
              title: const Text('Settings', style: TextStyle(color: Color(0xFF111111))),
              onTap: () {
                // Navigate to Settings
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.signOutAlt, color: Color(0xFF111111)),
              title: const Text('Logout', style: TextStyle(color: Color(0xFF111111))),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
