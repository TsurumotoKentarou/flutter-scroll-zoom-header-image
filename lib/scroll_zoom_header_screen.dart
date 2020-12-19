import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show Image;

class ScrollZoomHeaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ヘッダー画像
    final Image headerImage = Image(
      image: AssetImage('assets/view.jpg'),
      fit: BoxFit.cover,
    );

    // ヘッダー画像のCompleter
    Completer<ui.Image> completer = new Completer<ui.Image>();
    headerImage.image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));

    // ヘッダー画像の幅
    final headerImageWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          FutureBuilder<ui.Image>(
              future: completer.future,
              builder: (context, snapshot) {
                return SliverAppBar(
                    backgroundColor: Colors.white,
                    pinned: true,
                    stretch: true,
                    expandedHeight: snapshot.hasData
                        ? headerImageWidth *
                            snapshot.data.height /
                            snapshot.data.width
                        : 0,
                    flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        stretchModes: [
                          StretchMode.zoomBackground,
                        ],
                        background: headerImage));
              }),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                child: ListTile(
                  title: Text("List：$index"),
                  leading: Icon(Icons.person),
                ),
              );
            }, childCount: 100)),
          ),
        ],
      ),
    ));
  }
}
