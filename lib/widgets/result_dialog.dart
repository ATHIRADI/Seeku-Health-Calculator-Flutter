import 'package:flutter/material.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/custom_elevated_button.dart';
// Import localization
import 'package:seeku_health_calc/generated/l10n.dart';

class ResultDialog extends StatelessWidget {
  final String title;
  final List<Widget> resultCards;
  final VoidCallback? onClose;

  const ResultDialog({
    super.key,
    required this.title,
    required this.resultCards,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Spacing.mediumVertical,
              ...resultCards,
              Spacing.smallVertical,
              Align(
                alignment: Alignment.centerRight,
                child: CustomElevatedButton(
                  // Use localized "Close"
                  text: S.of(context).closeButtonLabel,
                  onPressed: () => onClose != null
                      ? onClose!()
                      : Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
