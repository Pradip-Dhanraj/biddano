import 'package:biddano/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CreditCard extends StatelessWidget {
  final String name;
  final String cardNumber;
  final String validThru;
  final int securityCode;
  final double angle;
  const CreditCard({
    Key? key,
    required this.name,
    required this.cardNumber,
    required this.validThru,
    required this.securityCode,
    required this.angle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: angle),
      duration: const Duration(milliseconds: 500),
      builder: (BuildContext context, double val, __) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(val),
          child: Card(
            elevation: 10,
            color: Colors.transparent,
            child: (val >= math.pi / 2)
                ? CardBack(
                    cardNumber: cardNumber,
                    validThru: validThru,
                    securityCode: securityCode)
                : CardFront(
                    name: name,
                    cardNumber: cardNumber,
                    validThru: validThru,
                    securityCode: securityCode),
          ),
        );
      },
    );
  }
}

TextStyle _getTextStyle({
  double? fontSize = 16,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: Colors.white,
  );
}

class CardFront extends StatelessWidget {
  final String name;
  final String cardNumber;
  final String validThru;
  final int securityCode;
  const CardFront({
    Key? key,
    required this.name,
    required this.cardNumber,
    required this.validThru,
    required this.securityCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 220,
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage(AppStrings.background), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            bottom: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'cardholder name',
                  style: _getTextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  name.toUpperCase(),
                  style: _getTextStyle(),
                )
              ],
            ),
          ),
          Positioned(
            left: 20,
            bottom: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'card number',
                  style: _getTextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  cardNumber,
                  style: _getTextStyle(),
                )
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: 30,
            child: Row(
              children: [
                Container(
                  width: 50,
                  child: Image.asset(AppStrings.chip),
                  margin: const EdgeInsets.only(right: 10),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'expiration',
                  style: _getTextStyle(
                    fontSize: 12,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'VALID THRU',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                    const Icon(
                      Icons.arrow_right,
                      color: Colors.white,
                    ),
                    Text(
                      validThru,
                      style: _getTextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  final String cardNumber;
  final String validThru;
  final int securityCode;
  const CardBack({
    Key? key,
    required this.cardNumber,
    required this.validThru,
    required this.securityCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(math.pi),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: 360,
            height: 220,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(AppStrings.background), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 20,
                  child: Container(
                    height: 40,
                    width: constraints.maxWidth,
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  right: 20,
                  left: 20,
                  top: 80,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 40,
                    width: constraints.widthConstraints().maxWidth,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        color: const Color.fromARGB(255, 182, 179, 179),
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          children: [
                            const Text(
                              'CVV',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              securityCode == 0 ? '' : securityCode.toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 30,
                  top: 125,
                  child: Text(
                    'SECURITY CODE',
                    style: _getTextStyle(
                      fontSize: 8,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
