import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet";
  int happinessLevel = 50;
  int hungerLevel = 50;
  int energyLevel = 50; // Added for Energy Bar Widget
  Color petColor = Colors.yellow; // Added for Dynamic Pet Color Change
  String mood = "Neutral"; // Added for Pet Mood Indicator
  Timer? hungerTimer;

  @override
  void initState() {
    super.initState();
    startHungerTimer(); // Added for Automatic Hunger Increase Over Time
  }

  void startHungerTimer() {
    hungerTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        hungerLevel = (hungerLevel + 5).clamp(0, 100);
        updateMoodAndColor();
      });
    });
  }

  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      hungerLevel = (hungerLevel + 5).clamp(0, 100);
      energyLevel =
          (energyLevel - 10).clamp(0, 100); // Added for Energy Bar Widget
      updateMoodAndColor();
    });
  }

  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      happinessLevel = (happinessLevel + 5).clamp(0, 100);
      updateMoodAndColor();
    });
  }

  void updateMoodAndColor() {
    if (happinessLevel > 70) {
      petColor = Colors.green;
      mood = "Happy ";
    } else if (happinessLevel >= 30) {
      petColor = Colors.yellow;
      mood = "Neutral ";
    } else {
      petColor = Colors.red;
      mood = "Unhappy ";
    }
  }

  void _setPetName(String name) {
    setState(() {
      petName = name;
    });
  }

  @override
  void dispose() {
    hungerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Enter Pet Name"),
              onSubmitted: _setPetName, // Added for Pet Name Customization
            ),
            SizedBox(height: 10.0),
            Text('Name: $petName', style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 10.0),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: petColor, // Added for Dynamic Pet Color Change
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 10.0),
            Text('Mood: $mood',
                style:
                    TextStyle(fontSize: 20.0)), // Added for Pet Mood Indicator
            Text('Happiness Level: $happinessLevel',
                style: TextStyle(fontSize: 20.0)),
            Text('Hunger Level: $hungerLevel',
                style: TextStyle(fontSize: 20.0)),
            Text('Energy Level: $energyLevel',
                style:
                    TextStyle(fontSize: 20.0)), // Added for Energy Bar Widget
            LinearProgressIndicator(
                value: energyLevel / 100), // Added for Energy Bar Widget
            SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: _playWithPet, child: Text('Play with Your Pet')),
            ElevatedButton(onPressed: _feedPet, child: Text('Feed Your Pet')),
          ],
        ),
      ),
    );
  }
}
