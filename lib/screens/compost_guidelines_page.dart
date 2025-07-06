import 'package:flutter/material.dart';
import './guideline_detail_page.dart';
import '../generated/l10n.dart';
import '../constants/app_colors.dart';

class CompostGuidelinesPage extends StatelessWidget {
  const CompostGuidelinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: Text(
            S.of(context).compostGuidelines,
            style: const TextStyle(color: AppColors.onPrimary, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildGuidelineItem(
              context,
              S.of(context).aerobicCompostingProcess,
              Icons.recycling,
              () => _navigateToGuidelineDetail(
                  context, S.of(context).aerobicCompostingProcess),
            ),
            _buildGuidelineItem(
              context,
              S.of(context).howToMakeCompost,
              Icons.format_list_numbered,
              () => _navigateToGuidelineDetail(
                  context, S.of(context).howToMakeCompost),
            ),
            _buildGuidelineItem(
              context,
              S.of(context).cnRatioOptimumCompostConditions,
              Icons.balance,
              () => _navigateToGuidelineDetail(
                  context, S.of(context).cnRatioOptimumCompostConditions),
            ),
            _buildGuidelineItem(
              context,
              S.of(context).troubleshootingCompostProblems,
              Icons.build,
              () => _navigateToGuidelineDetail(
                  context, S.of(context).troubleshootingCompostProblems),
            ),
          ],
        ));
  }

  Widget _buildGuidelineItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    bool showDivider = false,
  }) {
    return Column(children: [
      if (showDivider)
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Divider(thickness: 2, color: AppColors.primaryLight),
        ),
      Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: ListTile(
            leading: Icon(icon, color: AppColors.secondary, size: 36),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            onTap: onTap,
          ))
    ]);
  }

  void _navigateToGuidelineDetail(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuidelineDetailPage(title: title),
      ),
    );
  }
}
