part of epic_failure;

class Failure extends Equatable {
  final String name;
  final int priority;
  final List<FailureProb> probabilities;
  final OnFailureThrown onFailure;

  const Failure({
    this.name,
    @required this.priority,
    @required this.probabilities,
    this.onFailure,
  });

  @override
  List<Object> get props => [name, priority, probabilities, onFailure];
}
