import 'package:epic_failure/epic_failure.dart';

part 'epic_sitter_impl.dart';

abstract class EpicSitter {
  static EpicSitter _instance;

  /// Access to the instance of `EpicSitter`
  static EpicSitter get instance {
    _instance ??= _EpicSitterImpl();
    return _instance;
  }

  /// Short form to access the instance of `EpicSitter`
  static EpicSitter get I => instance;

  /// Sets a default `EpicFailure` that will be returned when there are no
  /// preset probabilities equivalent to the error thrown.
  void setUndeterminedFailure(EpicFailure undeterminedFailure);

  /// Registers a single `EpicFailurePrint` that will be checked for
  /// probabilities equivelant to the error passed into `checkOn()`.
  void registerFailurePrint(EpicPrint failurePrint);

  /// Similar to `registerFailurePrint()` but registers multiple at one time.
  void registerFailurePrints(List<EpicPrint> failurePrints);

  /// Call inside of a `try {} catch (e) {}` block and pass the exception or
  /// error into the function. It will return a `EpicFailure` that was
  /// blueprinted by a `EpicFailurePrint` object and had a probability
  /// equivelent to the passed object.
  EpicFailure checkOn(Object object, StackTrace stack);
}
