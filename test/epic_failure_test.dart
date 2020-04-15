import 'package:epic_failure/epic_failure.dart';
import 'package:test/test.dart';

enum _FailurePriority {
  low,
  medium,
  high,
}

void main() {
  test('did encounter failure', () {
    final failurePrint = EpicFailurePrint<_FailurePriority>(
      priority: _FailurePriority.low,
      probabilities: const [
        EpicFailureProb(FormatException, code: 404),
      ],
    );
    EpicFailureHandler.I.registerFailurePrint(failurePrint);

    try {
      throw FormatException();
    } catch (e) {
      print(EpicFailureHandler.I.encounteredFailure(e));
      expect(
        EpicFailureHandler.I.encounteredFailure(e),
        const EpicFailure(
          priority: _FailurePriority.low,
          probability: EpicFailureProb(FormatException, code: 404),
        ),
      );
    }
  });
}
