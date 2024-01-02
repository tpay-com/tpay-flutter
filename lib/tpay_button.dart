import 'package:flutter/cupertino.dart';

const _tpayLogoWidth = 90.0;
const _tpayLogoHeight = 20.0;
const _tpayLogoVerticalPadding = 14.0;
const _tpayButtonBorderRadius = 48.0;
const _tpayLogoPath = "packages/flutter_tpay/assets/images/tpay_payments.png";
const _tpayButtonGradientStartColor = Color(0xFF2952C4);
const _tpayButtonGradientEndColor = Color(0xFF082755);
const _tpayButtonPressedGradientStartColor = Color(0xFF14348E);
const _tpayButtonPressedGradientEndColor = Color(0xFF031A3C);
const _tpayButtonGradientColors = [_tpayButtonGradientStartColor, _tpayButtonGradientEndColor];
const _tpayButtonPressedGradientColors = [_tpayButtonPressedGradientStartColor, _tpayButtonPressedGradientEndColor];

/// Tpay pay button that should be displayed on checkout.
class TpayButton extends StatefulWidget {
  const TpayButton({super.key, required this.onClick});

  final Function onClick;

  @override
  State<StatefulWidget> createState() => _TpayButtonState();
}

class _TpayButtonState extends State<TpayButton> {
  late List<Color> _gradientColors = _tpayButtonGradientColors;

  void _onPress(PointerDownEvent event) {
    _setGradientColors(_tpayButtonPressedGradientColors);
  }

  void _onRelease(PointerUpEvent event) {
    widget.onClick();
    _setGradientColors(_tpayButtonGradientColors);
  }

  void _setGradientColors(List<Color> colors) {
    setState(() {
      _gradientColors = colors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPress,
      onPointerUp: _onRelease,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: _gradientColors),
          borderRadius: BorderRadius.circular(_tpayButtonBorderRadius),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: _tpayLogoVerticalPadding),
          child: Image(width: _tpayLogoWidth, height: _tpayLogoHeight, image: AssetImage(_tpayLogoPath)),
        ),
      ),
    );
  }
}
