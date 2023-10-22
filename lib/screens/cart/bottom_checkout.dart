import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users_ar/providers/user_provider.dart';
import 'package:shopsmart_users_ar/widgets/subtitle_text.dart';
import 'package:shopsmart_users_ar/widgets/title_text.dart';
import 'package:uuid/uuid.dart';

import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../services/my_app_method.dart';

class CartBottomCheckout extends StatelessWidget {
  const CartBottomCheckout({super.key, required this.function});
  final Function function;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: SizedBox(
        height: kBottomNavigationBarHeight + 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                        child: TitlesTextWidget(
                            label:
                                "Total (${cartProvider.getCartItems.length} products/${cartProvider.getQty()} Items)")),
                    SubtitleTextWidget(
                      label:
                          "${cartProvider.getTotal(productProvider: productProvider).toStringAsFixed(2)}\$",
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await function();
                },
                child: const Text("Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
