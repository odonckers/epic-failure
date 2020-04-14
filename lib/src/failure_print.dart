part of epic_failure;

class FailurePrint<T> extends Equatable {
  final String name;
  final T priority;
  final List<FailureProb> probabilities;
  final OnFailureThrown onFailure;

  const FailurePrint({
    this.name,
    @required this.priority,
    @required this.probabilities,
    this.onFailure,
  });

  @override
  List<Object> get props => [name, priority, probabilities, onFailure];
}
