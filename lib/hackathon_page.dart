import 'package:flutter/material.dart';
import 'package:firebase_demo/dashboard_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart'; // Import for image picking

class Hackathon {
  final String name;
  final String month;
  final String year;
  final String batchYear;
  final List<Team> teams;

  Hackathon({
    required this.name,
    required this.month,
    required this.year,
    required this.batchYear,
    required this.teams,
  });
}

class Team {
  final String name;
  final String presentation;
  final String prize;
  final String idea;

  Team({
    required this.name,
    required this.presentation,
    required this.prize,
    required this.idea,
  });
}

class HackathonPage extends StatefulWidget {
  @override
  _HackathonPageState createState() => _HackathonPageState();
}

class _HackathonPageState extends State<HackathonPage> {
  List<Hackathon> hackathons = [
    Hackathon(
      name: 'Smart India Hackathon 2023',
      month: 'January',
      year: '2023',
      batchYear: '2022',
      teams: [
        Team(
          name: 'Team Alpha',
          presentation: 'Alpha_Presentation.pdf',
          prize: '1st Place',
          idea: 'AI for Health',
        ),
        Team(
          name: 'Team Beta',
          presentation: 'Beta_Presentation.pdf',
          prize: '2nd Place',
          idea: 'Smart Agriculture',
        ),
      ],
    ),
    Hackathon(
      name: 'PSG iTech Hackathon 2022',
      month: 'March',
      year: '2022',
      batchYear: '2021',
      teams: [
        Team(
          name: 'Team Gamma',
          presentation: 'Gamma_Presentation.pdf',
          prize: '3rd Place',
          idea: 'Blockchain for Transparency',
        ),
      ],
    ),
    Hackathon(
      name: 'Tech Innovation Challenge 2023',
      month: 'July',
      year: '2023',
      batchYear: '2022',
      teams: [
        Team(
          name: 'Team Delta',
          presentation: 'Delta_Presentation.pdf',
          prize: '1st Place',
          idea: 'Smart Traffic Management',
        ),
        Team(
          name: 'Team Epsilon',
          presentation: 'Epsilon_Presentation.pdf',
          prize: '2nd Place',
          idea: 'Energy Optimization for Smart Grids',
        ),
      ],
    ),
    Hackathon(
      name: 'National Coding Hackathon 2021',
      month: 'November',
      year: '2021',
      batchYear: '2020',
      teams: [
        Team(
          name: 'Team Zeta',
          presentation: 'Zeta_Presentation.pdf',
          prize: '1st Place',
          idea: 'Automated Coding Assistance',
        ),
        Team(
          name: 'Team Theta',
          presentation: 'Theta_Presentation.pdf',
          prize: '3rd Place',
          idea: 'Cybersecurity Threat Detection',
        ),
      ],
    ),
    Hackathon(
      name: 'AI & ML Hackathon 2020',
      month: 'September',
      year: '2020',
      batchYear: '2019',
      teams: [
        Team(
          name: 'Team Lambda',
          presentation: 'Lambda_Presentation.pdf',
          prize: '1st Place',
          idea: 'AI-Powered Disease Diagnosis',
        ),
        Team(
          name: 'Team Mu',
          presentation: 'Mu_Presentation.pdf',
          prize: '2nd Place',
          idea: 'Predictive Maintenance for Factories',
        ),
      ],
    ),
  ];

