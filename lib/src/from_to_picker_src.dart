import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'colors.dart';
import 'package:intl/date_symbol_data_local.dart';

class FromToTimePicker extends StatefulWidget {
  final Function(TimeOfDay, TimeOfDay)? onTab;
  final Function? onCancelTab;
  final String? headerText;
  final Color? headerTextColor;
  final String? fromHeadline;
  final String? toHeadline;
  final String? doneText;
  final String? dismissText;
  final String? dayText;
  final String? nightText;
  final String? timeHintText;
  final Color? fromHeadlineColor;
  final Color? toHeadlineColor;
  final Color? activeDayNightColor;
  final Color? defaultDayNightColor;
  final Color? activeDayNightTextColor;
  final Color? defaultDayNightTextColor;
  final double? dayNightBorderRadius;
  final double? timeBoxBorderRadius;
  final Color? timeBoxColor;
  final Color? dialogBackgroundColor;
  final IconData? upIcon;
  final IconData? downIcon;
  final Color? upIconColor;
  final Color? downIconColor;
  final Color? dividerColor;
  final Color? timeHintColor;
  final Color? timeTextColor;
  final bool? showHeaderBullet;
  final Color? headerBulletColor;
  final Color? colonColor;

  const FromToTimePicker(
      {Key? key,
      required this.onTab,
      this.onCancelTab,
      this.headerText,
      this.fromHeadline = 'from',
      this.toHeadline = 'to',
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
      this.colonColor = MColors.black, this.timeHintText = '00'})
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
                ? MediaQuery.of(context).size.height * .30
                : MediaQuery.of(context).size.height * .28,
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
                            fontSize: 10, color: widget.headerTextColor),
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
                    // crossAxisAlignment: CrossAxisAlignment.start,
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
                            height: MediaQuery.of(context).size.height * .16,
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
              bottom: 20,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () {
                        widget.onCancelTab;
                        Navigator.pop(context);
                      },
                      child: Text(widget.dismissText!)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .06,
                  ),
                  InkWell(
                      onTap: () {
                        widget.onTab!(
                            generate24HTime(
                                isAmFrom, timePickerStartTime.toString()),
                            generate24HTime(
                                isAmTo, timePickerEndTime.toString())
                        );
                        Navigator.pop(context);
                      },
                      child: Text(widget.doneText!)),
                ],
              ))
        ],
      ),
    );
  }

  Widget fromTimeItem(String headline) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          headline,
          style: TextStyle(color: widget.fromHeadlineColor, fontWeight: FontWeight.w600),
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
                      if (timePickerStartTime != null)
                        fromTime = generate24HTime(
                            isAmFrom, timePickerStartTime.toString());
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .07,
                    height: MediaQuery.of(context).size.width * .07,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        widget.dayText!,
                        style: TextStyle(
                            color: isAmFrom ? widget.activeDayNightTextColor : widget.defaultDayNightTextColor,
                            fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isAmFrom == true
                            ? widget.activeDayNightColor
                            : widget.defaultDayNightColor,
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(widget.dayNightBorderRadius!),
                            topEnd: Radius.circular(widget.dayNightBorderRadius!))),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isAmFrom = false;
                      if (timePickerStartTime != null)
                        fromTime = generate24HTime(
                            isAmFrom, timePickerStartTime.toString());
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .07,
                    height: MediaQuery.of(context).size.width * .07,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        widget.nightText!,
                        style: TextStyle(
                            color: isAmFrom ? widget.defaultDayNightTextColor : widget.activeDayNightTextColor,
                            fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isAmFrom == true
                            ? widget.defaultDayNightColor
                            : widget.activeDayNightColor,
                        borderRadius: BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(widget.dayNightBorderRadius!),
                            bottomStart: Radius.circular(widget.dayNightBorderRadius!))),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget toTimeItem(String headline) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          headline,
          style: TextStyle(color:widget.toHeadlineColor, fontWeight: FontWeight.w600),
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
                      if (timePickerEndTime != null)
                        toTime = generate24HTime(
                            isAmTo, timePickerEndTime.toString());
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .07,
                    height: MediaQuery.of(context).size.width * .07,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        widget.dayText!,
                        style: TextStyle(
                            color: isAmTo ? widget.activeDayNightTextColor :widget.defaultDayNightTextColor,
                            fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isAmTo == true
                            ? widget.activeDayNightColor
                            : widget.defaultDayNightColor,
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(widget.dayNightBorderRadius!),
                            topEnd: Radius.circular(widget.dayNightBorderRadius!))),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isAmTo = false;
                      toTime = generate24HTime(
                          isAmTo, timePickerEndTime.toString());
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .07,
                    height: MediaQuery.of(context).size.width * .07,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        widget.nightText!,
                        style: TextStyle(
                            color: isAmTo ? widget.defaultDayNightTextColor : widget.activeDayNightTextColor,
                            fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isAmTo == true
                            ? widget.defaultDayNightColor
                            : widget.activeDayNightColor,
                        borderRadius: BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(widget.dayNightBorderRadius!),
                            bottomStart: Radius.circular(widget.dayNightBorderRadius!))),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

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
                      child: Icon(widget.upIcon, color: widget.upIconColor,),
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
                      child: Icon(widget.downIcon, color: widget.downIconColor,),
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
                      child: Icon(widget.upIcon,color: widget.upIconColor,),
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
                      child: Icon(widget.downIcon, color: widget.downIconColor,),
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
                  timePickerEndTime == 0 ? widget.timeHintText! : timePickerEndTime.toString(),
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

  TimeOfDay generate24HTime(bool isAm, String hour) {
    initializeDateFormatting();
    DateTime date =
        DateFormat("hh:mma", 'en').parse("$hour:00${isAm ? 'AM' : 'PM'}");
    return TimeOfDay.fromDateTime(date);
  }
}
