import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/transaction_add_model.dart';
import 'package:warsha_app/models/transaction_cateogry.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/accountings_v_m.dart';
import 'package:warsha_app/utils/price_helper.dart';
import 'package:warsha_app/views/accounting/transaction_table.dart';

class Accounting extends StatelessWidget {
  const Accounting({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountingVM>(
      builder: (context, value, child) {
        final accountBalance = value.accountsBalance;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: accountBalance == null
              ? Center(
                  child: SpinKitChasingDots(
                  color: Theme.of(context).colorScheme.tertiary,
                ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      txt: "Accounting",
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Are you sure you want to reset all transactions?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Cancel Button
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor:
                                              Colors.white, // Text color
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),

                                      // Reset Button
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor:
                                              Colors.white, // Text color
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () async {
                                          final accountingVM =
                                              Provider.of<AccountingVM>(
                                                  context,
                                                  listen: false);

                                          // Call the API
                                          final state = await accountingVM
                                              .deleteAllTransactions();

                                          // Check if widget is still in the tree before using context
                                          if (!context.mounted) return;

                                          Navigator.pop(
                                              context); // Close Dialog
                                          if (state ==
                                              "transactions_deleted") {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Transactions reset successfully"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            accountingVM.initAccounting();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Failed to reset transactions"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        },
                                        child: const Text("Reset"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.money_remove_copy,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            DefaultText(
                              txt: "Reset",
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // vodafone cash
                        _buildCashCard(
                          context,
                          title: accountBalance[0].name,
                          value: PriceHelper.formatNumber(
                              accountBalance[0].currentBalance),
                          icon: Iconsax.wallet_2_copy,
                          color: Colors.red,
                          onDeposit: () {
                            _showTransactionDialog(
                              value,
                              Colors.green,
                              context,
                              bankAccountId: accountBalance[0].id,
                              categoryId: 1,
                              transactionType: "Deposit",
                              accountName: accountBalance[0].name,
                            );
                          },
                          onWithdraw: () {
                            _showTransactionDialog(
                              value,
                              Colors.red,
                              context,
                              bankAccountId: accountBalance[0].id,
                              categoryId: 1,
                              transactionType: "Withdrawal",
                              accountName: accountBalance[0].name,
                            );
                          },
                        ),

                        //CIB
                        _buildCashCard(
                          context,
                          title: accountBalance[1].name,
                          value: PriceHelper.formatNumber(
                              accountBalance[1].currentBalance),
                          icon: Iconsax.bank_copy,
                          color: Colors.blue,
                          onDeposit: () {
                            _showTransactionDialog(
                              value,
                              Colors.green,
                              context,
                              bankAccountId: accountBalance[1].id,
                              categoryId: 1,
                              transactionType: "Deposit",
                              accountName: accountBalance[1].name,
                            );
                          },
                          onWithdraw: () {
                            _showTransactionDialog(
                              value,
                              Colors.red,
                              context,
                              bankAccountId: accountBalance[1].id,
                              categoryId: 1,
                              transactionType: "Withdrawal",
                              accountName: accountBalance[1].name,
                            );
                          },
                        ),

                        //Egypt Post
                        _buildCashCard(context,
                            title: accountBalance[2].name,
                            value: PriceHelper.formatNumber(
                                accountBalance[2].currentBalance),
                            icon: Iconsax.buildings_copy,
                            color: Colors.green, onDeposit: () {
                          _showTransactionDialog(
                            value,
                            Colors.green,
                            context,
                            bankAccountId: accountBalance[2].id,
                            categoryId: 1,
                            transactionType: "Deposit",
                            accountName: accountBalance[2].name,
                          );
                        }, onWithdraw: () {
                          _showTransactionDialog(
                            value,
                            Colors.red,
                            context,
                            bankAccountId: accountBalance[2].id,
                            categoryId: 1,
                            transactionType: "Withdrawal",
                            accountName: accountBalance[2].name,
                          );
                        }),

                        //Egypt Post
                        _buildCashCard(context,
                            title: accountBalance[3].name,
                            value: PriceHelper.formatNumber(
                                accountBalance[3].currentBalance),
                            icon: Iconsax.moneys_copy,
                            color: Colors.yellow.shade800, onDeposit: () {
                          _showTransactionDialog(
                            value,
                            Colors.green,
                            context,
                            bankAccountId: accountBalance[3].id,
                            categoryId: 1,
                            transactionType: "Deposit",
                            accountName: accountBalance[3].name,
                          );
                        }, onWithdraw: () {
                          _showTransactionDialog(
                            value,
                            Colors.red,
                            context,
                            bankAccountId: accountBalance[3].id,
                            categoryId: 1,
                            transactionType: "Withdrawal",
                            accountName: accountBalance[3].name,
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: DefaultText(
                        txt: "All Transactions",
                        bold: true,
                      ),
                    ),
                    value.allTransactions == null
                        ? Center(
                            child: SpinKitChasingDots(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          )
                        : const Expanded(
                            child: TransactionsTable(),
                          ),
                  ],
                ),
        );
      },
    );
  }

  void _showTransactionDialog(
    AccountingVM accountVM,
    Color color,
    BuildContext context, {
    required int bankAccountId,
    required int categoryId,
    required String transactionType, // "Deposit" or "Withdrawal"
    required String accountName, // "Deposit" or "Withdrawal"
  }) {
    final amountController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Row(
              children: [
                Text(
                  "$transactionType ",
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
                Text(
                  ": $accountName",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                cursorColor: Theme.of(context).colorScheme.tertiary,
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceTint,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: Constants.BORDER_RADIUS_50),
                  errorStyle: TextStyle(color: Colors.red.shade300),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Icon(
                      Iconsax.money_copy,
                      color: Colors.green.shade400,
                    ),
                  ),
                  suffixIcon: const Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30, top: 11),
                      child: DefaultText(txt: "EGP")),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: Constants.BORDER_RADIUS_50),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: Constants.BORDER_RADIUS_50),
                  hintText: "Amount",
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<TransactionCategory>(
                initialValue: accountVM.allTransactionCategories?.first,
                items: accountVM.allTransactionCategories == null
                    ? []
                    : accountVM.allTransactionCategories!.map((cat) {
                        return DropdownMenuItem<TransactionCategory>(
                          value: cat,
                          child: Text(cat.categoryName),
                        );
                      }).toList(),
                icon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Icon(Iconsax.arrow_down_1_copy),
                ),
                onChanged: (value) {
                  categoryId = value!.categoryID;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceTint,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: Constants.BORDER_RADIUS_50,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: Constants.BORDER_RADIUS_50,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: Constants.BORDER_RADIUS_50,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Icon(Iconsax.transaction_minus_copy,
                        color: Colors.green.shade400),
                  ),
                  hintText: "Select Category",
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                cursorColor: Theme.of(context).colorScheme.tertiary,
                controller: descriptionController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceTint,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: Constants.BORDER_RADIUS_50),
                  errorStyle: TextStyle(color: Colors.red.shade300),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Icon(
                      Iconsax.book_copy,
                      color: Colors.green.shade400,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: Constants.BORDER_RADIUS_50),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: Constants.BORDER_RADIUS_50),
                  hintText: "Description",
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final transaction = TransactionModel(
                  bankAccountId: bankAccountId,
                  categoryId: categoryId,
                  transactionType: transactionType,
                  amount: double.tryParse(amountController.text) ?? 0,
                  description: descriptionController.text.trim(),
                );

                final accountingVM =
                    Provider.of<AccountingVM>(context, listen: false);

                // Optional: show a loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => Center(
                      child: SpinKitChasingDots(
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 30,
                  )),
                );

