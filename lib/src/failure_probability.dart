part of epic_failure;

class FailureProb extends Equatable {
  final Type type;
  final num code;
  final OnFailureThrown onFailure;

  const FailureProb(
    this.type, {
    @required this.code,
    this.onFailure,
  });

  @override
  List<Object> get props => [type, code, onFailure];
}
