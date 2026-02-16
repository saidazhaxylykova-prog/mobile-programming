import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // this variable for switching betwen image1 and image2
  bool showFirstImage = true;

  // here i write about BoxFit property what each one do:
  // BoxFit.fill - it stretch image to fill all container, but image can look wierd
  // BoxFit.contain - make image fit inside container and keep same proportions
  // BoxFit.cover - image cover all container but some parts can be cut off
  // BoxFit.fitWidth - image fit to width of container
  // BoxFit.fitHeight - image fit to height of container
  // BoxFit.none - show image in original size, can go outside container
  // BoxFit.scaleDown - same like contain but only make smaller not bigger

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab 4: Images & Buttons'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // here i use Stack widget to put things on top of each other
            Stack(
              children: [
                // this is background image from assets folder
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Image.asset(
                    showFirstImage
                        ? 'assets/image1.jpg'
                        : 'assets/image2.jpg',
                    fit: BoxFit.cover, // i use cover so image fill all space
                  ),
                ),
                // dark overlay so text is more visible on image
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                ),
                // text on top of image
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Welcome to Flutter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            // elevated button - when press it show snackbar message
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Hello from SnackBar!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  'Show SnackBar',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: 16),

            // text button - go to another screen when click
            SizedBox(
              width: 200,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                ),
                child: Text(
                  'Go to Second Screen',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: 16),

            // outlined button - change image when press
            SizedBox(
              width: 200,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    showFirstImage = !showFirstImage;
                  });
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.black),
                ),
                child: Text(
                  'Toggle Image',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// this is second screen, we go here when press text button
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Second Screen!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
