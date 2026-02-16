import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 5',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomeScreen(),
    );
  }
}

// main screen with drawer and tabbar
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // i have 4 tabs for diffrent tasks
      child: Scaffold(
        appBar: AppBar(
          title: Text('Beauty Shop'),
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          // tabbar at bottom of appbar
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: [
              Tab(text: 'Categories'),
              Tab(text: 'Shades'),
              Tab(text: 'Products'),
              Tab(text: 'More'),
            ],
          ),
        ),
        // drawer for task 5
        drawer: MyDrawer(),
        // tabbarview shows diffrent content for each tab
        body: TabBarView(
          children: [
            ListViewTab(),    // task 1 & 2 - listview
            GridViewTab(),    // task 1 & 3 - gridview
            CardsTab(),       // task 4 - cards
            ToastTab(),       // task 6 - toast
          ],
        ),
      ),
    );
  }
}

// task 2: listview with 10 items - cosmetics categories
class ListViewTab extends StatelessWidget {
  const ListViewTab({super.key});

  // list of cosmetics categories
  final List<Map<String, dynamic>> categories = const [
    {'name': 'Lipsticks', 'subtitle': 'Matte, glossy, liquid', 'icon': Icons.brush},
    {'name': 'Foundations', 'subtitle': 'For all skin tones', 'icon': Icons.face},
    {'name': 'Eye Shadows', 'subtitle': 'Palettes and singles', 'icon': Icons.remove_red_eye},
    {'name': 'Mascara', 'subtitle': 'Volume and length', 'icon': Icons.visibility},
    {'name': 'Blush', 'subtitle': 'Pink, peach, coral', 'icon': Icons.favorite},
    {'name': 'Skincare', 'subtitle': 'Creams and serums', 'icon': Icons.spa},
    {'name': 'Perfumes', 'subtitle': 'Floral and fresh scents', 'icon': Icons.local_florist},
    {'name': 'Nail Polish', 'subtitle': 'Many colors available', 'icon': Icons.colorize},
    {'name': 'Brushes', 'subtitle': 'Professional quality', 'icon': Icons.format_paint},
    {'name': 'Gift Sets', 'subtitle': 'Perfect for presents', 'icon': Icons.card_giftcard},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length, // 10 items
      itemBuilder: (context, index) {
        // each item have title and subtitle
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.pink[100 * ((index % 4) + 1)],
            child: Icon(
              categories[index]['icon'],
              color: Colors.white,
            ),
          ),
          title: Text(categories[index]['name']),
          subtitle: Text(categories[index]['subtitle']),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink),
          onTap: () {
            // when tap show snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('You selected ${categories[index]['name']}')),
            );
          },
        );
      },
    );
  }
}

// task 3: gridview with containers - cosmetic shades
class GridViewTab extends StatelessWidget {
  const GridViewTab({super.key});

  // list of lipstick/makeup shades with names
  final List<Map<String, dynamic>> shades = const [
    {'color': Color(0xFFE91E63), 'name': 'Berry'},
    {'color': Color(0xFFF48FB1), 'name': 'Rose'},
    {'color': Color(0xFFD81B60), 'name': 'Fuchsia'},
    {'color': Color(0xFFAD1457), 'name': 'Wine'},
    {'color': Color(0xFFFF8A80), 'name': 'Coral'},
    {'color': Color(0xFFFFAB91), 'name': 'Peach'},
    {'color': Color(0xFFC2185B), 'name': 'Cherry'},
    {'color': Color(0xFFEC407A), 'name': 'Pink'},
    {'color': Color(0xFFBA68C8), 'name': 'Mauve'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 items in each row
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: shades.length, // more than 6 containers
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You picked ${shades[index]['name']} shade')),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: shades[index]['color'],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              // shade name inside container
              child: Center(
                child: Text(
                  shades[index]['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// task 4: cards with image title and description
class CardsTab extends StatelessWidget {
  const CardsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // list of cosmetics products for cards
    final List<Map<String, String>> cardData = [
      {
        'title': 'Rose Lip Gloss',
        'description': 'Shiny lip gloss with rose extract, make your lips soft and pretty',
        'image': 'https://picsum.photos/400/200?random=10',
        'price': '\$12.99',
      },
      {
        'title': 'Matte Foundation',
        'description': 'Long lasting foundation for smooth skin, available in 15 shades',
        'image': 'https://picsum.photos/400/200?random=11',
        'price': '\$24.99',
      },
      {
        'title': 'Eye Shadow Palette',
        'description': 'Beautiful colors for day and night look, 12 diffrent shades',
        'image': 'https://picsum.photos/400/200?random=12',
        'price': '\$18.50',
      },
      {
        'title': 'Moisturizing Cream',
        'description': 'Hydrating cream with vitamin E, good for all skin types',
        'image': 'https://picsum.photos/400/200?random=13',
        'price': '\$15.00',
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: cardData.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4, // shadow for card
          margin: EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image on top of card
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  cardData[index]['image']!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // show loading indicator when image loading
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 150,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
              // title, description and price
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cardData[index]['title']!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cardData[index]['price']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      cardData[index]['description']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 12),
                    // add to cart button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added ${cardData[index]['title']} to cart!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Add to Cart'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// task 6: toast notification
class ToastTab extends StatelessWidget {
  const ToastTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Press button to show toast',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // show toast using fluttertoast package
              Fluttertoast.showToast(
                msg: "Hello, Flutter!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(
              'Show Toast',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// task 5: drawer with options - beauty shop theme
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // header of drawer with user info
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink, Colors.pinkAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.face, size: 40, color: Colors.pink),
                ),
                SizedBox(height: 10),
                Text(
                  'Saida',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Welcome to Beauty Shop!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Home option
          ListTile(
            leading: Icon(Icons.home, color: Colors.pink),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // close drawer first
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You selected Home')),
              );
            },
          ),
          // Profile option
          ListTile(
            leading: Icon(Icons.person, color: Colors.pink),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You selected Profile')),
              );
            },
          ),
          // Settings option
          ListTile(
            leading: Icon(Icons.settings, color: Colors.pink),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You selected Settings')),
              );
            },
          ),
          Divider(), // line to seperate logout
          // Logout option
          ListTile(
            leading: Icon(Icons.logout, color: Colors.grey),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You selected Logout')),
              );
            },
          ),
        ],
      ),
    );
  }
}
