import 'package:ams/views/user/login/widgets/login_form.dart';
import 'package:ams/views/user/login/widgets/login_header.dart';
import 'package:flutter/material.dart';
import '../../../common/styles/spacing_style.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: AppSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            /// Logo, Title and SubTitle
            AppLoginHeader(),

            /// Form
            AppLoginForm(),
          ],
        ),
      )),
    );
  }
}