                final status = await accountingVM.addTransaction(transaction);

                Navigator.pop(context);
                Navigator.pop(context);

                if (status == "transaction_added") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Transaction added successfully")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to add transaction")),
                  );
                }
              },
              child: Text(transactionType),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCashCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    VoidCallback? onDeposit,
    VoidCallback? onWithdraw,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 35),
            const SizedBox(height: 15),
            DefaultText(
              txt: title,
              color: Colors.black54,
              size: 16,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultText(
                  txt: value,
                  color: color,
                  size: 20,
                  bold: true,
                ),
                const SizedBox(width: 5),
                DefaultText(
                  txt: "EGP",
                  color: color,
                  size: 20,
                  bold: true,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: onDeposit,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green.shade500,
                    side: BorderSide(color: Colors.green.shade500),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(Iconsax.add_copy,
                      size: 16, color: Colors.green.shade500),
                  label: Text("Deposit",
                      style: TextStyle(color: Colors.green.shade500)),
                ),
                OutlinedButton.icon(
                  onPressed: onWithdraw,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade500,
                    side: BorderSide(color: Colors.red.shade500),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(Iconsax.minus_copy,
                      size: 16, color: Colors.red.shade500),
                  label: Text("Withdraw",
                      style: TextStyle(color: Colors.red.shade500)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
