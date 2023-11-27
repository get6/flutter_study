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
      home: const MyHomePage(title: 'Flutter Demo'),
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

class Description {
  final IconData icon;
  final String title;
  final String desc;

  const Description({
    required this.icon,
    required this.title,
    required this.desc,
  });
}

class _MyHomePageState extends State<MyHomePage> {
  final descriptions = [
    const Description(
      icon: Icons.bolt,
      title: 'Premium features',
      desc:
          'Plus subscribers have access to FlutterBoot+ and out latest beta features.',
    ),
    const Description(
      icon: Icons.whatshot,
      title: 'Priority access',
      desc: 'You\'ll be able to use FlutterBoott even when demand is high',
    ),
    const Description(
      icon: Icons.speed,
      title: 'Ultra-fast',
      desc: 'Enjoy even faster response speeds when using FlutterBoot',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'FlutterBoot Plus',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                for (final description in descriptions)
                  DescriptionTile(
                    iconData: description.icon,
                    title: description.title,
                    description: description.desc,
                  )
              ],
            ),
            const Spacer(),
            const Text('Restore subscription'),
            const SizedBox(height: 24),
            Text(
              'Auto-renews for \$25/month until canceled',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: const Text('Subscribe'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DescriptionTile extends StatelessWidget {
  const DescriptionTile({
    super.key,
    required this.iconData,
    required this.title,
    required this.description,
  });
  final IconData iconData;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 32,
        color: Colors.black,
      ),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
    );
  }
}
