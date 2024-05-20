import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/obscure_text_bloc.dart';

class GenderSelectionWidget extends StatelessWidget {
  const GenderSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenderSelectionCubit, String>(
      builder: (context, gender) {
        return Row(
          children: [
            Radio<String>(
              fillColor: MaterialStateProperty.all(MColors.secondary),
              value: 'MALE',
              groupValue: gender,
              onChanged: (String? value) {
                context.read<GenderSelectionCubit>().selectGender(value!);
              },
            ),
            Text(
              MTexts.men,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Radio<String>(
              fillColor: MaterialStateProperty.all(MColors.secondary),
              value: 'FEMALE',
              groupValue: gender,
              onChanged: (String? value) {
                context.read<GenderSelectionCubit>().selectGender(value!);
              },
            ),
            Text(
              MTexts.women,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        );
      },
    );
  }
}
