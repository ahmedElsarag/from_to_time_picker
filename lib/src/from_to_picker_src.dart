import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'colors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/foundation.dart';

///interactive from to hours picker
///
/// the returned result will be two 24h [TimeOfDay]
class FromToTimePicker extends StatefulWidget {
  /// return the two picked [TimeOfDay] values
  ///
  /// on user click on ok Button
  final Function(TimeOfDay, TimeOfDay)? onTab;

  /// the header of the dialog
  ///
  /// can provide user with information or available time to pick
  final String? headerText;

  /// the color of dialog header text
  final Color? headerTextColor;

  /// submit button text
  final String? doneText;

  /// submit button text color
  final Color? doneTextColor;

  /// dismiss button text color
  final Color? dismissTextColor;

  ///  dismiss button text
  final String? dismissText;

  ///  day text of both from to time  picker
  ///
  /// by default it must be 'AM'
  ///
  /// pass any text you want to localize it
  final String? dayText;

  /// the night text of both from to time picker
  ///
  /// by default it must be 'PM'
  ///
  /// pass any text you want to localize it
  final String? nightText;

  /// the default viewed text in time picker
  ///
  /// by default it contains '00'
  final String? timeHintText;

  /// the text above the first time picker
  final String? fromHeadline;

  /// the text above second time picker
  final String? toHeadline;

  /// color of text above the first time picker
  final Color? fromHeadlineColor;

  /// color of text above the first time picker
  final Color? toHeadlineColor;

  /// background color of Active 'AM','PM' box
  final Color? activeDayNightColor;

  /// background color of deactivated 'AM','PM' box
  final Color? defaultDayNightColor;

  /// text color of Active 'AM','PM' box
  final Color? activeDayNightTextColor;

  /// text color of deactivated 'AM','PM' box
  final Color? defaultDayNightTextColor;

  ///border radius of 'AM','PM' box
  final double? dayNightBorderRadius;

  ///border radius of time picker
  final double? timeBoxBorderRadius;

  /// background color of time picker
  final Color? timeBoxColor;

  /// background color of the dialog
  final Color? dialogBackgroundColor;

  /// icon of increasing time button
  final IconData? upIcon;

  /// icon of decreasing time button
  final IconData? downIcon;

  /// icon color of increasing time button
  final Color? upIconColor;

  /// icon color of decreasing time button
  final Color? downIconColor;

  /// color of the vertical divider between 'increasing and decreasing buttons' and 'the time text'
  final Color? dividerColor;

  /// color of default shown text in time box
  final Color? timeHintColor;

  /// color of picked hour text
  final Color? timeTextColor;

  /// show circular bullet before the dialog header
  ///
  /// can be used to show available or unavailable time to user
  final bool? showHeaderBullet;

  ///color of circular bullet before the dialog header
  ///
  /// for best practice use green color for available and red for unavailable time
  final Color? headerBulletColor;

  /// color of two dots separates between two time picker box
  final Color? colonColor;

  const FromToTimePicker(
      {Key? key,
      required this.onTab,
      this.headerText,
      this.fromHeadline = 'From',
      this.toHeadline = 'To',
      this.fromHeadlineColor = MColors.black,
      this.toHeadlineColor = MColors.black,
      this.activeDayNightColor = MColors.primary_color,
      this.defaultDayNightColor = MColors.mainColor70,
      this.activeDayNightTextColor = MColors.white,
      this.defaultDayNightTextColor = MColors.black,
      this.dayNightBorderRadius = 5,
      this.timeBoxBorderRadius = 8,
      this.timeBoxColor = MColors.mainColor70,
      this.upIcon = Icons.keyboard_arrow_up_rounded,
      this.downIcon = Icons.keyboard_arrow_down_rounded,
      this.upIconColor = MColors.black,
      this.downIconColor = MColors.black,
      this.dividerColor = MColors.divider,
      this.timeHintColor = MColors.divider,
      this.timeTextColor = MColors.gray_66,
      this.doneText = 'ok',
      this.dismissText = 'cancel',
      this.dayText = 'AM',
      this.nightText = 'PM',
      this.dialogBackgroundColor = MColors.white,
      this.showHeaderBullet = false,
      this.headerBulletColor = MColors.green_1,
      this.headerTextColor = MColors.gray_9a,
      this.colonColor = MColors.black,
      this.timeHintText = '00',
      this.doneTextColor = MColors.black,
      this.dismissTextColor = MColors.black})
      : super(key: key);

