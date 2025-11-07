import '../models/bank_account.dart';

class Bank {
  final List<BankAccount> _accounts = [];

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
      print('Transferred \$${amount.toStringAsFixed(2)} from '
          '${fromAcc.holderName} to ${toAcc.holderName}.');
    } else {
      print('Transfer failed. One or both accounts not found.');
    }
  }

  void generateReport() {
    print('\n=== Bank Accounts Report ===');
    for (var acc in _accounts) {
      acc.displayInfo();
    }
  }
}
