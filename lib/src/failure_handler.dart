import 'package:epic_failure/epic_failure.dart';

part 'failure_handler_impl.dart';

abstract class FailureHandler {
  static FailureHandler _instance;

  /// Access to the instance of `EpicFailure`
  static FailureHandler get instance {
    _instance ??= _FailureHandlerImpl();
    return _instance;
  }

  /// Short form to access the instance of `EpicFailure`
  static FailureHandler get I => instance;

  /// Sets a default `Failure` that will be returned when there are no preset
  /// probabilities equivalent to the error thrown.
  void setUndeterminedFailure(Failure undeterminedFailure);

  /// Registers a single `FailurePrint` that will be checked for probabilities
  /// equivelant to the error passed into `encounteredFailure`.
  void registerFailurePrint(FailurePrint failurePrint);

  /// Similar to `registerFailurePrint()` but registers multiple at one time.
  void registerFailurePrints(List<FailurePrint> failurePrints);

  /// Call inside of a `try {} catch (e) {}` block and pass the exception or
  /// error into the function. It will return a `Failure` that was blueprinted
  /// by a `FailurePrint` object and had a probability equivelent to the passed
  /// object.
  Failure encounteredFailure(Object object);
}
