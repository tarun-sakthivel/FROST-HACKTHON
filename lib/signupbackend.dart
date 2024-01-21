import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseFirestore firestore = FirebaseFirestore.instance;
late User? user;
late String? email;
final _auth= FirebaseAuth.instance;





void addusername(String name){
  firestore.collection("usernames").add({
    "name":name
                          
                                                  });
}

void checkuserduplicate(String newusername){
  List <String> checklist=[];
  CollectionReference messagesCollection = firestore.collection('usernames');
  Stream<QuerySnapshot> messagesStream =  messagesCollection.snapshots();

  messagesStream.listen((datasnapshot)=> {
    for (var data in datasnapshot.docs ){
      if ((data['usernames'] as String).toLowerCase() == newusername.toLowerCase()){
        print(data["usernames"]),
        checklist.add(data['usernames']),
        }}});

}
