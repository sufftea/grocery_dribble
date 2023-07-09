// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grocery_dribble/data/data.dart';
import 'package:grocery_dribble/slivers/sliver_bottom_content.dart';
import 'package:grocery_dribble/slivers/sliver_top_content.dart';
import 'package:grocery_dribble/slivers/snapping_scroll_physics.dart';
import 'package:grocery_dribble/utils/utils.dart';
import 'package:intl/intl.dart';

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
        body: CustomScrollView(
          physics: SnappingScrollPhysics(),
          slivers: [
            buildProductList(),
            SliverBottomContent(
              child: InkWell(
                onTap: () {},
                child: Placeholder(),
              ),
            ),
            // for (int i = 0; i < 4; ++i)
            //   SliverToBoxAdapter(
            //     child: Placeholder(
            //       color: Colors.pink,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  SliverTopContent buildProductList() {
    return SliverTopContent(
      child: Container(
        decoration: BoxDecoration(
          color: BaseColors.beige,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        child: ListView.builder(
          itemCount: Data.products.length,
          itemBuilder: (context, index) {
            final prod = Data.products[index];
            final f = NumberFormat.currency(symbol: '\$');

            return Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  color: BaseColors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 130,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          prod.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      f.format(prod.price),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
