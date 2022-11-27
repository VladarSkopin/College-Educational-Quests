
import 'package:flutter/material.dart';

const btnTextStyleDark = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w600
);

const lightDecorationProfile = BoxDecoration(
    color: Color(0xFF31C6D4)
);

const darkDecorationProfile = BoxDecoration(
    color: Color(0xFF150050)
);


const boxDecorationDefault = BoxDecoration(
    image: DecorationImage(
        image: AssetImage('assets/images/bg_1.png'),
        fit: BoxFit.cover
    )
);

final boxDecorationBtn = BoxDecoration(
    color: const Color(0xFFE8FEFF),
    borderRadius: BorderRadius.circular(25)
);

const pageDecorationLight = BoxDecoration(
    gradient: LinearGradient(
        colors: [
          Color(0xFFa8ab00),
          Color(0xFFb8ac17),
          Color(0xFFc6ad27),
          Color(0xFFd4ae36),
          Color(0xFFe0af43),
          Color(0xFFebb150),
          Color(0xFFf6b35e),
          Color(0xFFffb56b),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
    )
);

const pageDecorationDark = BoxDecoration(
    gradient: LinearGradient(
        colors: [
          Color(0xFF000436),
          Color(0xFF11153d),
          Color(0xFF222245),
          Color(0xFF312f4c),
          Color(0xFF3f3d53),
          Color(0xFF4d4b5a),
          Color(0xFF5b5a62),
          Color(0xFF696969),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
    )
);

final boxDecorationAuthorCardDark = BoxDecoration(
    gradient: const LinearGradient(
        colors: [
          Color(0xFF523769),
          Color(0xFF9f5273),
          Color(0xFFe28954),
          Color(0xFF8b8c54),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight
    ),
    border: Border.all(
      width: 2,
      color: Colors.grey,
    ),
    borderRadius: const BorderRadius.all(Radius.circular(20))
);

final boxDecorationAuthorCardLight = BoxDecoration(
    gradient: const LinearGradient(
        colors: [
          Color(0xFF8afff9),
          Color(0xFF9effd9),
          Color(0xFFa2fa86),
          Color(0xFFfdff96),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight
    ),
    border: Border.all(
      width: 2,
      color: Colors.grey,
    ),
    borderRadius: const BorderRadius.all(Radius.circular(20))
);
