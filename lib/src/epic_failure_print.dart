part of epic_failure;

class EpicFailurePrint<T> extends Equatable {
  final String name;
  final T priority;
  final List<EpicFailureProb> probabilities;
  final OnFailureThrown onFailure;

  const EpicFailurePrint({
    this.name,
    @required this.priority,
    @required this.probabilities,
    this.onFailure,
  });

  @override
  List<Object> get props => [name, priority, probabilities, onFailure];
}
