import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

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
      home: const MyHomePage(title: 'MyCuteGPT 3.5'),
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
  List<Answer> answers = [];
  String _text = '';

  void _addAnswer(String text) {
    setState(() {
      answers.add(Answer(text: text));
      _controller.clear();
      _text = '';
    });
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
        actions: const [
          Icon(Icons.mode),
          Icon(Icons.more_vert),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Chat(text: 'Hello, how can I help you?'),
                      const SizedBox(height: 8),
                      ...answers,
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        hintText: 'Message',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                        ),
                        suffixIcon: const Icon(Icons.graphic_eq),
                      ),
                      onChanged: (text) {
                        if (text.isEmpty) return;
                        setState(() {
                          _text = text;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    style: IconButton.styleFrom(backgroundColor: Colors.black),
                    onPressed:
                        _text.isNotEmpty ? () => _addAnswer(_text) : null,
                    icon: const Icon(Icons.arrow_upward),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({super.key, required this.text, this.isUser = false});
  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: isUser ? Colors.purple : Colors.green,
              foregroundColor: Colors.white,
              maxRadius: 12,
              child: Text(isUser ? 'FC' : 'G'),
            ),
            const SizedBox(width: 8),
            Text(
              isUser ? 'FlutterBoot' : 'MyCuteGPT',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        Row(children: [
          const SizedBox(width: 32),
          Expanded(
              child: Text(text, style: Theme.of(context).textTheme.bodyLarge))
        ])
      ],
    );
  }
}

class Answer extends StatelessWidget {
  const Answer({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Chat(
          text: text,
          isUser: true,
        ),
        const SizedBox(height: 8),
        const Chat(
            text:
                'Actually, I don\'t have any features, but one day I\'ll grow up and become ChatGPT!')
      ],
    );
  }
}
