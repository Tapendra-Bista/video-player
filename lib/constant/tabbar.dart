  import 'package:flutter/material.dart';
import 'package:video/app_strings/strings.dart';

      
TabBar appTabBar(BuildContext context
) {
    return TabBar(

          indicatorWeight: 0.5,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: const BoxDecoration(color: Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          splashBorderRadius: BorderRadius.circular(0),
          labelPadding:
              const EdgeInsets.only(left: 0, top: 0, bottom: 0, right:15),
          indicatorPadding: const EdgeInsets.all(0),
          indicatorColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          dividerHeight: 0.2,
          dividerColor: Theme.of(context).textTheme.headlineMedium!.color,
          labelStyle: Theme.of(context).textTheme.headlineLarge,
          unselectedLabelStyle: Theme.of(context).textTheme.headlineMedium,
          isScrollable: true,
          tabs:  const [Text(Strings.tabOneName), Text(Strings.tabTwoName)],
        );
  }