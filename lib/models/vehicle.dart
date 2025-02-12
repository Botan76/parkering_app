import 'person.dart';

class Vehicle {
  String registrationNumber;
  String type;
  Person owner;

  Vehicle(
      {required this.registrationNumber,
      required this.type,
      required this.owner});

  @override
  String toString() {
    return 'Vehicle: RegNo = $registrationNumber, Type = $type, Owner = ${owner.name}';
  }
}
