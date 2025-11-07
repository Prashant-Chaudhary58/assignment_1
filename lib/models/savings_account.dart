import 'bank_account.dart';
import 'interest_bearing.dart';

class SavingsAccount extends BankAccount implements InterestBearing {
  static const double minBalance = 500.0;
  static const double interestRate = 0.02;
  int _withdrawCount = 0;

  SavingsAccount(int accountNumber, String holderName, double balance)
      : super(accountNumber, holderName, balance);

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
      print('Cannot withdraw. Minimum balance requirement of \$500 not met.');
    } else {
      balance -= amount;
      _withdrawCount++;
      print('Withdrew \$${amount.toStringAsFixed(2)} from Savings Account.');
    }
  }

  @override
  double calculateInterest() => balance * interestRate;
}
