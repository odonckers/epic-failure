import 'package:epic_failure/epic_failure.dart';
import 'package:test/test.dart';

enum _FailurePriority {
  low,
  medium,
  high,
}

void main() {
  test('did encounter failure', () {
    final failurePrint = FailurePrint<_FailurePriority>(
      priority: _FailurePriority.low,
      probabilities: const [
        FailureProb(FormatException, code: 404),
      ],
    );
    FailureHandler.I.registerFailurePrint(failurePrint);

    try {
      throw FormatException();
    } catch (e) {
      print(FailureHandler.I.encounteredFailure(e));
      expect(
        FailureHandler.I.encounteredFailure(e),
        const Failure(
          priority: _FailurePriority.low,
          probability: FailureProb(FormatException, code: 404),
        ),
      );
    }
  });
}
