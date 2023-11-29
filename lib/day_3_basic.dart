import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'I can layout this'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FittedBox(
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Container(
                        color: Colors.grey.shade400,
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  child: Expanded(
                    child: FittedBox(
                      child: Container(
                        width: 250,
                        height: 125,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded(
                //   child: SizedBox(
                //     width: 250,
                //     height: 250,
                //     child: Column(
                //       children: [
                //         Container(
                //           color: Colors.white,
                //           width: 250,
                //           height: 100,
                //         ),
                //         Container(
                //           color: Colors.green,
                //           width: 250,
                //           height: 100,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Expanded(
                  child: FittedBox(
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Column(
                        children: [
                          // Container(
                          //   color: Colors.yellow,
                          //   width: 250,
                          //   height: 100,
                          // ),
                          Container(
                            color: Colors.black,
                            width: 250,
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.yellowAccent,
                      width: 250,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child:
                      Container(color: Colors.yellow, width: 500, height: 100),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(color: Colors.brown, width: 500, height: 50),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
