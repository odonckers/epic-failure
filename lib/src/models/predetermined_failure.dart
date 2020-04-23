part of epic_failure;

class PredeterminedFailure<T> extends Equatable {
  final T priority;
  final List<FailureCode> codes;
  final String name;
  final OnFailureThrown onFailure;

  const PredeterminedFailure({
    @required this.priority,
    @required this.codes,
    this.name,
    this.onFailure,
  });

  @override
  List<Object> get props => [priority, codes, name, onFailure];
}
