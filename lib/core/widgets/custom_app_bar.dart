import 'package:dummy_clean_project/core/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    this.overrideTitle = AppConstants.appName,
    this.onBack,
  }) : super(
          leading: onBack != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: onBack,
                )
              : null,
          automaticallyImplyLeading: onBack != null,
          title: Text(overrideTitle),
        );
  final void Function()? onBack;
  final String overrideTitle;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
