import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repository/auth_repository.dart';

final loginStateProvider = StreamProvider((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});
