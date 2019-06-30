import 'package:flutter/material.dart';
import 'package:pet_adoption/shared/custom_color.dart';


class CustomDialog extends StatelessWidget {
  final child, onTap;
  const CustomDialog({
    Key key,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: this.onTap,
          child: Container(
              decoration: BoxDecoration(
                color: CustomColor.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 2,
              child: this.child),
        ),
      ),
    );
  }
}
