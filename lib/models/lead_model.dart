import 'package:cloud_firestore/cloud_firestore.dart';

class Lead {
  final String id;
  final String offerUrl;
  final String comment;
  final dynamic likes;
  final String authorId;
  final Timestamp timestamp;
  final String fromDate;
  final String toDate;

  Lead({
    this.id,
    this.offerUrl,
    this.comment,
    this.likes,
    this.authorId,
    this.timestamp,
    this.fromDate,
    this.toDate,
  });

  factory Lead.fromDoc(DocumentSnapshot doc) {
    return Lead(
        id: doc.id,
        offerUrl: doc['imagepost'],
        comment: doc['caption'],
        likes: doc['likes'],
        authorId: doc['authorId'],
        timestamp: doc['timestamp'],
        fromDate: doc['name'],
        toDate: doc['description']);
  }
}
