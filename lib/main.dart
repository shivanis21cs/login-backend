import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:demo/services/api_service.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}

/// ---------------- FIRST SCREEN ----------------
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SecondScreen()),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.black, // Black background
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/levelplay.png",
                width: 383,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10), // space between images
              Image.asset(
                "assets/images/subtitle.png",
                width: 283,
                height: 15,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------- SECOND SCREEN ----------------
class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String? selectedMode; // Track selected mode: 'player' or 'coach'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // -------- Images ----------
          Positioned(
            left: 3,
            top: 89,
            child: Image.asset("assets/images/levelplay.png",
                width: 363, height: 157),
          ),
          Positioned(
            left: 32,
            top: 232,
            child: Image.asset("assets/images/img4.png",
                width: 283, height: 28),
          ),

          // -------- Buttons ----------
          Positioned(
            left: 86,
            top: 370,
            child: SizedBox(
              width: 180,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.yellow, width: 2),
                  backgroundColor: selectedMode == 'player' ? Colors.yellow : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    selectedMode = 'player';
                  });
                },
                child: Text("Player",
                    style: TextStyle(color: selectedMode == 'player' ? Colors.black : Colors.white)),
              ),
            ),
          ),
          Positioned(
            left: 85,
            top: 450,
            child: SizedBox(
              width: 180,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.yellow, width: 2),
                  backgroundColor: selectedMode == 'coach' ? Colors.yellow : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    selectedMode = 'coach';
                  });
                },
                child: Text("Coach",
                    style: TextStyle(color: selectedMode == 'coach' ? Colors.black : Colors.white)),
              ),
            ),
          ),

          // -------- Bottom Sign In / Sign Up ----------
          Positioned(
            left: 30,
            bottom: 100,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignInScreen(selectedMode: selectedMode)),
                );
              },
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Color(0xFF00FFB3), // FF = fully visible
                  fontSize: 16,
                ),
              ),

            ),
          ),
          Positioned(
            right: 30,
            bottom: 100,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreen()),
                );
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Color(0xFF00FFB3), // same color
                  fontSize: 16,
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------- PLAYER SCREEN ----------------

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  int? selectedGender; // 1 = Male image, 2 = Female image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Back arrow image
          Positioned(
            left: 36,
            top: 88,
            width: 6,
            height: 11,
            child: Image.asset("assets/images/arrow.png"),
          ),

          // Back text
          Positioned(
            left: 54,
            top: 82,
            child: const Text(
              "Back",
              style: TextStyle(
                color: Color(0xFF00FFB3),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          // Title text
          Positioned(
            left: 90,
            top: 150,
            child: const Text(
              "What's your Gender?",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),

          // 2nd image
          Positioned(
            left: -50,
            top: 130,
            width: 400,
            height: 600,
            child: Image.asset("assets/images/playerbackground.png"),
          ),

          // 3rd image (selectable Male)
          Positioned(
            left: 105,
            top: 210,
            width: 162.95,
            height: 162.95,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedGender = 1;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedGender == 1 ? Colors.yellow : Colors.transparent,
                    width: 4,
                  ),
                ),
                child: Image.asset("assets/images/male.png"),
              ),
            ),
          ),

          // 4th image (selectable Female)
          Positioned(
            left: 105,
            top: 400,
            width: 162.95,
            height: 162.95,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedGender = 2;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedGender == 2 ? Colors.yellow : Colors.transparent,
                    width: 4,
                  ),
                ),
                child: Image.asset("assets/images/female.png"),
              ),
            ),
          ),

          // Continue Button
          Positioned(
            left: 16,
            right: 16,
            bottom: 100,

            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PlayerDetailsPage()),
                );
              },
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//---------------- PlayerDetailsPage ---------------------
class PlayerDetailsPage extends StatelessWidget {
  const PlayerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Back button (arrow + text)
          Positioned(
            top: 48,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate to previous screen
              },
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    "Back",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          // Background Image
          Positioned(
            left: -10,
            top: 150,
            width:200 ,
            height: 443.45,
            child: Image.asset(
              'assets/images/playerbackground.png', // replace with your image path
              fit: BoxFit.cover,
            ),
          ),

