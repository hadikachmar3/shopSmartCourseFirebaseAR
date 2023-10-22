import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users_ar/services/assets_manager.dart';
import 'package:shopsmart_users_ar/widgets/empty_bag.dart';
import 'package:shopsmart_users_ar/widgets/title_text.dart';

import '../../providers/wishlist_provider.dart';
import '../../services/my_app_method.dart';
import '../../widgets/products/product_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routName = '/WishlistScreen';
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return wishlistProvider.getWishlistItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.bagWish,
              title: "Your wishlist is empty",
              subtitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitlesTextWidget(
                  label:
                      "Wishlist (${wishlistProvider.getWishlistItems.length})"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorORWarningDialog(
                        isError: false,
                        context: context,
                        subtitle: "Remove items",
                        fct: () async {
                          await wishlistProvider.clearWishlistFromFirebase();
                          wishlistProvider.clearLocalWishlist();
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: wishlistProvider.getWishlistItems.length,
              builder: ((context, index) {
                return ProductWidget(
                  productId: wishlistProvider.getWishlistItems.values
                      .toList()[index]
                      .productId,
                );
              }),
              crossAxisCount: 2,
            ),
          );
  }
}
