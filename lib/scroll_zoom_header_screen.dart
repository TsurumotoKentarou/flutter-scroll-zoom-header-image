import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ScrollZoomHeaderScreen extends StatefulWidget {
  @override
  _ScrollZoomHeaderScreenState createState() => _ScrollZoomHeaderScreenState();
}

class _ScrollZoomHeaderScreenState extends State<ScrollZoomHeaderScreen> {
  ScrollController _controller = ScrollController();
  double scrollOffsetY = 0.0;
  final double maxStretchScrollOffsetY = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          // Logger()..d(notification);
          if (notification is OverscrollNotification) {
            print('呼ばれた');
          }

          // print(notification.metrics.pixels);
          setState(() {
            if (notification.metrics.pixels < 0) {
              print(notification.metrics.pixels);
              if (notification.metrics.pixels < -maxStretchScrollOffsetY) {
                this.scrollOffsetY = -maxStretchScrollOffsetY;
              } else {
                this.scrollOffsetY = notification.metrics.pixels;
              }
            } else {
              this.scrollOffsetY = 0;
            }
          });
          return false;
        },
        child: CustomScrollView(
          controller: this._controller,
          slivers: <Widget>[
            SliverAppBar(
                floating: false,
                pinned: true,
                expandedHeight: 200 - this.scrollOffsetY,
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    stretchModes: [
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground
                    ],
                    background: Container(color: Colors.red))),
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
      ),
    ));
  }
}
