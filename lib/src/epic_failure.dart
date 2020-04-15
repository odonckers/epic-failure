part of epic_failure;

class EpicFailure<T> extends Equatable {
  final String name;
  final T priority;
  final EpicFailureProb probability;

  const EpicFailure({
    this.name,
    this.priority,
    this.probability,
  });

  @override
  List<Object> get props => [name, priority, probability];
}
