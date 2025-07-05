import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/currency_constants.dart';
import '../compost_state.dart';
import '../generated/l10n.dart';

class CurrencySelector extends StatelessWidget {
  const CurrencySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CompostState>(
      builder: (context, compostState, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).currency,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: compostState.selectedCurrency,
                    onChanged: (String? newCurrency) {
                      if (newCurrency != null) {
                        compostState.setSelectedCurrency(newCurrency);
                      }
                    },
                    items: CurrencyConstants.getSupportedCurrencies()
                        .map<DropdownMenuItem<String>>((String currency) {
                      final symbol = CurrencyConstants.getCurrencySymbol(currency);
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(
                          '$currency ($symbol)',
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}