import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grocery_dribble/screens/product_list_screen/widgets/cart_maximized.dart';
import 'package:grocery_dribble/screens/product_list_screen/widgets/cart_minimized.dart';
import 'package:grocery_dribble/screens/product_list_screen/widgets/product_list.dart';
import 'package:grocery_dribble/slivers/sliver_bottom_content.dart';
import 'package:grocery_dribble/slivers/sliver_top_content.dart';
import 'package:grocery_dribble/slivers/snapping_scroll_physics.dart';
import 'package:grocery_dribble/base/utils.dart';

final listKey = GlobalKey();
final bottomSliverKey = GlobalKey();

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.black,
      body: SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(
              Utils.collapsedHeight / 2 - 2,
            ),
          ),
          child: CustomScrollView(
            physics: const SnappingScrollPhysics(),
            slivers: [
              const SliverTopContent(
                child: ProductList(),
              ),
              SliverBottomContent(
                key: bottomSliverKey,
                child: buildCart(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCart() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final currHeight = constraints.maxHeight;

        final sliver =
            bottomSliverKey.currentContext!.findRenderObject() as RenderSliver;
        final maxHeight = sliver.geometry?.maxPaintExtent ?? 1.0;

        final progress = (currHeight - Utils.collapsedHeight) /
            (maxHeight - Utils.collapsedHeight);
        debugPrint('progress: $progress');

        return Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: clampDouble(1 - progress * 2, 0, 1),
                child: const CartMinimized(),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              height: maxHeight,
              child: Opacity(
                opacity: progress,
                child: const CartMaximized(),
              ),
            ),
          ],
        );
      },
    );
  }
}

/*

- pass the max sliver height
- 

*/
