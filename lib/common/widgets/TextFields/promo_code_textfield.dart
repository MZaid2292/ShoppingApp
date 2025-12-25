import 'package:flutter/material.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/sized.dart';
import '../../../utils/helpers/helpers_function.dart';
import '../custom_shapes/rounded_container.dart';

class ZPromoCodeField extends StatelessWidget {
  const ZPromoCodeField({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunctions.isDarkMode(context);
    return ZRoundedContainer(
      showBorder: true,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.only(left: ZSizes.md,right: ZSizes.sm,top: ZSizes.sm,bottom: ZSizes.sm),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Have a promo code? Enter Here",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none
              ),
            ),
          ),


          SizedBox(
              width: 80.0,
              child: ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.withValues(alpha: 0.2),
                    foregroundColor: dark ? ZColors.white.withValues(alpha: 0.5):ZColors.dark.withValues(alpha: 0.5),
                    side: BorderSide(color: Colors.grey.withValues(alpha: 0.1))),
                child: Text("Apply"),
              )),

        ],
      ),
    );
  }
}