import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/text_strings.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Function() onAccept,
  String cancelText = 'ຍົກເລີກ',
  String confirmText = 'ຕົກລົງ',
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 225,
          height: 224,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 50,
                child: Image.asset(
                  MTexts.warning,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(10),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: MColors.grey),
                textAlign: TextAlign.center,
              ),
              const Gap(10),
              Text(
                content,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: MColors.orange,
                      fontSize: 12,
                    ),
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: MColors.accent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          cancelText,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: MColors.accent),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MColors.accent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        onAccept();
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          confirmText,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
