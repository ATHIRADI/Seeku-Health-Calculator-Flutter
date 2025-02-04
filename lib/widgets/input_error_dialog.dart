import 'package:flutter/material.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
// Import your localization
import 'package:seeku_health_calc/generated/l10n.dart';

class InputErrorDialog extends StatelessWidget {
  final String message;

  const InputErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Use localized "Invalid Input"
      title: AdaptiveText(S.of(context).invalidInputTitle),
      content: AdaptiveText(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          // Use localized "OK"
          child: Text(S.of(context).okButtonLabel),
        ),
      ],
    );
  }
}
