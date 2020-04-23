# epic_failure

This package allows the developer to easily define priorities for failures, error codes for individual errors, and finally generate an easy to use `EpicFailure` for any need without redundent code.

## Purpose

Idealy this package surves two purposes:

1. Get rid of reduntent clutter code.
2. Hand exception and error recognition off to an outside source without losing control.
3. Overall speed up development time.

Dart has two basic types of failures, also known as exceptions and errors. Anytime the base code of an app is broken, some type of class extending `Exception` is thrown, and in the case there is user error, an `Error` is thrown. These are usually thrown inside of a `try {} catch {}` block that you created at somepoint inside of your core code. What you do with the caught `Error` or `Exception` is up to you and can make you write redundent code that you probably don't know what to do with. `epic_failure` will fill this unknown area.

## Usage

To use this plugin, add `epic_failure` as a dependency in your pubspec.yaml file as the following.

```yaml
dependencies:
  epic_failure:
    git: git@github.com:odonckers/epic_failure.git
```

At the beginning of your `main()` function you will need to register all predetermined failures, so instances that you know at somepoint may or may not happen, as a `PredeterminedFailure` in the `EpicHandler.instance` (or `EpicHandler.I` for short).

```dart
import 'package:epic_failure/epic_failure.dart';

enum FailurePriority {
  low,
  epic,
}

void main() {
  FailureManager.I.registerPredeterminedFailures([
    PredeterminedFailure<FailurePriority>(
      priority: FailurePriority.low,
      codes: const [
        FailureCode(100, runtimeType: WrongInputError),
      ],
    ),
    PredeterminedFailure<FailurePriority>(
      priority: FailurePriority.epic,
      codes: const [
        FailureCode(400, runtimeType: SuperScaryException),
        FailureCode(404, runtimeType: AnotherScaryException),
      ],
    ),
  ]);

  runApp(MyApp());
}
```

At this point you may be wondering, 'what in the world is the point of this?!' At the moment, nothing. Your code will not change at this point and any error will still result in the same outcome as before. But its where these codes are used that is important.

You have set up a directory of priorities and codes that will be run through and used to generate an appropriate `EpicFailure` that you can return or use in any way to better handle failures.

I would recommend that you use the [dartz](https://github.com/spebbe/dartz) package as it makes this development much easier and was kept in mind when creating `epic_failure`.

```dart
import 'package:dartz/dartz.dart' as dz;
import 'package:epic_failure/epic_failure.dart';

dz.Either<EpicFailure, String> hopefullyHelloWorld() {
  try {
    if (foo != bar) {
      throw SuperScaryException();
    }

    return dz.Right('Hello World!');
  } catch (e, stack) {
    /* Will generate something that looks like this:
       EpicFailure(
         priority: FailurePriority.epic,
         code: FailureCode(400, runtimeType: SuperScaryException),
       ) */
    final epicFailure = FailureManager.I.generateEpicFailure(e, stack);

    return dz.Left(epicFailure);
  }
}

hopefullyHelloWorld().fold(
  (EpicFailure epicFailure) => print('epic failure code ${epicFailure.code}'),
  (String helloWorld) => print(helloWorld),
);
```

Hopefully you will get `'Hello World!'` as the return, but if not you will get the priority of the failure, the code, and even the `runtimeType`.

Anytime there is a new `Exception` or `Error` that you as the developer expect to get, you can add that as a registered `PredeterminedFailure` to the `EpicHandler`.

## Disclaimer

This project is being actively worked on and much is to be added. All of the above code is working properly, but I do hope to add more in the comming months or more.
