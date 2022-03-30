import 'package:flutter/material.dart';

class CounterState {
  int _value = 0;

  void inc() => _value++;
  void dec() => _value--;
  int get value => _value;

  bool diff(CounterState old) {
    return old.value != _value;
  }
}

class CounterProvider extends InheritedWidget {
  CounterProvider({Key? key, required Widget child})
      : super(child: child, key: key);
  final CounterState state = CounterState();

  static CounterProvider? of(BuildContext ctx) {
    return ctx.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.diff(state);
  }
}
