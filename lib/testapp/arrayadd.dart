import 'dart:async';

import 'package:flutter/material.dart';

class StreamBuilderPage extends StatefulWidget {
  const StreamBuilderPage({super.key});

  @override
  _StreamBuilderPageState createState() => _StreamBuilderPageState();
}

class _StreamBuilderPageState extends State<StreamBuilderPage> {
  List<int> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
            //Error number 2
            stream: NumberCreator().stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Text('done');
              } else if (snapshot.hasError) {
                return Text('Error!');
              } else {
                items.add(snapshot.data!);
                print(
                    items); //print every second: [0] then [0,1] then [0,1,2] ...
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index].toString()),
                    );
                  },
                  itemCount: items.length,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class NumberCreator {
  NumberCreator() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      //add count to stream
      _controller.sink.add(_count);
      _count++;
    });
  }
  var _count = 1;
  final _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;

  dispose() {
    _controller.close();
  }
}
