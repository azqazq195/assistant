import 'package:assistant/constants/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:assistant/constants/controllers.dart';
import 'package:assistant/constants/style.dart';
import 'package:assistant/helpers/responsiveness.dart';
import 'package:assistant/routing/routes.dart';
import 'package:assistant/widgets/custom_text.dart';
import 'package:assistant/widgets/side_menu_item.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.canvas,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Assistant",
                        style: TextStyle(
                          color: CustomColor.fontColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                          "v2.0.1",
                          style: TextStyle(
                            color: CustomColor.fontColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: sideMenuItems
                    .map(
                      (itemName) => SideMenuItem(
                        itemName: itemName,
                        onTap: () {
                          if (!menuController.isActive(itemName)) {
                            menuController.changeActiveItemTo(itemName);
                            if (ResponsiveWidget.isSmallScreen(context)) {
                              Get.back();
                            }
                            navigationController.navigateTo(itemName);
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   double _width = MediaQuery.of(context).size.width;
//   return Container(
//     color: CustomColor.canvas,
//     child: ListView(
//       children: [
//         if (ResponsiveWidget.isSmallScreen(context))
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(
//                 height: 40,
//               ),
//               Row(
//                 children: [
//                   SizedBox(width: _width / 48),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 12),
//                     child: Image.asset(
//                       "assets/icons/flutter.png",
//                       width: 28,
//                     ),
//                   ),
//                   const Flexible(
//                     child: CustomText(
//                       text: "Assistant",
//                       size: 20,
//                       weight: FontWeight.bold,
//                       color: active,
//                     ),
//                   ),
//                   SizedBox(width: _width / 48),
//                 ],
//               ),
//             ],
//           ),
//         const SizedBox(
//           height: 40,
//         ),
//         Divider(
//           color: lightGrey.withOpacity(.1),
//         ),
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           children: sideMenuItems
//               .map(
//                 (itemName) => SideMenuItem(
//                   itemName: itemName,
//                   onTap: () {
//                     if (!menuController.isActive(itemName)) {
//                       menuController.changeActiveItemTo(itemName);
//                       if (ResponsiveWidget.isSmallScreen(context)) Get.back();
//                       navigationController.navigateTo(itemName);
//                     }
//                   },
//                 ),
//               )
//               .toList(),
//         ),
//       ],
//     ),
//   );
// }
}
