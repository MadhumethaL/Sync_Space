import 'package:flutter/material.dart';
import 'package:firebase_demo/dashboard_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart'; // Import for image picking

class Symposium {
  final String name;
  final String month;
  final String year;
  final String batchYear;
  final List<Speaker> speakers;

  Symposium({
    required this.name,
    required this.month,
    required this.year,
    required this.batchYear,
    required this.speakers,
  });
}

class Speaker {
  final String name;
  final String presentation;
  final String topic;
  final String experience;

  Speaker({
    required this.name,
    required this.presentation,
    required this.topic,
    required this.experience,
  });
}

class SymposiumPage extends StatefulWidget {
  @override
  _SymposiumPageState createState() => _SymposiumPageState();
}

class _SymposiumPageState extends State<SymposiumPage> {
  List<Symposium> symposiums = [
    Symposium(
      name: 'AI & Tech Symposium 2023',
      month: 'January',
      year: '2023',
      batchYear: '2022',
      speakers: [
        Speaker(
          name: 'Dr. Alpha',
          presentation: 'AI_Trends.pdf',
          topic: 'AI in Healthcare',
          experience: '10 years',
        ),
        Speaker(
          name: 'Prof. Beta',
          presentation: 'Agriculture_AI.pdf',
          topic: 'AI in Agriculture',
          experience: '8 years',
        ),
      ],
    ),
    Symposium(
      name: 'Blockchain Innovation Symposium 2022',
      month: 'March',
      year: '2022',
      batchYear: '2021',
      speakers: [
        Speaker(
          name: 'Dr. Gamma',
          presentation: 'Blockchain_Technology.pdf',
          topic: 'Blockchain for Transparency',
          experience: '12 years',
        ),
      ],
    ),
    // Additional symposium entries
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

  List<Symposium> getFilteredSymposiums() {
    return symposiums.where((symposium) {
      bool matchesYear = selectedYear == 'All' || symposium.year == selectedYear;
      bool matchesMonth = selectedMonth == 'All' || symposium.month == selectedMonth;
      bool matchesBatchYear = selectedBatchYear == 'All' || symposium.batchYear == selectedBatchYear;
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
      appBar: AppBar(title: Text('Symposiums')),
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
                    ? buildSymposiumContent()
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
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Symposiums'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Symposium page content
  Widget buildSymposiumContent() {
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
                    Text('Year', style: TextStyle(fontSize: 16, color: Colors.white)),
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
                    Text('Month', style: TextStyle(fontSize: 16, color: Colors.white)),
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
            // Symposium List
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getFilteredSymposiums().length,
                itemBuilder: (context, index) {
                  final symposium = getFilteredSymposiums()[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SymposiumDetailsPage(symposium: symposium),
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
                                  image: AssetImage('assets/c_5.jpg'), // Background image for the card
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
                                      symposium.name,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                      textAlign: TextAlign.center, // Center text
                                    ),
                                    SizedBox(height: 5),
                                    Text('Month: ${symposium.month}', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
                                    Text('Year: ${symposium.year}', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
                                    Text('Batch Year: ${symposium.batchYear}', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
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

// Symposium Details Page
class SymposiumDetailsPage extends StatefulWidget {
  final Symposium symposium;

  SymposiumDetailsPage({required this.symposium});

  @override
  _SymposiumDetailsPageState createState() => _SymposiumDetailsPageState();
}

class _SymposiumDetailsPageState extends State<SymposiumDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.symposium.name)),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login.png'), // Use the same background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Symposium: ${widget.symposium.name}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white)),
                SizedBox(height: 16),
                Text('Year: ${widget.symposium.year}', style: TextStyle(fontSize: 18,color: Colors.white)),
                Text('Month: ${widget.symposium.month}', style: TextStyle(fontSize: 18,color: Colors.white)),
                Text('Batch Year: ${widget.symposium.batchYear}', style: TextStyle(fontSize: 18,color: Colors.white)),
                SizedBox(height: 24),
                Text('Speakers:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.symposium.speakers.length,
                    itemBuilder: (context, index) {
                      final speaker = widget.symposium.speakers[index];
                      return Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(speaker.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Presentation: ${speaker.presentation}'),
                              Text('Topic: ${speaker.topic}'),
                              Text('Experience: ${speaker.experience}'),
                            ],
                          ),
                          leading: Icon(Icons.person), // Icon for each speaker
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
