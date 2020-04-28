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

    FailureManager.I.register<FailurePriority>(
      priority: FailurePriority.low,
      codes: [failureCode],
    );

    try {
      throw const FormatException();
    } catch (e, stack) {
      expect(
        FailureManager.I.generateEpicFailure<FailurePriority>(e, stack),
        const EpicFailure(priority: FailurePriority.low, code: failureCode),
      );
    }
  });
}