          // Bowling Style label
          const Positioned(
            left: 20,
            top: 172,
            child: Text(
              "Bowling Style",
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Bowling style description
          const Positioned(
            left: 20,
            top: 200,
            child: Text(
              "What is your bowling style?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),

          // Bowling style text field
          const Positioned(
            left: 20,
            top: 236,
            width: 313,
            height: 40,
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type here",
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Location label
          const Positioned(
            left: 20,
            top: 296,
            child: Text(
              "Location",
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Location description
          const Positioned(
            left: 20,
            top: 325,
            child: Text(
              "Where are you from?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),

          // Location text field
          const Positioned(
            left: 20,
            top: 360,
            width: 313,
            height: 40,
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type here",
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Starting Date label
          const Positioned(
            left: 20,
            top: 420,
            child: Text(
              "Starting Date",
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Starting Date description
          const Positioned(
            left: 20,
            top: 445,
            child: Text(
              "Since when have you been playing?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),

          // Starting Date text field
          const Positioned(
            left: 20,
            top: 484,
            width: 313,
            height: 40,
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type here",
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Continue button
          Positioned(
            left: 100,
            top: 600, // adjust if needed
            width: 150,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------profile next screen----------------

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.yellow),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main background image
          Positioned(
            left: -10,
            top: 0,
            width: 389,
            height: 323,
            child: Image.asset(
              "assets/images/myprofilebackground.png",
              fit: BoxFit.contain,
            ),
          ),

          // Profile Image
          Positioned(
            left: 107,
            top: 80,
            width: 125,
            height: 120,
            child: Image.asset(
              "assets/images/profile.png",
              fit: BoxFit.contain,
            ),
          ),

          // Name below profile image
          const Positioned(
            left: 148,
            top: 200,
            child: Text(
              "NAME",

              style: TextStyle(color: Colors.white, fontSize: 20 ,fontWeight: FontWeight.bold),

            ),
          ),

          // Stats Image
          Positioned(
            left: 5,
            top: 230,
            width: 340,
            height: 160,
            child: Image.asset(
              "assets/images/myprofiledetails.png",
              fit: BoxFit.contain,
            ),
          ),

          // Inside Stats Texts
          const Positioned(left: 50, top: 250, child: Text("Spin", style: TextStyle(color: Colors.white))),
          const Positioned(left: 150, top: 250, child: Text("Session", style: TextStyle(color: Colors.white))),
          const Positioned(left: 270, top: 250, child: Text("Speed", style: TextStyle(color: Colors.white))),
          const Positioned(left: 50, top: 320, child: Text("Bounce", style: TextStyle(color: Colors.white))),
          const Positioned(left: 150, top: 320, child: Text("Revs", style: TextStyle(color: Colors.white))),
          const Positioned(left: 270, top: 320, child: Text("Drift", style: TextStyle(color: Colors.white))),

          // Info Section (Hand, Location, Calendar)
          Positioned(
            left: 10,
            top: 430,
            width: 353,
            height: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    Icon(Icons.pan_tool, color: Colors.greenAccent),
                    SizedBox(width: 8),
                    Text("Right hand off spin", style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.greenAccent),
                    SizedBox(width: 8),
                    Text("Chennai", style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.greenAccent),
                    SizedBox(width: 8),
                    Text("Since 15th June, 2025", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      // ✅ Custom Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 2), // Home/Profile selected
    );
  }
}

// ==================== Custom Bottom Navigation Bar ====================
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'New ', 'icon': 'assets/images/new.png'},
      {'label': 'Past ', 'icon': 'assets/images/past.png'},
      {'label': 'Home', 'icon': 'assets/images/home.png'},
      {'label': 'Learn', 'icon': 'assets/images/learn.png'},
      {'label': 'Notify', 'icon': 'assets/images/notify.png'},
    ];

    return Container(
      color: const Color(0xFF00FFB3), // navbar background
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          bool isSelected = index == currentIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                Widget page;
                switch (index) {
                  case 0:
                    page = const NewSessionPage();
                    break;
                  case 1:
                    page = const PastSessionPage();
                    break;
                  case 2:
                    page = const HomePage();
                    break;
                  case 3:
                    page = const LearnPage();
                    break;
                  case 4:
                    page = const NotificationPage();
                    break;
                  default:
                    page = const HomePage();
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
              child: Container(
                color: isSelected ? Colors.yellow : Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      items[index]['icon']!,
                      width: 32,
                      height: 32,
                      color: isSelected ? Colors.white : Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index]['label']!,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}



// ==================== Settings Screens ====================
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 🔙 Top-left arrow + Settings text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Go back to previous screen
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.yellow,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Settings",
                    style: TextStyle(
                      color: Color(0xFF00FFB3),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // First item: Edit Profile
            SettingItem(
              imagePath: "assets/images/editprofile.png", // Replace with your image
              title: "Edit Profile",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
            ),

            const SizedBox(height: 20),

            // Second item: Reset Password
            SettingItem(
              imagePath: "assets/images/resetpassword.png",
              title: "Reset Password",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ResetPassword1()),
                );
              },
            ),

            const SizedBox(height: 20),

            // Third item: Delete Account
            SettingItem(
              imagePath: "assets/images/deleteaccount.png",
              title: "Delete Account",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LogoutScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for each setting item
class SettingItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const SettingItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
//----------------reset password--------------------
class ResetPassword1 extends StatefulWidget {
  const ResetPassword1({super.key});

  @override
  State<ResetPassword1> createState() => _ResetPassword1State();
}

class _ResetPassword1State extends State<ResetPassword1> {
  bool _currentObscure = true;
  bool _newObscure = true;
  bool _confirmObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔙 Top-left arrow + Reset Password text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.yellow,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Reset Password",
                        style: TextStyle(
                          color: Color(0xFF00FFB3),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // Current Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    "Current Password",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    obscureText: _currentObscure,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _currentObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentObscure = !_currentObscure;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                // New Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    "New Password",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    obscureText: _newObscure,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _newObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _newObscure = !_newObscure;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                // Confirm New Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    "Confirm New Password",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    obscureText: _confirmObscure,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmObscure = !_confirmObscure;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Save button at bottom (absolute positioning)
            Positioned(
              left: 141,
              top: 639,
              child: SizedBox(
                width: 100,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Add save functionality here
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//-----------logout-------------------------------------------

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.yellow),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Replace with actual Settings page navigation
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Main background image
              Positioned(
                left: -10,
                top: 0,
                width: 389,
                height: 323,
                child: Image.asset(
                  "assets/images/myprofilebackground.png",
                  fit: BoxFit.contain,
                ),
              ),

              // Profile Image
              Positioned(
                left: 107,
                top: 50,
                width: 125,
                height: 120,
                child: Image.asset(
                  "assets/images/profile.png",
                  fit: BoxFit.contain,
                ),
              ),

              // Name below profile image
              const Positioned(
                left: 145,
                top: 170,
                child: Text(
                  "NAME",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              // Stats Image
              Positioned(
                left: 10,
                top: 210,
                width: 340,
                height: 160,
                child: Image.asset(
                  "assets/images/myprofiledetails.png",
                  fit: BoxFit.contain,
                ),
              ),

              // Inside Stats Texts
              const Positioned(left: 50, top: 240, child: Text("Spin", style: TextStyle(color: Colors.white))),
              const Positioned(left: 150, top: 240, child: Text("Session", style: TextStyle(color: Colors.white))),
              const Positioned(left: 270, top: 240, child: Text("Speed", style: TextStyle(color: Colors.white))),
              const Positioned(left: 50, top: 310, child: Text("Bounce", style: TextStyle(color: Colors.white))),
              const Positioned(left: 150, top: 310, child: Text("Revs", style: TextStyle(color: Colors.white))),
              const Positioned(left: 270, top: 310, child: Text("Drift", style: TextStyle(color: Colors.white))),

              // Info Section (Hand, Location, Calendar)
              Positioned(
                left: 10,
                top: 380,
                width: 353,
                height: 135,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.pan_tool, color: Colors.greenAccent),
                        SizedBox(width: 8),
                        Text("Right hand off spin", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.greenAccent),
                        SizedBox(width: 8),
                        Text("Chennai", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.greenAccent),
                        SizedBox(width: 8),
                        Text("Since 15th June, 2025", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),

              // ✅ Add logout bottom section
              Positioned(
                left: 5,
                top: 480,
                width: 350,
                height: 180,
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/images/logoutgreen.png"), // Replace with your bottom image
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      // 2-line text
                      Positioned(
                        left: 92,
                        top: 29, // relative to container
                        width: 500,
                        height: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Are you sure you want to",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              "log out ?",
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                      ),

                      // Cancel Button
                      Positioned(
                        left: 20,
                        bottom: 20,
                        child: SizedBox(
                          width: 150,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Color(0xFF00FFB3),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),

                      // Yes Logout Button
                      Positioned(
                        right: 20,
                        bottom: 20,
                        child: SizedBox(
                          width: 150,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              // Add logout functionality
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              "Yes, Logout",
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ==================== newSession Screens ====================
class NewSessionPage extends StatefulWidget {
  const NewSessionPage({super.key});

  @override
  State<NewSessionPage> createState() => _NewSessionPageState();
}

class _NewSessionPageState extends State<NewSessionPage> {
  // ✅ Checkbox states
  final Map<String, bool> drillOptions1 = {
    "Target Length": false,
    "Target Line": false,
    "Swing Seam": false,
  };

  final Map<String, bool> drillOptions2 = {
    "Variation": false,
    "Match Simulation": false,
    "Fitness Drill": false,
  };

  bool addVideo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          // 🖼 Top Image
          Positioned(
            top: 19,
            left: -7,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/newgreen.png", // replace with your image
                  width: 380,
                  height: 170,
                  fit: BoxFit.cover,
                ),

                // ↖️ Arrow + Text
                Positioned(
                  top: 20,
                  left: 15,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back,
                            color: Colors.yellow, size: 28),
                        SizedBox(width: 6),
                        Text(
                          "New Session",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ➖ Yellow Line
          Positioned(
            top: 200,
            left: 0,
            child: Container(
              width: 373,
              height: 2,
              color: Colors.yellow,
            ),
          ),

          // 📝 Section Title
          Positioned(
            top: 215,
            left: 5,
            child: const Text(
              "Select drill types",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          // ✅ Drill Options (Group 1)
          Positioned(
            top: 235,
            left: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: drillOptions1.keys.map((key) {
                return Row(
                  children: [
                    Checkbox(
                      value: drillOptions1[key],
                      onChanged: (val) {
                        setState(() {
                          drillOptions1[key] = val!;
                        });
                      },
                      activeColor: Colors.white,
                      checkColor: Colors.black,
                    ),
                    Text(
                      key,
                      style: const TextStyle(
                        color: Color(0xFF00FFB3),
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          // ✅ Drill Options (Group 2)
          Positioned(
            top: 235,
            left: 165,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: drillOptions2.keys.map((key) {
                return Row(
                  children: [
                    Checkbox(
                      value: drillOptions2[key],
                      onChanged: (val) {
                        setState(() {
                          drillOptions2[key] = val!;
                        });
                      },
                      activeColor: Colors.white,
                      checkColor: Colors.black,
                    ),
                    Text(
                      key,
                      style: const TextStyle(
                        color: Color(0xFF00FFB3),
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          // ➖ Yellow Line (after drill options)
          Positioned(
            top: 380,
            left: 65,
            child: Container(
              width: 200,
              height: 2,
              color: Colors.yellow,
            ),
          ),

          // 📹 Add Video Capture
          Positioned(
            top: 380,
            left: 59,
            child: Row(
              children: [
                Checkbox(
                  value: addVideo,
                  onChanged: (val) {
                    setState(() {
                      addVideo = val!;
                    });
                  },
                  activeColor: Colors.white,
                  checkColor: Colors.black,
                ),
                const Text(
                  "Add video capture",
                  style: TextStyle(
                    color: Color(0xFF00FFB3),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // ➖ Yellow Line (after video capture)
          Positioned(
            top: 420,
            left: 65,
            child: Container(
              width: 200,
              height: 2,
              color: Colors.yellow,
            ),
          ),

          // 🚀 Start Session Button
          Positioned(
            top: 440,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ConnectionPage()),
                );
              },
              child: Container(
                width: 335,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1E90FF).withOpacity(0.2),
                      const Color(0xFF1E90FF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Start Session ->",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),

          // ➖ Yellow Line (before footer)
          Positioned(
            top: 510,
            left: 0,
            child: Container(
              width: 373,
              height: 2,
              color: Colors.yellow,
            ),
          ),

          // 🖼 Footer Image
          Positioned(
            top: 513,
            left: -10,
            child: Image.asset(
              "assets/images/newplayer.png", // replace with your footer image
              width: 375,
              height: 174,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),

      // ✅ Custom Bottom Navigation Bar
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}

// ====================  connection ====================
class ConnectionPage extends StatelessWidget {
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // black background
      body: Stack(
        children: [
          // 🖼 Top Banner Image (x=0, y=47, w=390, h=170)
          Positioned(
            top: 37,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/connectiongreen.png", // replace with your image path
              width: 390,
              height: 170,
              fit: BoxFit.cover,
            ),
          ),

          // 🔙 Back Arrow + Text ("Connection")
          Positioned(
            top: 70,
            left: 16,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewSessionPage(),
                      ),
                    );
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.yellow, size: 28),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Connection",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 🔍 Search Bar (x=18, y=139, w=355, h=40)
          Positioned(
            top: 139,
            left: 2,
            child: Container(
              width: 355,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search Device",
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),

          // 🖼 Device Image (x=20, y=280, w=350, h=350)
          Positioned(
            top: 240,
            left: 2,
            child: Image.asset(
              "assets/images/bluetooth.png", // replace with your image path
              width: 350,
              height: 350,
              fit: BoxFit.contain,
            ),
          ),

          // ⚪ Connect Button (x=244,y=722,w=335,h=48)
          Positioned(
            top: 632,
            left: 8, // adjusted so it fits screen
            child: SizedBox(
              width: 335,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LiveSessionPage(),
                    ),
                  );
                },
                child: const Text(
                  "Connect Thynkball",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// The Live Session Page


class LiveSessionPage extends StatelessWidget {
  const LiveSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Swipe detection
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          // Swiped left
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NextLiveSessionPage(),
            ),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // 1. Background image full screen
            Positioned.fill(
              child: Image.asset(
                "assets/images/ground.png", // replace with your image
                fit: BoxFit.cover,
              ),
            ),

            // 2. Outline box with session info
            Positioned(
              top: 50,
              left: 32,
              child: Container(
                width: 300,
                height: 113,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF4FDFCC), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title text
                    Text(
                      "Live Session starts",
                      style: TextStyle(
                        color: const Color(0xFF4DDAC7),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        shadows: const [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Row: Session type & Deliveries
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Session type",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Swing/Seam",
                              style: TextStyle(
                                color: Color(0xFF4DDAC7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // Right Column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Deliveries",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "8",
                              style: TextStyle(
                                color: Color(0xFF4DDAC7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // 3. Six statistic boxes
            buildStatBox(15, 500), // position 3
            buildStatBox(189.5, 500), // position 4
            buildStatBox(15, 353), // position 5
            buildStatBox(189.5, 353), // position 6
            buildStatBox(15, 200), // position 1
            buildStatBox(189.5, 200), // position 2
          ],
        ),
      ),
    );
  }

  // Reusable stat box widget
  Widget buildStatBox(double left, double top) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: 150,
        height: 114,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF4DDAC7), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Swing",
              style: TextStyle(
                color: Color(0xFF4DDAC7),
                fontWeight: FontWeight.bold,
                fontSize: 16,
                shadows: [
                  Shadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            SizedBox(height: 6),
            Text(
              "Previous   2.2",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Average   2.2",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Next page after swipe left
class NextLiveSessionPage extends StatelessWidget {
  const NextLiveSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Detect swipe left → go to End Session page
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EndSessionPage(),
            ),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                "assets/images/ground.png",
                fit: BoxFit.cover,
              ),
            ),

            // Outline box with session info
            Positioned(
              top: 50,
              left: 32,
              child: Container(
                width: 300,
                height: 113,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF4FDFCC), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title text
                    const Text(
                      "Live Session starts",
                      style: TextStyle(
                        color: Color(0xFF4DDAC7),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Row: Session type & Deliveries
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Session type",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Swing/Seam",
                              style: TextStyle(
                                color: Color(0xFF4DDAC7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // Right Column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Deliveries",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "8",
                              style: TextStyle(
                                color: Color(0xFF4DDAC7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // First Outline Box (x=2.5, y=0)
            Positioned(
              top: 200,
              left: 10,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF4DDAC7), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "SpinAxis",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Coming Soon",
                      style: TextStyle(
                        color: Color(0xFF4DDAC7),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Second Outline Box (x=0, y=0)
            Positioned(
              top: 200,
              left: 190,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF4DDAC7), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "SpinAxis",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Coming Soon",
                      style: TextStyle(
                        color: Color(0xFF4DDAC7),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // First Image (x=2.5, y=181)
            Positioned(
              top: 360,
              left: 10,
              child: Image.asset(
                "assets/images/livesessionimg1.png", // replace with your image
                width: 150,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            // Second Image (x=0, y=0)
            Positioned(
              top: 360,
              left: 190,
              child: Image.asset(
                "assets/images/livesessionimg2.png", // replace with your image
                width: 150,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//---------- End Session Page-------------
class EndSessionPage extends StatelessWidget {
  const EndSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ Background image
          Positioned.fill(
            child: Image.asset(
              "assets/images/ground.png",
              fit: BoxFit.cover,
            ),
          ),

          // ✅ Center clickable outlined button
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewSessionSummaryPage(),
                  ),
                );
              },
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(30), // 👈 curved corners
                  color: Colors.transparent, // transparent background
                ),
                alignment: Alignment.center,
                child: const Text(
                  "End Session ->",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 3),
                        blurRadius: 6,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------new session summary page-----------------
class NewSessionSummaryPage extends StatelessWidget {
  const NewSessionSummaryPage({super.key});

  // handy colors
  static const Color accent = Color(0xFF00FFB3);
  static const Color greyText = Color(0xFF9E9E9E);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! < -200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewSessionSummary1Page(),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // ✅ Fixed Skip button
            Positioned(
              right: 16,
              top: 42,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewSessionSummary1Page(),
                    ),
                  );
                },

              ),
            ),

            // Back arrow
            Positioned(
              left: 6,
              top: 28,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.yellow),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // Header text
            Positioned(
              left: 54,
              top: 38,
              width: 185,
              height: 30,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Session Summary',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            // addplayerbar
            Positioned(
              left: 0,
              top: 107,
              width: 390,
              height: 60,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/addplayerbar.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 0,
                    width: 176,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Session Type',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Swing/Seam',
                            style: TextStyle(
                              color: greyText,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 232,
                    top: 10,
                    width: 91,
                    height: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Deliveries',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '8',
                          style: TextStyle(
                            color: greyText,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // lines and stat blocks
            Positioned(
              left: 100,
              top: 30,
              width: 400,
              child: Image.asset(
                'assets/images/linestraight.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              left: 50,
              top: 320,
              width: 300,
              child: Image.asset(
                'assets/images/verticalline.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              left: 45,
              top: 450,
              width: 300,
              child: Image.asset(
                'assets/images/verticalline.png',
                fit: BoxFit.fitWidth,
              ),
            ),

            _statBlock(left: 19, top: 203, width: 136, height: 102, heading: 'Swing'),
            _statBlock(left: 213, top: 203, width: 136, height: 102, heading: 'Speed (kmph)'),
            _statBlock(left: 19, top: 330, width: 136, height: 102, heading: 'Revs'),
            _statBlock(left: 210, top: 330, width: 136, height: 102, heading: 'Seam'),
            _statBlock(left: 19, top: 470, width: 136, height: 102, heading: 'Spin'),

            Positioned(
              left: 210,
              top: 470,
              width: 130,
              height: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Seam Position',
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Coming Soon',
                    style: TextStyle(
                      color: greyText,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Indicator balls
            Positioned(
              left: 145,
              top: 650,
              width: 70,
              height: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _indicatorBall(active: true),
                  _indicatorBall(active: false),
                  _indicatorBall(active: false),
                  _indicatorBall(active: false),
                ],
              ),
            ),
          ],
        ),

        // Actual bottom navbar here
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      ),
    );
  }

  // Stat block
  Positioned _statBlock({
    required double left,
    required double top,
    required double width,
    required double height,
    required String heading,
  }) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          _statLine('Highest', '2.2'),
          const SizedBox(height: 6),
          _statLine('Average', '2.2'),
          const SizedBox(height: 6),
          _statLine('Lowest', '2.2'),
        ],
      ),
    );
  }

  Widget _statLine(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: greyText,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: accent,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _indicatorBall({required bool active}) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: active ? Colors.yellow : Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

//----------- NewSessionSummary1Page---------------------------------


class NewSessionSummary1Page extends StatelessWidget {
  const NewSessionSummary1Page({super.key});

  static const Color accent = Color(0xFF00FFB3);
  static const Color greyText = Color(0xFF9E9E9E);

  void _goToNext(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewSessionSummary2Page()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // swipe left (right -> left)
        if (details.primaryVelocity != null && details.primaryVelocity! < -200) {
          _goToNext(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Back arrow
            Positioned(
              left: 6,
              top: 28,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.yellow),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // Header text
            Positioned(
              left: 54,
              top: 38,
              width: 185,
              height: 30,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Session Summary',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            // addplayerbar
            Positioned(
              left: 0,
              top: 107,
              width: 390,
              height: 60,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/addplayerbar.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 0,
                    width: 176,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Session Type',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Swing/Seam',
                            style: TextStyle(
                              color: greyText,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 232,
                    top: 10,
                    width: 91,
                    height: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Deliveries',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '8',
                          style: TextStyle(
                            color: greyText,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Images
            Positioned(
              left: 45,
              top: 236,
              width: 0,
              height: 400,
              child: Image.asset('assets/images/outline.png', fit: BoxFit.fill),
            ),
            Positioned(
              left: 27,
              top: 436,
              width: 150,
              height: 250,
              child: Image.asset('assets/images/outline1.png', fit: BoxFit.fill),
            ),
            Positioned(
              left: 220,
              top: 436,
              width: 150,
              height: 250,
              child: Image.asset('assets/images/outline2.png', fit: BoxFit.fill),
            ),

            // Info blocks
            Positioned(
              left: 27,
              top: 249,
              width: 150,
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Spin Axis',
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Coming Soon',
                    style: TextStyle(
                      color: greyText,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 225,
              top: 249,
              width: 150,
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Ball Impact',
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Force',
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Coming Soon',
                    style: TextStyle(
                      color: greyText,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Indicator balls (second ball yellow)
            Positioned(
              left: 145,
              top: 650,
              width: 70,
              height: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _indicatorBall(active: false),
                  _indicatorBall(active: true),
                  _indicatorBall(active: false),
                  _indicatorBall(active: false),
                ],
              ),
            ),
          ],

          // Bottom navigation bar
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      ),
    );
  }

  Widget _indicatorBall({required bool active}) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: active ? Colors.yellow : Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}



// ==================== NewSessionSummary2Page ====================
class NewSessionSummary2Page extends StatelessWidget {
  const NewSessionSummary2Page({super.key});

  static const Color accent = Color(0xFF00FFB3);
  static const Color greyText = Color(0xFF9E9E9E);

  void _goToBestDeliveries(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BestDeliveriesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // Swipe left -> right to left
        if (details.primaryVelocity != null && details.primaryVelocity! < -200) {
          _goToBestDeliveries(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Back arrow
            Positioned(
              left: 6,
              top: 28,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.yellow),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // Header text
            Positioned(
              left: 54,
              top: 38,
              width: 185,
              height: 30,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Session Summary',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            // addplayerbar
            Positioned(
              left: 0,
              top: 107,
              width: 390,
              height: 60,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/addplayerbar.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 0,
                    width: 176,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Session Type',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Swing/Seam',
                            style: TextStyle(
                              color: greyText,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 232,
                    top: 10,
                    width: 91,
                    height: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Deliveries',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '8',
                          style: TextStyle(
                            color: greyText,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Main diagram image
            Positioned(
              left: 30,
              top: 200,
              width: 315,
              height: 478,
              child: Image.asset(
                'assets/images/newsessionsummary2.png',
                fit: BoxFit.fill,
              ),
            ),

            // Indicator balls (third ball yellow)
            Positioned(
              left: 145,
              top: 650,
              width: 70,
              height: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _indicatorBall(active: false),
                  _indicatorBall(active: false),
                  _indicatorBall(active: true),
                  _indicatorBall(active: false),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      ),
    );
  }

  Widget _indicatorBall({required bool active}) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: active ? Colors.yellow : Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

// ==================== BestDeliveriesPage ====================

class BestDeliveriesPage extends StatelessWidget {
  const BestDeliveriesPage({super.key});

  static const Color accent = Color(0xFF00FFB3);
  static const Color yellowText = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Back arrow
          Positioned(
            left: 6,
            top: 28,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.yellow),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // ✅ Skip button (top right)
          Positioned(
            right: 20,
            top: 38,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ComparisonPage()),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          // Header text
          Positioned(
            left: 54,
            top: 38,
            width: 200,
            height: 30,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Best Deliveries',
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),

          // "Performance Highlights" text
          Positioned(
            left: 35,
            top: 120,
            width: 187,
            height: 22,
            child: const Text(
              'Performance Highlights',
              style: TextStyle(
                color: yellowText,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          // ====== 5 IMAGES ======
          Positioned(
            left: 25,
            top: 200,
            width: 155,
            height: 151,
            child: Image.asset(
              'assets/images/image1.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            left: 190,
            top: 200,
            width: 155,
            height: 151,
            child: Image.asset(
              'assets/images/image2.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            left: 25,
            top: 370,
            width: 155,
            height: 151,
            child: Image.asset(
              'assets/images/image3.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            left: 190,
            top: 370,
            width: 155,
            height: 151,
            child: Image.asset(
              'assets/images/image4.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            left: 25,
            top: 530,
            width: 155,
            height: 151,
            child: Image.asset(
              'assets/images/image5.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}

//------------comparison---------------

class ComparisonPage extends StatelessWidget {
  const ComparisonPage({super.key});

  static const Color accent = Color(0xFF00FFB3);
  static const Color greyText = Color(0xFF9E9E9E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            // Swipe from right to left
            if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArtificialIntelligencePage(),
                ),
              );
            }
          },
          child: Stack(
            children: [
              // Back arrow
              Positioned(
                left: 6,
                top: 8,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.yellow),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // Header text
              Positioned(
                left: 54,
                top: 18,
                width: 200,
                height: 30,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Comparison',
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              // Outline background image
              Positioned(
                left: 164,
                top: 2,
                width: 189,
                height: 156,
                child: Image.asset(
                  'assets/images/outlinebackground.png',
                  fit: BoxFit.fill,
                ),
              ),

              // Yellow text
              Positioned(
                left: 20,
                top: 100,
                width: 249,
                height: 22,
                child: const Text(
                  'Compare with Previous Session',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              // Stat blocks
              _statBlock(left: 19, top: 190, width: 136, height: 102, heading: 'Swing'),
              _statBlock(left: 213, top: 190, width: 136, height: 102, heading: 'Speed (kmph)'),
              _statBlock(left: 19, top: 310, width: 136, height: 102, heading: 'Revs'),
              _statBlock(left: 210, top: 310, width: 136, height: 102, heading: 'Seam'),
              _statBlock(left: 19, top: 440, width: 136, height: 102, heading: 'Spin'),

              // Seam Position info block
              Positioned(
                left: 210,
                top: 440,
                width: 130,
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Seam Position',
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Coming Soon',
                      style: TextStyle(
                        color: greyText,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // Next button (fixed visibility)
              Positioned(
                left: 135,
                bottom: 40, // changed from top: 744 for visibility
                width: 90,
                height: 36,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ArtificialIntelligencePage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.black, // visible on yellow
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  static Widget _statBlock({
    required double left,
    required double top,
    required double width,
    required double height,
    required String heading,
  }) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: const TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            _statLine('Current', '2.2'),
            const SizedBox(height: 6),
            _statLine('Previous', '2.2'),
          ],
        ),
      ),
    );
  }

  static Widget _statLine(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: greyText,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}


// ---------- Artificial Intelligence Page ----------
class ArtificialIntelligencePage extends StatelessWidget {
  const ArtificialIntelligencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Back arrow
            Positioned(
              left: 6,
              top: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.yellow),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // Heading "AI"
            Positioned(
              left: 54,
              top: 17,
              child: const Text(
                'AI',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            // Skip button
            Positioned(
              right: 16,
              top: 14,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCommentPage(),
                    ),
                  );
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),

            // First image (hello)
            Positioned(
              left: 295,
              top: 163,
              width: 76,
              height: 33,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/hello.png', fit: BoxFit.fill),
                  const Text(
                    'Hello',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

// Second image (help)
            Positioned(
              left: 0,
              top: 244,
              width: 254,
              height: 59,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/help.png', fit: BoxFit.fill),
                  const Text(
                    'How can I help you today?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),


            // Textbox with lens, mic, and send buttons (fixed position)
            Positioned(
              left: 10,
              bottom: 30, //changed from top: 674 to bottom: 30 so it’s visible on all screens
              width: 340,
              height: 61,
              child: Stack(
                children: [
                  Container(
                    width: 340,
                    height: 61,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15), // slight transparency for better contrast
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white24),
                    ),
                  ),
                  // Text field
                  Positioned(
                    left: 0,
                    top: 10,
                    right: 100, //leave space for lens, mic, send
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Type here',
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Lens icon
                  Positioned(
                    right: 70,
                    top: 10,
                    child: IconButton(
                      icon: const Icon(Icons.photo_camera, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                  // Mic button
                  Positioned(
                    right: 40,
                    top: 10,
                    child: IconButton(
                      icon: const Icon(Icons.mic, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                  // Send button
                  Positioned(
                    right: 10,
                    top: 10,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}

//-------add comments----------------

class AddCommentPage extends StatefulWidget {
  const AddCommentPage({super.key});

  static const Color accent = Color(0xFF00FFB3);
  static const Color yellowText = Colors.yellow;

  @override
  State<AddCommentPage> createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {
  bool isSaveClicked = false;
  bool isCancelClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Back arrow
          Positioned(
            left: 6,
            top: 28,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.yellow),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // ✅ Skip button (top right)
          Positioned(
            right: 20,
            top: 38,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          // Header text
          Positioned(
            left: 54,
            top: 38,
            width: 200,
            height: 30,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add Comments',
                style: TextStyle(
                  color: AddCommentPage.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),

          // "Send Feedback Request" text
          Positioned(
            left: 35,
            top: 100,
            width: 187,
            height: 22,
            child: const Text(
              'Send Feedback Request',
              style: TextStyle(
                color: AddCommentPage.yellowText,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          // ====== 5 IMAGES ======
          Positioned(
            left: 25,
            top: 150,
            width: 155,
            height: 151,
            child: Image.asset('assets/images/image1.png', fit: BoxFit.fill),
          ),
          Positioned(
            left: 190,
            top: 150,
            width: 155,
            height: 151,
            child: Image.asset('assets/images/image2.png', fit: BoxFit.fill),
          ),
          Positioned(
            left: 25,
            top: 320,
            width: 155,
            height: 151,
            child: Image.asset('assets/images/image3.png', fit: BoxFit.fill),
          ),
          Positioned(
            left: 190,
            top: 320,
            width: 155,
            height: 151,
            child: Image.asset('assets/images/image4.png', fit: BoxFit.fill),
          ),
          Positioned(
            left: 25,
            top: 490,
            width: 155,
            height: 151,
            child: Image.asset('assets/images/image5.png', fit: BoxFit.fill),
          ),

          // ====== NEW IMAGE SECTION ======
          Positioned(
            left: -10,
            top: 504,
            width: 390,
            height: 250,
            child: Stack(
              children: [
                // Background image
                Image.asset(
                  'assets/images/addcomments.png', // use your image name
                  width: 390,
                  height: 250,
                  fit: BoxFit.cover,
                ),

                // Message icon
                const Positioned(
                  left: 31,
                  top: 28,
                  width: 24,
                  height: 24,
                  child: Icon(
                    Icons.message,
                    color: Colors.black,
                    size: 24,
                  ),
                ),

                // Text beside message icon
                const Positioned(
                  left: 64,
                  top: 31,
                  width: 183,
                  height: 18,
                  child: Text(
                    'Add Coach Comments',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                // Textbox
                Positioned(
                  left: 32,
                  top: 69,
                  width: 326,
                  height: 95,
                  child: TextField(
                    maxLines: 5,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Write comments here',
                      hintStyle: const TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                ),

                // Save button
                Positioned(
                  left: 32,
                  top: 184,
                  width: 153,
                  height: 48,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSaveClicked = true;
                        isCancelClicked = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSaveClicked
                            ? const Color(0xFF00FFB3)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // Cancel button
                Positioned(
                  left: 205,
                  top: 184,
                  width: 153,
                  height: 48,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isCancelClicked = true;
                        isSaveClicked = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isCancelClicked
                            ? const Color(0xFF00FFB3)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- PastSessionPage ----------
class PastSessionPage extends StatelessWidget {
  const PastSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🔙 Back Arrow + Title
          Positioned(
            left: 16,
            top: 60,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.yellow,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Session summary",
                  style: TextStyle(
                    color: Color(0xFF00FFB3),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          // 📝 Full Name TextField
          Positioned(
            left: 13,
            top: 100,
            width: 335,
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Full Name",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: "Enter full name",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          // 🔍 Search Bar
          Positioned(
            left: 13,
            top: 186,
            width: 335,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search bowling session",
                hintStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),

          // ⚡ Options Row (All, Yorker, Swing, Spin)
          Positioned(
            left: 10,
            top: 236,
            width: 340,
            height: 45,
            child: Row(
              children: [
                // 1. All (selected)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "All",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 2. Yorker
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const YorkerPage1()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Yorker",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 3. Swing
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SwingPage1()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Swing",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 4. Spin
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SpinPage1()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Spin",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======= 📸 Image 1 =======
          Positioned(
            left: 20,
            top: 312,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all1.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // 🏏 Title Text
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),

                // 📅 Date + Calendar Icon
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏰ Time + Clock Icon
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏱ Duration + Alarm Icon
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 2 =======
          Positioned(
            left: 20,
            top: 435,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all2.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Spin Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 3 =======
          Positioned(
            left: 20,
            top: 560,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all3.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Swing Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),

      // ✅ Bottom Navigation (Past option highlighted)
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}

// ---------- YorkerPage1 ----------
class YorkerPage1 extends StatelessWidget {
  const YorkerPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1), // Past highlighted
      body: Stack(
        children: [
          Positioned(
            left: 16,
            top: 40,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.yellow,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Yorker",
                  style: TextStyle(
                    color: Color(0xFF00FFB3),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          // 📝 Full Name TextField
          Positioned(
            left: 18,
            top: 90,
            width: 335,
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Full Name",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: "Enter full name",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          // 🔍 Search Bar
          Positioned(
            left: 18,
            top: 186,
            width: 335,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search bowling session",
                hintStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),

          // ⚡ Options Row
          Positioned(
            left: 14,
            top: 236,
            width: 340,
            height: 45,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const PastSessionPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("All", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Yorker",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SwingPage1()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Swing", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SpinPage1()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Spin", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======= 📸 Image 1 =======
          Positioned(
            left: 20,
            top: 312,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all1.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // 🏏 Title Text
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),

                // 📅 Date + Calendar Icon
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏰ Time + Clock Icon
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏱ Duration + Alarm Icon
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 2 =======
          Positioned(
            left: 20,
            top: 435,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all2.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 3 =======
          Positioned(
            left: 20,
            top: 560,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all3.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

// ---------- SwingPage1 ----------
class SwingPage1 extends StatelessWidget {
  const SwingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1), // Past highlighted
      body: Stack(
        children: [
          Positioned(
            left: 16,
            top: 40,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.yellow,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Swing",
                  style: TextStyle(
                    color: Color(0xFF00FFB3),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          // 📝 Full Name TextField
          Positioned(
            left: 18,
            top: 90,
            width: 335,
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Full Name",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: "Enter full name",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          // 🔍 Search Bar
          Positioned(
            left: 18,
            top: 186,
            width: 335,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search bowling session",
                hintStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),

          // ⚡ Options Row
          Positioned(
            left: 14,
            top: 236,
            width: 340,
            height: 45,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const PastSessionPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("All", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const YorkerPage1()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Yorker", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Swing",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SpinPage1()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Spin", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======= 📸 Image 1 =======
          Positioned(
            left: 20,
            top: 312,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all1.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // 🏏 Title Text
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Swing Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),

                // 📅 Date + Calendar Icon
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏰ Time + Clock Icon
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏱ Duration + Alarm Icon
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 2 =======
          Positioned(
            left: 20,
            top: 435,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all2.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Swing Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 3 =======
          Positioned(
            left: 20,
            top: 560,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all3.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Swing Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

// ---------- SpinPage1 ----------
class SpinPage1 extends StatelessWidget {
  const SpinPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1), // Past highlighted
      body: Stack(
        children: [
          Positioned(
            left: 16,
            top: 40,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.yellow,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Spin",
                  style: TextStyle(
                    color: Color(0xFF00FFB3),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          // 📝 Full Name TextField
          Positioned(
            left: 18,
            top: 90,
            width: 335,
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Full Name",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: "Enter full name",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          // 🔍 Search Bar
          Positioned(
            left: 18,
            top: 186,
            width: 335,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search bowling session",
                hintStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),

          // ⚡ Options Row
          Positioned(
            left: 14,
            top: 236,
            width: 340,
            height: 45,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const PastSessionPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("All", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const YorkerPage1()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Yorker", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SwingPage1()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Swing", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Spin",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======= 📸 Image 1 =======
          Positioned(
            left: 20,
            top: 312,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all1.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // 🏏 Title Text
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Spin Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),

                // 📅 Date + Calendar Icon
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏰ Time + Clock Icon
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏱ Duration + Alarm Icon
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 2 =======
          Positioned(
            left: 20,
            top: 435,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all2.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Spin Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 3 =======
          Positioned(
            left: 20,
            top: 560,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all3.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Spin Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}


// ==================== home Screens ====================

class CustomBottomNavBar1 extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNavBar1({super.key, required this.currentIndex});

  @override
  State<CustomBottomNavBar1> createState() => _CustomBottomNavBar1State();
}

class _CustomBottomNavBar1State extends State<CustomBottomNavBar1> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    if (index == selectedIndex) return; // Already on this tab
    setState(() {
      selectedIndex = index;
    });

    Widget page;
    switch (index) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const AddPage();
        break;
      case 2:
        page = const ReviewPage();
        break;
      case 3:
        page = const ComparePage();
        break;
      default:
        page = const HomePage();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF00FFB3),
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.white,
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/home.png',
            width: 30,
            height: 30,
            color: selectedIndex == 0 ? Colors.yellow : Colors.white,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/add.png',
            width: 30,
            height: 30,
            color: selectedIndex == 1 ? Colors.yellow : Colors.white,
          ),
          label: "Add",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/review.png',
            width: 30,
            height: 30,
            color: selectedIndex == 2 ? Colors.yellow : Colors.white,
          ),
          label: "Review",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/compare.png',
            width: 30,
            height: 30,
            color: selectedIndex == 3 ? Colors.yellow : Colors.white,
          ),
          label: "Compare",
        ),
      ],
    );
  }
}

// ----------------- HomePage -----------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Top-left arrow back
          Positioned(
            left: 10,
            top: 40,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.yellow),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
          ),
          // Top Text "My Profile"
          const Positioned(
            left: 60,
            top: 50,
            child: Text(
              "My Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          // Top-center image
          Positioned(
            left: 175,
            top: 20,
            width: 199,
            height: 200,
            child: Image.asset(
              "assets/images/home1.png",
              fit: BoxFit.contain,
            ),
          ),
          // Main card/image under header
          Positioned(
            left: 1,
            top: 115,
            width: 390,
            height: 191,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/homebackground.png",
                  width: 390,
                  height: 191,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  left: 35,
                  top: 10,
                  child: Text(
                    "John",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                Positioned(
                  left: 35,
                  top: 62,
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    "assets/images/homeface.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                  left: 180,
                  top: 70,
                  child: Row(
                    children: [
                      Icon(Icons.sports, color: Colors.blue, size: 20),
                      SizedBox(width: 5),
                      Text("Coach", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const Positioned(
                  left: 180,
                  top: 100,
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue, size: 20),
                      SizedBox(width: 5),
                      Text("Chennai", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const Positioned(
                  left: 180,
                  top: 130,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blue, size: 20),
                      SizedBox(width: 5),
                      Text("Since 15th June, 2025",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Image blocks with text inside
          Positioned(
            left: 15,
            top: 315,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset("assets/images/homecontainer.png",
                    width: 325, height: 110, fit: BoxFit.cover),
                const Positioned(
                  left: 70,
                  top: 13,
                  child: Text(
                    "Player Roster",
                    style: TextStyle(
                        color: Color(0xFF00FFB3),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                const Positioned(
                  left: 70,
                  top: 55,
                  child: Text(
                    "Overview of assigned players with quick access..",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 15,
            top: 440,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset("assets/images/homecontainer.png",
                    width: 325, height: 110, fit: BoxFit.cover),
                const Positioned(
                  left: 70,
                  top: 13,
                  child: Text(
                    "Performance Alert",
                    style: TextStyle(
                        color: Color(0xFF00FFB3),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                const Positioned(
                  left: 70,
                  top: 55,
                  child: Text(
                    "Recent performance alert(AI Based)",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 15,
            top: 565,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset("assets/images/homecontainer.png",
                    width: 325, height: 110, fit: BoxFit.cover),
                const Positioned(
                  left: 70,
                  top: 13,
                  child: Text(
                    "Advanced Filters",
                    style: TextStyle(
                        color: Color(0xFF00FFB3),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                const Positioned(
                  left: 70,
                  top: 55,
                  child: Text(
                    "Overview of assigned players with"
                        " quick access..",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar1(currentIndex: 0),
    );
  }
}

// ----------------- AddPage -----------------
class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Back Arrow
          Positioned(
            left: 10,
            top: 40,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.yellow),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // Add Players Text
          const Positioned(
            left: 60,
            top: 50,
            child: Text(
              "Add Players",
              style: TextStyle(
                color: Color(0xFF00FFB3),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Top Image
          Positioned(
            left: 175,
            top: 20,
            width: 199,
            height: 150,
            child: Image.asset(
              "assets/images/home1.png", // replace with your image
              fit: BoxFit.contain,
            ),
          ),

          // Image container with Individual / Team toggle
          Positioned(
            left: 1,
            top: 180,
            width: 390,
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/addplayerbar.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                children: [
                  // Individual option (selected)
                  Expanded(
                    child: Container(
                      color: const Color(0xFF00FFB3),
                      child: const Center(
                        child: Text(
                          "Individual",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Team option (unselected, black)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const TeamPage()),
                        );
                      },
                      child: Container(

                        child: const Center(
                          child: Text(
                            "Team",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Full Name Input
          Positioned(
            left: 20,
            top: 270,
            right: 20,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Full Name",
                labelStyle: const TextStyle(color: Colors.white),
                hintText: "Enter full name",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.black,
                counterText: "/500",
                counterStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLength: 500,
            ),
          ),

          // School/Academy Input
          Positioned(
            left: 20,
            top: 360,
            right: 20,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "School/Academy",
                labelStyle: const TextStyle(color: Colors.white),
                hintText: "Enter school/academy",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          // Phone Number Input with country code
          Positioned(
            left: 20,
            top: 450,
            right: 20,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                labelStyle: const TextStyle(color: Colors.white),
                hintText: "+91 Enter phone number",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          // Add Button
          Positioned(
            left: 120,
            top: 550,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text(
                "Add ->",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const CustomBottomNavBar1(currentIndex: 1),
    );
  }
}
//-----------team page------------------
class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Back Arrow
          Positioned(
            left: 10,
            top: 40,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.yellow),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // Add Players Text
          const Positioned(
            left: 60,
            top: 50,
            child: Text(
              "Add Players",
              style: TextStyle(
                color: Color(0xFF00FFB3),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Top Image
          Positioned(
            left: 175,
            top: 20,
            width: 199,
            height: 150,
            child: Image.asset(
              "assets/images/home1.png",
              fit: BoxFit.contain,
            ),
          ),

          // Individual / Team Toggle with background image
          Positioned(
            left: 1,
            top: 180,
            width: 390,
            height: 60,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/addplayerbar.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                children: [
                  // Individual option (unselected)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const AddPage()),
                        );
                      },
                      child: Container(
                        child: const Center(
                          child: Text(
                            "Individual",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Team option (selected)
                  Expanded(
                    child: Container(
                      color: const Color(0xFF00FFB3),
                      child: const Center(
                        child: Text(
                          "Team",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Team Name Input
          Positioned(
            left: 20,
            top: 270,
            right: 20,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Team Name",
                labelStyle: const TextStyle(color: Colors.white),
                hintText: "Enter team name",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          // Full Name
          Positioned(
            left: 20,
            top: 350,
            right: 20,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Full Name",
                labelStyle: const TextStyle(color: Colors.white),
                hintText: "Enter full name",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.black,
                counterText: "/500",
                counterStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLength: 500,
            ),
          ),

          // School/Academy
          Positioned(
            left: 20,
            top: 440,
            right: 20,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "School/Academy",
                labelStyle: const TextStyle(color: Colors.white),
                hintText: "Enter school/academy",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          // Phone
          Positioned(
            left: 20,
            top: 530,
            right: 20,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                labelStyle: const TextStyle(color: Colors.white),
                hintText: "+91 Enter phone number",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          // Add Button
          Positioned(
            left: 120,
            top: 630,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text(
                "Add ->",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const CustomBottomNavBar1(currentIndex: 1),
    );
  }
}

// ----------------- ReviewPage -----------------

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🔙 Back Arrow + Title
          Positioned(
            left: 16,
            top: 60,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.yellow,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Session summary",
                  style: TextStyle(
                    color: Color(0xFF00FFB3),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          // 📝 Full Name TextField
          Positioned(
            left: 13,
            top: 100,
            width: 335,
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Full Name",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: "Enter full name",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          // 🔍 Search Bar
          Positioned(
            left: 13,
            top: 186,
            width: 335,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search bowling session",
                hintStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),

          // ⚡ Options Row (All, Yorker, Swing, Spin)
          Positioned(
            left: 10,
            top: 236,
            width: 340,
            height: 45,
            child: Row(
              children: [
                // 1. All (selected)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "All",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 2. Yorker
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const YorkerPage1()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Yorker",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 3. Swing
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SwingPage1()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Swing",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 4. Spin
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SpinPage1()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Spin",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======= 📸 Image 1 =======
          Positioned(
            left: 20,
            top: 312,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all1.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // 🏏 Title Text
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),

                // 📅 Date + Calendar Icon
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏰ Time + Clock Icon
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏱ Duration + Alarm Icon
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 2 =======
          Positioned(
            left: 20,
            top: 435,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all2.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Spin Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 3 =======
          Positioned(
            left: 20,
            top: 560,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all3.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Swing Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),

      // ✅ Bottom Navigation
      bottomNavigationBar: const CustomBottomNavBar1(currentIndex: 2),
    );
  }
}
//--yorker------------------
class YorkerPage extends StatelessWidget {
  const YorkerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // ✅ Add Custom Navbar here
      bottomNavigationBar: const CustomBottomNavBar1(currentIndex: 2),

      body: Stack(
        children: [
          // 🔙 Back Arrow + Title
          Positioned(
            left: 16,
            top: 40,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AddPage()),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.yellow,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Yorker",
                  style: TextStyle(
                    color: Color(0xFF00FFB3),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          // 📝 Full Name TextField
          Positioned(
            left: 18,
            top: 90,
            width: 335,
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Full Name",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: "Enter full name",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          // 🔍 Search Bar
          Positioned(
            left: 18,
            top: 186,
            width: 335,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search bowling session",
                hintStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),

          // ⚡ Options Row
          Positioned(
            left: 14,
            top: 236,
            width: 340,
            height: 45,
            child: Row(
              children: [
                // All
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ReviewPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("All", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Yorker (selected)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Yorker",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Swing
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SwingPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Swing", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Spin
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SpinPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Spin", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======= 📸 Image 1 =======
          Positioned(
            left: 20,
            top: 312,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all1.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // 🏏 Title Text
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),

                // 📅 Date + Calendar Icon
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏰ Time + Clock Icon
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏱ Duration + Alarm Icon
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 2 =======
          Positioned(
            left: 20,
            top: 435,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all2.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 3 =======
          Positioned(
            left: 20,
            top: 560,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all3.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//-----swing----------------

class SwingPage extends StatelessWidget {
  const SwingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // ✅ Add Custom Navbar here
      bottomNavigationBar: const CustomBottomNavBar1(currentIndex: 2),

      body: Stack(
        children: [
          // 🔙 Back Arrow + Title
          Positioned(
            left: 16,
            top: 40,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AddPage()),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.yellow,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Swing",
                  style: TextStyle(
                    color: Color(0xFF00FFB3),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          // 📝 Full Name TextField
          Positioned(
            left: 18,
            top: 90,
            width: 335,
            height: 90, // ⬅️ increase this
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Full Name",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: "Enter full name",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),


          // 🔍 Search Bar
          Positioned(
            left: 18,
            top: 186,
            width: 335,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search bowling session",
                hintStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),

          // ⚡ Options Row
          Positioned(
            left: 14,
            top: 236,
            width: 340,
            height: 45,
            child: Row(
              children: [
                // All
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ReviewPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("All", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Yorker
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const YorkerPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Yorker", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Swing (selected)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Swing",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Spin
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SpinPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Spin", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======= 📸 Image 1 =======
          Positioned(
            left: 20,
            top: 312,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all1.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // 🏏 Title Text
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),

                // 📅 Date + Calendar Icon
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏰ Time + Clock Icon
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏱ Duration + Alarm Icon
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 2 =======
          Positioned(
            left: 20,
            top: 435,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all2.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 3 =======
          Positioned(
            left: 20,
            top: 560,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all3.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//--------spin-------------
class SpinPage extends StatelessWidget {
  const SpinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // ✅ Add Custom Navbar here
      bottomNavigationBar: const CustomBottomNavBar1(currentIndex: 2),

      body: Stack(
        children: [
          // 🔙 Back Arrow + Title
          Positioned(
            left: 16,
            top: 40,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AddPage()),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.yellow,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Spin",
                  style: TextStyle(
                    color: Color(0xFF00FFB3),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          // 📝 Full Name TextField
          Positioned(
            left: 18,
            top: 90,
            width: 335,
            height: 90, // ⬅️ increase this
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Full Name",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: "Enter full name",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white), // ✅ match hint color
                ),
              ],
            ),
          ),

          // 🔍 Search Bar
          Positioned(
            left: 18,
            top: 186,
            width: 335,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search bowling session",
                hintStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),

          // ⚡ Options Row
          Positioned(
            left: 14,
            top: 236,
            width: 340,
            height: 45,
            child: Row(
              children: [
                // All
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ReviewPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("All", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Yorker
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const YorkerPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Yorker", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Swing
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SwingPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFB3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text("Swing", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Spin (selected)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Spin",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======= 📸 Image 1 =======
          Positioned(
            left: 20,
            top: 312,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all1.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // 🏏 Title Text
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),

                // 📅 Date + Calendar Icon
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏰ Time + Clock Icon
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏱ Duration + Alarm Icon
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 2 =======
          Positioned(
            left: 20,
            top: 435,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all2.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

// ======= 📸 Image 3 =======
          Positioned(
            left: 20,
            top: 560,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/all3.png",
                  fit: BoxFit.cover,
                  width: 325,
                  height: 110,
                ),

                // Same text + icons inside
                Positioned(
                  left: 97,
                  top: 8,
                  child: Text(
                    "Yorker Training",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "30/07/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 122,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "16:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 65,
                  child: Row(
                    children: [
                      Icon(Icons.alarm, size: 16, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "45 minutes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// ----------------- ComparePage -----------------

class ComparePage extends StatefulWidget {
  const ComparePage({super.key});

  @override
  State<ComparePage> createState() => _ComparePageState();
}
class _ComparePageState extends State<ComparePage> {
  int selectedIndex = 0; // default selected option (0 = Spin)

  final List<String> options = ["Spin", "Speed", "Bounce", "Revs", "Drift"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          // 🔙 Back Arrow + Text
          Positioned(
            top: 40,
            left: 16,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Icon(Icons.arrow_back,
                      color: Colors.yellow, size: 28),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Compare",
                  style: TextStyle(
                    color: Color(0xFF00FFB3), // greenish color
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 🖼 Second Image
          Positioned(
            top: 85,
            left: 0,
            right: 0, // makes it stretch to screen width
            child: Image.asset(
              "assets/images/comparegreen.png",
              width: MediaQuery.of(context).size.width,
              height: 250,
              fit: BoxFit.contain, // keeps full image visible
            ),
          ),

          // 🖼 First Image
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/nameslistcompare.png",
              width: MediaQuery.of(context).size.width,
              height: 390,
              fit: BoxFit.contain, // or BoxFit.fitWidth if you want full width
            ),
          ),

          // ⚡ Row Options (Spin, Speed, Bounce, Revs, Drift)
          Positioned(
            top: 350,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(options.length, (index) {
                bool isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.yellow
                          : const Color(0xFF00FFB3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      options[index],
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),

      // 🟢 Your Custom Bottom Navbar
      bottomNavigationBar: const CustomBottomNavBar1(currentIndex: 3),
    );
  }
}


// ==================== Learn Page ====================

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,


      body: Stack(
        children: [
          // 🖼 First Image
          Positioned(
            left: -30,
            top: 47,
            width: 390,
            height: 170,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/learngreen.png",
                  fit: BoxFit.cover,
                  width: 390,
                  height: 170,
                ),

                // ↖️ Arrow + Text
                Positioned(
                  top: 28,
                  left: 30,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()),
                          );
                        },
                        child: const Icon(Icons.arrow_back,
                            color: Colors.yellow, size: 30),
                      ),
                      const SizedBox(width: 9),
                      const Text(
                        "Ready To Level Up Today ?",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
// 🖼 Second Image (learncontainer1)
          Positioned(
            left: 15,
            top: 250,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/learncontainer1.png",
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  left: 110,
                  top: 13,
                  width: 189,
                  height: 22,
                  child: Text(
                    "Comparisons",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Positioned(
                  left: 110,
                  top: 55,
                  width: 189,
                  height: 40,
                  child: Text(
                    "Master the art of analyzing\n different concepts side by side",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),

// 🖼 Third Image (learncontainer2)
          Positioned(
            left: 15,
            top: 370,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/learncontainer2.png",
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  left: 110,
                  top: 13,
                  width: 189,
                  height: 22,
                  child: Text(
                    "AI Generated Feedback",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Positioned(
                  left: 110,
                  top: 55,
                  width: 189,
                  height: 40,
                  child: Text(
                    "Get personalized insights\n powered by advanced AI",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),

// 🖼 Fourth Image (learncontainer3)
          Positioned(
            left: 15,
            top: 490,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/learncontainer3.png",
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  left: 110,
                  top: 13,
                  width: 189,
                  height: 22,
                  child: Text(
                    "Videos",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Positioned(
                  left: 110,
                  top: 55,
                  width: 189,
                  height: 40,
                  child: Text(
                    "Learn through videos",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
      //  Add Navbar Here
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );

  }
}

// ==================== Notification Page ====================

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          // 🖼 First Image
          Positioned(
            left: -20,
            top: 47,
            width: 390,
            height: 170,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/learngreen.png",
                  fit: BoxFit.cover,
                  width: 390,
                  height: 170,
                ),

                // ↖️ Arrow + Text
                Positioned(
                  top: 28,
                  left: 18,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()),
                          );
                        },
                        child: const Icon(Icons.arrow_back,
                            color: Colors.yellow, size: 30),
                      ),
                      const SizedBox(width: 9),
                      const Text(
                        "Notification",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🖼 Second Image (notifycontainer1)
          Positioned(
            left: 15,
            top: 250,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/notifycontainer1.png",
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  left: 110,
                  top: 13,
                  width: 189,
                  height: 22,
                  child: Text(
                    "John (Coach)",
                    style: TextStyle(
                      color: Color(0xFF4DDAC7), // Teal color
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Positioned(
                  left: 110,
                  top: 51,
                  width: 189,
                  height: 17,
                  child: Text(
                    "Great job your bowling today!",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Positioned(
                  left: 110,
                  top: 84,
                  width: 75,
                  height: 14,
                  child: Text(
                    "30 minutes ago",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

// 🖼 Third Image (notifycontainer2)
          Positioned(
            left: 15,
            top: 400,
            width: 325,
            height: 110,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/notifycontainer2.png",
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  left: 110,
                  top: 13,
                  width: 189,
                  height: 22,
                  child: Text(
                    "Abi (Teammate)",
                    style: TextStyle(
                      color: Color(0xFF4DDAC7),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Positioned(
                  left: 110,
                  top: 51,
                  width: 189,
                  height: 17,
                  child: Text(
                    "Hey! ready for the practice?",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Positioned(
                  left: 110,
                  top: 84,
                  width: 75,
                  height: 14,
                  child: Text(
                    "1 hour ago",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔍 Search Box
          Positioned(
            left: 22,
            top: 130,
            width: 325,
            height: 45,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      //  Add Navbar Here
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }
}
/// ---------------- COACH SCREEN ----------------
class CoachScreen extends StatefulWidget {
  const CoachScreen({super.key});

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  int? selectedGender; // 1 = Male, 2 = Female

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Back arrow image
          Positioned(
            left: 36,
            top: 88,
            width: 6,
            height: 11,
            child: Image.asset("assets/images/arrow.png"),
          ),

          // Back text
          Positioned(
            left: 54,
            top: 82,
            child: const Text(
              "Back",
              style: TextStyle(
                color: Color(0xFF00FFB3),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          // Title text
          Positioned(
            left: 90,
            top: 150,
            child: const Text(
              "What's your Gender?",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),

          // Background image
          Positioned(
            left: -50,
            top: 130,
            width: 400,
            height: 600,
            child: Image.asset("assets/images/playerbackground.png"),
          ),

          // Male image
          Positioned(
            left: 105,
            top: 210,
            width: 162.95,
            height: 162.95,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedGender = 1;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedGender == 1 ? Colors.yellow : Colors.transparent,
                    width: 4,
                  ),
                ),
                child: Image.asset("assets/images/male.png"),
              ),
            ),
          ),

          // Female image
          Positioned(
            left: 105,
            top: 400,
            width: 162.95,
            height: 162.95,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedGender = 2;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedGender == 2 ? Colors.yellow : Colors.transparent,
                    width: 4,
                  ),
                ),
                child: Image.asset("assets/images/female.png"),
              ),
            ),
          ),

          // Continue Button
          Positioned(
            left: 16,
            right: 16,
            bottom: 100,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CoachDetailsScreen()),
                );
              },
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//---------------- CoachDetailsScreen ---------------------
class CoachDetailsScreen extends StatelessWidget {
  const CoachDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Back button
          Positioned(
            top: 48,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.yellow),
                  SizedBox(width: 5),
                  Text(
                    "Back",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          // Background image
          Positioned(
            left: -50,
            top: 100,
            width: 200,
            height: 443.45,
            child: Image.asset(
              'assets/images/playerbackground.png',
              fit: BoxFit.cover,
            ),
          ),

          // Bowling Style label
          const Positioned(
            left: 20,
            top: 172,
            child: Text(
              "Role",
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Bowling style description
          const Positioned(
            left: 20,
            top: 200,
            child: Text(
              "What is your role as a coach?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),

          // Bowling style text field
          const Positioned(
            left: 20,
            top: 236,
            width: 313,
            height: 40,
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type here",
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Location label
          const Positioned(
            left: 20,
            top: 296,
            child: Text(
              "Location",
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Location description
          const Positioned(
            left: 20,
            top: 325,
            child: Text(
              "Where are you from?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),

          // Location text field
          const Positioned(
            left: 20,
            top: 360,
            width: 313,
            height: 40,
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type here",
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Starting Date label
          const Positioned(
            left: 20,
            top: 420,
            child: Text(
              "Active Since",
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Starting Date description
          const Positioned(
            left: 20,
            top: 445,
            child: Text(
              "Since when have you been coaching?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),

          // Starting Date text field
          const Positioned(
            left: 20,
            top: 484,
            width: 313,
            height: 40,
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type here",
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Continue button
          Positioned(
            left: 100,
            top: 600,
            width: 150,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/// ---------------- SIGN IN SCREEN ----------------

class SignInScreen extends StatefulWidget {
  final String? selectedMode;

  const SignInScreen({super.key, this.selectedMode});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // helper to navigate to the chosen mode
  void _navigateToMode(String mode) {
    if (mode == 'player') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PlayerScreen()),
      );
    } else if (mode == 'coach') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CoachScreen()),
      );
    }
  }

  // ✅ UPDATED LOGIN FUNCTION using ApiService
  Future<void> _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    try {
      // ✅ call the ApiService.login() instead of direct http.post
      final result = await ApiService.login(email, password);

      if (result['success'] == true) {
        final role = result['role'] ?? widget.selectedMode;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );

        if (widget.selectedMode != null) {
          _navigateToMode(widget.selectedMode!);
        } else {
          _navigateToMode(role);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Login failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            left: 36,
            top: 88,
            width: 6,
            height: 11,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset("assets/images/arrow.png"),
            ),
          ),
          Positioned(
            left: 85,
            top: 78,
            width: 190,
            height: 140,
            child: Image.asset("assets/images/signinimg2.png"),
          ),
          Positioned(
            left: 10,
            top: 580,
            width: 335,
            height: 18,
            child: Image.asset("assets/images/signinimg3.png"),
          ),
          Positioned(
            left: 5,
            top: 254,
            width: 350,
            height: 250,
            child: Container(
              color: const Color(0xCC00FFB3),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      hintText: "Email",
                      hintStyle: const TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const ResetPasswordScreen()),
                        );
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 520,
            right: 16,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: _handleLogin,
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 620,
            width: 74.5,
            height: 48,
            child: Image.asset("assets/images/img5.png"),
          ),
          Positioned(
            left: 100,
            top: 620,
            width: 74.5,
            height: 48,
            child: Image.asset("assets/images/img6.png"),
          ),
          Positioned(
            left: 190,
            top: 620,
            width: 74.5,
            height: 48,
            child: Image.asset("assets/images/img7.png"),
          ),
          Positioned(
            left: 275,
            top: 600,
            width: 74.5,
            height: 90,
            child: Image.asset("assets/images/img8.png"),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//-------------------- Sign Up Screen-------------------
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // 📅 Date Picker
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _birthDateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, //
      body: Stack(
        children: [
          // 1st image (arrow)
          Positioned(
            left: 15,
            top: 0,
            width: 10,
            height: 180,
            child: Image.asset(
              'assets/images/arrow.png',
              fit: BoxFit.contain,
            ),
          ),

          // 2nd image (signup1)
          Positioned(
            left: 100,
            top: 0,
            width: 162,
            height: 260,
            child: Image.asset(
              'assets/images/signup1.png',
              fit: BoxFit.contain,
            ),
          ),

          // 3rd image background (greenscreen + textfields inside)
          Positioned(
            left: 0,
            top: 213,
            width: 360,
            height: 360,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/greenscreen.png'),
                  fit: BoxFit.fill,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Full Name
                    TextField(
                      controller: _fullNameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Full Name",
                        hintStyle: TextStyle(color: Colors.white54),
                        fillColor: Colors.black,
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Email
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white54),
                        fillColor: Colors.black,
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Birth Date with calendar
                    TextField(
                      controller: _birthDateController,
                      style: const TextStyle(color: Colors.white),
                      readOnly: true,
                      onTap: _pickDate,
                      decoration: const InputDecoration(
                        hintText: "Date of Birth",
                        hintStyle: TextStyle(color: Colors.white54),
                        fillColor: Colors.black,
                        filled: true,
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Phone Number
                    TextField(
                      controller: _phoneController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "Phone Number (+Country Code)",
                        hintStyle: TextStyle(color: Colors.white54),
                        fillColor: Colors.black,
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Password with eye toggle
                    TextField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.white54),
                        fillColor: Colors.black,
                        filled: true,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Register Button (navigate to SignInScreen)
          Positioned(
            left: 13,
            top: 600,
            width: 335,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                );
              },
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// -----------Reset Password Screen------------------
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          //  Yellow Back Arrow
          Positioned(
            left: 6,
            top: 88,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.yellow, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // 🟡 Title - "Forgotten Password"
          const Positioned(
            left: 0,
            right: 0,
            top: 98,
            child: Center(
              child: Text(
                "Forgotten Password",
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Image at y=362
          Positioned(
            left: -15,
            top: 320,
            child: Container(
              width: 390,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/resetpasswordgreen.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Label above TextBox
                  const Text(
                    "Enter your email",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),

                  const SizedBox(height: 8),

                  //  TextBox for Email
                  Container(
                    width: 313,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: const TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Email ID",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Continue Button (Bottom Center)
          Positioned(
            left: 95,
            top: 500,
            child: SizedBox(
              width: 153,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SetPasswordScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// ----------SetPasswordScreen----------------


class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🔙 Yellow Back Arrow
          Positioned(
            left: 6,
            top: 88,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.yellow, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // 🟡 Title - "Set Password"
          const Positioned(
            left: 0,
            right: 0,
            top: 98,
            child: Center(
              child: Text(
                "Set Password",
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //  Image at y=362
          Positioned(
            left: -15,
            top: 320,
            child: Container(
              width: 390,
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/resetpasswordgreen.png"), // replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Password Label
                  const Text(
                    "Enter new password",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  const SizedBox(height: 8),

                  //  Password TextBox
                  Container(
                    width: 313,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextField(
                      obscureText: _obscurePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Confirm Password Label
                  const Text(
                    "Confirm password",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  const SizedBox(height: 8),

                  // Confirm Password TextBox
                  Container(
                    width: 313,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextField(
                      obscureText: _obscureConfirmPassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ⬜ Continue Button
          Positioned(
            left: 119,
            top: 632,
            width: 153,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              },
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

