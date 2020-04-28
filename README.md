# epic_failure

Allows the developer to easily define priorities for failures, error codes for individual errors, and finally generate an easy to use `EpicFailure` for any need without redundant code.

## Purpose

Ideally this package serves three purposes:

1. Get rid of redundant clutter code.
2. Hand exception and error recognition off to an outside source without losing control.
3. Overall speed up development time.

Dart has two basic types of failures, also known as exceptions and errors. Anytime the base code of an app is broken, some type of class extending `Exception` is thrown, and in the case there is user error, an `Error` is thrown. These are usually thrown inside of a `try {} catch {}` block that you created at some point inside of your core code. What you do with the caught `Error` or `Exception` is up to you and can make you write redundant code that you probably don't know what to do with. `epic_failure` will fill this unknown area.

## Usage

To use this plugin, add `epic_failure` as a dependency in your pubspec.yaml file as the following.

```yaml
dependencies:
  epic_failure: ^[current version]
```

At the beginning of your `main()` function you will need to register all predetermined failures, so instances that you know at some point may or may not happen, in the `FailureManager.instance` (or `FailureManager.I` for short).

```dart
import 'package:epic_failure/epic_failure.dart';

enum FailurePriority {
  low,
  high,
  epic,
}

void main() {
  FailureManager.I
    ..register<FailurePriority>(
      priority: FailurePriority.low,
      codes: const [
        FailureCode(100, runtimeType: WrongInputError),
      ],
    )
    ..register<FailurePriority>(
      priority: FailurePriority.high,
      codes: const [
        FailureCode(400, runtimeType: SuperScaryException),
        FailureCode(404, runtimeType: AnotherScaryException),
      ],
    );

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
    /// Will generate something that looks like this:
    ///
    /// ```dart
    /// EpicFailure<FailurePriority>(
    ///   priority: FailurePriority.high,
    ///   code: FailureCode(400, runtimeType: SuperScaryException),
    /// )
    /// ```
    final epicFailure = FailureManager.I.generateEpicFailure<FailurePriority>(e, stack);

    return dz.Left(epicFailure);
  }
}

hopefullyHelloWorld().fold(
  (EpicFailure epicFailure) => print('epic failure code ${epicFailure.code}'),
  (String helloWorld) => print(helloWorld),
);
```

Hopefully you will get `'Hello World!'` as the return, but if not you will get the priority of the failure, the code, and even the `runtimeType`.

Anytime there is a new `Exception` or `Error` that you as the developer expect to get, you can add that as a registered `PredeterminedFailure` to the `FailureManager`. But what if there is a type thrown that you don't have `PredeterminedFailure` for? You can set the undetermined failure by using the function, `FailureManager.I.setUndeterminedFailure`. This lets you pass in your own custom `EpicFailure` that will be returned if nothing you preset is found.

```dart
import 'package:epic_failure/epic_failure.dart';

static const undeterminedFailure = EpicFailure(
  priority: FailurePriority.epic,
  name: 'undetermined failure',
);

FailureHandler.I.setUndeterminedFailure(undeterminedFailure);
```

And that is the grand tour of `epic_failure`!

## Disclaimer

This project is being actively worked on and much is to be added. All of the above code is working properly, but I do hope to add more in the coming months or more.
