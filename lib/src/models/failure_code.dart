part of epic_failure;

class FailureCode extends Equatable {
  final num number;
  final Type runtimeType;
  final String name;

  const FailureCode(
    this.number, {
    this.name,
    @required this.runtimeType,
  });

  @override
  List<Object> get props => [number, name, runtimeType];
}
