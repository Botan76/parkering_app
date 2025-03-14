import 'dart:io';
import 'package:parkeringsapp/repositories/person_repository.dart';
import 'package:parkeringsapp/repositories/vehicle_repository.dart';
import 'package:parkeringsapp/repositories/parking_space_repository.dart';
import 'package:parkeringsapp/repositories/parking_repository.dart';

Future<void> main() async {
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

    print("🔹 [DEBUG] User choice: $choice");

    switch (choice) {
      case '1':
        await managePersons(personRepo);
        break;
      case '2':
        await manageVehicles(vehicleRepo, personRepo);
        break;
      case '3':
        await manageParkingSpaces(spaceRepo);
        break;
      case '4':
        await manageParkings(parkingRepo, vehicleRepo, spaceRepo);
        break;
      case '5':
        print(" Exiting...");
        exit(0);
      default:
        print("Invalid choice. Try again.");
    }
  }
}

Future<void> managePersons(PersonRepository repo) async {
  print("\n--- Manage Persons ---");
  print("1. Add Person");
  print("2. View All Persons");
  print("3. Delete Person");
  stdout.write("Enter choice: ");
  var choice = stdin.readLineSync();

  if (choice == '1') {
    stdout.write("Enter name: ");
    var name = stdin.readLineSync();
    stdout.write("Enter personal number: ");
    var personalNumber = stdin.readLineSync();

    if (name != null && personalNumber != null) {
      await repo.addPerson(name, personalNumber); // Call server API
    }
  } else if (choice == '2') {
    await repo.getAllPersons(); // Fetch data from server
  } else if (choice == '3') {
    stdout.write("Enter personal number to delete: ");
    var personalNumber = stdin.readLineSync();
    if (personalNumber != null) {
      await repo.delete(personalNumber);
    }
  }
}

Future<void> manageVehicles(
    VehicleRepository repo, PersonRepository personRepo) async {
  print("\n--- Manage Vehicles ---");
  print("1. Add Vehicle");
  print("2. View All Vehicles");
  print("3. Delete Vehicle");
  stdout.write("Enter choice: ");
  var choice = stdin.readLineSync();

  if (choice == '1') {
    stdout.write("Enter registration number: ");
    var regNumber = stdin.readLineSync();
    stdout.write("Enter vehicle type: ");
    var type = stdin.readLineSync();
    stdout.write("Enter owner's personal number: ");
    var ownerPN = stdin.readLineSync();

    if (regNumber != null && type != null && ownerPN != null) {
      print(
          "Calling addVehicle with: regNumber=$regNumber, type=$type, ownerPN=$ownerPN");
      await repo.addVehicle(regNumber, type, ownerPN);
      print(" Vehicle added successfully!");
    } else {
      print(" Invalid input. Please enter valid values.");
    }
  } else if (choice == '2') {
    print("Calling getAllVehicles");
    await repo.getAllVehicles();
  } else if (choice == '3') {
    stdout.write("Enter registration number to delete: ");
    var regNumber = stdin.readLineSync();
    if (regNumber != null) {
      print("Calling deleteVehicle with: regNumber=$regNumber");
      await repo.deleteVehicle(regNumber);
    } else {
      print("Invalid registration number.");
    }
  } else {
    print("Invalid choice. Please try again.");
  }
}

Future<void> manageParkingSpaces(ParkingSpaceRepository repo) async {
  print("\n--- Manage Parking Spaces ---");
  print("1. Add Parking Space");
  print("2. View All Parking Spaces");
  print("3. Delete Parking Space");
  stdout.write("Enter choice: ");
  var choice = stdin.readLineSync();

  if (choice == '1') {
    stdout.write("Enter Parking Space ID: ");
    var id = int.tryParse(stdin.readLineSync() ?? '');
    stdout.write("Enter Address: ");
    var address = stdin.readLineSync();
    stdout.write("Enter Price per Hour: ");
    var price = double.tryParse(stdin.readLineSync() ?? '');

    if (id != null && address != null && price != null) {
      await repo.addParkingSpace(id, address, price);
    } else {
      print("Invalid input. Please enter valid values.");
    }
  } else if (choice == '2') {
    await repo.getAllParkingSpaces();
  } else if (choice == '3') {
    stdout.write("Enter Parking Space ID to delete: ");
    var id = int.tryParse(stdin.readLineSync() ?? '');
    if (id != null) {
      await repo.deleteParkingSpace(id.toString());
    } else {
      print("Invalid Parking Space ID.");
    }
  } else {
    print("Invalid choice. Please try again.");
  }
}

Future<void> manageParkings(ParkingRepository repo,
    VehicleRepository vehicleRepo, ParkingSpaceRepository spaceRepo) async {
  print("\n--- Manage Parkings ---");
  print("1. Add Parking");
  print("2. View All Parkings");
  print("3. Delete Parking");
  stdout.write("Enter your choice: ");
  var choice = stdin.readLineSync();

  if (choice == '1') {
    stdout.write("Enter Vehicle Registration Number: ");
    var regNumber = stdin.readLineSync();
    stdout.write("Enter Parking Space ID: ");
    var spaceId = stdin.readLineSync();

    if (regNumber != null && spaceId != null) {
      await repo.addParking(regNumber, spaceId);
    } else {
      print("Invalid input.");
    }
  } else if (choice == '2') {
    await repo.getAllParkings();
  } else if (choice == '3') {
    stdout.write("Enter Parking ID to delete: ");
    var id = stdin.readLineSync();
    if (id != null) {
      await repo.deleteParking(id);
    }
  }
}
