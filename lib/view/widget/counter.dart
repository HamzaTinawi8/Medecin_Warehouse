import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final int initialValue;
  final Function(int) onCounterChanged;

  const Counter(
      {Key? key, this.initialValue = 0, required this.onCounterChanged})
      : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late int counter;

  @override
  void initState() {
    super.initState();
    counter = widget.initialValue;
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
    widget.onCounterChanged(counter);
  }

  void decrementCounter() {
    setState(() {
      if (counter > 1) counter--;
    });
    widget.onCounterChanged(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35,
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: decrementCounter,
              icon: const Icon(Icons.remove),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          '$counter',
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(width: 5),
        Container(
          width: 35,
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: incrementCounter,
              icon: const Icon(Icons.add),
            ),
          ),
        )
      ],
    );
  }
}
