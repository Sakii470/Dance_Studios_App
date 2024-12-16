// lib/DI/service_locator.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:mimiqit_app/presentation/bloc/dance_studio_bloc.dart';
import 'package:mimiqit_app/domain/i_dance_studio_repository.dart';
import 'package:mimiqit_app/data/repositories/dance_studio_repository_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Rejestracja FirebaseFirestore
  getIt.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance,
  );

  // Rejestracja Repozytorium
  getIt.registerLazySingleton<IDanceStudioRepository>(
        () => DanceStudioFirestoreRepository(firestore: getIt<FirebaseFirestore>()),
  );

  // Register BLoC
  getIt.registerFactory(() => DanceStudioBloc(repository: getIt<IDanceStudioRepository>()));
}
