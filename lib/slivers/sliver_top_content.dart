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
  @override
  bool hitTestSelf({
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    // TODO: implement hitTestSelf
    return super.hitTestSelf(
      mainAxisPosition: mainAxisPosition,
      crossAxisPosition: crossAxisPosition,
    );
  }

  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
   assert(geometry!.hitTestExtent > 0.0);
    if (child != null) {
      return hitTestBoxChild(BoxHitTestResult.wrap(result), child!, mainAxisPosition: mainAxisPosition, crossAxisPosition: crossAxisPosition);
    }
    return false;
  }

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
      layoutExtent: paintOffset,
      paintExtent: max(Utils.collapsedHeight, paintOffset),
      maxPaintExtent: maxHeight,
    );

    child!.layout(constraints.asBoxConstraints(
      maxExtent: geometry!.paintExtent,
      minExtent: geometry!.paintExtent,
    ));
  }
}
