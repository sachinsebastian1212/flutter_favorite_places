import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_favorite_places/models/place.dart';
import 'package:flutter_favorite_places/providers/user_places.dart';
import 'package:flutter_favorite_places/widgets/image_input.dart';
import 'package:flutter_favorite_places/widgets/location_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  File? _selectedImage;
  final _titleController = TextEditingController();
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final enteredText = _titleController.text;

    if (enteredText.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredText, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 10),
            ImageInput(
              onPickedImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 16),
            LocationInput(
              onSelectLocation: (PlaceLocation location) {
                _selectedLocation = location;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace,
              label: const Text('Add place'),
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
