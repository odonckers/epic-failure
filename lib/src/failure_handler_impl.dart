part of 'failure_handler.dart';

class _FailureHandlerImpl implements FailureHandler {
  Failure _undeterminedFailure = const _UndeterminedFailure();
  List<FailurePrint> _failurePrints = [];

  @override
  void setUndeterminedFailure(Failure undeterminedFailure) {
    _undeterminedFailure = undeterminedFailure;
  }

  @override
  void registerFailurePrint(FailurePrint failurePrint) {
    _failurePrints.add(failurePrint);
  }

  @override
  void registerFailurePrints(List<FailurePrint> failurePrints) {
    _failurePrints.addAll(failurePrints);
  }

  @override
  Failure encounteredFailure(Object object) {
    for (FailurePrint failurePrint in _failurePrints)
      for (FailureProb prob in failurePrint.probabilities)
        if (object.runtimeType == prob.type) {
          if (failurePrint?.onFailure != null) failurePrint.onFailure(prob);

          return Failure(
            name: failurePrint.name,
            priority: failurePrint.priority,
            probability: prob,
          );
        }

    return _undeterminedFailure;
  }
}

class _UndeterminedFailure<T> extends Failure {
  const _UndeterminedFailure() : super(name: 'Undetermined Failure');
}
