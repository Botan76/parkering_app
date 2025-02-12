import '../models/person.dart';
import 'package:collection/collection.dart';

class PersonRepository {
  List<Person> persons = [];

  void add(Person person) {
    persons.add(person);
    print("Person added successfully.");
  }

  List<Person> getAll() => persons;

  Person? getById(String personalNumber) {
    return persons.firstWhereOrNull((p) => p.personalNumber == personalNumber);
  }

  void delete(String personalNumber) {
    persons.removeWhere((p) => p.personalNumber == personalNumber);
    print("Person deleted.");
  }
}
