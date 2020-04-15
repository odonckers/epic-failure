part of 'epic_failure_handler.dart';

class _FailureHandlerImpl implements EpicFailureHandler {
  EpicFailure _undeterminedFailure = const _UndeterminedFailure();
  List<EpicFailurePrint> _failurePrints = [];

  @override
  void setUndeterminedFailure(EpicFailure undeterminedFailure) {
    _undeterminedFailure = undeterminedFailure;
  }

  @override
  void registerFailurePrint(EpicFailurePrint failurePrint) {
    _failurePrints.add(failurePrint);
  }

  @override
  void registerFailurePrints(List<EpicFailurePrint> failurePrints) {
    _failurePrints.addAll(failurePrints);
  }

  @override
  EpicFailure encounteredFailure(Object object) {
    for (EpicFailurePrint failurePrint in _failurePrints)
      for (EpicFailureProb prob in failurePrint.probabilities)
        if (object.runtimeType == prob.type) {
          if (failurePrint?.onFailure != null) failurePrint.onFailure(prob);

          return EpicFailure(
            name: failurePrint.name,
            priority: failurePrint.priority,
            probability: prob,
          );
        }

    return _undeterminedFailure;
  }
}

class _UndeterminedFailure<T> extends EpicFailure {
  const _UndeterminedFailure() : super(name: 'Undetermined Failure');
}
