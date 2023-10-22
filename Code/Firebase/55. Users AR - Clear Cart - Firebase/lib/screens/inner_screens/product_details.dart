import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../services/my_app_method.dart';
import '../../widgets/app_name_text.dart';
import '../../widgets/products/heart_btn.dart';
import '../../widgets/subtitle_text.dart';
import '../../widgets/title_text.dart';

class ProductDetails extends StatefulWidget {
  static const routName = '/ProductDetails';
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productProvider.findByProdId(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(fontSize: 20),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
        // automaticallyImplyLeading: false,
      ),
      body: getCurrProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Column(
                children: [
                  FancyShimmerImage(
                    imageUrl: getCurrProduct.productImage,
                    height: size.height * 0.38,
                    width: double.infinity,
                    boxFit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              // flex: 5,
                              child: Text(
                                getCurrProduct.productTitle,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            SubtitleTextWidget(
                              label: "${getCurrProduct.productPrice}\$",
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              HeartButtonWidget(
                                productId: getCurrProduct.productId,
                                color: Colors.blue.shade300,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight - 10,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          30,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (cartProvider.isProductInCart(
                                          productId:
                                              getCurrProduct.productId)) {
                                        return;
                                      }
                                      // cartProvider.addProductToCart(
                                      //     productId: getCurrProduct.productId);
                                      try {
                                        await cartProvider.addToCartFirebase(
                                            productId: getCurrProduct.productId,
                                            qty: 1,
                                            context: context);
                                      } catch (error) {
                                        MyAppMethods.showErrorORWarningDialog(
                                            context: context,
                                            subtitle: error.toString(),
                                            fct: () {});
                                      }
                                      // if (cartProvider.isProductInCart(
                                      //     productId:
                                      //         getCurrProduct.productId)) {
                                      //   return;
                                      // }
                                      // cartProvider.addProductToCart(
                                      //     productId: getCurrProduct.productId);
                                    },
                                    icon: Icon(
                                      cartProvider.isProductInCart(
                                              productId:
                                                  getCurrProduct.productId)
                                          ? Icons.check
                                          : Icons.add_shopping_cart_rounded,
                                    ),
                                    label: Text(
                                      cartProvider.isProductInCart(
                                              productId:
                                                  getCurrProduct.productId)
                                          ? "In cart"
                                          : "Add to cart",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TitlesTextWidget(label: "About this item"),
                            SubtitleTextWidget(
                                label: "In ${getCurrProduct.productCategory}")
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SubtitleTextWidget(
                          label: getCurrProduct.productDescription,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
