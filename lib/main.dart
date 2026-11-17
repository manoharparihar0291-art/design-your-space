
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      home: const DesignHome(),
    );
  }
}

class DesignHome extends StatefulWidget {
  const DesignHome({super.key});

  @override
  State<DesignHome> createState() => _DesignHomeState();
}

class _DesignHomeState extends State<DesignHome> {
  final ImagePicker picker = ImagePicker();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController customStyleController =
      TextEditingController();

  File? selectedImage;

  String designType = 'Interior';
  String selectedRoom = 'Living Room';
  String selectedStyle = 'Modern';
  String areaUnit = 'sq ft';

  final List<String> styles = [
    'Modern',
    'Traditional',
    'Minimalist',
    'Luxury',
    'Contemporary',
    'Scandinavian',
    'Industrial',
    'Bohemian',
    'Indian Heritage',
    'Rustic',
    'Japandi',
    'Art Deco',
    'Coastal',
    'Classic',
    'Custom',
  ];

  final List<String> interiorRooms = [
    'Living Room',
    'Bedroom',
    'Kitchen',
    'Bathroom',
    'Dining Room',
    'Office',
    'Kids Room',
    'Study Room',
    'Hallway',
    'Full House',
    'Shop',
    'Restaurant',
  ];

  final List<String> exteriorRooms = [
    'Front Elevation',
    'House Exterior',
    'Garden',
    'Balcony',
    'Terrace',
    'Swimming Pool',
    'Outdoor Seating',
    'Boundary Wall',
    'Full Property',
  ];

  double get areaInSqFt {
    final value = double.tryParse(areaController.text) ?? 0;
    if (areaUnit == 'sq m') return value * 10.7639;
    if (areaUnit == 'sq yd') return value * 9;
    return value;
  }

  int get estimatedCost {
    final rate = designType == 'Interior' ? 1200 : 900;
    return (areaInSqFt * rate).round();
  }

  Future<void> choosePhoto(ImageSource source) async {
    try {
      final photo = await picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (photo != null) {
        setState(() {
          selectedImage = File(photo.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Photo select nahi ho payi.')),
      );
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget optionChip(
    String value,
    String selected,
    Function(String) onSelected,
  ) {
    return ChoiceChip(
      label: Text(value),
      selected: selected == value,
      onSelected: (_) => onSelected(value),
    );
  }

  @override
  void dispose() {
    areaController.dispose();
    customStyleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rooms = designType == 'Interior'
        ? interiorRooms
        : exteriorRooms;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Design Your Space',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFAF7F2),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AI Interiors & Exteriors, Made Personal',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Create a space that feels like you.',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),

            sectionTitle('1. Choose Design Type'),
            Wrap(
              spacing: 10,
              children: [
                optionChip('Interior', designType, (value) {
                  setState(() {
                    designType = value;
                    selectedRoom = interiorRooms.first;
                  });
                }),
                optionChip('Exterior', designType, (value) {
                  setState(() {
                    designType = value;
                    selectedRoom = exteriorRooms.first;
                  });
                }),
              ],
            ),

            sectionTitle('2. Choose Room / Area'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: rooms.map((room) {
                return optionChip(room, selectedRoom, (value) {
                  setState(() => selectedRoom = value);
                });
              }).toList(),
            ),

            sectionTitle('3. Upload Your Photo'),
            const Text(
              'Choose a photo from your gallery or take a new photo.',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => choosePhoto(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => choosePhoto(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                  ),
                ),
              ],
            ),

            if (selectedImage != null) ...[
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  selectedImage!,
                  width: double.infinity,
                  height: 230,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() => selectedImage = null);
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text('Remove Photo'),
              ),
            ],

            sectionTitle('4. Choose Your Design Style'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: styles.map((style) {
                return optionChip(style, selectedStyle, (value) {
                  setState(() => selectedStyle = value);
                });
              }).toList(),
            ),

            if (selectedStyle == 'Custom') ...[
              const SizedBox(height: 14),
              TextField(
                controller: customStyleController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Describe your custom style',
                  hintText:
                      'Example: Modern Indian design with warm wooden furniture...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],

            sectionTitle('5. Enter Area Measurement'),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: areaController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'Area',
                      hintText: 'Example: 500',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: areaUnit,
                    decoration: const InputDecoration(
                      labelText: 'Unit',
                      border: OutlineInputBorder(),
                    ),
                    items: ['sq ft', 'sq m', 'sq yd'].map((unit) {
                      return DropdownMenuItem(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => areaUnit = value);
                      }
                    },
                  ),
                ),
              ],
            ),

            sectionTitle('6. Estimated Renovation Budget'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE2D5),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Approximate estimated cost'),
                  const SizedBox(height: 8),
                  Text(
                    areaInSqFt > 0
                        ? '₹${estimatedCost.toString()}'
                        : 'Enter area to calculate',
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Demo estimate only. Actual cost depends on '
                    'materials, labour, location and design choices.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: () {
                  if (selectedImage == null) {
                    showMessage('Please upload a room photo first.');
                    return;
                  }

                  if (areaInSqFt <= 0) {
                    showMessage('Please enter the area.');
                    return;
                  }

                  if (selectedStyle == 'Custom' &&
                      customStyleController.text.trim().isEmpty) {
                    showMessage('Please describe your custom style.');
                    return;
                  }

                  showMessage(
                    'Your design details are ready. AI service '
                    'connection is the next step.',
                  );
                },
                icon: const Icon(Icons.auto_awesome),
                label: const Text(
                  'Prepare My Design',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),

            const SizedBox(height: 25),
            const Center(
              child: Text(
                'Design Your Space',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
