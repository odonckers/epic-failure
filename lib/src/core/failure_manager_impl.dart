part of 'failure_manager.dart';

class _FailureManagerImpl implements FailureManager {
  EpicFailure _undeterminedFailure = const _UndeterminedFailure();
  List<PredeterminedFailure> _predeterminedFailures = [];

  @override
  void setUndeterminedFailure(EpicFailure undeterminedFailure) {
    _undeterminedFailure = undeterminedFailure;
  }

  @override
  void registerPredeterminedFailure(PredeterminedFailure predeterminedFailure) {
    _predeterminedFailures.add(predeterminedFailure);
  }

  @override
  void registerPredeterminedFailures(
    List<PredeterminedFailure> predeterminedFailures,
  ) {
    _predeterminedFailures.addAll(predeterminedFailures);
  }

  @override
  EpicFailure generateEpicFailure(Object object, StackTrace stack) {
    for (PredeterminedFailure predeterminedFailure in _predeterminedFailures) {
      for (FailureCode failureCode in predeterminedFailure.codes) {
        if (object.runtimeType == failureCode.runtimeType) {
          if (predeterminedFailure?.onFailure != null) {
            predeterminedFailure.onFailure(failureCode);
          }

          return EpicFailure(
            priority: predeterminedFailure.priority,
            code: failureCode,
            name: predeterminedFailure.name,
          );
        }
      }
    }

    return _undeterminedFailure;
  }
}

class _UndeterminedFailure<T> extends EpicFailure {
  const _UndeterminedFailure() : super(name: 'Undetermined Failure');
}
