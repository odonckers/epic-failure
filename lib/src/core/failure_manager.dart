import 'package:epic_failure/epic_failure.dart';

part 'failure_manager_impl.dart';

abstract class FailureManager {
  static FailureManager _instance;

  /// Access to the singular instance of `FailureManager`
  static FailureManager get instance {
    _instance ??= _FailureManagerImpl();
    return _instance;
  }

  /// Short form to access the singular instance of `FailureManager`
  static FailureManager get I => instance;

  void setUndeterminedFailure(EpicFailure undeterminedFailure);
  void registerPredeterminedFailure(PredeterminedFailure predeterminedFailure);
  void registerPredeterminedFailures(
    List<PredeterminedFailure> predeterminedFailures,
  );
  EpicFailure generateEpicFailure(Object object, StackTrace stack);
}
