import 'package:medai_try/model/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDbHelper{
  static Future<Database> initDb()async{
    var dbPath = await getDatabasesPath();
    String path = join(dbPath,'contact.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int varsion)async{
    final sql = '''   CREATE TABLE contact_tbl (id INTEGER PRIMARY KEY, name Text, phone Text)''';
    await db.execute(sql);
  }

  static Future<int> createContact(Contact contact)async{
    Database db = await MyDbHelper.initDb();
    return await db.insert('contact_tbl', contact.toMap());
  }

  static Future<List<Contact>> readContact()async{
    Database db= await MyDbHelper.initDb();
    var contact = await db.query('contact_tbl');
    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((e) => Contact.fromMap(e)).toList()
        :[];
    return contactList;
  }

}