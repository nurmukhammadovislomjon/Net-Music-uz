// ignore_for_file: avoid_print

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:net_music_uz/home/body/qoshiqchi-open-page/open-qoshiqchi-page.dart';

class QoshiqchiScreen extends StatefulWidget {
  const QoshiqchiScreen({super.key});

  @override
  State<QoshiqchiScreen> createState() => _QoshiqchiScreenState();
}

List<String> barchaQoshiqchiImageList = [];
List<String> barchaQoshiqchiNameList = [];
bool isLoadImage = true;

class _QoshiqchiScreenState extends State<QoshiqchiScreen> {
  @override
  void initState() {
    super.initState();
    getLoadAllQoshiqchiImageFunc();
  }

  Future getLoadAllQoshiqchiImageFunc() async {
    ListResult result =
        await FirebaseStorage.instance.ref().child('barcha-artist').listAll();

    for (var item in result.items) {
      barchaQoshiqchiImageList.add(await item.getDownloadURL());
      barchaQoshiqchiNameList.add(item.name.split('.')[0]);
      print(item.name.split('.')[0]);
    }
    if (mounted) {
      isLoadImage = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: barchaQoshiqchiImageList.isNotEmpty
          ? barchaQoshiqchiImageList.length
          : 6,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return !isLoadImage
            ? Padding(
                padding: const EdgeInsets.all(15),
                child: ClipOval(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OpenQoshiqchiPage(
                              artistName: barchaQoshiqchiNameList[index],
                            ),
                          ));
                    },
                    child: Image.network(
                      barchaQoshiqchiImageList[index],
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(15),
                child: ClipOval(
                  child: Image.asset("assets/png-state.png"),
                ),
              );
      },
    );
  }
}
