import 'package:flutter/cupertino.dart';
import 'package:flutter_tpay/tpay_button.dart';

const tpayItemTextVerticalPadding = 10.0;
const tpayItemTextSize = 20.0;
const tpayItemTextFontWeight = FontWeight.w500;

class TpayItem extends StatelessWidget {
  const TpayItem({super.key, required this.title, required this.onClick});

  final String title;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: tpayItemTextVerticalPadding),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: tpayItemTextSize,
              fontWeight: tpayItemTextFontWeight,
            ),
          ),
        ),
        TpayButton(onClick: onClick)
      ],
    );
  }
}