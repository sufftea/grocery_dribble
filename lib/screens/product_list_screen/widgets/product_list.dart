// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grocery_dribble/data/data.dart';
import 'package:grocery_dribble/data/product.dart';
import 'package:grocery_dribble/screens/product_screen/product_screen.dart';
import 'package:grocery_dribble/slivers/sliver_stack.dart';
import 'package:grocery_dribble/base/utils.dart';
import 'package:intl/intl.dart';

var _lastOffset = 0.0;

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final controller = ScrollController(initialScrollOffset: _lastOffset);

  final productHeroNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      _lastOffset = controller.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: BaseColors.beige,
        borderRadius: BorderRadius.circular(Utils.collapsedHeight / 2 - 2),
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
      child: CustomScrollView(
        controller: controller,
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 70,
            ),
          ),
          SliverLayoutBuilder(
            builder: (context, constraints) {
              final half = constraints.crossAxisExtent / 2;

              return SliverStack(children: [
                SliverPadding(
                  padding: EdgeInsets.only(right: half, left: 5),
                  sliver: SliverList.builder(
                    itemCount: (Data.products.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      final i = index * 2;

                      return buildProduct(context, Data.products[i]);
                    },
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(left: half, right: 5),
                  sliver: SliverList.builder(
                    itemCount: (Data.products.length / 2).floor() + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return buildSearchResults();
                      }

                      final i = (index) * 2 - 1;

                      return buildProduct(context, Data.products[i]);
                    },
                  ),
                ),
              ]);
            },
          ),
        ],
      ),
    );
  }

  Widget buildSearchResults() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '56 Results',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
            stops: [0.5, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.chevron_left, size: 35),
              const SizedBox(width: 32),
              Text(
                'Pasta & Noodles',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.tune_rounded,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProduct(BuildContext context, Product prod) {
    final f = NumberFormat.currency(symbol: '\$');

    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () async {
          productHeroNotifier.value = true;
          final addedToCart = await Navigator.of(context).push(
            // TODO: I can use PageRouteBuilder to:
            //   1. Slow down the hero transitions (they're too fast currently)
            //   2. Implement the transition from [ProductList] to 
            //      [ProductScreen], that I couldn't get with heroes.
            MaterialPageRoute(
              builder: (context) {
                return ProductScreen(product: prod);
              },
            ),
          ) ?? false;

          if (addedToCart) {
            productHeroNotifier.value = false;
          }
        },
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
                  child: ValueListenableBuilder(
                    valueListenable: productHeroNotifier,
                    builder: (context, active, child) {
                      if (!active) {
                        return child!;
                      }

                      return Hero(
                        tag: prod,
                        child: child!,
                      );
                    },
                    child: Image.asset(
                      prod.image,
                      fit: BoxFit.contain,
                    ),
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
