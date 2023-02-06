import 'package:flutter/material.dart';

import '../../util/custom_themes.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'TechnoArt Software',
            style: josefinSans.copyWith(fontSize: 8, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
