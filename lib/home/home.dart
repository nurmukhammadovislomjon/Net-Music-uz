// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:net_music_uz/colors.dart';
import 'package:net_music_uz/home/body/home_screen.dart';
import 'package:net_music_uz/home/body/profil_screen.dart';
import 'package:net_music_uz/home/body/qoshiqchi_screen.dart';
import 'package:net_music_uz/home/body/search_page.dart';
import 'package:net_music_uz/home/body/xitlar_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomeScreen(),
          QoshiqchiScreen(),
          SearchPage(),
          XitlarScreen(),
          ProfilScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        width: size.width,
        height: 80,
        margin: EdgeInsets.only(
          left: size.width * 0.02,
          right: size.width * 0.02,
          bottom: size.width * 0.02,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: greyColor.withOpacity(0.25),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(5, 5),
              blurStyle: BlurStyle.normal,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  currentIndex = 0;
                  bottomNavigationBarItem1Color =
                      bottomNavigationBarCurrentItemColor;
                  bottomNavigationBarItem2Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem3Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem4Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem5Color =
                      bottomNavigationBarUnCurrentItemColor;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIconsFill.house,
                    color: bottomNavigationBarItem1Color,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Asosiy",
                    style: GoogleFonts.akatab(
                      color: bottomNavigationBarItem1Color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  currentIndex = 1;
                  bottomNavigationBarItem2Color =
                      bottomNavigationBarCurrentItemColor;
                  bottomNavigationBarItem1Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem3Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem4Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem5Color =
                      bottomNavigationBarUnCurrentItemColor;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIconsFill.waveform,
                    color: bottomNavigationBarItem2Color,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Qo'shiqchi",
                    style: GoogleFonts.akatab(
                      color: bottomNavigationBarItem2Color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  currentIndex = 2;
                  bottomNavigationBarItem3Color =
                      bottomNavigationBarCurrentItemColor;
                  bottomNavigationBarItem2Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem1Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem4Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem5Color =
                      bottomNavigationBarUnCurrentItemColor;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: bottomNavigationBarItem3Color,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Qidirish",
                    style: GoogleFonts.akatab(
                      color: bottomNavigationBarItem3Color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  currentIndex = 3;
                  bottomNavigationBarItem4Color =
                      bottomNavigationBarCurrentItemColor;
                  bottomNavigationBarItem2Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem1Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem3Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem5Color =
                      bottomNavigationBarUnCurrentItemColor;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIconsFill.musicNote,
                    color: bottomNavigationBarItem4Color,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Xitlar",
                    style: GoogleFonts.akatab(
                      color: bottomNavigationBarItem4Color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  currentIndex = 4;
                  bottomNavigationBarItem4Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem2Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem3Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem1Color =
                      bottomNavigationBarUnCurrentItemColor;
                  bottomNavigationBarItem5Color =
                      bottomNavigationBarCurrentItemColor;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category,
                    color: bottomNavigationBarItem5Color,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Boshqa",
                    style: GoogleFonts.akatab(
                      color: bottomNavigationBarItem5Color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
