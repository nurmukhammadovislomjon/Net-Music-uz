// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class XitlarScreen extends StatefulWidget {
  const XitlarScreen({super.key});

  @override
  State<XitlarScreen> createState() => _XitlarScreenState();
}

List<String> xitMusicNames = [];
List<String> xitMusicArtists = [];

class _XitlarScreenState extends State<XitlarScreen> {
  @override
  void initState() {
    super.initState();
    getLoadXitItems();
  }

  Future getLoadXitItems() async {
    await FirebaseFirestore.instance.collection("xitlar").get().then((value) {
      value.docs.forEach((element) {
        xitMusicNames.add(element.data()['music name']);
        xitMusicArtists.add(element.data()['ijrochi']);
        print("xit music -> ${element.data()['music name']}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Container();
      },
    );
  }
}
