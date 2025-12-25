import 'package:flutter/material.dart';

import '../../../../../utils/constant/sized.dart';
import '../../../../../utils/constant/texts.dart';

class ZLoginHeader extends StatelessWidget {
  const ZLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        ///Title
        Text(ZTexts.loginTitle,style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: ZSizes.sm),
        ///SubTitle
        Text(ZTexts.loginSubTitle,style: Theme.of(context).textTheme.bodySmall),


      ],
    );
  }
}