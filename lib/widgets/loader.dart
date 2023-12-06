import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_work/settings/context_theme.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: context.theme.backgroundPrimaryColor,
        child: RepaintBoundary(
          child: SpinKitRing(
            color: context.theme.spinKitColor,
            size: 40,
            lineWidth: 1,
          ),
        ),
      ),
    );
  }
}
