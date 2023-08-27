import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'globals.dart' as globals;

void main() {
  runApp(const PictureStoryApp());
}

class PictureStoryApp extends StatelessWidget {
  const PictureStoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picture Story Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StoryLibraryScreen(),
    );
  }
}

class StoryLibraryScreen extends StatelessWidget {
  const StoryLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Library'),
      ),
      body: ListView.builder(
        itemCount: storyList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the story viewer screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StoryViewerScreen(story: storyList[index]),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    storyList[index].coverImage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    storyList[index].title,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class StoryViewerScreen extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  final Story story;

  StoryViewerScreen({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                GestureDetector(
                  onTap: () => speak("Where there is a will,there is a way!"),
                  child: Image.asset(
                    story.coverImage,
                    width: 400,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    story.content,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  // onPressed: () {
                  //   // Implement interactive elements or read-aloud functionality
                  // },

                  onPressed: () => speak(story.content),
                  child: const Text('Read Aloud'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Story {
  final String title;
  final String coverImage;
  final String content;

  Story({required this.title, required this.coverImage, required this.content});
}

// const String s;

// Dummy data
List<Story> storyList = [
  Story(
    title: 'A Thirsty Crow',
    coverImage: 'assets/bird3.png',
    content: globals.story1,
  ),
  Story(
    title: 'Lion and rat',
    coverImage: 'assets/download.png',
    content: globals.story2,
  ),
  // Add more stories here
];
