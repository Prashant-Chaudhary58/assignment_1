import 'models/savings_account.dart';
import 'models/checking_account.dart';
import 'models/premium_account.dart';
import 'services/bank.dart';

void main() {
  Bank bank = Bank();

  // Create accounts
  var savings = SavingsAccount(1001, 'Prashant', 1200);
  var checking = CheckingAccount(1002, 'Nishan', 500);
  var premium = PremiumAccount(1003, 'Sushim', 15000);

  // Add to bank
  bank.createAccount(savings);
  bank.createAccount(checking);
  bank.createAccount(premium);

  // Perform operations
  savings.withdraw(200);
  checking.withdraw(600);
  premium.withdraw(4000);

  // Transfer money
  bank.transfer(1001, 1002, 100);

  // Display reports
  bank.generateReport();

  // Interest calculation
  print('\nInterest for Prashant (Savings): \$${savings.calculateInterest().toStringAsFixed(2)}');
  print('Interest for Sushim (Premium): \$${premium.calculateInterest().toStringAsFixed(2)}');
}
