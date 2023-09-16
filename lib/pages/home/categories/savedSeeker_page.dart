import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/variables.dart';

List<String> bookmarkedJobs = [];
class SavedSeeker extends StatefulWidget {
  const SavedSeeker({super.key});

  @override
  State<SavedSeeker> createState() => _SavedSeekerState();
}

void updateIsBookmarked(CollectionReference jobsRef, List<String> isBookmarked) {
  jobsRef.get().then((QuerySnapshot) {
    print("MASUK JOBREF QUERY SNAPSHOT");
    if(QuerySnapshot.docs.isNotEmpty) {
      WriteBatch batch = fsdb.batch();

      for(QueryDocumentSnapshot docSnapshot in QuerySnapshot.docs) {

        List<dynamic> isBookmarkedList = docSnapshot.data()?['isBookmarked'] ?? [];

        // Add elements to the 'isBookmarked' array if they are not already present
        for (String element in isBookmarkedList) {
          if (!isBookmarked.contains(element)) {
            isBookmarked.add(element);
          }
        }

        batch.update(docSnapshot.reference, {
          'isBookmarked': isBookmarked,
        });

        batch.commit().then((_) {
          print("Updated 'isBookmarked' for all jobs");
        })
          .catchError((error) {
            print("ERROR UPDATING $error");
          });
      }
    }
  });
}

class _SavedSeekerState extends State<SavedSeeker> {

  final bookmarkedJobRef = fsdb.collection('Jobs');
  


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: titleJobCardColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(bookmarkedJobs.toString()),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  if (!bookmarkedJobs.contains(auth.currentUser!.uid)) {
                    bookmarkedJobs.add(auth.currentUser!.uid);
                  }
                  updateIsBookmarked(bookmarkedJobRef, bookmarkedJobs);
                  print(bookmarkedJobs);
                },
                child: Text("Update me"),
              )
            ]
          )
        )
      )
    );
  }
}