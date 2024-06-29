import 'package:flutter/material.dart';
import 'package:healthcy/manager/image_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeContainer extends StatelessWidget {
  final bool? isStepsCount;
  final String data;
  final String goalData;
  final String goalDataAcheived;
  const HomeContainer(
      {super.key,
      this.isStepsCount,
      required this.data,
      required this.goalData,
      required this.goalDataAcheived});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(2.h),
      margin: EdgeInsets.only(top:5.h),
      decoration: BoxDecoration(
          color: theme.cardColor, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                    text: isStepsCount ?? false
                        ? "Steps:  "
                        : "Calories Burned:  ",
                    style: theme.textTheme.labelSmall,
                    children: [
                      TextSpan(text: data, style: theme.textTheme.titleSmall)
                    ])),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: SizedBox(
                  width: 60.w,
                  child: LinearProgressIndicator(
                    color: theme.iconTheme.color,
                    backgroundColor: theme.indicatorColor,
                    borderRadius: BorderRadius.circular(20),
                    minHeight: 2.5.h,
                    value: 0.5,
                  ),
                ),
              ),
              Image.asset(
                isStepsCount ?? false ? stepsLight : calLight,
                color: theme.iconTheme.color,
                width: 15.w,
                height: 15.w,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.5.w, right: 23.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  goalDataAcheived,
                  style: theme.textTheme.displaySmall,
                ),
                Text(
                  "Goal: $goalData",
                  style: theme.textTheme.displaySmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
