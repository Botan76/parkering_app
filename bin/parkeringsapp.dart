import 'dart:io';
import 'package:parkeringsapp/models/person.dart';
import 'package:parkeringsapp/models/vehicle.dart';
import 'package:parkeringsapp/models/parking_space.dart';
import 'package:parkeringsapp/models/parking.dart';
import 'package:parkeringsapp/repositories/person_repository.dart';
import 'package:parkeringsapp/repositories/vehicle_repository.dart';
import 'package:parkeringsapp/repositories/parking_space_repository.dart';
import 'package:parkeringsapp/repositories/parking_repository.dart';

void main() {
  var personRepo = PersonRepository();
  var vehicleRepo = VehicleRepository();
  var spaceRepo = ParkingSpaceRepository();
  var parkingRepo = ParkingRepository();

  while (true) {
    print("\n--- Parking System CLI ---");
    print("1. Manage Persons");
    print("2. Manage Vehicles");
    print("3. Manage Parking Spaces");
    print("4. Manage Parkings");
    print("5. Exit");
    stdout.write("Enter your choice: ");
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        managePersons(personRepo);
        break;
      case '2':
        manageVehicles(vehicleRepo, personRepo);
        break;
      case '3':
        manageParkingSpaces(spaceRepo);
        break;
      case '4':
        manageParkings(parkingRepo, vehicleRepo, spaceRepo);
        break;
      case '5':
        exit(0);
      default:
        print("Invalid choice. Try again.");
    }
  }
}

void managePersons(PersonRepository repo) {
  stdout.write("Enter name: ");
  var name = stdin.readLineSync();
  stdout.write("Enter personal number: ");
  var personalNumber = stdin.readLineSync();

  if (name != null && personalNumber != null) {
    repo.add(Person(name: name, personalNumber: personalNumber));
  }
}

void manageVehicles(VehicleRepository repo, PersonRepository personRepo) {
  stdout.write("Enter registration number: ");
  var regNumber = stdin.readLineSync();
  stdout.write("Enter vehicle type: ");
  var type = stdin.readLineSync();
  stdout.write("Enter owner's personal number: ");
  var ownerPN = stdin.readLineSync();

  var owner = personRepo.getById(ownerPN!);
  if (owner != null && regNumber != null && type != null) {
    repo.add(Vehicle(registrationNumber: regNumber, type: type, owner: owner));
  } else {
    print("Owner not found.");
  }
}

void manageParkingSpaces(ParkingSpaceRepository repo) {
  while (true) {
    print("\n--- Manage Parking Spaces ---");
    print("1. Add Parking Space");
    print("2. View All Parking Spaces");
    print("3. Delete Parking Space");
    print("4. Go Back");
    stdout.write("Enter your choice: ");
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write("Enter Parking Space ID: ");
        var id = int.tryParse(stdin.readLineSync() ?? '');
        stdout.write("Enter Address: ");
        var address = stdin.readLineSync();
        stdout.write("Enter Price per Hour: ");
        var price = double.tryParse(stdin.readLineSync() ?? '');

        if (id != null && address != null && price != null) {
          repo.add(ParkingSpace(id: id, address: address, pricePerHour: price));
          print("Parking space added successfully.");
        } else {
          print("Invalid input. Try again.");
        }
        break;

      case '2':
        print("\nList of Parking Spaces:");
        for (var space in repo.getAll()) {
          print(space);
        }
        break;

      case '3':
        stdout.write("Enter Parking Space ID to delete: ");
        var id = int.tryParse(stdin.readLineSync() ?? '');
        if (id != null) {
          repo.delete(id);
          print("Parking space deleted.");
        } else {
          print("Invalid input.");
        }
        break;

      case '4':
        return; // Go back to the main menu
      default:
        print("Invalid choice. Try again.");
    }
  }
}

void manageParkings(ParkingRepository repo, VehicleRepository vehicleRepo,
    ParkingSpaceRepository spaceRepo) {
  while (true) {
    print("\n--- Manage Parkings ---");
    print("1. Add Parking");
    print("2. View All Parkings");
    print("3. Delete Parking");
    print("4. Go Back");
    stdout.write("Enter your choice: ");
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write("Enter Vehicle Registration Number: ");
        var regNumber = stdin.readLineSync();
        var vehicle = vehicleRepo.getById(regNumber!);

        stdout.write("Enter Parking Space ID: ");
        var spaceId = int.tryParse(stdin.readLineSync() ?? '');
        var parkingSpace = spaceRepo.getById(spaceId!);

        if (vehicle != null && parkingSpace != null) {
          var parking = Parking(
              vehicle: vehicle,
              parkingSpace: parkingSpace,
              startTime: DateTime.now());
          repo.add(parking);
          print("Parking added successfully.");
        } else {
          print("Vehicle or Parking Space not found.");
        }
        break;

      case '2':
        print("\nList of Parkings:");
        for (var parking in repo.getAll()) {
          print(parking);
        }
        break;

      case '3':
        stdout.write("Enter Parking ID to delete: ");
        var id = int.tryParse(stdin.readLineSync() ?? '');
        if (id != null) {
          repo.delete(id);
          print("Parking deleted.");
        } else {
          print("Invalid input.");
        }
        break;

      case '4':
        return; // Go back to the main menu
      default:
        print("Invalid choice. Try again.");
    }
  }
}
