import 'bank_account.dart';
import 'interest_bearing.dart';

class PremiumAccount extends BankAccount implements InterestBearing {
  static const double minBalance = 10000.0;
  static const double interestRate = 0.05;

  PremiumAccount(int accountNumber, String holderName, double balance)
      : super(accountNumber, holderName, balance);

  @override
  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      print('Deposited \$${amount.toStringAsFixed(2)} to Premium Account.');
    } else {
      print('Invalid deposit amount.');
    }
  }

  @override
  void withdraw(double amount) {
    if (balance - amount < minBalance) {
      print('Cannot withdraw below the minimum balance of \$10,000.');
    } else {
      balance -= amount;
      print('Withdrew \$${amount.toStringAsFixed(2)} from Premium Account.');
    }
  }

  @override
  double calculateInterest() => balance * interestRate;
}
