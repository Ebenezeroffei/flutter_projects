import 'package:flutter/material.dart';
import 'package:flutter_tuts/providers/counter.dart';
import 'package:provider/provider.dart';

class ProviderApp extends StatelessWidget {
  const ProviderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>(
      create: (BuildContext context) => Counter(),
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "This is the current value of count.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            Consumer<Counter>(
              builder: (context, value, child) => Text(
                "${value.count}",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: value.isNegative ? Colors.red : Colors.black54),
              ),
            ),
            CountPage(),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () => context.read<Counter>().decreament(),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            width: 40,
          ),
          FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () => context.read<Counter>().reset(),
            child: const Icon(Icons.replay_outlined),
          ),
          const SizedBox(
            width: 40,
          ),
          FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () => context.read<Counter>().increament(),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class CountPage extends StatelessWidget {
  const CountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${context.watch<Counter>().count}",
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
