import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'colors.dart';
import 'package:intl/date_symbol_data_local.dart';

class FromToTimePicker extends StatefulWidget {
  final Function(TimeOfDay, TimeOfDay)? onTab;
  final Function? onCancelTab;
  final String? headerText;
  final String? fromHeadline;
  final String? toHeadline;
  final String? doneText;
  final String? dismissText;
  final String? dayText;
  final String? nightText;
  final Color? fromHeadlineColor;
  final Color? toHeadlineColor;
  final Color? activePeriodColor;
  final Color? defaultPeriodColor;
  final Color? activePeriodBorderColor;
  final Color? defaultPeriodBorderColor;
  final Color? activePeriodTextColor;
  final Color? defaultPeriodTextColor;
  final int? periodBorderRadius;
  final int? timeBoxBorderRadius;
  final Color? timeBoxColor;
  final Color? dialogBackgroundColor;
  final Icon? upIcon;
  final Icon? downIcon;
  final Color? upIconColor;
  final Color? downIconColor;
  final Color? dividerColor;
  final Color? timeHintColor;
  final Color? timeTextColor;

  const FromToTimePicker(
      {Key? key,
      required this.onTab,
      this.onCancelTab,
      this.headerText,
      this.fromHeadline = 'from',
      this.toHeadline = 'to',
      this.fromHeadlineColor,
      this.toHeadlineColor,
      this.activePeriodColor,
      this.defaultPeriodColor,
      this.activePeriodTextColor,
      this.defaultPeriodTextColor,
      this.activePeriodBorderColor,
      this.defaultPeriodBorderColor,
      this.periodBorderRadius,
      this.timeBoxBorderRadius,
      this.timeBoxColor,
      this.upIcon,
      this.downIcon,
      this.upIconColor,
      this.downIconColor,
      this.dividerColor,
      this.timeHintColor,
      this.timeTextColor,
      this.doneText = 'ok',
      this.dismissText = 'cancel',
      this.dayText = 'AM',
      this.nightText = 'PM',
      this.dialogBackgroundColor = MColors.white})
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
                color: MColors.white, borderRadius: BorderRadius.circular(12)),
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
                      Container(
                        width: MediaQuery.of(context).size.width * .03,
                        height: MediaQuery.of(context).size.width * .03,
                        decoration: BoxDecoration(
                            color: MColors.green_1,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * .04)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .02,
                      ),
                      Text(
                        '${widget.headerText}',
                        style: TextStyle(fontSize: 10, color: MColors.gray_9a),
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
                                  fontWeight: FontWeight.bold, fontSize: 20),
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
                      onTap: () => widget.onCancelTab,
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
                                isAmTo, timePickerEndTime.toString()));
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
          style: TextStyle(color: MColors.black, fontWeight: FontWeight.w600),
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
                            color: isAmFrom ? MColors.white : MColors.black,
                            fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isAmFrom == true
                            ? MColors.primary_color
                            : MColors.mainColor70,
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(5),
                            topEnd: Radius.circular(5))),
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
                            color: isAmFrom ? MColors.black : MColors.white,
                            fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isAmFrom == true
                            ? MColors.mainColor70
                            : MColors.primary_color,
                        borderRadius: BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(5),
                            bottomStart: Radius.circular(5))),
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
          style: TextStyle(color: MColors.black, fontWeight: FontWeight.w600),
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
                            color: isAmTo ? MColors.white : MColors.black,
                            fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isAmTo == true
                            ? MColors.primary_color
                            : MColors.mainColor70,
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(5),
                            topEnd: Radius.circular(5))),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isAmTo = false;
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
                        widget.nightText!,
                        style: TextStyle(
                            color: isAmTo ? MColors.black : MColors.white,
                            fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isAmTo == true
                            ? MColors.mainColor70
                            : MColors.primary_color,
                        borderRadius: BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(5),
                            bottomStart: Radius.circular(5))),
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
        borderRadius: BorderRadius.circular(8),
        color: MColors.mainColor70,
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
                      print('tapped');
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
                      child: Icon(Icons.keyboard_arrow_up_rounded),
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
                      child: Icon(Icons.keyboard_arrow_down_rounded),
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
              color: MColors.gray_99.withOpacity(.2),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .01,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .10,
              alignment: Alignment.center,
              child: Text(
                  timePickerStartTime == 0
                      ? '00'
                      : timePickerStartTime.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: timePickerStartTime == 0
                          ? MColors.gray_99.withOpacity(.5)
                          : MColors.gray_66)),
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
        borderRadius: BorderRadius.circular(8),
        color: MColors.mainColor70,
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
                      child: Icon(Icons.keyboard_arrow_up_rounded),
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
                      child: Icon(Icons.keyboard_arrow_down_rounded),
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
              color: MColors.gray_99.withOpacity(.2),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .01,
            ),
            Container(
                width: MediaQuery.of(context).size.width * .10,
                alignment: Alignment.center,
                child: Text(
                  timePickerEndTime == 0 ? '00' : timePickerEndTime.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: timePickerEndTime == 0
                          ? MColors.gray_99.withOpacity(.5)
                          : MColors.gray_66),
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
