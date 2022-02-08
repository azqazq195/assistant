import 'package:assistant/constants/controllers.dart';
import 'package:assistant/constants/custom_color.dart';
import 'package:assistant/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final GestureTapCallback onTap;

  const SideMenuItem({Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  Widget menuItem() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        onHover: (value) {
          value
              ? menuController.onHover(itemName)
              : menuController.onHover("not hovering");
        },
        child: Obx(
          () => Container(
            decoration: menuController.isHovering(itemName) ?
            BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              color: lightGrey.withOpacity(.2),
            ) :
            const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                if (menuController.isActive(itemName))
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      alignment: Alignment.centerLeft,
                      decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: CustomColor.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: CustomText(
                          text: itemName,
                          color: Colors.white,
                          size: 26,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                else
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: CustomText(
                          text: itemName,
                          color: CustomColor.fontColor,
                          size: 26,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return menuItem();
    // if (ResponsiveWidget.isCustomScreen(context)) {
    //   return VerticalMenuItem(itemName: itemName, onTap: onTap);
    // }
    //
    // return HorizontalMenuItem(itemName: itemName, onTap: onTap);
  }
}
