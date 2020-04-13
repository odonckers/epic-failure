part of 'failure_holder.dart';

class _FailureHolderImpl implements FailureHolder {
  Failure _undeterminedFailure = const _UndeterminedFailure();
  List<Failure> _failures = [];

  @override
  void setUndeterminedFailure(Failure undeterminedFailure) {
    _undeterminedFailure = undeterminedFailure;
  }

  @override
  void registerFailure(Failure failure) {
    _failures.add(failure);
  }

  @override
  void registerFailures(List<Failure> failures) {
    _failures.addAll(failures);
  }

  @override
  Failure encounteredFailure(Object object) {
    for (Failure failure in _failures)
      for (FailureProb prob in failure.probabilities)
        if (object.runtimeType == prob.type) {
          prob.onFailure(prob);
          failure.onFailure(prob);
          return failure;
        }

    return _undeterminedFailure;
  }
}

class _UndeterminedFailure extends Failure {
  const _UndeterminedFailure()
      : super(
          name: 'Undetermined Failure',
          priority: 0,
          probabilities: const [],
        );
}
