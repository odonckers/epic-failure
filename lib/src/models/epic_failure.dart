part of epic_failure;

class EpicFailure<T> extends Equatable {
  final T priority;
  final EpicCheck checkpoint;
  final String name;

  const EpicFailure({
    this.priority,
    this.checkpoint,
    this.name,
  });

  @override
  List<Object> get props => [priority, checkpoint, name];
}
