import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class AppUserInfo extends StatelessWidget {
  const AppUserInfo({
    super.key,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap,
  });

  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
