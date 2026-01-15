import 'dart:async';
import 'dart:convert';

// EXERCISE 1:
class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  @override
  String toString() => 'Product(id: $id, name: $name, price: \$$price)';
}

class ProductRepository {
  final _controller = StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Product(id: 1, name: 'Laptop', price: 999.99),
      Product(id: 2, name: 'Mouse', price: 25.50),
      Product(id: 3, name: 'Keyboard', price: 75.00),
    ];
  }

  Stream<Product> liveAdded() => _controller.stream;

  void addProduct(Product product) => _controller.add(product);

  void dispose() => _controller.close();
}

// EXERCISE 2:
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(name: json['name'], email: json['email']);

  @override
  String toString() => 'User(name: $name, email: $email)';
}

class UserRepository {
  Future<List<User>> fetchUsers() async {
    await Future.delayed(Duration(seconds: 1));
    String jsonData = '''[
      {"name": "Nguyen Van A", "email": "vana@example.com"},
      {"name": "Tran Thi B", "email": "thib@example.com"},
      {"name": "Le Van C", "email": "vanc@example.com"}
    ]''';
    return (jsonDecode(jsonData) as List)
        .map((json) => User.fromJson(json))
        .toList();
  }
}

// EXERCISE 3:
void demonstrateEventLoop() {
  print('\n--- EXERCISE 3:');
  print('1. Start');
  scheduleMicrotask(() => print('4. Microtask 1'));
  scheduleMicrotask(() => print('5. Microtask 2'));
  Future(() => print('6. Future 1'));
  Future(() => print('7. Future 2'));
  scheduleMicrotask(() => print('3. Microtask 3'));
  print('2. End');
  // Order: Sync → Microtasks → Futures
}

// EXERCISE 4: Stream Transformation
Future<void> demonstrateStreamTransformation() async {
  print('\n--- EXERCISE 4:  ---');
  Stream<int> stream = Stream.fromIterable([1, 2, 3, 4, 5])
      .map((n) => n * n)
      .where((squared) => squared % 2 == 0);

  await for (var value in stream) {
    print('Emitted: $value');
  }
}

// EXERCISE 5: Factory Constructors & Cache
class Settings {
  static Settings? _instance;
  final String theme;

  Settings._({this.theme = 'dark'});

  factory Settings() => _instance ??= Settings._();

  @override
  String toString() => 'Settings(theme: $theme)';
}

// MAIN
void main() async {

  // Ex 1
  print('--- EXERCISE 1:  ---');
  var productRepo = ProductRepository();
  productRepo.liveAdded().listen((p) => print('Added: $p'));

  var products = await productRepo.getAll();
  products.forEach(print);

  productRepo.addProduct(Product(id: 4, name: 'Monitor', price: 299.99));
  await Future.delayed(Duration(milliseconds: 100));

  // Ex 2
  print('\n--- EXERCISE 2: ---');
  var users = await UserRepository().fetchUsers();
  users.forEach(print);

  // Ex 3
  demonstrateEventLoop();
  await Future.delayed(Duration(milliseconds: 100));

  // Ex 4
  await demonstrateStreamTransformation();

  // Ex 5
  print('\n--- EXERCISE 5:  ---');
  var s1 = Settings();
  var s2 = Settings();
  print('$s1\n$s2');
  print('Identical: ${identical(s1, s2)}');

  productRepo.dispose();
}