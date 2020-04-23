import 'package:epic_failure/epic_failure.dart';
import 'package:test/test.dart';

enum FailurePriority {
  low,
  medium,
  high,
}

void main() {
  test('did encounter failure', () {
    const failureCode = FailureCode(404, runtimeType: FormatException);

    FailureManager.I.registerPredeterminedFailures([
      PredeterminedFailure<FailurePriority>(
        priority: FailurePriority.low,
        codes: const [failureCode],
      ),
    ]);

    try {
      throw FormatException();
    } catch (e, stack) {
      expect(
        FailureManager.I.generateEpicFailure(e, stack),
        const EpicFailure(priority: FailurePriority.low, code: failureCode),
      );
    }
  });
}
