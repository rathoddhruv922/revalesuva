import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/services/api_constant.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

showLoader() {
  FocusManager.instance.primaryFocus?.unfocus();
  return (Get.isDialogOpen ?? false)
      ? const SizedBox()
      : Get.dialog(
          barrierDismissible: false,
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: const CupertinoActivityIndicator(
              color: Colors.white,
              animating: true,
              radius: 20,
            ),
          ),
        );
}

hideLoader({bool? hideOverlay}) {
  FocusManager.instance.primaryFocus?.unfocus();
  if (Get.isDialogOpen ?? false) {
    Get.back(closeOverlays: hideOverlay ?? false);
  }
}

Widget noDataFoundWidget({double height = 50,String? message}) {
  return SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    child: Container(
      alignment: Alignment.center,
      height: height.h,
      child: TextBodyLarge(
        text: message ?? StringConstants.noDataFound,
        color: AppColors.textPrimary,
      ),
    ),
  );
}

Widget appVersion() {
  return Container(
    padding: const EdgeInsets.all(10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
    ),
    child: true ? const SizedBox():Text(
      "Version : ${APIConstant.instance.appVersion}",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

customHtmlWidget(String htmlData) {
  return HtmlWidget(
    htmlData,
    customStylesBuilder: (element) {
      if (element.localName == 'p') {
        return {'text-align': 'justify'};
      }
      return null;
    },
    renderMode: RenderMode.column,
    onTapImage: (imageMetadata) {},
  );
}

showToast({required String msg}) {
  if (msg.isNotEmpty) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: AppColors.surfaceOrange..withValues(alpha: 0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

String convertTo12HourFormat(String time24Hour) {
  try {
    final time = TimeOfDay(
      hour: int.parse(time24Hour.split(':')[0]),
      minute: int.parse(time24Hour.split(':')[1]),
    );

    final formattedTime = DateFormat.jm().format(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, time.hour, time.minute),
    );

    return formattedTime;
  } catch (e) {
    return "";
  }
}

String changeDateStringFormat({required String date, required String format}) {
  try {
    if (date.isNotEmpty) {
      String dateString = date;
      DateTime dateTime = DateTime.parse(dateString).toLocal();
      String formattedDate = DateFormat(format).format(dateTime);
      return formattedDate;
    } else {
      return "no date";
    }
  } on FormatException {
    return "Invalid Date format";
  }
}

bool? compareTwoDate({required String date1, required String date2}) {
  try {
    return changeDateStringFormat(date: date1, format: DateFormatHelper.ymdFormat) ==
        changeDateStringFormat(date: date2, format: DateFormatHelper.ymdFormat);
  } catch (e) {
    return null;
  }
}

String calculateEndTime(
    {required String date, required String startTime, required String durationToAdd}) {
  DateTime startDateTime = DateTime.parse("$date $startTime:00");
  List<String> durationParts = durationToAdd.split(":");
  Duration duration = Duration(hours: int.parse(durationParts[0]), minutes: int.parse(durationParts[1]));
  DateTime endDateTime = startDateTime.add(duration);
  String endTime =
      "${endDateTime.hour.toString().padLeft(2, '0')}:${endDateTime.minute.toString().padLeft(2, '0')}";
  return endTime;
}

int calculateAge(String stBirthDate) {
  DateTime currentDate = DateTime.now();
  DateTime? birthDate = DateTime.tryParse(stBirthDate);
  if (birthDate != null) {
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  } else {
    return 0;
  }
}

double calculateBMI({required double weight, required double height}) {
  double heightInMeters = height / 100;
  return weight / (heightInMeters * heightInMeters);
}

String convertJsonToString(Map<String, dynamic> json) {
  StringBuffer buffer = StringBuffer();
  json.forEach((key, value) {
    if (value is Map) {
      value.forEach((subKey, subValue) {
        buffer.writeln('$subKey: ${subValue.join(', ')}');
      });
    } else {
      buffer.writeln('$key: $value');
    }
  });
  return buffer.toString();
}

String removeHtmlTags(String htmlString) {
  final RegExp htmlTagRegExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(htmlTagRegExp, '');
}

String getNumberFromString({required String text}) {
  String input = text;
  RegExp regExp = RegExp(r'\d+');
  String? match = regExp.firstMatch(input)?.group(0);

  if (match != null) {
    int number = int.parse(match);
    return number.toString();
  } else {
    return "";
  }
}

String convertToTimeString(String time) {
  List<String> parts = time.split(':');
  String hours = parts[0].padLeft(2, '0');
  String minutes = parts[1].padLeft(2, '0');
  return '$hours:$minutes';
}

String addHoursToTime(String time, int hoursToAdd) {
  List<String> parts = time.split(':');
  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);

  DateTime dateTime = DateTime(0, 1, 1, hours, minutes);
  dateTime = dateTime.add(Duration(hours: hoursToAdd));

  String newHours = dateTime.hour.toString().padLeft(2, '0');
  String newMinutes = dateTime.minute.toString().padLeft(2, '0');

  return '$newHours:$newMinutes';
}

// void dateTimeFromTimeString() {
//   DateFormat format = DateFormat("HH:mm:ss");
//   DateTime startTime = format.parse(startTimeStr);
//   DateTime currentTime = DateTime.now();
//   Duration difference = currentTime.difference(startTime);
//   setState(() {
//     timeDifference = difference.toString();
//   });
// }

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.shape = BoxShape.rectangle,
  });

  final double? height;
  final double? width;
  final double? radius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.grey.shade300,
        enabled: true,
        child: Container(
          decoration: BoxDecoration(
            shape: shape,
            borderRadius: radius == null ? null : BorderRadius.circular(radius ?? 0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

String getFirstSentence({required String text}) {
  List<String> sentences = text.split('.');
  return sentences.isNotEmpty ? '${sentences[0]}.' : '';
}

String getFirstWords({required String text, required int length}) {
  List<String> words = text.split(' ');
  return words.length >= length ? '${words[0]} ${words[1]} ${words[2]}' : text;
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    required this.color,
  });

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(AppCorner.messageBox)),
      ),
      child: child,
    );
  }
}

