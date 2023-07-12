// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_dribble/base/cart_cubit/cart_cubit.dart';
import 'package:grocery_dribble/base/cart_cubit/cart_state.dart';
import 'package:grocery_dribble/base/utils.dart';
import 'package:grocery_dribble/data/product.dart';
import 'package:intl/intl.dart';

class CartMaximized extends StatefulWidget {
  const CartMaximized({super.key});

  @override
  State<CartMaximized> createState() => _CartMaximizedState();
}

class _CartMaximizedState extends State<CartMaximized> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 64),
          Text(
            'Cart',
            style: TextStyle(
              fontSize: 32,
              color: BaseColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          buildList(),
          const SizedBox(height: 48),
          buildTotal(),
          const SizedBox(height: 64),
          FilledButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(BaseColors.yellow),
              foregroundColor: MaterialStatePropertyAll(BaseColors.black),
              textStyle: MaterialStatePropertyAll(TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
              padding: MaterialStatePropertyAll(const EdgeInsets.all(15)),
            ),
            child: Text('Next'),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Row buildTotal() {
    return Row(
      children: [
        Text(
          'Total',
          style: TextStyle(
            color: BaseColors.grey,
            fontSize: 32,
          ),
        ),
        const Spacer(),
        Text(
          '\$59.97',
          style: TextStyle(
              color: BaseColors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Expanded buildList() {
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      for (final product in state.products) ...[
                        buildProductEntry(product),
                        const SizedBox(height: 32),
                      ],
                      buildDeliveryCost(),
                      const SizedBox(height: 32),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            height: 16,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      BaseColors.black,
                      Colors.black.withOpacity(0),
                    ],
                    // stops: [0.0, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            height: 50,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      BaseColors.black,
                      Colors.black.withOpacity(0),
                    ],
                    // stops: [0.0, 1.0],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDeliveryCost() {
    const size = 40.0;
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: BaseColors.dark,
                borderRadius: BorderRadius.circular(size / 2),
              ),
              child: Icon(
                Icons.local_shipping_outlined,
                size: 22,
                color: BaseColors.yellow,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Delivery',
                style: TextStyle(
                  color: BaseColors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              '\$30.00',
              style: TextStyle(
                color: BaseColors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const SizedBox(
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'All orders of \$40 or more qualify for free delivery.',
                    style: TextStyle(
                      color: BaseColors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: BaseColors.dark,
                      borderRadius: BorderRadius.circular(1),
                    ),
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      heightFactor: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: BaseColors.yellow,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 80,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildProductEntry(Product product) {
    const imageSize = 40.0;
    final f = NumberFormat.currency(symbol: '\$');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            color: BaseColors.white,
            borderRadius: BorderRadius.circular(imageSize / 2),
          ),
          child: Image.asset(
            product.image,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '1',
          style: TextStyle(
            color: BaseColors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.close, size: 16, color: BaseColors.white),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            product.name,
            style: TextStyle(
              color: BaseColors.white,
              fontSize: 16,
            ),
          ),
        ),
        Text(
          f.format(product.price),
          style: TextStyle(
            color: BaseColors.grey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
