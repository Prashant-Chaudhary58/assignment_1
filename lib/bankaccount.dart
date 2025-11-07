//abstract class representing a generic bank account

import 'package:path/path.dart';

abstract class BankAccount {
  //private fields
  int _accountNumber;
  String _holderName;
  double _balance;

  //constructor
  BankAccount(this._accountNumber, this._holderName, this._balance);

  //getters ad setters (Encapsulation)
  int get accountNumber => _accountNumber;
  String get holderName => _holderName;
  double get balance => _balance;

  set holderName(String name) => _holderName = name;
  set balance(double newBAlance) => _balance = newBAlance;

  //Abstract methods (Abstraction)
  void deposit(double amount);
  void withdraw(double amount);

  //Display account info
  void displayInfo() {
    print('________________________________');
    print('Account Number: $_accountNumber');
    print('Holder NAme: $_holderName');
    print('Balance :\$${_balance.toStringAsFixed(2)}');
    print('_________________________________');
  }
}

//Interface for interest-bearing accounts
abstract class InterestBearing {
  double calculateInterest();
}

//Savings Account
class SavingsAccount extends BankAccount implements InterestBearing {
  static const double minBalance = 500.0;
  static const double interestRate = 0.02;
  int _withdrawCount = 0;

  SavingsAccount(int accountNumber, String holderName, double balance)
    : super(accountNumber, holderName, balance);

  @override
  double calculateInterest() {
    return balance * interestRate;
  }

  @override
  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      print('Deposited \$${amount.toStringAsFixed(2)} to Savings Account.');
    } else {
      print('Invalid deposit amount.');
    }
  }

  @override
  void withdraw(double amount) {
    if (_withdrawCount >= 3) {
      print('Withdrawal limit reached for this month.');
      return;
    }
    if (balance - amount < minBalance) {
      print('Cannot withdraw. Minimim balance requirement of \$500 not met');
    } else {
      balance -= amount;
      _withdrawCount++;
      print('Withdrew \$${amount.toStringAsFixed(2)} from Savings Account');
    }
  }
}

//Checking Account
class CheckingAccount extends BankAccount {
  static const double overdraftFee = 35.0;

  CheckingAccount(int accountNumber, String holderName, double balance)
    : super(accountNumber, holderName, balance);

  @override
  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      print('Deposited \$${amount.toStringAsFixed(2)} to Checking Account.');
    } else {
      print('Invalid deposit amount');
    }
  }

  @override
  void withdraw(double amount) {
    balance -= amount;
    if (balance < 0) {
      balance -= overdraftFee;
      print('Account overdrawn. Overdraft fee of \$35 applied.');
    } else {
      print('withdrew \$${amount.toStringAsFixed(2)} from checking account.');
    }
  }
}

//Premium Account
class PremiumAccount extends BankAccount implements InterestBearing {
  static const double minBalance = 10000.0;
  static const double interestRate = 0.05;

  PremiumAccount(int accountNumber, String holderName, double balance)
    : super(accountNumber, holderName, balance);

  @override
  double calculateInterest() {
    return balance * interestRate;
  }

  @override
  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      print('Deposited \$${amount.toStringAsFixed(2)} to premium Account.');
    } else {
      print('Invalid deposit amount.');
    }
  }

  @override
  void withdraw(double amount) {
    if (balance - amount < minBalance) {
      print('Cannot withdraw below the minimum balance of \$10,000');
    } else {
      balance -= amount;
      print('Withdrew \$${amount.toStringAsFixed(2)} from Premium Account.');
    }
  }
}

//Bank Class to manage multiple accounts
class Bank {
  List<BankAccount> _accounts = [];

  void createAccount(BankAccount account) {
    _accounts.add(account);
    print('Account created for ${account.holderName}.');
  }

  BankAccount? findAccount(int accountNumber) {
    for (var acc in _accounts) {
      if (acc.accountNumber == accountNumber) return acc;
    }
    print('Account not found.');
    return null;
  }

  void transfer(int fromAccNum, int toAccNum, double amount) {
    var fromAcc = findAccount(fromAccNum);
    var toAcc = findAccount(toAccNum);

    if (fromAcc != null && toAcc != null) {
      fromAcc.withdraw(amount);
      toAcc.deposit(amount);
      print(
        'Transferred \$${amount.toStringAsFixed(2)} from'
        '${fromAcc.holderName} to ${toAcc.holderName}',
      );
    } else {
      print('Transfer failed. one or both accounts not found.');
    }
  }

  void generateReport() {
    print('\n=== Bank Accounts Reports===');
    for (var acc in _accounts) {
      acc.displayInfo();
    }
  }
}

//Main function for testing
void main() {
  Bank bank = Bank();

  // create accounts
  var savings = SavingsAccount((001), "Prashant", 2000);
  var checking = CheckingAccount(1002, "Sushim", 500);
  var premium = PremiumAccount(10002, "Nishan", 50000);

  //Add to bank
  bank.createAccount(savings);
  bank.createAccount(checking);
  bank.createAccount(premium);

  //perform operations
  savings.withdraw(200);
  checking.withdraw(500);
  premium.withdraw(4000);

  //transfer money
  bank.transfer(001, 1002, 100);

  //display reports
  bank.generateReport();

  //Interest Calculation
  print(
    '\nInterest for Prashant (Savings): \$${savings.calculateInterest().toStringAsFixed(2)}',
  );
  print(
    'Interest for Nishan (premium): \$${premium.calculateInterest().toStringAsFixed(2)}',
  );
}
