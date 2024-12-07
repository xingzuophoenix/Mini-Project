import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(UploadScreenApp());

class UploadScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadScreen(),
    );
  }
}

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<XFile?> uploadedFiles = [null, null, null, null]; // Store uploaded files
  int uploadedCount = 0;

  final picker = ImagePicker();

  Future<void> _pickFile(int index) async {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Use Camera'),
            onTap: () async {
              final pickedFile =
                  await picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) _handleFileUpload(index, pickedFile);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from Gallery'),
            onTap: () async {
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) _handleFileUpload(index, pickedFile);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text('Choose Document (PDF)'),
            onTap: () async {
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery); // Simulate PDF
              if (pickedFile != null) _handleFileUpload(index, pickedFile);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _handleFileUpload(int index, XFile pickedFile) {
    setState(() {
      uploadedFiles[index] = pickedFile;
      uploadedCount = uploadedFiles.where((file) => file != null).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Upload Documents'),
      ),
      body: Column(
        children: [
          // Slider to show progress
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              value: uploadedCount / 4,
              color: Colors.green,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
          // Upload buttons
          Expanded(
            child: ListView(
              children: [
                _uploadButton('Profile Picture', 0),
                _uploadButton('Driving License', 1),
                _uploadButton('Certificate', 2),
                _uploadButton('Passport', 3),
              ],
            ),
          ),
          // Done Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: uploadedCount == 4
                  ? () {
                      // Navigate to next screen
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                primary: uploadedCount == 4 ? Colors.blue : Colors.grey,
              ),
              child: Text('Done'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _uploadButton(String label, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _pickFile(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: uploadedFiles[index] == null
                ? Text(label)
                : Image.file(
                    File(uploadedFiles[index]!.path),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}

import 'package:equatable/equatable.dart';

abstract class UploadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadDocumentsSubmitted extends UploadEvent {
  final String profilePicture;
  final String drivingLicense;
  final String certificate;
  final String passport;

  UploadDocumentsSubmitted({
    required this.profilePicture,
    required this.drivingLicense,
    required this.certificate,
    required this.passport,
  });

  @override
  List<Object> get props => [profilePicture, drivingLicense, certificate, passport];
}

import 'package:equatable/equatable.dart';

abstract class UploadState extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadInitial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadSuccess extends UploadState {}

class UploadFailure extends UploadState {
  final String error;

  UploadFailure(this.error);

  @override
  List<Object> get props => [error];
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'upload_event.dart';
import 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(UploadInitial()) {
    on<UploadDocumentsSubmitted>((event, emit) async {
      emit(UploadLoading());
      await Future.delayed(const Duration(seconds: 2)); // Simulate document upload
      if (event.profilePicture.isNotEmpty && event.drivingLicense.isNotEmpty) {
        emit(UploadSuccess());
      } else {
        emit(UploadFailure('All fields are required.'));
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/upload/upload_bloc.dart';
import 'blocs/upload/upload_event.dart';
import 'blocs/upload/upload_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => UploadBloc(),
        child: const UploadPage(),
      ),
    );
  }
}

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profilePictureController = TextEditingController();
    final drivingLicenseController = TextEditingController();
    final certificateController = TextEditingController();
    final passportController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Upload Documents', style: TextStyle(fontSize: 24)),
              TextField(
                controller: profilePictureController,
                decoration: const InputDecoration(labelText: 'Profile Picture URL'),
              ),
              TextField(
                controller: drivingLicenseController,
                decoration: const InputDecoration(labelText: 'Driving License URL'),
              ),
              TextField(
                controller: certificateController,
                decoration: const InputDecoration(labelText: 'Certificate URL'),
              ),
              TextField(
                controller: passportController,
                decoration: const InputDecoration(labelText: 'Passport URL'),
              ),
              const SizedBox(height: 16),
              BlocConsumer<UploadBloc, UploadState>(
                listener: (context, state) {
                  if (state is UploadSuccess) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Documents uploaded successfully')));
                  } else if (state is UploadFailure) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  if (state is UploadLoading) {
                    return const CircularProgressIndicator();
                  }

                  return ElevatedButton(
                    onPressed: () {
                      context.read<UploadBloc>().add(UploadDocumentsSubmitted(
                        profilePicture: profilePictureController.text,
                        drivingLicense: drivingLicenseController.text,
                        certificate: certificateController.text,
                        passport: passportController.text,
                      ));
                    },
                    child: const Text('Done'),
                  );
                },
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard'); // Skip Now button
                },
                child: const Text('Skip Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

