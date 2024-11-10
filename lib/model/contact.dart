class Contact{
  int? id;
  String? name;
  String? phone;

  Contact({this.id, required this.name, required this.phone});
  factory Contact.fromMap(Map<String, dynamic> s)=>
      Contact(id: s['id'],name: s['name'],phone: s['phone']);
  Map<String, dynamic> toMap()=>{'id':id, 'name':name, 'phone':phone};
}