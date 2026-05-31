class ChefDetailsModel {
  final String kitchen;
  final String extraKitchen;
  final int guestsCapability;
  final String workSchedule;
  final List<String> menu;
  final double pricePerPerson;
  final bool? canGoToRegions;
  final List<String> images;

  const ChefDetailsModel({
    required this.kitchen,
    required this.extraKitchen,
    required this.guestsCapability,
    required this.workSchedule,
    required this.menu,
    required this.pricePerPerson,
    this.canGoToRegions,
    required this.images,
  });
}
