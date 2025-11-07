// Abstract base class for all bank accounts

abstract class BankAccount {
  // Private fields (Encapsulation)
  int _accountNumber;
  String _holderName;
  double _balance;

  // Constructor
  BankAccount(this._accountNumber, this._holderName, this._balance);

  // Getters and setters
  int get accountNumber => _accountNumber;
  String get holderName => _holderName;
  double get balance => _balance;

  set holderName(String name) => _holderName = name;
  set balance(double newBalance) => _balance = newBalance;

  // Abstract methods (Abstraction)
  void deposit(double amount);
  void withdraw(double amount);

  // Display method
  void displayInfo() {
    print('-----------------------------');
    print('Account Number: $_accountNumber');
    print('Holder Name: $_holderName');
    print('Balance: \$${_balance.toStringAsFixed(2)}');
    print('-----------------------------');
  }
}
