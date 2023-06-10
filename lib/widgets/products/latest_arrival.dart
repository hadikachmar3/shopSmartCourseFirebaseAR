import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users_ar/widgets/subtitle_text.dart';

import '../../consts/app_constants.dart';
import '../../screens/inner_screens/product_details.dart';
import 'heart_btn.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, ProductDetails.routName);
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: AppConstants.productImageUrl,
                    width: size.width * 0.28,
                    height: size.width * 0.28,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title " * 10,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          const HeartButtonWidget(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const FittedBox(
                      child: SubtitleTextWidget(
                        label: "166.5\$",
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
