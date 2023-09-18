import 'package:flutter/material.dart';

class CounterMobile extends StatefulWidget {
  const CounterMobile({
    super.key,
  });

  @override
  State<CounterMobile> createState() => _CounterMobileState();
}

class _CounterMobileState extends State<CounterMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Angular with flutter'),
      ),
      body: const Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
            ]),
      ),
    );
  }
}
