class Category {
  final String name;
  final String image;

  Category({required this.name, required this.image});
}

final List<Category> categories = [
  Category(name: 'Salads', image: 'assets/temp/salad.png'),
  Category(name: 'Pizza', image: 'assets/temp/pizza.jpg'),
  Category(name: 'Soups', image: 'assets/temp/soup.png'),
  Category(name: 'Pasta', image: 'assets/temp/pasta.png'),
  Category(name: 'Grills', image: 'assets/temp/grill.png'),
  Category(name: 'Desserts', image: 'assets/temp/dessert.png'),
];

class Food {
  final String name;
  final String image;
  final String description;
  final double price;
  final double rating;

  Food({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.rating,
  });
}

final List<Food> popularFoods = [
  Food(
    name: 'Boso Lagman',
    image: 'assets/temp/lagman.png',
    description:
        'A beloved Central Asian noodle dish with a rich broth, tender meat, and fresh vegetables.',
    price: 320,
    rating: 4.6,
  ),
  Food(
    name: 'Margherita Pizza',
    image: 'assets/temp/pizza.jpg',
    description:
        'Classic Italian pizza topped with fresh tomato sauce, mozzarella, and basil leaves.',
    price: 450,
    rating: 4.7,
  ),
  Food(
    name: 'Caesar Salad',
    image: 'assets/temp/salad.png',
    description:
        'Crisp romaine lettuce tossed with Caesar dressing, croutons, and shaved Parmesan.',
    price: 280,
    rating: 4.5,
  ),
  Food(
    name: 'Beef Soup',
    image: 'assets/temp/soup.png',
    description:
        'Hearty slow-cooked beef soup with root vegetables and aromatic herbs.',
    price: 350,
    rating: 4.8,
  ),
  Food(
    name: 'Grilled Salmon',
    image: 'assets/temp/lagman.png',
    description:
        'Fresh Atlantic salmon fillet grilled to perfection, served with lemon butter sauce.',
    price: 620,
    rating: 4.9,
  ),
];
