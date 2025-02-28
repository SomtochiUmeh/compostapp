import 'package:flutter/material.dart';
import '../models/availability_model.dart';
import '../generated/l10n.dart';

class EditAvailabilityDialog extends StatefulWidget {
  final String componentId;
  final String componentName;
  final AvailabilityPeriod currentAvailability;
  final Function(AvailabilityPeriod) onSave;

  const EditAvailabilityDialog({
    super.key,
    required this.componentId,
    required this.componentName,
    required this.currentAvailability,
    required this.onSave,
  });

  @override
  State<EditAvailabilityDialog> createState() => _EditAvailabilityDialogState();
}

class _EditAvailabilityDialogState extends State<EditAvailabilityDialog> {
  late int startMonth;
  late int endMonth;

  @override
  void initState() {
    super.initState();
    startMonth = widget.currentAvailability.startMonth;
    endMonth = widget.currentAvailability.endMonth;
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return S.of(context).january;
      case 2:
        return S.of(context).february;
      case 3:
        return S.of(context).march;
      case 4:
        return S.of(context).april;
      case 5:
        return S.of(context).may;
      case 6:
        return S.of(context).june;
      case 7:
        return S.of(context).july;
      case 8:
        return S.of(context).august;
      case 9:
        return S.of(context).september;
      case 10:
        return S.of(context).october;
      case 11:
        return S.of(context).november;
      case 12:
        return S.of(context).december;
      default:
        return month.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).editAvailabilityFor(widget.componentName)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<int>(
            value: startMonth,
            items: List.generate(12, (index) {
              final monthIndex = index + 1; // 1-12 for Jan-Dec
              return DropdownMenuItem(
                value: monthIndex,
                child: Text(_getMonthName(monthIndex)),
              );
            }),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  startMonth = value;
                });
              }
            },
            decoration: InputDecoration(
              labelText: S.of(context).startMonth,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            value: endMonth,
            items: List.generate(12, (index) {
              final monthIndex = index + 1; // 1-12 for Jan-Dec
              return DropdownMenuItem(
                value: monthIndex,
                child: Text(_getMonthName(monthIndex)),
              );
            }),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  endMonth = value;
                });
              }
            },
            decoration: InputDecoration(
              labelText: S.of(context).endMonth,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: () {
            // Check if this matches one of the predefined periods
            bool isPredefined = false;
            for (var period in AvailabilityPeriod.values) {
              if (period.startMonth == startMonth &&
                  period.endMonth == endMonth) {
                widget.onSave(period);
                isPredefined = true;
                break;
              }
            }

            // If not a predefined period, create a custom one
            if (!isPredefined) {
              final availability = AvailabilityPeriod(startMonth, endMonth);
              widget.onSave(availability);
            }

            Navigator.pop(context);
          },
          child: Text(S.of(context).save),
        ),
      ],
    );
  }
}
