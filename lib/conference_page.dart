import 'package:flutter/material.dart';
import 'package:firebase_demo/dashboard_page.dart';

class Conference {
  final String name;
  final String month;
  final String year;
  final String batchYear;
  final List<Speaker> speakers;

  Conference({
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

class ConferencePage extends StatefulWidget {
  @override
  _ConferencePageState createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> {
  List<Conference> conferences = [
    Conference(
      name: 'Tech Innovation Conference 2023',
      month: 'February',
      year: '2023',
      batchYear: '2022',
      speakers: [
        Speaker(
          name: 'Dr. Alpha',
          presentation: 'Innovation_Trends.pdf',
          topic: 'Future of AI in Industry',
          experience: '15 years',
        ),
        Speaker(
          name: 'Prof. Beta',
          presentation: 'Tech_Future.pdf',
          topic: 'Technology in Education',
          experience: '10 years',
        ),
      ],
    ),
    Conference(
      name: 'Blockchain Conference 2022',
      month: 'April',
      year: '2022',
      batchYear: '2021',
      speakers: [
        Speaker(
          name: 'Dr. Gamma',
          presentation: 'Blockchain_Applications.pdf',
          topic: 'Blockchain in Government',
          experience: '12 years',
        ),
      ],
    ),
    // Additional conference entries can be added here
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

  List<Conference> getFilteredConferences() {
    return conferences.where((conference) {
      bool matchesYear = selectedYear == 'All' || conference.year == selectedYear;
      bool matchesMonth = selectedMonth == 'All' || conference.month == selectedMonth;
      bool matchesBatchYear = selectedBatchYear == 'All' || conference.batchYear == selectedBatchYear;
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
      appBar: AppBar(title: Text('Conferences')),
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
                    ? buildConferenceContent()
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
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Conferences'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Conference page content
  Widget buildConferenceContent() {
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
            // Conference List
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getFilteredConferences().length,
                itemBuilder: (context, index) {
                  final conference = getFilteredConferences()[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConferenceDetailsPage(conference: conference),
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
                                  image: AssetImage('assets/c_7.jpg'), // Background image for the card
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
                                      conference.name,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                      textAlign: TextAlign.center, // Center text
                                    ),
                                    SizedBox(height: 5),
                                    Text('Month: ${conference.month}', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
                                    Text('Year: ${conference.year}', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
                                    Text('Batch Year: ${conference.batchYear}', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
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

// Conference Details Page
class ConferenceDetailsPage extends StatefulWidget {
  final Conference conference;

  ConferenceDetailsPage({required this.conference});

  @override
  _ConferenceDetailsPageState createState() => _ConferenceDetailsPageState();
}

class _ConferenceDetailsPageState extends State<ConferenceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.conference.name)),
      body: ListView.builder(
        itemCount: widget.conference.speakers.length,
        itemBuilder: (context, index) {
          final speaker = widget.conference.speakers[index];
          return Card(
            child: ListTile(
              title: Text(speaker.name),
              subtitle: Text('Topic: ${speaker.topic}\nExperience: ${speaker.experience}'),
              trailing: Icon(Icons.picture_as_pdf),
              onTap: () {
                // Add your logic for PDF opening
              },
            ),
          );
        },
      ),
    );
  }
}
