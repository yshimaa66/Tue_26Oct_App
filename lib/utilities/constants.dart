import 'package:cloud_firestore/cloud_firestore.dart';

const String appName = "Tue_26Oct App";
const String baseUrl = "https://api.quran.com/api/v4/";
const String audioBaseUrl = "https://download.quranicaudio.com/verses/";
final usersRef = FirebaseFirestore.instance.collection('users');
