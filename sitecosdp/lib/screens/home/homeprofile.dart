import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sitecosdp/screens/auth/login.dart';

class Homeprofile extends StatefulWidget {
  const Homeprofile({super.key});

  @override
  State<Homeprofile> createState() => _HomeprofileState();
}

class _HomeprofileState extends State<Homeprofile> {
  final String username = "John Doe";
  final String email = "john.doe@example.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBD3F8),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BounceInDown(
                  duration: const Duration(milliseconds: 1200),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF2E073F),
                          Color(0xFF7A1CAC),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: const Color(0xFF2E073F),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Shimmer.fromColors(
                  baseColor: const Color(0xFF2E073F),
                  highlightColor: const Color(0xFFAD49E1),
                  child: Text(
                    username,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FadeIn(
                  duration: const Duration(milliseconds: 1200),
                  child: Text(
                    email,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ElasticIn(
                  duration: const Duration(milliseconds: 1500),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => Loginscreen()),
                            (Route<dynamic> route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7A1CAC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 10,
                        shadowColor: const Color(0xFF7A1CAC),
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
