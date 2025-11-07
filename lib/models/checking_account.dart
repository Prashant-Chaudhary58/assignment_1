import 'bank_account.dart';

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
      print('Invalid deposit amount.');
    }
  }

  @override
  void withdraw(double amount) {
    balance -= amount;
    if (balance < 0) {
      balance -= overdraftFee;
      print('Account overdrawn. Overdraft fee of \$35 applied.');
    } else {
      print('Withdrew \$${amount.toStringAsFixed(2)} from Checking Account.');
    }
  }
}
