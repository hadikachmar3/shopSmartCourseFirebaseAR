import 'package:flutter/material.dart';

import 'subtitle_text.dart';
import 'title_text.dart';

class EmptyBagWidget extends StatelessWidget {
  const EmptyBagWidget(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.buttonText});
  final String imagePath, title, subtitle, buttonText;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: size.height * 0.35,
              width: double.infinity,
            ),
            const TitlesTextWidget(
              label: "Whoops",
              fontSize: 40,
              color: Colors.red,
            ),
            const SizedBox(
              height: 20,
            ),
            SubtitleTextWidget(
              label: title,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SubtitleTextWidget(
                label: subtitle,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20), elevation: 0),
              onPressed: () {},
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
