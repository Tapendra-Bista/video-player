import 'package:flutter/material.dart';
import 'package:video/app_strings/strings.dart';

Center noResult(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          Strings.noResultImg,
          height: 60,
          width: 60,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          Strings.noVideoString,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 12,
              ),
        ),
      ],
    ),
  );
}
