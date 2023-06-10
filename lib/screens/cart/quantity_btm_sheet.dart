import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopsmart_users_ar/widgets/subtitle_text.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  const QuantityBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 6,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: 30,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      log("index  $index");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Center(
                        child: SubtitleTextWidget(
                          label: "${index + 1}",
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
