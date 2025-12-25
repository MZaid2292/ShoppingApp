import 'package:flutter/material.dart';

import '../../../utils/constant/sized.dart';


class ZGridLayout extends StatelessWidget {
  const ZGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 288,
    required this.itemBuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget Function(BuildContext context, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      //GridView scroll nh hogi
      shrinkWrap: true,
      itemCount: itemCount,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: ZSizes.gridViewSpacing,
        crossAxisSpacing: ZSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder
    );
  }
}
