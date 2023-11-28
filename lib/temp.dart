import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  ScrollController _scrollController = ScrollController();
  bool _isBlueContainerSticky = false;

  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        // SliverFixedExtentList(
        //   itemExtent: 100,
        //   delegate: SliverChildListDelegate([
        //     Container(
        //       color: Colors.yellow,
        //     ),
        //   ]),
        // ),
        SliverFixedExtentList(
          itemExtent: 500,
          delegate: SliverChildListDelegate([
            Container(
              height: 500,
              color: Colors.red,
            ),
          ]),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.blue,
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Text('Item $index');
                  },
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 100,
                      height: 500,
                      color: Colors.purple,
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 0) {
        if (!_isBlueContainerSticky) {
          setState(() {
            _isBlueContainerSticky = true;
          });
        }
      } else {
        if (_isBlueContainerSticky) {
          setState(() {
            _isBlueContainerSticky = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
