import 'package:flutter/material.dart';
import 'package:grocery_dribble/data/product.dart';
import 'package:grocery_dribble/screens/product_list_screen/widgets/product_list.dart';
import 'package:grocery_dribble/utils/utils.dart';
import 'package:intl/intl.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: HeroTags.listView,
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        final decoration = DecorationTween(
          begin: BoxDecoration(
            color: BaseColors.beige,
            borderRadius: BorderRadius.circular(Utils.collapsedHeight / 2 - 2),
          ),
          end: const BoxDecoration(
            color: BaseColors.white,
            borderRadius: BorderRadius.zero,
          ),
        );

        return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final t = animation.value;

              final child = switch (t) {
                <= 0.5 => Opacity(
                    opacity: 1 - t * 2,
                    child: const Material(
                      type: MaterialType.transparency,
                      child: ProductList(),
                    ),
                  ),
                _ => Opacity(
                    opacity: t * 2 - 1,
                    child: Material(
                      type: MaterialType.transparency,
                      child: ProductScreen(product: product),
                    ),
                  ),
              };

              return Container(
                decoration: decoration.evaluate(animation),
                clipBehavior: Clip.antiAlias,
                child: child,
              );
            });
      },
      child: Scaffold(
        backgroundColor: BaseColors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    buildContent(),
                    buildAppbar(context),
                    buildBottomGradient(),
                  ],
                ),
              ),
              buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    final priceFormat = NumberFormat.currency(symbol: '\$');

    return Positioned.fill(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                height: 300,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: Image.asset(
                  product.image,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${product.weight}g',
                style: TextStyle(
                  fontSize: 14,
                  color: BaseColors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildCounterButton(),
                  const Spacer(),
                  Text(
                    priceFormat.format(product.price),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'About the product',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCounterButton() {
    const height = 45.0;
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove),
          ),
          const Text(
            '1',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget buildAppbar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        // height: 100,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [BaseColors.beige, Color.fromRGBO(255, 255, 255, 0)],
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
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.chevron_left, size: 35),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomGradient() {
    return const Positioned(
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

  Widget buildFooter() {
    const height = 50.0;

    return Container(
      color: BaseColors.beige,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: Row(
        children: [
          Material(
            type: MaterialType.transparency,
            child: Container(
              height: height,
              width: height,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black26,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(height / 2),
              ),
              child: IconButton.outlined(
                onPressed: () {
                  debugPrint('click');
                },
                splashRadius: height / 2,
                icon: const Icon(Icons.favorite_border_rounded),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: SizedBox(
              height: height,
              child: FilledButton(
                onPressed: () {},
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(BaseColors.yellow),
                  foregroundColor: MaterialStatePropertyAll(BaseColors.black),
                ),
                child: const Text(
                  'Add to cart',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
