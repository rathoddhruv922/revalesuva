import 'package:revalesuva/utils/strings_constant.dart';

class DefaultList {
  DefaultList._();

  static List<String> ganderList = <String>[
    StringConstants.male,
    StringConstants.female,
  ];

  static List<String> periodList = <String>[
    StringConstants.regularPeriod,
    StringConstants.irregularPeriod,
    StringConstants.breastfeedingPeriod,
    StringConstants.pregnantPeriod,
  ];

  static List<String> monthList = <String>[
    StringConstants.january,
    StringConstants.february,
    StringConstants.march,
    StringConstants.april,
    StringConstants.may,
    StringConstants.june,
    StringConstants.july,
    StringConstants.august,
    StringConstants.september,
    StringConstants.october,
    StringConstants.november,
    StringConstants.december,
  ];

  static List<String> personalStatusList = <String>[
    StringConstants.married,
    StringConstants.unmarried,
  ];

  static List<String> filterBy = <String>[
    StringConstants.vegan,
    StringConstants.vegetarian,
    StringConstants.meat,
    StringConstants.dairy,
  ];

  static List<String> sortBy = <String>[
    StringConstants.mostRelevant,
    StringConstants.mostPopular,
    StringConstants.priceLowToHigh,
    StringConstants.priceHighToLow,
  ];

  static List<String> cityList = <String>[
    StringConstants.jerusalem,
    StringConstants.telAvivYafo,
    StringConstants.haifa,
    StringConstants.rishonLeZion,
    StringConstants.ashdod,
    StringConstants.beersheba,
    StringConstants.petahTikva,
    StringConstants.netanya,
    StringConstants.holon,
    StringConstants.bneiBrak,
    StringConstants.batYam,
    StringConstants.ramatGan,
    StringConstants.ashkelon,
    StringConstants.rehovot,
    StringConstants.beitShemesh,
    StringConstants.kfarSaba,
    StringConstants.herzliya,
    StringConstants.hadera,
    StringConstants.modiinMaccabimReut,
    StringConstants.eilat,
  ];

  static List<String> yearList() {
    final currentYear = DateTime.now().year;
    return List<String>.generate(10, (index) => (currentYear - index).toString());
  }
}
