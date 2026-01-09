// ===============================
// LAB 2 – DART ESSENTIALS
// ===============================

import 'dart:async';

void main() async {
  print('===== EXERCISE 1: BASIC SYNTAX & DATA TYPES =====');
  exercise1();

  print('\n===== EXERCISE 2: COLLECTIONS & OPERATORS =====');
  exercise2();

  print('\n===== EXERCISE 3: CONTROL FLOW & FUNCTIONS =====');
  exercise3();

  print('\n===== EXERCISE 4: OOP BASICS =====');
  exercise4();

  print('\n===== EXERCISE 5: ASYNC, NULL SAFETY & STREAMS =====');
  await exercise5();
}

// =================================================
// EXERCISE 1 – BASIC SYNTAX & DATA TYPES
// =================================================
void exercise1() {
  // Declare variables with core data types
  int age = 21;
  double gpa = 3.5;
  String name = 'Dat';
  bool isStudent = true;

  // Print using string interpolation
  print('Name: $name');
  print('Age: $age');
  print('GPA: $gpa');
  print('Is student: $isStudent');
  print('Next year age: ${age + 1}');
}

// =================================================
// EXERCISE 2 – COLLECTIONS & OPERATORS
// =================================================
void exercise2() {
  // List of integers
  List<int> numbers = [1, 2, 3, 4, 5];
  print('Initial list: $numbers');

  // Arithmetic & comparison operators
  int sum = numbers[0] + numbers[1];
  bool isGreater = numbers[4] > numbers[2];
  print('Sum of first two numbers: $sum');
  print('Is last number greater than third? $isGreater');

  // Set (unique values)
  Set<int> uniqueNumbers = {1, 2, 2, 3, 4};
  uniqueNumbers.add(5);
  uniqueNumbers.remove(1);
  print('Set values: $uniqueNumbers');

  // Map (key-value pairs)
  Map<String, int> scores = {
    'Math': 90,
    'English': 85,
  };

  scores['Science'] = 88;
  print('Scores map: $scores');
  print('Math score: ${scores['Math']}');

  // Logical & ternary operator
  bool pass = scores['Math']! >= 50 && scores['English']! >= 50;
  String result = pass ? 'Pass' : 'Fail';
  print('Result: $result');
}

// =================================================
// EXERCISE 3 – CONTROL FLOW & FUNCTIONS
// =================================================
void exercise3() {
  int score = 75;

  // if / else
  if (score >= 80) {
    print('Grade: A');
  } else if (score >= 60) {
    print('Grade: B');
  } else {
    print('Grade: C');
  }

  // switch case
  int day = 3;
  switch (day) {
    case 1:
      print('Monday');
      break;
    case 2:
      print('Tuesday');
      break;
    case 3:
      print('Wednesday');
      break;
    default:
      print('Invalid day');
  }

  // for loop
  for (int i = 1; i <= 3; i++) {
    print('For loop iteration: $i');
  }

  // for-in loop
  List<String> fruits = ['Apple', 'Banana', 'Orange'];
  for (var fruit in fruits) {
    print('Fruit: $fruit');
  }

  // forEach
  fruits.forEach((fruit) => print('forEach fruit: $fruit'));

  // Function calls
  print('Sum (normal function): ${add(3, 4)}');
  print('Sum (arrow function): ${multiply(3, 4)}');
}

// Normal function
int add(int a, int b) {
  return a + b;
}

// Arrow function
int multiply(int a, int b) => a * b;

// =================================================
// EXERCISE 4 – INTRO TO OOP
// =================================================
void exercise4() {
  Car car = Car('Toyota');
  car.drive();

  Car car2 = Car.named('Honda');
  car2.drive();

  ElectricCar tesla = ElectricCar('Tesla');
  tesla.drive();
}

// Base class
class Car {
  String brand;

  // Constructor
  Car(this.brand);

  // Named constructor
  Car.named(this.brand);

  // Method
  void drive() {
    print('The car $brand is driving');
  }
}

// Subclass with inheritance
class ElectricCar extends Car {
  ElectricCar(String brand) : super(brand);

  // Override method
  @override
  void drive() {
    print('The electric car $brand is driving silently');
  }
}

// =================================================
// EXERCISE 5 – ASYNC, NULL SAFETY & STREAMS
// =================================================
Future<void> exercise5() async {
  // Async & Future
  print('Loading data...');
  String data = await loadData();
  print('Data loaded: $data');

  // Null safety
  String? nullableName;
  print('Nullable name: ${nullableName ?? 'Default Name'}');

  nullableName = 'Dat';
  print('Non-null value: ${nullableName!}');

  // Stream of integers
  Stream<int> numberStream = Stream.periodic(
    Duration(seconds: 1),
        (count) => count + 1,
  ).take(3);

  print('Listening to stream...');
  await for (var value in numberStream) {
    print('Stream value: $value');
  }
}

// Async function with Future.delayed
Future<String> loadData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Sample Data';
}
