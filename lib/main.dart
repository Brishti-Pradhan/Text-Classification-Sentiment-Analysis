import 'package:flutter/material.dart';
import 'classifier.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _controller;
  late Classifier _classifier;
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _classifier = Classifier();
    _children = [];
    _children.add(Container());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Setting debugShowCheckedModeBanner to false
      theme: ThemeData(
        primaryColor: Colors.orangeAccent,
        fontFamily: 'Roboto',
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text('Text Classification'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: _children.length,
                  itemBuilder: (_, index) {
                    return _children[index];
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orangeAccent),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Write some text here',
                        ),
                        controller: _controller,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        final text = _controller.text;
                        final prediction = _classifier.classify(text);
                        setState(() {
                          _children.add(
                            Dismissible(
                              key: GlobalKey(),
                              onDismissed: (direction) {},
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  color: prediction[1] > prediction[0]
                                      ? Colors.lightGreen
                                      : Colors.redAccent,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Input: $text",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 8),
                                      Text("Output:"),
                                      Text("   Positive: ${prediction[1]}"),
                                      Text("   Negative: ${prediction[0]}"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                          _controller.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
