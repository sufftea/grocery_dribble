import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Supports both Slivers and Boxes
/// If it's a box, it will be provided the constraints from the biggest sliver
/// child.
class SliverStack extends MultiChildRenderObjectWidget {
  const SliverStack({
    super.children,
    super.key,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SliverStackRenderObject();
  }
}

// SliverLogicalContainerParentData
class SliverStackRenderObject extends RenderSliver
    with
        ContainerRenderObjectMixin<RenderObject,
            SliverStackParentData<RenderObject>> {
  // SliverStackRenderObject();

  @override
  void setupParentData(covariant RenderObject child) {
    // switch (child) {
    //   case RenderBox child:
    //   // child.parent = SliverStackParentData<RenderBox>();
    //   case RenderSliver child:
    //   // child.parent =
    //   default:
    //     throw TypeError();
    // }

    if (child.parentData is! SliverStackParentData<RenderObject>) {
      child.parentData = SliverStackParentData<RenderObject>();
    }
  }

  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    var currChild = lastChild;
    bool hitFlag = false;

    while (currChild != null && !hitFlag) {
      switch (currChild) {
        case RenderBox child:
          final result = BoxHitTestResult();
          hitFlag |= child.hitTest(result, position: Offset.zero);
        case RenderSliver child:
          hitFlag |= child.hitTest(
            result,
            mainAxisPosition: mainAxisPosition,
            crossAxisPosition: crossAxisPosition,
          );
        default:
          throw TypeError();
      }

      currChild = childBefore(currChild);
    }

    return hitFlag;
  }

  @override
  void performLayout() {
    var currChild = firstChild;

    double cacheExtent = 0;
    double layoutExtent = 0;
    double maxPaintExtent = 0;
    double hitTestExtent = 0;
    double panitExtent = 0;
    double scrollExtent = 0;

    final boxChildren = <RenderBox>[];

    while (currChild != null) {
      if (currChild is RenderBox) {
        boxChildren.add(currChild);
        currChild = childAfter(currChild);
        continue;
      }

      if (currChild is! RenderSliver) {
        throw TypeError();
      }

      currChild.layout(constraints, parentUsesSize: true);

      final currGeometry = currChild.geometry!;

      cacheExtent = max(
        currGeometry.cacheExtent,
        cacheExtent,
      );

      layoutExtent = max(
        currGeometry.layoutExtent,
        layoutExtent,
      );

      maxPaintExtent = max(
        currGeometry.maxPaintExtent,
        layoutExtent,
      );

      hitTestExtent = max(
        currGeometry.hitTestExtent,
        hitTestExtent,
      );

      panitExtent = max(
        currGeometry.paintExtent,
        panitExtent,
      );

      scrollExtent = max(
        currGeometry.scrollExtent,
        scrollExtent,
      );

      currChild = childAfter(currChild);
    }

    for (final box in boxChildren) {
      box.layout(constraints.asBoxConstraints(
        minExtent: panitExtent,
      ));
    }

    geometry = SliverGeometry(
      layoutExtent: layoutExtent,
      maxPaintExtent: maxPaintExtent,
      cacheExtent: cacheExtent,
      hitTestExtent: hitTestExtent,
      paintExtent: panitExtent,
      scrollExtent: scrollExtent,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var currChild = firstChild;

    while (currChild != null) {
      context.paintChild(currChild, offset);
      currChild = childAfter(currChild);
    }
  }
}

class SliverStackParentData<T extends RenderObject> extends ParentData
    with ContainerParentDataMixin<T> {
  SliverStackParentData({
    this.expand = false,
  });

  final bool expand;
}
