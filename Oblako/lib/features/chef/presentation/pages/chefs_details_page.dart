import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:cullinarium/core/utils/constants/app_consts.dart';
import 'package:cullinarium/features/chef/presentation/widgets/layout/dishes_overview.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChefsDetailsPage extends StatefulWidget {
  const ChefsDetailsPage({super.key, required this.chef});

  final ChefModel chef;

  @override
  State<ChefsDetailsPage> createState() => _ChefsDetailsPageState();
}

class _ChefsDetailsPageState extends State<ChefsDetailsPage> {
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
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: size.height * 0.4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -kToolbarHeight * 2,
                    child: Image.asset(
                      'assets/layout/chef_back.png',
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.white,
                          child: widget.chef.avatar != null
                              ? ClipOval(
                                  child: Image.network(
                                    widget.chef.avatar!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            widget.chef.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: kToolbarHeight,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Chef info cards
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.black54,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Experience: ",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "${widget.chef.profile?.jobExperience ?? 1} years",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // City
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.black54,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "City: ",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          widget.chef.profile?.location ?? "Bishkek",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Travel availability
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_car,
                          color: Colors.black54,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Available for travel: ",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          widget.chef.chefDetails?.canGoToRegions == true
                              ? "Yes"
                              : "No",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Icon(
                          Icons.timelapse_outlined,
                          color: Colors.black54,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Work schedule: ",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          widget.chef.chefDetails?.workSchedule ?? "Not specified",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Icon(
                          Icons.people,
                          color: Colors.black54,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Guest capacity: ",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          widget.chef.chefDetails?.guestsCapability != null
                              ? "${widget.chef.chefDetails!.guestsCapability} guests"
                              : "Not specified",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.attach_money_outlined,
                          color: Colors.black54,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Price per person: ",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          widget.chef.chefDetails?.pricePerPerson != null
                              ? "${widget.chef.chefDetails!.pricePerPerson.toStringAsFixed(0)} KGS"
                              : "Not specified",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Top dishes section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top Dish',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DishesOverview(dishes: widget.chef.chefDetails?.images ?? []),
                ],
              ),
            ),
          ),

          if (widget.chef.chefDetails != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Specialization',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Text(
                            widget.chef.chefDetails?.kitchen ?? 'Not specified',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Text(
                            widget.chef.chefDetails?.extraKitchen ??
                                'Not specified',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Contact Information',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/email.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Email: ",
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: Colors.black87,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget.chef.email,
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/whatsapp.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "WhatsApp:",
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: Colors.black87,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _launchUrl(
                                    '${AppConsts.whatsApp}${widget.chef.phoneNumber}'),
                                child: Text(
                                  widget.chef.phoneNumber,
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/instagram.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Instagram:",
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: Colors.black87,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _launchUrl(
                                    '${AppConsts.instagram}${widget.chef.profile?.instagram}'),
                                child: Text(
                                  "@${widget.chef.profile?.instagram ?? 'Not specified'}",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: AppColors.secondary,
                                  ),
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

          const SliverToBoxAdapter(
            child: SizedBox(height: kToolbarHeight),
          ),
        ],
      ),
    );
  }
}
