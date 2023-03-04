//sealed class 형태로 만들어보자!

import 'package:equatable/equatable.dart';
import 'package:note/domain/util/order_type.dart';

abstract class NoteOrder {
  //약간의 꼼수같은 느낌이긴하다...허허허
  late OrderType orderType;
  copy({required OrderType orderType}) {}

  factory NoteOrder.title(OrderType orderType) {
    return NoteOrderTitle(orderType);
  }

  factory NoteOrder.date(OrderType orderType) {
    return NoteOrderDate(orderType);
  }

  factory NoteOrder.color(OrderType orderType) {
    return NoteOrderColor(orderType);
  }
}

class NoteOrderTitle extends Equatable implements NoteOrder {
  @override
  OrderType orderType;
  NoteOrderTitle(this.orderType);

  @override
  copy({required OrderType orderType}) {
    return NoteOrderTitle(orderType);
  }

  @override
  // TODO: implement props

  //Equatable은 객체의 비교를 가능케해준다.
  //기본적으로 서로다른 두개의 intance를 ==로 비교하면 다른놈들이라고 판단한다
  //메모리 주소같이 다르기때문이다.
  //서로다른 인스턴스를 == true가 나오게해주고싶다
  //그럴때 Equatable 라이브러리를 사용하면된다.
  //Equatable은 같은 클래스의 인스턴스는 == true로 인식하게해준다.
  //여기서 주의해야할 점은
  //[]빈배열로 넣게되면, orderType이 다른데에도 불구하고
  //두개의 NoteOrderTitle 인스턴스가 == true가 나온다.
  //[]로 특별한 조건을 주지않으면 같은 클래스의 인스턴스라면 ==가 true가 나오기때문이다.
  //여기서 아무리 같은 클래스의 인스턴스여도 내부적으로 다르면 다른 인스턴스로 인식하게
  //제한을 주고싶다면[orderType]을 넣어주면된다.
  //orderType도 같아야만!!!!!! == true로 인식되게 조건을 추가해줄수있다.

  List<Object?> get props => [];
}

class NoteOrderDate extends Equatable implements NoteOrder {
  @override
  OrderType orderType;
  NoteOrderDate(this.orderType);
  @override
  copy({required OrderType orderType}) {
    return NoteOrderDate(orderType);
  }

  @override
  List<Object?> get props => [];
}

class NoteOrderColor extends Equatable implements NoteOrder {
  @override
  OrderType orderType;
  NoteOrderColor(this.orderType);
  @override
  copy({required OrderType orderType}) {
    return NoteOrderColor(orderType);
  }

  @override
  List<Object?> get props => [];
}
