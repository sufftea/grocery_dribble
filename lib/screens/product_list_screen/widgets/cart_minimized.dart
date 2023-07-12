import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_dribble/base/cart_cubit/cart_cubit.dart';
import 'package:grocery_dribble/base/cart_cubit/cart_state.dart';
import 'package:grocery_dribble/base/utils.dart';

class CartMinimized extends StatefulWidget {
  const CartMinimized({super.key});

  @override
  State<CartMinimized> createState() => _CartMinimizedState();
}

class _CartMinimizedState extends State<CartMinimized> {
  final lastProductVisibility = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Cart',
            style: TextStyle(
              color: BaseColors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: BlocListener<CartCubit, CartState>(
              listener: (context, state) {
                lastProductVisibility.value = false;
              },
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      buildProductStack(state),
                      const SizedBox(width: 16),
                      buildCounter(state),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildCounter(CartState state) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: BaseColors.yellow,
        borderRadius: BorderRadius.circular(50 / 2),
      ),
      child: Text(
        switch (state.products.length) {
          final l && < 10 => l.toString(),
          _ => '9+',
        },
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Expanded buildProductStack(CartState state) {
    const size = 40.0;
    return Expanded(
      child: LayoutBuilder(builder: (context, cons) {
        const maxSpace = size + 8;
        final width = cons.biggest.width;
        final space = min(
          (width - size) / (state.products.length - 1),
          maxSpace,
        );

        return SizedBox(
          height: size,
          child: Stack(
            children: [
              for (int i = 0; i < state.products.length; ++i)
                Positioned(
                  left: space * i,
                  child: buildProductIcon(
                    size: size,
                    image: state.products[i].image,
                    isLast: i == state.products.length - 1,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildProductIcon({
    required double size,
    required String image,
    required bool isLast,
  }) {
    final child = Container(
      height: size,
      width: size,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: BaseColors.white,
          borderRadius: BorderRadius.circular(size / 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 5,
            ),
          ]),
      child: Image.asset(
        image,
        fit: BoxFit.contain,
      ),
    );

    if (!isLast) {
      return child;
    }

    return Hero(
      tag: HeroTags.cartProduct,
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          lastProductVisibility.value = true;
        });

        return LayoutBuilder(builder: (context, cons) {
          return Container(
            width: cons.maxWidth,
            height: cons.maxWidth,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: BaseColors.white,
              borderRadius: BorderRadius.circular(cons.maxWidth / 2),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          );
        });
      },
      child: ValueListenableBuilder(
        valueListenable: lastProductVisibility,
        builder: (context, value, child) {
          return Opacity(
            opacity: value ? 1 : 0,
            child: child!,
          );
        },
        child: child,
      ),
    );
  }
}

/*

1.
Update visibility with valueNotifier. 

2.
Create a hidden Hero on the second page.



*/