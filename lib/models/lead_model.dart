import 'package:cloud_firestore/cloud_firestore.dart';

class Lead {
  final String id;
  final String fromPlace;
  final String toPlace;
  final String comment;
  final String authorId;
  final String userName;
  final String userPhone;
  final Timestamp timestamp;
  final DateTime fromDate;
  final DateTime toDate;
  final String type;
  final String email;

  Lead(
      {this.id,
      this.fromPlace,
      this.toPlace,
      this.comment,
      this.authorId,
      this.timestamp,
      this.fromDate,
      this.toDate,
      this.type,
      this.userName,
      this.userPhone,
      this.email});

  factory Lead.fromDoc(DocumentSnapshot doc) {
    return Lead(
        id: doc.id,
        fromPlace: doc['fromPlace'],
        toPlace: doc['toPlace'],
        comment: doc['comment'],
        authorId: doc['authorId'],
        timestamp: doc['timestamp'],
        fromDate: doc['fromDate'],
        toDate: doc['toDate'],
        type: doc['type'],
        userName: doc['userName'],
        userPhone: doc['userPhone'],
        email: doc['email']);
  }
}
