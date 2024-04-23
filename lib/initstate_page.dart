import 'package:flutter/material.dart';
import 'package:net_music_uz/home/home.dart';

class InitStatePage extends StatefulWidget {
  const InitStatePage({super.key});

  @override
  State<InitStatePage> createState() => _InitStatePageState();
}

class _InitStatePageState extends State<InitStatePage> {
  @override
  void initState() {
    super.initState();
    initStateBuilder();
  }

  Future initStateBuilder() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/png-state.png",
          width: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
