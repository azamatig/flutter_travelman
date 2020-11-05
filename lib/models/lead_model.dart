import 'package:cloud_firestore/cloud_firestore.dart';

class Lead {
  final String id;
  final String fromPlace;
  final String toPlace;
  final String comment;
  final String authorId;
  final Timestamp timestamp;
  final DateTime fromDate;
  final DateTime toDate;
  final String type;

  Lead(
      {this.id,
      this.fromPlace,
      this.toPlace,
      this.comment,
      this.authorId,
      this.timestamp,
      this.fromDate,
      this.toDate,
      this.type});

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
        type: doc['type']);
  }
}
