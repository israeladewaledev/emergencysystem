import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../sos/services/sos_service.dart';

final triageControllerProvider = StateNotifierProvider<TriageController, AsyncValue<void>>((ref) {
  return TriageController(ref.read(sosServiceProvider));
});

class TriageController extends StateNotifier<AsyncValue<void>> {
  final SOSService _sosService;

  TriageController(this._sosService) : super(const AsyncValue.data(null));

  Future<void> submitAlert({
    required String category,
    required String severity,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _sosService.triggerSOS(
        category: category,
        severity: severity,
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