String getHebrewDay({required DateTime date}) {
  List<String> hebrewDays = [
    "א׳",
    "ב׳",
    "ג׳",
    "ד׳",
    "ה׳",
    "ו׳",
    "ז׳",
    "ח׳",
    "ט׳",
    "י׳",
    "י״א",
    "י״ב",
    "י״ג",
    "י״ד",
    "ט״ו",
    "ט״ז",
    "י״ז",
    "י״ח",
    "י״ט",
    "כ׳",
    "כ״א",
    "כ״ב",
    "כ״ג",
    "כ״ד",
    "כ״ה",
    "כ״ו",
    "כ״ז",
    "כ״ח",
    "כ״ט",
    "ל׳"
  ];

  // Adjust for months with 31 days
  int day = date.day > 30 ? 30 : date.day;

  return hebrewDays[day - 1];
}

Map<String, dynamic> removeNullAndEmptyKeys(Map<String, dynamic> data) {
  data.removeWhere((key, value) => value == null);
  return data;
}

Widget getStatusOrderStatus({required String orderStatus}) {
  var color = AppColors.surfaceGreen;
  var textColor = AppColors.textPrimary;
  var status = StringConstants.pending;

  if (orderStatus == "pending") {
    color = AppColors.pending;
    status = StringConstants.pending;
  } else if (orderStatus == "processing") {
    color = AppColors.processing;
    status = StringConstants.processing;
  } else if (orderStatus == "shipped") {
    color = AppColors.shipped;
    status = StringConstants.shipped;
  } else if (orderStatus == "delivered") {
    color = AppColors.delivered;
    status = StringConstants.delivered;
  } else if (orderStatus == "cancelled") {
    color = AppColors.canceled;
    status = StringConstants.canceled;
  } else if (orderStatus == "returned") {
    color = AppColors.returned;
    status = StringConstants.returned;
  } else if (orderStatus == "refunded") {
    color = AppColors.refunded;
    status = StringConstants.refunded;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: AppColors.borderSecondary),
      borderRadius: BorderRadius.circular(AppCorner.cardBoarder),
    ),
    child: TextBodySmall(
      text: status,
      maxLine: 1,
      color: textColor,
    ),
  );
}

String? formatSeconds(int? seconds) {
  if (seconds != null) {
    if (seconds < 0) return "00:00";

    final Duration duration = Duration(seconds: seconds);

    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);
    final int remainingSeconds = duration.inSeconds.remainder(60);

    final String minutesStr = minutes.toString().padLeft(2, '0');
    final String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    final String hoursStr = hours.toString().padLeft(2, '0');
    return "$hoursStr:$minutesStr:$secondsStr";
  } else {
    return null;
  }
}

String calculateTimeDifference({required String playedLength, required String totalLength}) {
  // Function to convert time string to Duration
  Duration parseTime(String time) {
    List<String> parts = time.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    return Duration(hours: hours, minutes: minutes);
  }

  // Parse the time strings into Duration objects
  Duration playedDuration = parseTime(playedLength);
  Duration totalDuration = parseTime(totalLength);

  // Calculate the difference
  Duration difference = totalDuration - playedDuration;

  // Format the difference based on the presence of hours
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String formattedDifference;

  if (difference.inHours > 0) {
    formattedDifference = "${twoDigits(difference.inHours)}:"
        "${twoDigits(difference.inMinutes.remainder(60))}:"
        "${twoDigits(difference.inSeconds.remainder(60))}";
  } else {
    formattedDifference = "${twoDigits(difference.inMinutes)}:"
        "${twoDigits(difference.inSeconds.remainder(60))}";
  }

  return formattedDifference;
}

takeScreenShotAndShareByKey({
  required GlobalKey<State<StatefulWidget>> key,
  required String message,
}) async {
  try {
    showLoader();
    RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 2);
    ByteData byteData = (await image.toByteData(format: ImageByteFormat.png))!;
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    File file = File('$tempPath/${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    await Share.shareXFiles(
      [XFile(file.path)],
      text: message,
    );
    hideLoader();
  } catch (e) {
    hideLoader();
  }
}

shareContent({
  required String title,
  required String message,
}) async {
  try {
    showLoader();
    await Share.share(
      message,
      subject: title,
    );
    hideLoader();
  } catch (e) {
    hideLoader();
  }
}

downloadFile({required String url, required BuildContext context}) async {
  await MediaDownload().downloadMedia(context, url);
}

class CustomCard2 extends StatelessWidget {
  const CustomCard2({
    super.key,
    required this.child,
    required this.color,
    this.radius = AppCorner.messageBox,
  });

  final Widget child;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(radius),
          topEnd: Radius.circular(radius),
        ),
      ),
      child: child,
    );
  }
}
