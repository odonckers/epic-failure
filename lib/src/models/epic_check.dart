part of epic_failure;

class EpicCheck extends Equatable {
  final Type type;
  final num code;
  final String name;

  const EpicCheck(
    this.type, {
    @required this.code,
    this.name,
  });

  @override
  List<Object> get props => [type, code, name];
}
