part of 'epic_sitter.dart';

class _EpicSitterImpl implements EpicSitter {
  EpicFailure _undeterminedFailure = const _UndeterminedFailure();
  List<EpicPrint> _failurePrints = [];

  @override
  void setUndeterminedFailure(EpicFailure undeterminedFailure) {
    _undeterminedFailure = undeterminedFailure;
  }

  @override
  void registerFailurePrint(EpicPrint failurePrint) {
    _failurePrints.add(failurePrint);
  }

  @override
  void registerFailurePrints(List<EpicPrint> failurePrints) {
    _failurePrints.addAll(failurePrints);
  }

  @override
  EpicFailure checkOn(Object object, StackTrace stack) {
    for (EpicPrint failurePrint in _failurePrints)
      for (EpicCheck check in failurePrint.checks)
        if (object.runtimeType == check.type) {
          if (failurePrint?.onFailure != null) failurePrint.onFailure(check);

          return EpicFailure(
            priority: failurePrint.priority,
            checkpoint: check,
            name: failurePrint.name,
          );
        }

    return _undeterminedFailure;
  }
}

class _UndeterminedFailure<T> extends EpicFailure {
  const _UndeterminedFailure() : super(name: 'Undetermined Failure');
}
