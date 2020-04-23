import 'package:epic_failure/epic_failure.dart';

enum FailurePriority {
  low,
  epic,
}

class KindaEvilError extends Error {}

class SuperThreatfulException {}

void main() {
  FailureManager.I.registerPredeterminedFailures([
    PredeterminedFailure<FailurePriority>(
      priority: FailurePriority.low,
      codes: const [
        FailureCode(100, runtimeType: KindaEvilError),
      ],
    ),
    PredeterminedFailure<FailurePriority>(
      priority: FailurePriority.epic,
      codes: const [
        FailureCode(200, runtimeType: SuperThreatfulException),
      ],
    ),
  ]);

  try {
    throw SuperThreatfulException();
  } catch (e, stack) {
    final epicFailure = FailureManager.I.generateEpicFailure(e, stack);
    print(epicFailure);
  }
}
