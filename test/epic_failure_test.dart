import 'package:epic_failure/epic_failure.dart';
import 'package:test/test.dart';

void main() {
  test('did encounter failure', () {
    final failure = Failure(
      name: 'Random',
      priority: 5,
      probabilities: const [
        FailureProb(FormatException, code: 404),
      ],
      onFailure: (prob) {
        print(prob.code);
      },
    );
    FailureHolder.I.registerFailure(failure);

    try {
      throw FormatException();
    } catch (e) {
      expect(FailureHolder.I.encounteredFailure(e), failure);
    }
  });
}
