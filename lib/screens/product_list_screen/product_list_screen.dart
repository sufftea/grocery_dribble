import 'package:flutter/material.dart';
import 'package:grocery_dribble/screens/product_list_screen/widgets/product_list.dart';
import 'package:grocery_dribble/slivers/sliver_bottom_content.dart';
import 'package:grocery_dribble/slivers/sliver_top_content.dart';
import 'package:grocery_dribble/slivers/snapping_scroll_physics.dart';
import 'package:grocery_dribble/utils/utils.dart';

final listKey = GlobalKey();

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
                child: Hero(
                  tag: HeroTags.listView,
                  child: ProductList(),
                ),
              ),
              SliverBottomContent(
                child: InkWell(
                  onTap: () {},
                  child: const Placeholder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
