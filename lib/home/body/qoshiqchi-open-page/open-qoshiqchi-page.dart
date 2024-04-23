// ignore_for_file: file_names

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:net_music_uz/colors.dart';
import 'package:net_music_uz/home/body/open-audio/open-audio-page.dart';

class OpenQoshiqchiPage extends StatefulWidget {
  const OpenQoshiqchiPage({super.key, required this.artistName});
  final String artistName;

  @override
  State<OpenQoshiqchiPage> createState() => _OpenQoshiqchiPageState();
}

class _OpenQoshiqchiPageState extends State<OpenQoshiqchiPage> {
  List<String> images = [];
  List<String> audios = [];
  List<String> names =[];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getLoadItems();
  }

  Future getLoadItems() async {
    ListResult resultAudio = await FirebaseStorage.instance
        .ref()
        .child(widget.artistName)
        .listAll();

    ListResult resultImage = await FirebaseStorage.instance
        .ref()
        .child('${widget.artistName}-image')
        .listAll();
    for (var item in resultImage.items) {
      names.add(item.name.split('.')[0]);
      images.add(await item.getDownloadURL());
    }
    for (var item in resultAudio.items) {
      audios.add(await item.getDownloadURL());
    }
    if (mounted) {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: MasonryGridView.builder(
        itemCount: images.isNotEmpty?images.length:4,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return !isLoading
              ? Container(
                  width: size.width * 0.5,
                  height: size.width*0.65,
                  margin: const EdgeInsets.all(15),
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
                            audios: audios,
                            images: images,
                            imagesName: names,
                            index: index,
                            artistName: widget.artistName,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(images[index]),
                        SizedBox(height: size.width * 0.03),
                        Text(
                          textAlign: TextAlign.center,
                          names[index],
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
                  height: size.width * 0.7,
                  margin: const EdgeInsets.all(15),
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
    );
  }
}
