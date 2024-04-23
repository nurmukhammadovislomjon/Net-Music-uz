// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, unused_local_variable, prefer_is_empty

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:net_music_uz/colors.dart';
import 'package:net_music_uz/home/body/open-audio/open-audio-page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> sliderImages = [];
  bool isLoadingImage = true;
  List<String> itemsName = [];
  // List<String> item1Name = [];
  // List<String> item2Name = [];
  // List<String> item3Name = [];
  // List<String> item4Name = [];
  List<String> item1Image = [];
  List<String> item2Image = [];
  List<String> item3Image = [];
  List<String> item4Image = [];
  List<String> item1Musics = [];
  List<String> item2Musics = [];
  List<String> item3Musics = [];
  List<String> item4Musics = [];
  List<String> item1ImageName = [];
  List<String> item2ImageName = [];
  List<String> item3ImageName = [];
  List<String> item4ImageName = [];
  List<String> item1MusicsName = [];
  List<String> item2MusicsName = [];
  List<String> item3MusicsName = [];
  List<String> item4MusicsName = [];
  bool isLoadingNext4 = true;
  bool isEmptyItem1 = true;
  bool isEmptyItem2 = true;

  Future loadSliderImage() async {
    ListResult result =
        await FirebaseStorage.instance.ref().child("slider").listAll();
    for (var item in result.items) {
      sliderImages.add(await item.getDownloadURL());
    }
    if (mounted) {
      isLoadingImage = !isLoadingImage;
      setState(() {});
    }
  }

  Future loadItemNext() async {
    await FirebaseFirestore.instance.collection("home").get().then((value) {
      value.docs.forEach((element) {
        Map<String, dynamic> data = element.data();
        itemsName.add(data['name']);
        print(data['name']);
      });
    });
    if (itemsName.length >= 2) {
      ListResult resultImageN1 = await FirebaseStorage.instance
          .ref()
          .child("${itemsName[0]}-image")
          .list();
      ListResult resultImageN2 = await FirebaseStorage.instance
          .ref()
          .child("${itemsName[1]}-image")
          .list();

      ListResult resultMusicsN1 =
          await FirebaseStorage.instance.ref().child(itemsName[0]).listAll();
      ListResult resultMusicsN2 =
          await FirebaseStorage.instance.ref().child(itemsName[1]).listAll();

      for (var i in itemsName) {
        if (i == itemsName[0]) {
          for (var x in resultImageN1.items) {
            item1Image.add(await x.getDownloadURL());
            item1ImageName.add(x.name);
            print(x.name);
          }
          for (var z in resultMusicsN1.items) {
            item1Musics.add(await z.getDownloadURL());
            item1MusicsName.add(z.name);
            print(z.name);
          }
          if (mounted) {
            isEmptyItem1 = false;
            setState(() {});
          }
        } else if (i == itemsName[1]) {
          for (var x in resultImageN2.items) {
            item2Image.add(await x.getDownloadURL());
            item2ImageName.add(x.name);
            print(x.name);
          }
          for (var z in resultMusicsN2.items) {
            item2Musics.add(await z.getDownloadURL());
            item2MusicsName.add(z.name);
            print(z.name);
          }
          if (mounted) {
            isEmptyItem2 = false;
            setState(() {});
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadSliderImage();
    loadItemNext();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider.builder(
            itemCount: sliderImages.isNotEmpty ? sliderImages.length : 4,
            itemBuilder: (context, index, realIndex) {
              return isLoadingImage
                  ? Image.asset("assets/png-slider.png")
                  : Image.network(sliderImages[index]);
            },
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayCurve: Curves.slowMiddle,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          !isEmptyItem1
              ? Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    itemsName[0],
                    style: GoogleFonts.akatab(
                      color: blueAccentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : Container(),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: size.width * 0.7,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: item1Image.isNotEmpty ? item1Image.length : 4,
              itemBuilder: (context, index) {
                return !isEmptyItem1
                    ? Container(
                        width: size.width * 0.5,
                        height: size.height * 0.5,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                                color: greyColor.withOpacity(0.2),
                                blurRadius: 50,
                                offset: const Offset(2, 2),
                                spreadRadius: 2),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OpenAudioPage(
                                  audios: item1Musics,
                                  images: item1Image,
                                  imagesName: item1ImageName,
                                  index: index,
                                  artistName: itemsName[0],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(item1Image[index]),
                              SizedBox(height: size.width * 0.03),
                              Text(
                                textAlign: TextAlign.center,
                                item1ImageName[index].split('.')[0],
                                style: GoogleFonts.akatab(
                                  color: blueAccentColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        width: size.width * 0.5,
                        height: size.height * 0.5,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                                color: greyColor.withOpacity(0.2),
                                blurRadius: 50,
                                offset: const Offset(2, 2),
                                spreadRadius: 2),
                          ],
                        ),
                        child: Image.asset("assets/png-state.png"));
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          !isEmptyItem2
              ? Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    itemsName[1],
                    style: GoogleFonts.akatab(
                      color: blueAccentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : Container(),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: size.width * 0.7,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: item2Image.isNotEmpty ? item2Image.length : 4,
              itemBuilder: (context, index) {
                return !isEmptyItem2
                    ? Container(
                        width: size.width * 0.5,
                        height: size.height * 0.5,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                                color: greyColor.withOpacity(0.2),
                                blurRadius: 50,
                                offset: const Offset(2, 2),
                                spreadRadius: 2),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OpenAudioPage(
                                  audios: item2Musics,
                                  images: item2Image,
                                  imagesName: item2ImageName,
                                  index: index,
                                  artistName: itemsName[1],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(item2Image[index]),
                              SizedBox(height: size.width * 0.03),
                              Text(
                                textAlign: TextAlign.center,
                                item2ImageName[index].split('.')[0],
                                style: GoogleFonts.akatab(
                                  color: blueAccentColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        width: size.width * 0.5,
                        height: size.height * 0.5,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                                color: greyColor.withOpacity(0.2),
                                blurRadius: 50,
                                offset: const Offset(2, 2),
                                spreadRadius: 2),
                          ],
                        ),
                        child: Image.asset("assets/png-state.png"));
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
