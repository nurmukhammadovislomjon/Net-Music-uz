// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:net_music_uz/colors.dart';
import 'package:net_music_uz/home/body/open-audio/open-audio-page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

List<String> allAudios = [];
List<String> youAudios = [];
List<String> artistsName = [];
List<String> allImage = [];
List<String> youImage = [];
List<String> allMusicNames = [];
List<String> youMusicNames = [];
bool isLoading = true;

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    loadingAllAudios();
  }


  Future loadingAllAudios() async {
    await FirebaseStorage.instance
        .ref()
        .child("barcha-artist")
        .listAll()
        .then((value) {
      value.items.forEach((element) {
        artistsName.add(element.name.split('.')[0]);
      });
    });

    for (var artists in artistsName) {
      await FirebaseStorage.instance
          .ref()
          .child(artists)
          .listAll()
          .then((value) {
        value.items.forEach((element) async {
          allAudios.add(await element.getDownloadURL());
        });
      });
      await FirebaseStorage.instance
          .ref()
          .child("$artists-image")
          .listAll()
          .then((value) {
        value.items.forEach((element) async {
          allImage.add(await element.getDownloadURL());
          allMusicNames.add(element.name.split('.')[0]);
          print(element.name.split('.')[0]);
        });
      });
    }
    if (mounted) {
      isLoading = false;
      setState(() {});
    }
  }

  String thisText = "Musiqani qidiring";

  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: greyColor.withOpacity(0.2),
                      blurRadius: 30,
                      blurStyle: BlurStyle.inner)
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  filled: true,
                  fillColor: greyColor.withOpacity(0.2),
                  hintText: "Musiqani qidiring",
                  hintStyle: GoogleFonts.akatab(
                      color: CupertinoColors.black,
                      fontWeight: FontWeight.w700),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        searchAudioFunc(searchTextOk: searchText.text),
                    icon: Icon(
                      Icons.search,
                      color: blackColor,
                    ),
                  ),
                ),
                controller: searchText,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
              ),
            ),
          ),
          youImage.isNotEmpty
              ? MasonryGridView.builder(
                  shrinkWrap: true,
                  itemCount: youImage.isNotEmpty ? youImage.length : 4,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return !isLoading
                        ? Container(
                            width: size.width * 0.5,
                            height: size.width * 0.65,
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
                                      audios: youAudios,
                                      images: youImage,
                                      imagesName: youMusicNames,
                                      index: index,
                                      artistName: artistsName[0],
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(youImage[index]),
                                  SizedBox(height: size.width * 0.03),
                                  Text(
                                    textAlign: TextAlign.center,
                                    youMusicNames[index],
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
                )
              : Center(
                  child: Text(
                    thisText,
                    style: GoogleFonts.akatab(
                      color: blueAccentColor,
                      fontSize: 18,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Future searchAudioFunc({required String searchTextOk}) async {
    if (searchTextOk.isNotEmpty) {
      youAudios.clear();
      youImage.clear();
      youMusicNames.clear();
      for (var text in allMusicNames) {
        if (text.trim().toLowerCase() == searchTextOk.trim().toLowerCase()) {
          int index = allMusicNames.indexOf(text);
          youAudios.add(allAudios[index]);
          youMusicNames.add(allMusicNames[index]);
          youImage.add(allImage[index]);
          if (mounted) {
            setState(() {});
          }
        } else if (text.trim().toLowerCase() !=
            searchTextOk.trim().toLowerCase()) {
          // youAudios.clear();
          // youImage.clear();
          // youMusicNames.clear();
          if (mounted) {
            thisText = """"$searchTextOk" bunday musiqa mavjud emas""";
            setState(() {});
          }
        }
      }
    } else {
      youAudios.clear();
      youImage.clear();
      youMusicNames.clear();
      if (mounted) {
        thisText = "Musiqani qidiring";
        setState(() {});
      }
    }
  }
}
