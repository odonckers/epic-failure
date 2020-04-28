part of 'failure_manager.dart';

class _FailureManagerImpl implements FailureManager {
  EpicFailure _undeterminedFailure = const _UndeterminedFailure();
  List<_PredeterminedFailure> _predeterminedFailures = [];

  @override
  EpicFailure get undeterminedFailure => _undeterminedFailure;

  @override
  List<_PredeterminedFailure> get predeterminedFailures =>
      _predeterminedFailures;

  @override
  void setUndeterminedFailure<T>(EpicFailure<T> undeterminedFailure) {
    _undeterminedFailure = undeterminedFailure;
  }

  @override
  void register<T>({
    @required T priority,
    @required List<FailureCode> codes,
    String name,
    String message,
    OnFailureThrown onFailure,
  }) {
    final predeterminedFailure = _PredeterminedFailure<T>(
      priority: priority,
      codes: codes,
      name: name,
      message: message,
      onFailure: onFailure,
    );
    _predeterminedFailures.add(predeterminedFailure);
  }

  @override
  EpicFailure<T> generateEpicFailure<T>(Object object, StackTrace stack) {
    for (_PredeterminedFailure predeterminedFailure in _predeterminedFailures) {
      for (FailureCode failureCode in predeterminedFailure.codes) {
        if (object.runtimeType == failureCode.runtimeType) {
          if (predeterminedFailure?.onFailure != null) {
            predeterminedFailure.onFailure(failureCode);
          }

          return EpicFailure<T>(
            priority: predeterminedFailure.priority,
            code: failureCode,
            name: predeterminedFailure.name,
            message: predeterminedFailure.message,
          );
        }
      }
    }

    return _undeterminedFailure;
  }
}

class _PredeterminedFailure<T> extends Equatable {
  const _PredeterminedFailure({
    @required this.priority,
    @required this.codes,
    this.name,
    this.message,
    this.onFailure,
  });

  final T priority;
  final List<FailureCode> codes;
  final String name;
  final String message;
  final OnFailureThrown onFailure;

  @override
  List<Object> get props => [priority, codes, name, message, onFailure];
}

class _UndeterminedFailure extends EpicFailure {
  const _UndeterminedFailure() : super(name: 'Undetermined Failure');
}
