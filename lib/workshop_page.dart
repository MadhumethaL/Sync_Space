import 'package:flutter/material.dart';
import 'package:firebase_demo/dashboard_page.dart';

class Workshop {
  final String name;
  final String month;
  final String year;
  final String batchYear;
  final List<Speaker> speakers;

  Workshop({
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

class WorkshopPage extends StatefulWidget {
  @override
  _WorkshopPageState createState() => _WorkshopPageState();
}

class _WorkshopPageState extends State<WorkshopPage> {
  List<Workshop> workshops = [
    Workshop(
      name: 'AI Workshop 2023',
      month: 'February',
      year: '2023',
      batchYear: '2022',
      speakers: [
        Speaker(
          name: 'Dr. Alpha',
          presentation: 'AI_Trends.pdf',
          topic: 'AI and Industry',
          experience: '15 years',
        ),
        Speaker(
          name: 'Prof. Beta',
          presentation: 'Future_of_AI.pdf',
          topic: 'AI in Education',
          experience: '10 years',
        ),
      ],
    ),
    Workshop(
      name: 'Blockchain Workshop 2022',
      month: 'April',
      year: '2022',
      batchYear: '2021',
      speakers: [
        Speaker(
          name: 'Dr. Gamma',
          presentation: 'Blockchain_Use_Cases.pdf',
          topic: 'Blockchain in Government',
          experience: '12 years',
        ),
      ],
    ),
    // Additional workshop entries can be added here
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

  List<Workshop> getFilteredWorkshops() {
    return workshops.where((workshop) {
      bool matchesYear = selectedYear == 'All' || workshop.year == selectedYear;
      bool matchesMonth = selectedMonth == 'All' || workshop.month == selectedMonth;
      bool matchesBatchYear = selectedBatchYear == 'All' || workshop.batchYear == selectedBatchYear;
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
      appBar: AppBar(title: Text('Workshops')),
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
                    ? buildWorkshopContent()
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
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Workshops'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Workshop page content
  Widget buildWorkshopContent() {
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
            // Workshop List
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getFilteredWorkshops().length,
                itemBuilder: (context, index) {
                  final workshop = getFilteredWorkshops()[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkshopDetailsPage(workshop: workshop),
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
                                  image: AssetImage('assets/c-8.jpg'), // Background image for the card
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
                                      workshop.name,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                      textAlign: TextAlign.center, // Center text
                                    ),
                                    SizedBox(height: 5),
                                    Text('Month: ${workshop.month}', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
                                    Text('Year: ${workshop.year}', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
                                    Text('Batch Year: ${workshop.batchYear}', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
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

// Workshop Details Page
class WorkshopDetailsPage extends StatefulWidget {
  final Workshop workshop;

  WorkshopDetailsPage({required this.workshop});

  @override
  _WorkshopDetailsPageState createState() => _WorkshopDetailsPageState();
}

class _WorkshopDetailsPageState extends State<WorkshopDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.workshop.name)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Month: ${widget.workshop.month}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Year: ${widget.workshop.year}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Batch Year: ${widget.workshop.batchYear}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Speakers:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: widget.workshop.speakers.length,
                itemBuilder: (context, index) {
                  final speaker = widget.workshop.speakers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${speaker.name}', style: TextStyle(fontSize: 16)),
                        Text('Topic: ${speaker.topic}', style: TextStyle(fontSize: 16)),
                        Text('Presentation: ${speaker.presentation}', style: TextStyle(fontSize: 16)),
                        Text('Experience: ${speaker.experience}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10),
                      ],
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
}
