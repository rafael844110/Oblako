// Function to seed test chef data

final List<Map<String, dynamic>> russianChefDummyData = [
  {
    'id': 'chef001',
    'name': 'James Carter',
    'email': 'james.carter@oblako.com',
    'role': 'chef',
    'phoneNumber': '+44712345678',
    'avatar':
        'https://images.unsplash.com/photo-1566554273541-37a9ca77b91f?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'createdAt': '2024-05-01T10:30:00.000Z',
    'profile': {
      'description':
          'Blending authentic Italian and French culinary traditions with modern techniques to create unforgettable dining experiences.',
      'jobExperience': '15 years of experience in Italian & French fusion cuisine.',
      'location': 'London, UK',
      'instagram': 'james_carter_chef',
      'categories': ['Italian Cuisine', 'French Cuisine', 'Fusion'],
      'languages': ['English', 'Italian', 'French'],
      'rating': 4.8,
      'isApprovied': true,
    },
    'chefDetails': {
      'kitchen': 'Italian & French Fusion',
      'extraKitchen': 'Mediterranean, Modern European',
      'guestsCapability': 50,
      'workSchedule': 'Mon-Sat, 9:00-21:00',
      'menu': [
        'Truffle Risotto with Pan-Seared Scallops',
        'Duck Confit with Cherry Reduction',
        'Handmade Tagliatelle with Black Truffle',
        'Crème Brûlée with Seasonal Berries'
      ],
      'pricePerPerson': 3500.0,
      'canGoToRegions': true,
      'images': [
        'https://images.unsplash.com/photo-1551006917-3b4c078c47c9?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1576866209830-589e1bfbaa4d?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1583953596987-451b9f8ea6e6?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
      ],
    }
  },
  {
    'id': 'chef002',
    'name': 'Sofia Rossi',
    'email': 'sofia.rossi@oblako.com',
    'role': 'chef',
    'phoneNumber': '+39267890123',
    'avatar':
        'https://images.unsplash.com/photo-1594490434733-dc762c4e0765?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'createdAt': '2024-04-12T08:15:00.000Z',
    'profile': {
      'description':
          'Passionate about creating exquisite pastries and desserts that combine classic Italian techniques with contemporary flair.',
      'jobExperience': '8 years specializing in pastry and desserts.',
      'location': 'Milan, Italy',
      'instagram': 'sofia_desserts',
      'categories': ['Pastry', 'Desserts', 'Fusion Baking'],
      'languages': ['Italian', 'French', 'English'],
      'rating': 4.9,
      'isApprovied': true,
    },
    'chefDetails': {
      'kitchen': 'Pastry & Desserts',
      'extraKitchen': 'Italian Baking, French Patisserie',
      'guestsCapability': 30,
      'workSchedule': 'Tue-Sun, 8:00-20:00',
      'menu': [
        'Classic Tiramisu with Amaretto',
        'Pistachio Cannoli with Ricotta Cream',
        'Lemon Tart with Italian Meringue',
        'Chocolate Fondant with Vanilla Gelato'
      ],
      'pricePerPerson': 2800.0,
      'canGoToRegions': true,
      'images': [
        'https://images.unsplash.com/photo-1567954970774-58d6aa6c50dc?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1568199435309-08cfbd0e8f71?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1612886623532-1952b13a4a85?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
      ],
    }
  },
  {
    'id': 'chef003',
    'name': 'Marcus Williams',
    'email': 'marcus.williams@oblako.com',
    'role': 'chef',
    'phoneNumber': '+12125678901',
    'avatar':
        'https://images.unsplash.com/photo-1577219491135-ce391730fb2c?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'createdAt': '2024-03-28T14:20:00.000Z',
    'profile': {
      'description':
          'A pit master with over two decades of experience perfecting the art of BBQ and smokehouse cooking across the American South.',
      'jobExperience': '20 years leading BBQ and smokehouse kitchens.',
      'location': 'New York, USA',
      'instagram': 'marcus_bbq',
      'categories': ['BBQ', 'Smokehouse', 'American Cuisine'],
      'languages': ['English', 'Spanish'],
      'rating': 4.7,
      'isApprovied': true,
    },
    'chefDetails': {
      'kitchen': 'BBQ & Smokehouse',
      'extraKitchen': 'Southern American, Tex-Mex',
      'guestsCapability': 100,
      'workSchedule': 'Tue-Sun, 10:00-22:00',
      'menu': [
        'Texas-Style Slow-Smoked Brisket',
        'Memphis Dry-Rub Pork Ribs',
        'Carolina Pulled Pork Sandwich',
        'Smoked Mac & Cheese with Jalapeño'
      ],
      'pricePerPerson': 4000.0,
      'canGoToRegions': false,
      'images': [
        'https://images.unsplash.com/photo-1561626138-65e912e912a9?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1580476262798-bddd9f4b7369?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1588689115724-e04f8ee8e55c?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
      ],
    }
  },
  {
    'id': 'chef004',
    'name': 'Yuki Tanaka',
    'email': 'yuki.tanaka@oblako.com',
    'role': 'chef',
    'phoneNumber': '+81345678901',
    'avatar':
        'https://images.unsplash.com/photo-1561366467-a9e4f9f8e2e9?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'createdAt': '2024-05-10T09:45:00.000Z',
    'profile': {
      'description':
          'Creating innovative dishes that celebrate the rich heritage of Japanese cuisine while embracing bold Asian fusion flavors.',
      'jobExperience': '12 years specializing in Japanese & Asian fusion cuisine.',
      'location': 'Tokyo, Japan',
      'instagram': 'yuki_tanaka_chef',
      'categories': ['Japanese Cuisine', 'Asian Fusion', 'Sushi'],
      'languages': ['Japanese', 'English', 'Korean'],
      'rating': 4.6,
      'isApprovied': true,
    },
    'chefDetails': {
      'kitchen': 'Japanese & Asian Fusion',
      'extraKitchen': 'Korean, Vietnamese',
      'guestsCapability': 40,
      'workSchedule': 'Mon-Fri, 10:00-20:00',
      'menu': [
        'Omakase Sushi Selection',
        'Wagyu Beef Ramen with Truffle',
        'Tempura Platter with Dipping Sauces',
        'Matcha Mochi Ice Cream'
      ],
      'pricePerPerson': 3200.0,
      'canGoToRegions': true,
      'images': [
        'https://images.unsplash.com/photo-1598180310788-9fc7e9248659?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1619380061814-58f749111d50?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1594041680534-e8c8cdebd659?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
      ],
    }
  },
  {
    'id': 'chef005',
    'name': 'Ahmed Hassan',
    'email': 'ahmed.hassan@oblako.com',
    'role': 'chef',
    'phoneNumber': '+97154567890',
    'avatar':
        'https://images.unsplash.com/photo-1545389333-cf878a5d9c9a?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'createdAt': '2024-04-05T16:30:00.000Z',
    'profile': {
      'description':
          'A master of Middle Eastern cuisine with a quarter century of experience bringing the finest flavors of the region to the table.',
      'jobExperience': '25 years of experience in Middle Eastern cuisine.',
      'location': 'Dubai, UAE',
      'instagram': 'ahmed_hassan_chef',
      'categories': ['Middle Eastern', 'Arabic', 'Mediterranean'],
      'languages': ['Arabic', 'English', 'Urdu'],
      'rating': 4.9,
      'isApprovied': true,
    },
    'chefDetails': {
      'kitchen': 'Middle Eastern Cuisine',
      'extraKitchen': 'Persian, Levantine',
      'guestsCapability': 150,
      'workSchedule': 'Daily, 12:00-22:00',
      'menu': [
        'Slow-Roasted Lamb Ouzi with Saffron Rice',
        'Mezze Platter with Hummus and Fattoush',
        'Mixed Grill Platter with Garlic Sauce',
        'Knafeh with Rose Water Syrup'
      ],
      'pricePerPerson': 2500.0,
      'canGoToRegions': true,
      'images': [
        'https://images.unsplash.com/photo-1525164286253-04e68b9d94c6?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1544025162-d76694265947?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1544474607-41c1e1168191?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
      ],
    }
  },
  {
    'id': 'chef006',
    'name': 'Emma Laurent',
    'email': 'emma.laurent@oblako.com',
    'role': 'chef',
    'phoneNumber': '+33265678901',
    'avatar':
        'https://images.unsplash.com/photo-1551836022-d5d88e9218df?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'createdAt': '2024-05-15T11:00:00.000Z',
    'profile': {
      'description':
          'Pioneering plant-based cuisine in Paris, proving that vegan food can be just as indulgent, colorful, and exciting as any other style.',
      'jobExperience': '10 years in vegan and plant-based cuisine across Europe.',
      'location': 'Paris, France',
      'instagram': 'emma_vegan_paris',
      'categories': ['Vegan', 'Plant-Based', 'Organic'],
      'languages': ['French', 'English', 'German'],
      'rating': 4.8,
      'isApprovied': true,
    },
    'chefDetails': {
      'kitchen': 'Vegan & Plant-Based',
      'extraKitchen': 'Raw Food, Gluten-Free',
      'guestsCapability': 35,
      'workSchedule': 'Mon-Sat, 9:00-19:00',
      'menu': [
        'Roasted Beetroot Tartare with Cashew Cream',
        'Mushroom Wellington with Red Wine Jus',
        'Jackfruit Tacos with Mango Salsa',
        'Avocado Chocolate Mousse'
      ],
      'pricePerPerson': 2800.0,
      'canGoToRegions': true,
      'images': [
        'https://images.unsplash.com/photo-1543339308-43e59d6b73a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1623428187969-5da2dcea5ebf?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1610379230744-2e57a268f53d?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
      ],
    }
  },
  {
    'id': 'chef007',
    'name': 'Luca Bianchi',
    'email': 'luca.bianchi@oblako.com',
    'role': 'chef',
    'phoneNumber': '+39156789012',
    'avatar':
        'https://images.unsplash.com/photo-1588516903720-8ceb67f9ef84?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'createdAt': '2024-04-20T13:15:00.000Z',
    'profile': {
      'description':
          'A rising star of the Roman culinary scene, bringing fresh perspectives and creative energy to traditional Italian recipes.',
      'jobExperience': '6 years working in premium restaurants across Italy.',
      'location': 'Rome, Italy',
      'instagram': 'luca_rising_chef',
      'categories': ['Modern Italian', 'Pasta', 'Contemporary'],
      'languages': ['Italian', 'English', 'Spanish'],
      'rating': 4.5,
      'isApprovied': true,
    },
    'chefDetails': {
      'kitchen': 'Modern Italian',
      'extraKitchen': 'Mediterranean, Fusion',
      'guestsCapability': 25,
      'workSchedule': 'Tue-Sun, 14:00-22:00',
      'menu': [
        'Hand-Rolled Cacio e Pepe with Bottarga',
        'Osso Buco with Saffron Risotto Milanese',
        'Burrata with Heirloom Tomatoes and Basil Oil',
        'Panna Cotta with Strawberry Coulis'
      ],
      'pricePerPerson': 3800.0,
      'canGoToRegions': true,
      'images': [
        'https://images.unsplash.com/photo-1621567453855-edacc2ffad7b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1607330289024-1535acc792a5?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1632789395770-20e6f63be806?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
      ],
    }
  },
  {
    'id': 'chef008',
    'name': 'Maria Santos',
    'email': 'maria.santos@oblako.com',
    'role': 'chef',
    'phoneNumber': '+35167890123',
    'avatar':
        'https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'createdAt': '2024-03-15T10:45:00.000Z',
    'profile': {
      'description':
          'A seasoned catering professional who has coordinated and executed memorable events from intimate dinners to large corporate galas across Portugal.',
      'jobExperience': '15 years of catering and event cuisine across Portugal and Europe.',
      'location': 'Lisbon, Portugal',
      'instagram': 'maria_catering_pro',
      'categories': ['Catering', 'Events', 'Portuguese Cuisine'],
      'languages': ['Portuguese', 'English', 'Spanish'],
      'rating': 4.7,
      'isApprovied': true,
    },
    'chefDetails': {
      'kitchen': 'Portuguese Traditional Cuisine',
      'extraKitchen': 'Mediterranean, Event Catering',
      'guestsCapability': 300,
      'workSchedule': 'By appointment',
      'menu': [
        'Bacalhau à Brás with Olives and Eggs',
        'Slow-Roasted Suckling Pig with Rosemary',
        'Seafood Cataplana with Fresh Clams',
        'Pastel de Nata Selection'
      ],
      'pricePerPerson': 2200.0,
      'canGoToRegions': true,
      'images': [
        'https://images.unsplash.com/photo-1605522588521-6cb88a93b23e?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1584663639452-b272afba0bf3?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1507434888513-76389292d288?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
      ],
    }
  },
  {
    'id': 'chef009',
    'name': 'David Kim',
    'email': 'david.kim@oblako.com',
    'role': 'chef',
    'phoneNumber': '+82158901234',
    'avatar':
        'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'createdAt': '2024-05-05T12:30:00.000Z',
    'profile': {
      'description':
          'An exclusive private chef offering bespoke fine dining experiences that merge Korean heritage with global gastronomy for discerning clients.',
      'jobExperience': '10 years as a private chef for executives and diplomats.',
      'location': 'Seoul, Korea',
      'instagram': 'david_private_chef',
      'categories': ['Fine Dining', 'Korean Cuisine', 'Private Events'],
      'languages': ['Korean', 'English', 'Japanese'],
      'rating': 5.0,
      'isApprovied': true,
    },
    'chefDetails': {
      'kitchen': 'Private Fine Dining',
      'extraKitchen': 'Korean, Molecular Gastronomy',
      'guestsCapability': 15,
      'workSchedule': 'By appointment',
      'menu': [
        'Wagyu Galbi with Truffle Doenjang Glaze',
        'Bibimbap Reimagined with Seared Foie Gras',
        'Haemul Pajeon with Yuzu Dipping Sauce',
        '7-Course Tasting Menu with Wine Pairing'
      ],
      'pricePerPerson': 7500.0,
      'canGoToRegions': true,
      'images': [
        'https://images.unsplash.com/photo-1518133683791-0b9de5a055f0?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1501189347517-8f805d44779b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1541809570-59ab6eda2596?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
      ],
    }
  },
  {
    'id': 'chef010',
    'name': 'Priya Sharma',
    'email': 'priya.sharma@oblako.com',
    'role': 'chef',
    'phoneNumber': '+91269012345',
    'avatar':
        'https://images.unsplash.com/photo-1598976789852-59e0c82f5e50?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'createdAt': '2024-04-28T14:00:00.000Z',
    'profile': {
      'description':
          'Sharing the rich culinary traditions of India through immersive cooking classes, workshops, and educational programs for all skill levels.',
      'jobExperience': '18 years in culinary education and the restaurant industry.',
      'location': 'Mumbai, India',
      'instagram': 'priya_culinary_school',
      'categories': ['Culinary Education', 'Indian Cuisine', 'Workshops'],
      'languages': ['Hindi', 'English', 'Marathi'],
      'rating': 4.9,
      'isApprovied': true,
    },
    'chefDetails': {
      'kitchen': 'Indian Culinary Instruction',
      'extraKitchen': 'Regional Indian, Spice Blending',
      'guestsCapability': 20,
      'workSchedule': 'Mon-Fri, 10:00-18:00',
      'menu': [
        'Butter Chicken with Homemade Garlic Naan',
        'Lamb Rogan Josh with Saffron Pulao',
        'Paneer Tikka Masala',
        'Gulab Jamun with Cardamom Syrup'
      ],
      'pricePerPerson': 3000.0,
      'canGoToRegions': true,
      'images': [
        'https://images.unsplash.com/photo-1507048947301-7afc2aca0edc?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1590577976322-3d2d6e2130d5?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1610725667100-1fd24eb6a10b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
      ],
    }
  },
  {
    'id': 'chef011',
    'name': 'Carlos Mendez',
    'email': 'carlos.mendez@oblako.com',
    'role': 'chef',
    'phoneNumber': '+34612345678',
    'avatar':
        'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'createdAt': '2024-06-01T10:00:00.000Z',
    'profile': {
      'description':
          'A Barcelona-born culinary artist celebrating the bold, sun-drenched flavors of Spain and the broader Mediterranean coastline.',
      'jobExperience': '14 years of experience in Spanish & Mediterranean cuisine.',
      'location': 'Barcelona, Spain',
      'instagram': 'carlos_mendez_chef',
      'categories': ['Spanish Cuisine', 'Mediterranean', 'Tapas'],
      'languages': ['Spanish', 'Catalan', 'English'],
      'rating': 4.7,
      'isApprovied': true,
    },
    'chefDetails': {
      'kitchen': 'Spanish & Mediterranean',
      'extraKitchen': 'Seafood, Tapas',
      'guestsCapability': 60,
      'workSchedule': 'Tue-Sun, 11:00-23:00',
      'menu': [
        'Paella Valenciana with Saffron and Rabbit',
        'Grilled Octopus with Paprika Oil',
        'Jamón Ibérico and Manchego Tapas Board',
        'Churros with Rich Chocolate Dipping Sauce'
      ],
      'pricePerPerson': 3300.0,
      'canGoToRegions': true,
      'images': [
        'https://images.unsplash.com/photo-1551006917-3b4c078c47c9?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
      ],
    }
  },
  {
    'id': 'chef012',
    'name': 'Aisha Okonkwo',
    'email': 'aisha.okonkwo@oblako.com',
    'role': 'chef',
    'phoneNumber': '+23480987654',
    'avatar':
        'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'createdAt': '2024-06-10T09:00:00.000Z',
    'profile': {
      'description':
          'Bringing the vibrant, aromatic, and deeply soulful culinary traditions of Africa and the Caribbean to life in a contemporary kitchen setting.',
      'jobExperience': '9 years exploring African and Caribbean fusion cuisine.',
      'location': 'Lagos, Nigeria',
      'instagram': 'aisha_afro_kitchen',
      'categories': ['African Cuisine', 'Caribbean', 'Fusion'],
      'languages': ['English', 'Yoruba', 'French'],
      'rating': 4.6,
      'isApprovied': true,
    },
    'chefDetails': {
      'kitchen': 'African & Caribbean Fusion',
      'extraKitchen': 'West African, Jerk Cuisine',
      'guestsCapability': 45,
      'workSchedule': 'Mon-Sat, 10:00-20:00',
      'menu': [
        'Egusi Soup with Pounded Yam',
        'Jerk Chicken with Coconut Rice and Peas',
        'Suya Beef Skewers with Groundnut Sauce',
        'Plantain Tarte Tatin with Rum Caramel'
      ],
      'pricePerPerson': 2600.0,
      'canGoToRegions': false,
      'images': [
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
      ],
    }
  },
];
