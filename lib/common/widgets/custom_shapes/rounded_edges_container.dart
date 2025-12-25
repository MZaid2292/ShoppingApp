import 'package:e_commerce/common/widgets/custom_shapes/clipper/custom_rounded_clipper.dart';
import 'package:flutter/material.dart';

class ZRoundedEdgesContainer extends StatelessWidget {
  const ZRoundedEdgesContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ZCustomRoundedEdges(),
      child: child,
    );
  }
}
