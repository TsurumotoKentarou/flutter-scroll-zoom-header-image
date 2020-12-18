import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollZoomHeaderScreen extends StatefulWidget {
  @override
  _ScrollZoomHeaderScreenState createState() => _ScrollZoomHeaderScreenState();
}

class _ScrollZoomHeaderScreenState extends State<ScrollZoomHeaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              pinned: true,
              stretch: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  stretchModes: [
                    StretchMode.zoomBackground,
                  ],
                  background: Image.asset('assets/mountain.jpg'))),
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
