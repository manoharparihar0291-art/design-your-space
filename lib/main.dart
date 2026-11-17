import 'package:flutter/material.dart';

void main() {
  runApp(const DesignYourSpaceApp());
}

class DesignYourSpaceApp extends StatelessWidget {
  const DesignYourSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Design Your Space',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9A7658),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF7F2),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Design Your Space',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFAF7F2),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AI Interiors, Made Personal',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Transform your room into a space you love.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE2D5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.chair_alt, size: 45),
                  const SizedBox(height: 12),
                  const Text(
                    'Transform a Room',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Give your room a fresh new look.'),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Photo upload coming soon!'),
                        ),
                      );
                    },
                    child: const Text('Get Started'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Explore Ideas',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            const RoomCard(icon: Icons.weekend, title: 'Living Room'),
            const RoomCard(icon: Icons.bed, title: 'Bedroom'),
            const RoomCard(icon: Icons.kitchen, title: 'Kitchen'),
            const RoomCard(icon: Icons.desk, title: 'Workspace'),
            const SizedBox(height: 20),
            const Text(
              'Your Projects',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Your saved designs will appear here.'),
          ],
        ),
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const RoomCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, size: 30),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
