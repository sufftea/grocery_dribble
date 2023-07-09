// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grocery_dribble/slivers/sliver_bottom_content.dart';
import 'package:grocery_dribble/slivers/sliver_top_content.dart';
import 'package:grocery_dribble/slivers/snapping_scroll_physics.dart';
import 'package:grocery_dribble/utils/utils.dart';
import 'package:grocery_dribble/widgets/product_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: BaseColors.black,
        body: CustomScrollView(
          physics: SnappingScrollPhysics(),
          slivers: [
            SliverTopContent(
              child: ProductList(),
            ),
            SliverBottomContent(
              child: InkWell(
                onTap: () {},
                child: Placeholder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
