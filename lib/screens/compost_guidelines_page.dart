import 'package:flutter/material.dart';
import './guideline_detail_page.dart';

class CompostGuidelinesPage extends StatelessWidget {
  const CompostGuidelinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown.shade200,
          elevation: 0,
          title: const Text(
            'Compost Guidelines',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildGuidelineItem(
              context,
              'Aerobic Composting Process',
              Icons.recycling,
              () => _navigateToGuidelineDetail(
                  context, 'Aerobic Composting Process'),
            ),
            _buildGuidelineItem(
              context,
              'How to Make Compost',
              Icons.format_list_numbered,
              () => _navigateToGuidelineDetail(context, 'How to Make Compost'),
            ),
            _buildGuidelineItem(
              context,
              'C:N Ratio & Optimum Compost Conditions',
              Icons.balance,
              () => _navigateToGuidelineDetail(
                  context, 'C:N Ratio & Optimum Compost Conditions'),
            ),
            _buildGuidelineItem(
              context,
              'Troubleshooting Compost Problems',
              Icons.build,
              () => _navigateToGuidelineDetail(
                  context, 'Troubleshooting Compost Problems'),
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
          child: Divider(thickness: 2, color: Colors.brown.shade200),
        ),
      Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: ListTile(
            leading: Icon(icon, color: Colors.brown.shade300, size: 36),
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
