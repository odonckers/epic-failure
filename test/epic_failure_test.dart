import 'package:epic_failure/epic_failure.dart';
import 'package:test/test.dart';

enum _FailurePriority {
  low,
  medium,
  high,
}

void main() {
  test('did encounter failure', () {
    final failurePrint = EpicPrint<_FailurePriority>(
      priority: _FailurePriority.low,
      checks: const [
        EpicCheck(FormatException, code: 404),
      ],
    );
    EpicSitter.I.registerFailurePrint(failurePrint);

    try {
      throw FormatException();
    } catch (e, stack) {
      expect(
        EpicSitter.I.checkOn(e, stack),
        const EpicFailure(
          priority: _FailurePriority.low,
          checkpoint: EpicCheck(FormatException, code: 404),
        ),
      );
    }
  });
}
