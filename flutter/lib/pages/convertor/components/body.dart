import 'package:assistant/constants/custom_color.dart';
import 'package:assistant/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Widget fieldMain() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: filedButton(),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          flex: 3,
          child: fieldAction(),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          flex: 7,
          child: filedTable(),
        ),
      ],
    );
  }

  Widget fieldAction() {
    return Row(
      children: const [
        Expanded(
          child: CardPopupButton(),
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: CardPopupButton(),
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: CardPopupButton(),
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: CardPopupButton(),
        ),
      ],
    );
  }

  Widget fieldSQL() {
    return CardContainer(
      content: CustomText(
        text: "SQL",
        size: 26,
        weight: FontWeight.bold,
        color: CustomColor.fontColor,
      ),
    );
  }

  Widget filedTable() {
    return CardContainer(
      content: CustomText(
        text: "Table",
        size: 26,
        weight: FontWeight.bold,
        color: CustomColor.fontColor,
      ),
    );
  }

  Widget filedButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: CardButton(
            buttonColor: CustomColor.warning,
            text: "버그제보",
          ),
          width: 170,
        ),
        Row(
          children: [
            const SizedBox(width: 200, child: CardTextField()),
            const SizedBox(
              width: 30,
            ),
            SizedBox(
              child: CardButton(
                buttonColor: CustomColor.primary,
                text: "붙여넣기",
              ),
              width: 170,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 7, child: fieldMain()),
        const SizedBox(
          width: 30,
        ),
        Expanded(flex: 3, child: fieldSQL()),
      ],
    );
  }
}

class CardContainer extends StatelessWidget {
  const CardContainer({Key? key, required this.content}) : super(key: key);
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: CustomColor.canvas,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: content);
  }
}

class CardTextField extends StatefulWidget {
  const CardTextField({Key? key}) : super(key: key);

  @override
  _CardTextFieldState createState() => _CardTextFieldState();
}

class _CardTextFieldState extends State<CardTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.canvas,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Package Name",
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CustomColor.fontColor,
            ),
            contentPadding: const EdgeInsets.only(left: 20, right: 20),
          ),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: CustomColor.fontColor,
          ),
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }
}

class CardButton extends StatefulWidget {
  const CardButton({Key? key, required this.buttonColor, required this.text})
      : super(key: key);
  final Color buttonColor;
  final String text;

  @override
  _CardButtonState createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()
      ..scale(1.1)
      ..translate(-5.0, -3.0);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();

    return InkWell(
      onTap: () {},
      onHover: (isHovered) {
        setState(() {
          this.isHovered = isHovered;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: transform,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: CustomText(
            text: widget.text,
            size: 26,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CardPopupButton extends StatefulWidget {
  const CardPopupButton({Key? key}) : super(key: key);

  @override
  _CardPopupButtonState createState() => _CardPopupButtonState();
}

class _CardPopupButtonState extends State<CardPopupButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..translate(0.0, 30.0);
    final transform = isHovered ? Matrix4.identity() : hoveredTransform;

    return Container();

    // return InkWell(
    //   onHover: (isHovered) {
    //     setState(() {
    //       this.isHovered = isHovered;
    //     });
    //   },
    //   onTap: () {},
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: CustomColor.canvas,
    //       borderRadius: const BorderRadius.all(
    //         Radius.circular(15),
    //       ),
    //     ),
    //     width: double.infinity,
    //     height: double.infinity,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         const Padding(
    //           padding: EdgeInsets.all(20),
    //           child: Text("Hover"),
    //         ),
    //         AnimatedContainer(
    //           decoration: BoxDecoration(
    //             color: CustomColor.canvas,
    //             borderRadius: const BorderRadius.all(
    //               Radius.circular(15),
    //             ),
    //           ),
    //           duration: const Duration(milliseconds: 150),
    //           width: 10005,
    //           height: 30,
    //           curve: Curves.easeOutQuart,
    //           color: CustomColor.primary,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
