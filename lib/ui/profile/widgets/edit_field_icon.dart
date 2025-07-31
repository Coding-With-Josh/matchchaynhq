import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class EditFieldIconButton extends StatelessWidget {
  const EditFieldIconButton({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        "assets/icons/edit_field.svg",
        width: 16,
        height: 16,
      ),
    );
  }
}