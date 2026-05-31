import 'dart:math';

import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:cullinarium/features/chef/presentation/pages/chefs_details_page.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:flutter/material.dart';

class ChefCard extends StatefulWidget {
  const ChefCard({super.key, required this.chef, this.onTap});

  final ChefModel chef;
  final VoidCallback? onTap;

  @override
  State<ChefCard> createState() => _ChefCardState();
}

class _ChefCardState extends State<ChefCard> {
  String getRandomRating() {
    final random = Random();
    double rating = 3.0 + random.nextDouble() * 2.0;
    return rating.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChefsDetailsPage(chef: widget.chef),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Chef avatar
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFF9BE45),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: widget.chef.avatar != null
                      ? Image.network(
                          widget.chef.avatar!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.person,
                            size: 36,
                            color: Colors.grey,
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          size: 36,
                          color: Colors.grey,
                        ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Chef name and rating
                    Row(
                      children: [
                        // Name in yellow pill
                        Expanded(
                          child: Text(
                            widget.chef.name,
                            style: theme.textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Rating
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFFF9BE45),
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(getRandomRating(),
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: AppColors.primary,
                                )),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Experience
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.black54,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Experience: ",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "${widget.chef.profile?.jobExperience ?? 2} years",
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // City
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.black54,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "City: ",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          widget.chef.profile?.location ?? "Bishkek",
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Travel availability
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_car,
                          color: Colors.black54,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            "Available for travel: ",
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          widget.chef.chefDetails?.canGoToRegions == true
                              ? "Yes"
                              : "No",
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
