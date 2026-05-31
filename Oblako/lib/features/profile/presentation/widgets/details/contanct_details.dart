import 'package:cullinarium/core/utils/constants/app_consts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContanctDetails extends StatelessWidget {
  const ContanctDetails({
    super.key,
    required this.whatsapp,
    required this.instagram,
  });

  final String instagram;
  final String whatsapp;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Details',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'WhatsApp:',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _launchUrl('${AppConsts.whatsApp}$whatsapp'),
                child: Text(
                  '+$whatsapp',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'Instagram:',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _launchUrl('${AppConsts.instagram}$instagram'),
                child: Text(
                  instagram,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
