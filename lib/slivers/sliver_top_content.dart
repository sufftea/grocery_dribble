import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:grocery_dribble/utils/utils.dart';

class SliverTopContent extends SingleChildRenderObjectWidget {
  const SliverTopContent({
    super.child,
    super.key,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverTopContent();
  }
}

class RenderSliverTopContent extends RenderSliverSingleBoxAdapter {
  // @override
  // bool hitTestChildren(
  //   SliverHitTestResult result, {
  //   required double mainAxisPosition,
  //   required double crossAxisPosition,
  // }) {
  //   assert(geometry!.hitTestExtent > 0.0);
  //   if (child != null) {
  //     return child!.hitTest(
  //       BoxHitTestResult.wrap(result),
  //       position: Offset(crossAxisPosition, mainAxisPosition),
  //     );
  //   }
  //   return false;
  // }

  @override
  void performLayout() {
    final maxHeight =
        constraints.viewportMainAxisExtent - Utils.collapsedHeight;
    final paintOffset = calculatePaintOffset(
      constraints,
      from: 0,
      to: maxHeight,
    );

    geometry = SliverGeometry(
      scrollExtent: maxHeight,
      layoutExtent: max(Utils.collapsedHeight, paintOffset),
      paintExtent: maxHeight,
      maxPaintExtent: maxHeight,
      paintOrigin:- constraints.scrollOffset,
    );

    child!.layout(constraints.asBoxConstraints(
      maxExtent: geometry!.paintExtent,
      minExtent: geometry!.paintExtent,
    ));
  }
}
