import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/auth_card.dart';

import 'methods/method.dart';

class AuthScreen extends StatelessWidget {
  static const String authRouteName = '/screens.auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundContainer(),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildFlexibleContainer(context),
                  Flexible(child: AuthCard(), flex: deviceSize.width > 600 ? 2: 1,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}


