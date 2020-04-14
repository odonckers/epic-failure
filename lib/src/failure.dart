part of epic_failure;

class Failure<T> extends Equatable {
  final String name;
  final T priority;
  final FailureProb probability;

  const Failure({
    this.name,
    this.priority,
    this.probability,
  });

  @override
  List<Object> get props => [name, priority, probability];
}