  @override
  State<FromToTimePicker> createState() => _FromToTimePickerState();
}

class _FromToTimePickerState extends State<FromToTimePicker> {
  bool isAmFrom = false, isAmTo = false;
  int timePickerStartTime = 0, timePickerEndTime = 0;
  late TimeOfDay fromTime;
  late TimeOfDay toTime;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: widget.headerText != null
                ? MediaQuery.of(context).size.height *
                    (isNotMobile() ? 0.33 : 0.26)
                : MediaQuery.of(context).size.height * .24,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: widget.dialogBackgroundColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: widget.headerText != null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: widget.showHeaderBullet!,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .03,
                          height: MediaQuery.of(context).size.width * .03,
                          margin: EdgeInsetsDirectional.only(
                              end: MediaQuery.of(context).size.width * .02),
                          decoration: BoxDecoration(
                              color: widget.headerBulletColor,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * .04)),
                        ),
                      ),
                      Text(
                        '${widget.headerText}',
                        style: TextStyle(
                            fontSize: 12, color: widget.headerTextColor),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          fromTimeItem(widget.fromHeadline!),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .04,
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.only(
                                top: MediaQuery.of(context).size.height * .02),
                            height: MediaQuery.of(context).size.height * .12,
                            alignment: Alignment.center,
                            child: Text(
                              ':',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: widget.colonColor),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .04,
                          ),
                          toTimeItem(widget.toHeadline!)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
              end: 20,
              bottom: 10,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        widget.dismissText!,
                        style: TextStyle(
                            color: widget.dismissTextColor, fontSize: 16),
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .06,
                  ),
                  InkWell(
                      onTap: () {
                        widget.onTab!(
                            generate24HTime(
                                isAmFrom, timePickerStartTime.toString()),
                            generate24HTime(
                                isAmTo, timePickerEndTime.toString()));
                        Navigator.pop(context);
                      },
                      child: Text(
                        widget.doneText!,
                        style: TextStyle(
                            color: widget.doneTextColor, fontSize: 16),
                      )),
                ],
              ))
        ],
      ),
    );
  }

  /// the from time part of the dialog
  ///
  /// contains two arrows, day night box, and time box
  Widget fromTimeItem(String headline) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          headline,
          style: TextStyle(
              color: widget.fromHeadlineColor, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            fromTimePicker(),
            SizedBox(
              width: MediaQuery.of(context).size.width * .02,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isAmFrom = true;
                      fromTime = generate24HTime(
                          isAmFrom, timePickerStartTime.toString());
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .07,
                    height: MediaQuery.of(context).size.height * .038,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        widget.dayText!,
                        style: TextStyle(
                            color: isAmFrom
                                ? widget.activeDayNightTextColor
                                : widget.defaultDayNightTextColor,
                            fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isAmFrom == true
                            ? widget.activeDayNightColor
                            : widget.defaultDayNightColor,
                        borderRadius: BorderRadiusDirectional.only(
                            topStart:
                                Radius.circular(widget.dayNightBorderRadius!),
                            topEnd:
                                Radius.circular(widget.dayNightBorderRadius!))),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .005,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isAmFrom = false;
                      fromTime = generate24HTime(
                          isAmFrom, timePickerStartTime.toString());
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .07,
                    height: MediaQuery.of(context).size.height * .038,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        widget.nightText!,
                        style: TextStyle(
                            color: isAmFrom
                                ? widget.defaultDayNightTextColor
                                : widget.activeDayNightTextColor,
                            fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isAmFrom == true
                            ? widget.defaultDayNightColor
                            : widget.activeDayNightColor,
                        borderRadius: BorderRadiusDirectional.only(
                            bottomEnd:
                                Radius.circular(widget.dayNightBorderRadius!),
                            bottomStart:
                                Radius.circular(widget.dayNightBorderRadius!))),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  /// the to time part of the dialog
  ///
  /// contains two arrows, day night box, and time box
  Widget toTimeItem(String headline) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          headline,
          style: TextStyle(
              color: widget.toHeadlineColor, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            toTimePicker(),
            SizedBox(
              width: MediaQuery.of(context).size.width * .02,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isAmTo = true;
                      toTime =
                          generate24HTime(isAmTo, timePickerEndTime.toString());
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .07,
                    height: MediaQuery.of(context).size.height * .038,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        widget.dayText!,
                        style: TextStyle(
                            color: isAmTo
                                ? widget.activeDayNightTextColor
                                : widget.defaultDayNightTextColor,
                            fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isAmTo == true
                            ? widget.activeDayNightColor
                            : widget.defaultDayNightColor,
                        borderRadius: BorderRadiusDirectional.only(
                            topStart:
                                Radius.circular(widget.dayNightBorderRadius!),
                            topEnd:
                                Radius.circular(widget.dayNightBorderRadius!))),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .005,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isAmTo = false;
                      toTime =
                          generate24HTime(isAmTo, timePickerEndTime.toString());
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .07,
                    height: MediaQuery.of(context).size.height * .038,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        widget.nightText!,
                        style: TextStyle(
                            color: isAmTo
                                ? widget.defaultDayNightTextColor
                                : widget.activeDayNightTextColor,
                            fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isAmTo == true
                            ? widget.defaultDayNightColor
                            : widget.activeDayNightColor,
                        borderRadius: BorderRadiusDirectional.only(
                            bottomEnd:
                                Radius.circular(widget.dayNightBorderRadius!),
                            bottomStart:
                                Radius.circular(widget.dayNightBorderRadius!))),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  /// from time box that contain arrows and picked hour text
  Widget fromTimePicker() {
    return Container(
      width: MediaQuery.of(context).size.width * .20,
      height: MediaQuery.of(context).size.height * .08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.timeBoxBorderRadius!),
        color: widget.timeBoxColor,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            start: MediaQuery.of(context).size.width * .01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      if (timePickerStartTime < 12) {
                        setState(() {
                          timePickerStartTime++;
                          fromTime = generate24HTime(
                              isAmFrom, timePickerStartTime.toString());
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .06,
                      child: Icon(
                        widget.upIcon,
                        color: widget.upIconColor,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  InkWell(
                    onTap: () {
                      if (timePickerStartTime > 1) {
                        setState(() {
                          timePickerStartTime--;
                          fromTime = generate24HTime(
                              isAmFrom, timePickerStartTime.toString());
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .06,
                      child: Icon(
                        widget.downIcon,
                        color: widget.downIconColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .01,
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              indent: 2,
              color: widget.dividerColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .01,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .10,
              alignment: Alignment.center,
              child: Text(
                  timePickerStartTime == 0
                      ? widget.timeHintText!
                      : timePickerStartTime.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: timePickerStartTime == 0
                          ? widget.timeHintColor
                          : widget.timeTextColor)),
            )
          ],
        ),
      ),
    );
  }

  /// to time box that contain arrows and picked hour text
  Widget toTimePicker() {
    return Container(
      width: MediaQuery.of(context).size.width * .20,
      height: MediaQuery.of(context).size.height * .08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.timeBoxBorderRadius!),
        color: widget.timeBoxColor,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            start: MediaQuery.of(context).size.width * .01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      if (timePickerEndTime < 12) {
                        setState(() {
                          timePickerEndTime++;
                          toTime = generate24HTime(
                              isAmTo, timePickerEndTime.toString());
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .06,
                      child: Icon(
                        widget.upIcon,
                        color: widget.upIconColor,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  InkWell(
                    onTap: () {
                      if (timePickerEndTime > 1) {
                        setState(() {
                          timePickerEndTime--;
                          toTime = generate24HTime(
                              isAmTo, timePickerEndTime.toString());
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .06,
                      child: Icon(
                        widget.downIcon,
                        color: widget.downIconColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .01,
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              indent: 2,
              color: widget.dividerColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .01,
            ),
            Container(
                width: MediaQuery.of(context).size.width * .10,
                alignment: Alignment.center,
                child: Text(
                  timePickerEndTime == 0
                      ? widget.timeHintText!
                      : timePickerEndTime.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: timePickerEndTime == 0
                          ? widget.timeHintColor
                          : widget.timeTextColor),
                ))
          ],
        ),
      ),
    );
  }

  ///convert time from 12h to 24h format
  TimeOfDay generate24HTime(bool isAm, String hour) {
    initializeDateFormatting();
    DateTime date =
        DateFormat("hh:mma", 'en').parse("$hour:00${isAm ? 'AM' : 'PM'}");

    return TimeOfDay.fromDateTime(date);
  }

  ///check platform
  bool isNotMobile() {
    return defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows;
  }
}
