import 'package:cullinarium/features/chef/presentation/pages/chefs_details_page.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:flutter/material.dart';

class ChefHomeCard extends StatelessWidget {
  const ChefHomeCard({super.key, required this.chef});

  final ChefModel chef;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChefsDetailsPage(chef: chef),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(chef.avatar ?? ''),
            ),
            const SizedBox(height: 8),
            Text(
              chef.name,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              chef.chefDetails?.kitchen ?? '',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
