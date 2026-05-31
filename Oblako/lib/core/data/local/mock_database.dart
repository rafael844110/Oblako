import 'package:cullinarium/features/profile/data/models/author_model.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_details_model.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:cullinarium/features/profile/data/models/profile_model.dart';
import 'package:cullinarium/features/profile/data/models/user_model.dart';
import 'package:cullinarium/features/recipe/data/models/ingredient_model.dart';
import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';
import 'package:uuid/uuid.dart';

class MockDatabase {
  static final MockDatabase _instance = MockDatabase._internal();

  factory MockDatabase() => _instance;

  MockDatabase._internal() {
    _seedData();
  }

  final List<UserModel> users = [];
  final List<ChefModel> chefs = [];
  final List<AuthorModel> authors = [];
  final List<RecipeModel> recipes = [];

  // Currently logged in user
  dynamic currentUser;

  void clear() {
    users.clear();
    chefs.clear();
    authors.clear();
    recipes.clear();
    currentUser = null;
  }

  void _seedData() {
    const uuid = Uuid();

    // Seed Chefs
    chefs.addAll([
      ChefModel(
        id: 'chef_gordon',
        name: 'Gordon Ramsay',
        email: 'chef@gmail.com', // Matched with auth email
        role: 'chef',
        phoneNumber: '+1234567890',
        avatar:
            'https://images.unsplash.com/photo-1583394838336-acd977736f90?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
        createdAt: DateTime.now().toIso8601String(),
        profile: const ProfileModel(
          description:
              'Multi-Michelin starred chef known for his fiery temper and exceptional culinary skills.',
          jobExperience: 25,
          location: 'London, UK',
          instagram: '@gordongram',
          categories: ['British', 'French', 'Fine Dining'],
          languages: ['English', 'French'],
          rating: 4.9,
          isApprovied: true,
        ),
        chefDetails: const ChefDetailsModel(
          kitchen: 'Professional Kitchen',
          extraKitchen: 'Outdoor Grill',
          guestsCapability: 50,
          workSchedule: 'Mon-Sat 10am-10pm',
          menu: ['Beef Wellington', 'Risotto', 'Scallops'],
          pricePerPerson: 150.0,
          canGoToRegions: true,
          images: [
            'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1559339352-11d035aa65de?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
          ],
        ),
      ),
      ChefModel(
        id: 'chef_julia',
        name: 'Julia Child',
        email: 'julia@frenchcooking.com',
        role: 'chef',
        phoneNumber: '+1987654321',
        avatar:
            'https://images.unsplash.com/photo-1577219491135-ce391730fb2c?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
        createdAt: DateTime.now().toIso8601String(),
        profile: const ProfileModel(
          description:
              'Bringing French cuisine to the American public with passion and humor.',
          jobExperience: 40,
          location: 'Paris, France',
          instagram: '@juliacooking',
          categories: ['French', 'Home Cooking'],
          languages: ['English', 'French'],
          rating: 5.0,
          isApprovied: true,
        ),
        chefDetails: const ChefDetailsModel(
          kitchen: 'Home Kitchen',
          extraKitchen: 'Baking Station',
          guestsCapability: 10,
          workSchedule: 'Wed-Sun 12pm-8pm',
          menu: ['Boeuf Bourguignon', 'Coq au Vin', 'Soufflé'],
          pricePerPerson: 80.0,
          canGoToRegions: false,
          images: [
            'https://images.unsplash.com/photo-1467003909585-2f8a7270028d?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
          ],
        ),
      ),
      ChefModel(
        id: 'chef_jamie',
        name: 'Jamie Oliver',
        email: 'jamie@nakedchef.com',
        role: 'chef',
        phoneNumber: '+4412345678',
        avatar:
            'https://images.unsplash.com/photo-1566554273541-37a9ca77b91f?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
        createdAt: DateTime.now().toIso8601String(),
        profile: const ProfileModel(
          description:
              'Passionate about fresh, organic, and healthy food for everyone.',
          jobExperience: 20,
          location: 'Essex, UK',
          instagram: '@jamieoliver',
          categories: ['Italian', 'British', 'Healthy'],
          languages: ['English'],
          rating: 4.7,
          isApprovied: true,
        ),
        chefDetails: const ChefDetailsModel(
          kitchen: 'Farm Kitchen',
          extraKitchen: 'Pizza Oven',
          guestsCapability: 20,
          workSchedule: 'Thu-Sun 11am-9pm',
          menu: ['Fresh Pasta', 'Roasted Chicken', 'Healthy Salads'],
          pricePerPerson: 60.0,
          canGoToRegions: true,
          images: [
            'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1490645935967-10de6ba17061?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
          ],
        ),
      ),
    ]);

    // Seed Authors
    authors.add(const AuthorModel(
      id: 'author_critic',
      name: 'Food Critic',
      email: 'author@gmail.com',
      role: 'author',
      createdAt: '2023-01-01T00:00:00.000Z',
      phoneNumber: '+2222222222',
      avatar:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      profile: ProfileModel(
        description: 'Food lover and critic.',
        jobExperience: 5,
        location: 'Paris',
        isApprovied: true,
        rating: 4.5,
      ),
    ));

    // Seed Users
    users.add(const UserModel(
      id: 'regular_user',
      name: 'Regular User',
      email: 'user@gmail.com',
      role: 'user',
      createdAt: '2023-01-01T00:00:00.000Z',
      phoneNumber: '+1111111111',
      avatar:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      preferences: ['Italian', 'Mexican'],
    ));

    // Seed Recipes
    recipes.addAll([
      RecipeModel(
        id: uuid.v4(),
        title: 'Classic Beef Burger',
        description:
            'Juicy, delicious homemade beef burger with cheese and fresh vegetables.',
        authorId: 'chef_gordon',
        imageUrl:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
        categories: ['American', 'Lunch', 'Dinner', 'Fast Food'],
        ingredients: [
          IngredientModel(name: 'Ground Beef', quantity: 500, unit: 'g'),
          IngredientModel(name: 'Burger Buns', quantity: 4, unit: 'pcs'),
          IngredientModel(name: 'Cheddar Cheese', quantity: 4, unit: 'slices'),
          IngredientModel(name: 'Lettuce', quantity: 1, unit: 'head'),
          IngredientModel(name: 'Tomato', quantity: 2, unit: 'pcs'),
        ],
        steps: [
          'Season the ground beef with salt and pepper.',
          'Form into 4 patties.',
          'Grill patties for 3-4 minutes per side.',
          'Add cheese in the last minute of cooking.',
          'Toast buns and assemble the burger with vegetables.',
        ],
        prepTimeMinutes: 20,
        cookTimeMinutes: 15,
        servings: 4,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        likes: 120,
      ),
      RecipeModel(
        id: uuid.v4(),
        title: 'Italian Tomato Pasta',
        description:
            'Simple yet flavorful pasta with a rich tomato basil sauce.',
        authorId: 'chef_jamie',
        imageUrl:
            'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
        categories: ['Italian', 'Vegetarian', 'Lunch'],
        ingredients: [
          IngredientModel(name: 'Spaghetti', quantity: 400, unit: 'g'),
          IngredientModel(name: 'Canned Tomatoes', quantity: 400, unit: 'g'),
          IngredientModel(name: 'Garlic', quantity: 2, unit: 'cloves'),
          IngredientModel(name: 'Fresh Basil', quantity: 1, unit: 'bunch'),
          IngredientModel(name: 'Olive Oil', quantity: 2, unit: 'tbsp'),
        ],
        steps: [
          'Boil pasta in salted water until al dente.',
          'Sauté garlic in olive oil.',
          'Add tomatoes and simmer for 15 minutes.',
          'Stir in fresh basil.',
          'Toss pasta with the sauce and serve.',
        ],
        prepTimeMinutes: 10,
        cookTimeMinutes: 20,
        servings: 4,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        likes: 85,
      ),
      RecipeModel(
        id: uuid.v4(),
        title: 'Avocado Toast with Egg',
        description:
            'Healthy and nutritious breakfast with creamy avocado and poached egg.',
        authorId: 'chef_gordon',
        imageUrl:
            'https://images.unsplash.com/photo-1525351484163-7529414395d8?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
        categories: ['Breakfast', 'Healthy', 'Vegetarian'],
        ingredients: [
          IngredientModel(name: 'Sourdough Bread', quantity: 2, unit: 'slices'),
          IngredientModel(name: 'Avocado', quantity: 1, unit: 'pc'),
          IngredientModel(name: 'Eggs', quantity: 2, unit: 'pcs'),
          IngredientModel(name: 'Chili Flakes', quantity: 1, unit: 'pinch'),
          IngredientModel(name: 'Lemon Juice', quantity: 1, unit: 'tsp'),
        ],
        steps: [
          'Toast the bread slices.',
          'Mash avocado with lemon juice, salt, and pepper.',
          'Poach the eggs in simmering water.',
          'Spread avocado on toast and top with poached egg.',
          'Sprinkle with chili flakes.',
        ],
        prepTimeMinutes: 10,
        cookTimeMinutes: 5,
        servings: 2,
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        likes: 210,
      ),
    ]);
  }
}
