import 'package:flutter/material.dart';
import 'package:movies_trailler_apps/config/constants/color_constant.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double maxHeight = size.height;
    double maxWidth = size.width;
    return SizedBox(
      height: maxHeight,
      width: maxWidth,
      child: const Center(
        child: CircularProgressIndicator(
          color: ColorConstant.colorTitle,
        ),
      ),
    );
  }
}
