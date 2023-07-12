import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_dribble/base/utils.dart';

class SliverBottomContent extends SingleChildRenderObjectWidget {
  const SliverBottomContent({
    super.child,
    super.key,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverBottomContent();
  }
}

class RenderSliverBottomContent extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    final maxHeight =
        constraints.viewportMainAxisExtent - Utils.collapsedHeight;
    geometry = SliverGeometry(
      paintExtent: constraints.remainingPaintExtent,
      maxPaintExtent: maxHeight,
      scrollExtent: maxHeight,
      // paintOrigin:
      //     constraints.viewportMainAxisExtent - constraints.remainingPaintExtent,
    );

    child!.layout(constraints.asBoxConstraints(
      minExtent: geometry!.paintExtent,
      maxExtent: geometry!.paintExtent,
    ));
  }
}
