import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

class UserSwitch extends StatelessWidget {
  const UserSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppButton(
          color: Colors.black,
          width: 130,
          margin: const EdgeInsets.only(right: 10),
          title: 'Client',
          textStyle: theme.textTheme.titleMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          onPressed: () {},
        ),
        AppButton(
          color: Colors.grey.shade400,
          width: 130,
          margin: const EdgeInsets.only(left: 10),
          title: 'Chef',
          textStyle: theme.textTheme.titleMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
