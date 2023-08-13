import 'package:dummy_clean_project/core/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({super.key, this.overrideTitle = AppConstants.appName})
      : super(
          title: Text(overrideTitle),
        );
  final String overrideTitle;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
