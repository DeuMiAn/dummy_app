import 'package:get/get.dart';

class MultipleBindingBuilder extends Bindings {
  final Iterable<Bindings> bindings;

  MultipleBindingBuilder({required this.bindings});

  @override
  void dependencies() {
    for (final element in bindings) {
      element.dependencies();
    }
  }
}
