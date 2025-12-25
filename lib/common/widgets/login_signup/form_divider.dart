import 'package:flutter/material.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/helpers/helpers_function.dart';

class ZFormDivider extends StatelessWidget {
  const ZFormDivider({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {

    final dark = ZHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Expanded(child: Divider(indent: 60,endIndent: 5,thickness: 0.5,
            color: dark?ZColors.darkGrey:ZColors.grey)),
        Text(title,style: Theme.of(context).textTheme.labelMedium,),
        Expanded(child: Divider(indent: 5,endIndent: 60,thickness: 0.5,
            color: dark?ZColors.darkGrey:ZColors.grey)),
      ],
    );
  }
}