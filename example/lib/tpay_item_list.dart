import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tpay_example/tpay_item.dart';

class TpayItemList extends StatelessWidget {
  const TpayItemList({super.key, required this.actions});

  final Map<String, Function> actions;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final action in actions.entries)
            TpayItem(title: action.key, onClick: action.value)
        ],
      ),
    );
  }
}