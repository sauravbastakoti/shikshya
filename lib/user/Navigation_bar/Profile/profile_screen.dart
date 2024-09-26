import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:sikshya/core/router/app_router.dart';
import 'package:sikshya/features/login_screen.dart';
import 'package:sikshya/user/Navigation_bar/Profile/change_password.dart';
import 'package:sikshya/user/Navigation_bar/Profile/personal_info.dart';
import 'package:sikshya/user/Navigation_bar/Profile/terms_and_condition.dart';
import 'package:sikshya/user/Navigation_bar/Profile/transcation.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = 'profile';
  final PageController pageController;
  const ProfileScreen({super.key, required this.pageController});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Clear the saved token
    await prefs.remove(
        'token'); // or `await prefs.clear();` if you want to clear all data
    // Navigate to the login screen
    context.goNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightGreenAccent, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.settings),
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "John Doe",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("johndoe@gmail.com"),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  textlist(
                    text: "Personal information",
                    icons: Icons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PersonalInfo(),
                        ),
                      );
                    },
                  ),
                  textlist(
                    text: "Change password",
                    icons: Icons.lock,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePassword(),
                        ),
                      );
                    },
                  ),
                  textlist(
                    text: "Change Email",
                    icons: Icons.email,
                    onTap: () {},
                  ),
                  textlist(
                    text: "Transaction History",
                    icons: Icons.payment,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Transaction_history(),
                        ),
                      );
                    },
                  ),
                  textlist(
                    text: "Security Question",
                    icons: Icons.security,
                    onTap: () {},
                  ),
                  textlist(
                    text: "Terms and Condition",
                    icons: Icons.privacy_tip,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsAndCondition(),
                        ),
                      );
                    },
                  ),
                  textlist(
                    text: "Change Language",
                    icons: Icons.language,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PersonalInfo(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: TextButton(
                        onPressed: _logout, // Call the logout function
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 62, 151, 215),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: Text(
                          'Log Out',
                          style: GoogleFonts.getFont(
                            'Roboto Condensed',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: const Color.fromARGB(255, 248, 248, 248),
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
      ),
    );
  }
}

class textlist extends StatelessWidget {
  final String text;
  final IconData icons;
  final VoidCallback onTap;

  const textlist({
    super.key,
    required this.text,
    required this.icons,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icons),
      title: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      onTap: onTap,
    );
  }
}
