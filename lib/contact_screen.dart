import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController nameController= TextEditingController();
  TextEditingController phnController= TextEditingController();

  //List _contact=['ban','nepal','india'];
  Box? _contactBox;
  @override
  void initState() {
    _contactBox = Hive.box('contactBox');
    super.initState();
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Add Contact",style: TextStyle(color: Colors.blue),),
          content: Column(
            children: [
              TextFormField(
                controller: nameController,
                autofocus: true,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Enter name',
                ),
              ),
              TextFormField(
                controller: phnController,
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter contact number',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: (){
              final contactName= nameController.text;
              _contactBox!.add(contactName);
              final contactPhn= phnController.text;
              //_contactBox!.add(contactName);
            },
              child: Text('SUBMIT',style: TextStyle(color: Colors.blue),),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
            valueListenable: Hive.box('contactBox').listenable(),
            builder: (context,box,widget)=> ListView.builder(
                itemCount: _contactBox!.keys.toList().length,
                itemBuilder: (context,index){
                  return Card(
                    child: ListTile(
                      title: Text(_contactBox!.getAt(index).toString()),
                      //trailing: Text(_contactBox!.getAt(index).toString()),
                      //trailing: IconButton(onPressed: (){box.clear();}, icon: Icon(Icons.delete)),
                    ),
                  );
                },
              )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('floating button pressed');
          openDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
