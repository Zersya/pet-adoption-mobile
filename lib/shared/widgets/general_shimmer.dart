
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GeneralShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
            width: 120.0,
            child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[50],
                child: Container(color: Colors.black87)),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 60.0,
            width: 120.0,
            child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[50],
                child: Container(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
