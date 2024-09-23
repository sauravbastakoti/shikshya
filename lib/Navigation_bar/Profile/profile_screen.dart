import 'package:flutter/material.dart';
import 'package:sikshya/Navigation_bar/Profile/change_password.dart';
import 'package:sikshya/Navigation_bar/Profile/personal_info.dart';
import 'package:sikshya/Navigation_bar/Profile/terms_and_condition.dart';
import 'package:sikshya/Navigation_bar/Profile/transcation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightGreenAccent, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: [
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
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: const [
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
                          builder: (context) => PersonalInfo(),
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
                          builder: (context) => ChangePassword(),
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
                          builder: (context) => Transaction_history(),
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
                          builder: (context) => TermsAndCondition(),
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
                          builder: (context) => PersonalInfo(),
                        ),
                      );
                    },
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
