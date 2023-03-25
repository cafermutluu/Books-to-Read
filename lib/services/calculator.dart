import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Calculator{

  /// Zaman bilgisini stringe çeviren method
  static String dateTimetoString(DateTime dateTime){

    String formattedDate = DateFormat("dd/MM/yyyy").format(dateTime);
    return formattedDate;}


  /// Datetime to timeStamp

  static Timestamp dateTimetoTimeStamp(DateTime dateTime){

    return Timestamp.fromDate(dateTime);
  }

  /// TimeStamp to Datetime

  static DateTime dateTimefromTimeStamp(Timestamp timestamp){
    return DateTime.fromMillisecondsSinceEpoch(timestamp.seconds*1000);
  }
}