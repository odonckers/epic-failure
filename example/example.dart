import 'package:epic_failure/epic_failure.dart';

enum FailurePriority {
  low,
  epic,
}

class KindaEvilError extends Error {}

class SuperThreatfulException {}

void main() {
  FailureManager.I
    ..register(
      priority: FailurePriority.low,
      codes: const [
        FailureCode(100, runtimeType: FormatException),
        FailureCode(101, runtimeType: KindaEvilError),
      ],
    )
    ..register(
      priority: FailurePriority.epic,
      codes: const [
        FailureCode(200, runtimeType: SuperThreatfulException),
      ],
    );

  try {
    throw SuperThreatfulException();
  } catch (e, stack) {
    final epicFailure =
        FailureManager.I.generateEpicFailure<FailurePriority>(e, stack);
    print(epicFailure);
  }
}
