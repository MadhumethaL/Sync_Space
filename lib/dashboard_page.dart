import 'package:flutter/material.dart';
import 'hackathon_page.dart'; // Import the Hackathon Page
import 'symposium_page.dart'; // Import the Symposium Page
import 'workshop_page.dart'; // Import the Workshop Page
import 'conference_page.dart'; // Import the Conference Page
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:firebase_demo/settings.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  // List of pages to navigate between
  final List<Widget> _pages = [
    DashboardContent(), // Dashboard grid content
    // ProfilePage() is no longer directly included in the list
    Text('Settings Page'), // Placeholder for other options
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Replace the page instead of pushing to a stack
      if (index == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      } else {
        _selectedIndex = index; // Keep the original behavior for other tabs
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Stack(
        children: [
          // Background image for the entire page
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/app_image.png'), // Set your background image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Page content
          _selectedIndex == 1 ? ProfilePage() : _pages[0], // Show ProfilePage directly if selected
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}


// Separate widget for Dashboard content (ListView)
class DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildCard(context, 'Hackathons', Icons.computer, HackathonPage()),
          _buildCard(context, 'Symposiums', Icons.business_center, SymposiumPage()),
          _buildCard(context, 'Workshops', Icons.event, WorkshopPage()),
          _buildCard(context, 'Conferences', Icons.event, ConferencePage()),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16.0), // Space between cards
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // Navigate to the respective page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(30.0),// Padding around the content
          child: Row(
            children: [
              Icon(
                icon,
                size: 40, // Set the size of the icon
                color: Colors.black, // Change color if needed
              ),
              SizedBox(width: 16), // Space between icon and title
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  // Define a method to fetch user details from Firebase
  Future<Map<String, String>> _fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    return {
      'Username': user?.displayName ?? 'N/A',
      'Email': user?.email ?? 'N/A',
      'Password': '********', // Masked for security
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: FutureBuilder<Map<String, String>>(
        future: _fetchUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching user details'));
          } else {
            final userDetails = snapshot.data!;
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/back.png'), // Set your background image for the profile
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  buildProfileDetail('Username', userDetails['Username']!),
                  buildProfileDetail('Email', userDetails['Email']!),
                  buildProfileDetail('Password', userDetails['Password']!),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 1, // Set the current index to 1 for Profile
        onTap: (index) {
          if (index == 0) {
            // Navigate back to Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          } else if (index == 2) {
            // Navigate to Settings Page
            // You can replace this with your actual settings page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()), // Create a SettingsPage
            );
          }
        },
      ),
    );
  }

  Widget buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(value, style: TextStyle(fontSize: 18, color: Colors.white)),
        ],
      ),
    );
  }
}

