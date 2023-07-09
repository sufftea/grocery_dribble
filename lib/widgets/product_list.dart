// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grocery_dribble/data/data.dart';
import 'package:grocery_dribble/data/product.dart';
import 'package:grocery_dribble/slivers/sliver_stack.dart';
import 'package:grocery_dribble/utils/utils.dart';
import 'package:intl/intl.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: BaseColors.beige,
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(Utils.collapsedHeight / 2)),
      ),
      child: Stack(
        children: [
          buildContent(),
          buildAppbar(),
          buildBottomGradient(),
        ],
      ),
    );
  }

  Widget buildContent() {
    return Positioned.fill(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverLayoutBuilder(
              builder: (context, constraints) {
                final half = constraints.crossAxisExtent / 2;

                return SliverStack(children: [
                  SliverPadding(
                    padding: EdgeInsets.only(right: half),
                    sliver: SliverList.builder(
                      itemCount: (Data.products.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        final i = index * 2;

                        return buildItem(Data.products[i]);
                      },
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(left: half),
                    sliver: SliverList.builder(
                      itemCount: (Data.products.length / 2).floor() + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const Placeholder(fallbackHeight: 100);
                        }

                        final i = (index) * 2 - 1;

                        return buildItem(Data.products[i]);
                      },
                    ),
                  ),
                ]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppbar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        // height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [BaseColors.beige, const Color.fromRGBO(255, 255, 255, 0)],
            // colors: [BaseColors.beige, const Color.fromRGBO(0, 0, 0, 0)],
            stops: [0.5, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              children: [
                Icon(Icons.chevron_left),
                Text(
                  'Pasta & Noodles',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Icon(Icons.tune_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem(Product prod) {
    final f = NumberFormat.currency(symbol: '\$');

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: BaseColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            SizedBox(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset(
                  prod.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              f.format(prod.price),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              prod.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${prod.weight}g',
              style: TextStyle(
                fontSize: 14,
                color: BaseColors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomGradient() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: Utils.collapsedHeight,
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                BaseColors.beige,
                const Color.fromRGBO(255, 255, 255, 0)
              ],
              stops: [0.0, 1.0],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }
}
