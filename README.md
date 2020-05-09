# AdDU Student Information System Node.js Library

A Dart library for accessing AdDU Student Information System (SIS) data. This library scrapes data using dio and the http HTML parser. No data is saved when using this library by itself.

## Getting Started

These instructions will get you the library up and running on your local machine for development and testing purposes

### Installing

Add this to your package's pubspec.yaml file:

```
dependencies:
  addu_sis: ^1.0.0
```

### Usage

Here is an example that:
1. initializes the SIS library
2. gets and prints user information
```dart
import 'package:addu_sis/addu_sis.dart';

Future<void> main() async {
  var sis = new SIS('username', 'password');
  var user = await sis.getUser();
  // user.card, user.id, user.name, user.course, user.section, user.division, user.year, user.status
}
```

Getting and printing the grades of the account

```
var grades = await sis.getGrades();

print(grades.all());

```

Getting and printing the balance of the account

```
var balance = await sis.getBalance();

print(balance.all());

```

Getting and printing the registration of the account

```
var registration = await sis.getRegistration();

print(registration.all());

```

Getting and printing all of the subjects in the curriculum of the account

```
var curriculum = await sis.getCurriculum();

print(curriculum.all());

```

Searching for currently available classes with class code 4-%

```
var search = await sis.searchClasses('4-%');

print(search);

```

## Testing

This package does not come with examples for testing yet.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/sonroyaalmerol/dart-addu-sis/tags). 

## Authors

* **Son Roy Almerol** - *Initial work* - [sonroyaalmerol](https://github.com/sonroyaalmerol)

See also the list of [contributors](https://github.com/sonroyaalmerol/dart-addu-sis/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* AdDU SIS ;)
* Hat tip to anyone whose code was used
* Inspiration
* etc