  List<String> years = ['All', '2023', '2022', '2021', '2020'];
  List<String> months = [
    'All',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<String> batchYears = ['All', '2022', '2021', '2020', '2019'];
  String selectedYear = 'All';
  String selectedMonth = 'All';
  String selectedBatchYear = 'All';
  int _selectedIndex = 0;

  List<Hackathon> getFilteredHackathons() {
    return hackathons.where((hackathon) {
      bool matchesYear = selectedYear == 'All' || hackathon.year == selectedYear;
      bool matchesMonth = selectedMonth == 'All' || hackathon.month == selectedMonth;
      bool matchesBatchYear = selectedBatchYear == 'All' || hackathon.batchYear == selectedBatchYear;
      return matchesYear && matchesMonth && matchesBatchYear;
    }).toList();
  }

  // Navigation bar handling
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to Profile Page
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hackathons')),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/back.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content on top of the background
          Column(
            children: [
              Expanded(
                child: _selectedIndex == 0
                    ? buildHackathonContent()
                    : Center(child: Text('Other Tab Content')),
              ),
              SizedBox(height: 80), // SizedBox above the BottomNavigationBar
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Hackathons'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }



  // Hackathon page content
  Widget buildHackathonContent() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Filter dropdowns with labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Year', style: TextStyle(fontSize: 16,color: Colors.white)),
                    buildFilterDropdown(years, (value) {
                      setState(() {
                        selectedYear = value!;
                      });
                    }, selectedYear),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Month', style: TextStyle(fontSize: 16,color: Colors.white)),
                    buildFilterDropdown(months, (value) {
                      setState(() {
                        selectedMonth = value!;
                      });
                    }, selectedMonth),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Batch Year', style: TextStyle(fontSize: 16, color: Colors.white)),
                    buildFilterDropdown(batchYears, (value) {
                      setState(() {
                        selectedBatchYear = value!;
                      });
                    }, selectedBatchYear),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            // Hackathon List
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getFilteredHackathons().length,
                itemBuilder: (context, index) {
                  final hackathon = getFilteredHackathons()[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HackathonDetailsPage(hackathon: hackathon),
                        ),
                      );
                    },
                    child: Container(
                      width: 250, // Set a fixed width for each card
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // Rounded corners
                        ),
                        elevation: 4,
                        child: Stack( // Use Stack to overlay the image and content
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0), // Round corners
                                image: DecorationImage(
                                  image: AssetImage('assets/login.png'), // Background image for the card
                                  fit: BoxFit.cover, // Cover the entire card
                                ),
                              ),
                            ),
                            Container(
                              height: 150, // Set a fixed height for the card
                              padding: const EdgeInsets.all(10.0), // Padding for the content
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.black54, // Semi-transparent overlay for better readability
                              ),
                              child: Center( // Centering the content
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
                                  crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
                                  children: [
                                    Text(
                                      hackathon.name,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                      textAlign: TextAlign.center, // Center text
                                    ),
                                    SizedBox(height: 5),
                                    Text('Month: ${hackathon.month}', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
                                    Text('Year: ${hackathon.year}', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
                                    Text('Batch Year: ${hackathon.batchYear}', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );

  }

  DropdownButton<String> buildFilterDropdown(
      List<String> items,
      ValueChanged<String?> onChanged,
      String currentValue,
      ) {
    return DropdownButton<String>(
      value: currentValue,
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: TextStyle(color: Colors.black)),
        );
      }).toList(),
    );
  }
}


class HackathonDetailsPage extends StatefulWidget {
  final Hackathon hackathon;

  HackathonDetailsPage({required this.hackathon});

  @override
  _HackathonDetailsPageState createState() => _HackathonDetailsPageState();
}

class _HackathonDetailsPageState extends State<HackathonDetailsPage> {
  int _selectedIndex = 0;
  List<Team> _teams = [];
  File? _uploadedImage; // To hold the uploaded image
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _teams = widget.hackathon.teams;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HackathonPage()), // Navigate back to Hackathon Page
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to Profile Page
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()), // Navigate to Dashboard Page
      );
    }
  }

  Future<void> _showAddTeamDialog() async {
    String teamName = '';
    String presentation = '';
    String prize = '';
    String idea = '';

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Team Details'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'Team Name'),
                  onChanged: (value) {
                    teamName = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Presentation'),
                  onChanged: (value) {
                    presentation = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Prize'),
                  onChanged: (value) {
                    prize = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Idea'),
                  onChanged: (value) {
                    idea = value;
                  },
                ),
                SizedBox(height: 10),
                _uploadedImage != null
                    ? Image.file(_uploadedImage!, height: 100, width: 100)
                    : Text('No image selected'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                setState(() {
                  // Add the new team details
                  _teams.add(Team(
                    name: teamName,
                    presentation: presentation,
                    prize: prize,
                    idea: idea,
                  ));
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.hackathon.name)),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.png'), // Background image for the whole screen
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details for ${widget.hackathon.name}',
                style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _teams.length,
                  itemBuilder: (context, index) {
                    final team = _teams[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Rounded corners for the card
                      ),
                      elevation: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage('assets/dash.png'), // Background image for the card
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [

                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(team.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                    SizedBox(height: 5),
                                    Text('Presentation: ${team.presentation}', style: TextStyle(color: Colors.white)),
                                    Text('Prize: ${team.prize}', style: TextStyle(color: Colors.white)),
                                    Text('Idea: ${team.idea}', style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Hackathons'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTeamDialog,
        child: Icon(Icons.add),
        tooltip: 'Add Team',
      ),
    );
  }
}

