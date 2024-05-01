import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? user;
  late String _displayName;
  late String _email;
  late String _photoURL;
  final _firestore = FirebaseFirestore.instance;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _displayName = user?.displayName ?? '';
    _email = user?.email ?? '';
    _photoURL = user?.photoURL ?? '';
  }

  Future<void> _updateUserDetails() async {
    try {
      await _firestore.collection('users').doc(user!.uid).update({
        'displayName': _displayName,
        'email': _email,
        'photoURL': _photoURL,
      });
    } catch (e) {
      print('Error updating user details: $e');
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _photoURL = pickedFile.path;
      });
      _updateUserDetails();
    }
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _photoURL = pickedFile.path;
      });
      _updateUserDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey,
                  child: _photoURL.isNotEmpty
                      ? Image.file(File(_photoURL))
                      : user?.photoURL == null
                          ? Icon(Icons.person, size: 120, color: Colors.white)
                          : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt,
                          color: Colors.blueGrey.shade900),
                      onPressed: _getImageFromCamera,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.blueGrey.shade900),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Update Details'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _displayName = value;
                                      });
                                      _updateUserDetails();
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Display Name',
                                    ),
                                  ),
                                  TextField(
                                    // initialValue: _email,
                                    onChanged: (value) {
                                      setState(() {
                                        _email = value;
                                      });
                                      _updateUserDetails();
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Update'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _updateUserDetails();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.only(top: 16.0),
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.deepPurple),
                title: Text(_displayName,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            Card(
              margin: EdgeInsets.only(top: 16.0),
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.deepPurple),
                title: Text(_email,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImageFromGallery,
        tooltip: 'Pick Image',
        child: Icon(Icons.image),
      ),
    );
  }
}
