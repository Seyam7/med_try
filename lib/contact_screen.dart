import 'package:flutter/material.dart';
import 'package:medai_try/database/detabase_helper.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> _contacts = [];

  @override
  void initState() {
    super.initState();
    _refreshContacts();
  }

  Future<void> _refreshContacts() async {
    final contacts = await _databaseHelper.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  Future<void> _addContact() async {
    if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
      await _databaseHelper.insertContact({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
      });
      _refreshContacts();
      nameController.clear();
      phoneController.clear();
      Navigator.pop(context);
    }
  }

  Future<void> openDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        "Add Contact",
        style: TextStyle(color: Colors.blue),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter name',
            ),
          ),
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: 'Enter contact number',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _addContact,
          child: const Text(
            'SUBMIT',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _contacts.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(_contacts[index]['name']),
                subtitle: Text(_contacts[index]['phone']),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}