//sealed class 형태로 만들어보자!

import 'package:equatable/equatable.dart';

abstract class OrderType {
  factory OrderType.ascending() {
    return const Ascending();
  }

  factory OrderType.descending() {
    return const Descending();
  }
}

class Ascending extends Equatable implements OrderType {
  const Ascending();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Descending extends Equatable implements OrderType {
  const Descending();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
