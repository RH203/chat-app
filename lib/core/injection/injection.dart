import 'package:chat_app/core/router/router.dart';
import 'package:chat_app/core/utils/helper_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerSingleton<HelperValidator>(HelperValidator());
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerFactory<FirebaseStorage>(() => FirebaseStorage.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
}
