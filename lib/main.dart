import 'package:flutter/material.dart';
import 'package:jnigen_looper_example/gen/android/android/os/Handler.dart';
import 'package:jnigen_looper_example/gen/android/android/os/Looper.dart';
import 'package:jnigen_looper_example/gen/android/java/lang/Runnable.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Handler? _handler;

  void _prepareLooper() {
    debugPrint('_prepareLooper');

    if (Looper.myLooper().isNull) {
      debugPrint('Looper was null. Preparing');
      Looper.prepare();
    }

    debugPrint('Creating Handler');
    _handler = Handler();

    setState(() {});
  }

  void _loopLooperInDelayedZero() {
    debugPrint('_loopLooperInDelayedZero');
    Future.delayed(Duration.zero, _loopLooper);
  }

  void _loopLooper() {
    debugPrint('_loopLooper');
    Looper.loop();
  }

  void _postMessage() {
    debugPrint('_postMessage');
    _handler?.post(
      Runnable.implement(
        $RunnableImpl(
          run: () {
            debugPrint("Hello from Looper!");
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLooperPrepared = !Looper.myLooper().isNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Looper - Home'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _prepareLooper,
              child: const Text('Prepare Looper'),
            ),
            Text(
              'Looper is prepared: $isLooperPrepared',
            ),
            ElevatedButton(
              onPressed: isLooperPrepared ? _loopLooperInDelayedZero : null,
              child: const Text(
                'Loop Looper in Future.delayed(Duration.zero)',
              ),
            ),
            ElevatedButton(
              onPressed: isLooperPrepared ? _loopLooper : null,
              child: const Text('Loop Looper'),
            ),
            ElevatedButton(
              onPressed: isLooperPrepared ? _postMessage : null,
              child: const Text('Post Message via Handler'),
            ),
          ],
        ),
      ),
    );
  }
}
