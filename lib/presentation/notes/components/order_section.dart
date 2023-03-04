import 'package:flutter/material.dart';
import 'package:note/domain/util/note_order.dart';
import 'package:note/domain/util/order_type.dart';

enum SingingCharacter { lafayette, jefferson }

class OrderSection extends StatelessWidget {
  final NoteOrder noteOrder;

  final Function(NoteOrder) onOrderChanged;

  const OrderSection({
    super.key,
    required this.noteOrder,
    required this.onOrderChanged,
  });

  @override
  Widget build(BuildContext context) {
    print(noteOrder.orderType);
    return Column(
      children: [
        Row(
          children: [
            Radio<NoteOrder>(
              activeColor: Colors.white,
              value: NoteOrder.title(OrderType.descending()),
              groupValue: noteOrder,
              onChanged: (NoteOrder? value) {
                if (value is NoteOrderTitle) {
                  onOrderChanged(NoteOrder.title(noteOrder.orderType));
                }
              },
            ),
            const Text('제목'),
            Radio<NoteOrder>(
              activeColor: Colors.white,
              value: NoteOrder.date(OrderType.descending()),
              groupValue: noteOrder,
              onChanged: (NoteOrder? value) {
                if (value is NoteOrderDate) {
                  onOrderChanged(NoteOrder.date(noteOrder.orderType));
                }
              },
            ),
            const Text('날짜'),
            Radio<NoteOrder>(
              activeColor: Colors.white,
              value: NoteOrder.color(OrderType.descending()),
              groupValue: noteOrder,
              onChanged: (NoteOrder? value) {
                if (value is NoteOrderColor) {
                  onOrderChanged(NoteOrder.color(noteOrder.orderType));
                }
              },
            ),
            const Text('색상'),
          ],
        ),
        Row(
          children: [
            Radio<OrderType>(
              activeColor: Colors.white,
              value: OrderType.ascending(),
              groupValue: noteOrder.orderType,
              onChanged: (OrderType? value) {
                if (value is Ascending) {
                  onOrderChanged(
                      noteOrder.copy(orderType: OrderType.ascending()));
                }
              },
            ),
            const Text('오름차순'),
            Radio<OrderType>(
              activeColor: Colors.white,
              value: OrderType.descending(),
              groupValue: noteOrder.orderType,
              onChanged: (OrderType? value) {
                if (value is Descending) {
                  onOrderChanged(
                      noteOrder.copy(orderType: OrderType.descending()));
                }
              },
            ),
            const Text('내림차순'),
          ],
        ),
      ],
    );
  }
}
