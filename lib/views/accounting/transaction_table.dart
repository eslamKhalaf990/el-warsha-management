import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/transaction_provider.dart';
import 'package:warsha_app/utils/date.dart';
import 'package:warsha_app/utils/price_helper.dart';
import 'package:warsha_app/view_models/accountings_v_m.dart';

class TransactionsTable extends StatelessWidget {
  const TransactionsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final accountingVM = context.watch<AccountingVM>();
    final provider = context.watch<TransactionsProvider>();
    final theme = Theme.of(context);

    final transactions = accountingVM.allTransactions ?? [];

    // Sync AccountingVM transactions to TransactionsProvider when changed
    if (provider.allTransactions.isEmpty && transactions.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.setTransactions(transactions);
      });
    } else if (transactions.length != provider.allTransactions.length) {
      // Detect new/removed transactions and refresh the provider
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.setTransactions(transactions);
      });
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortColumnIndex: provider.sortColumnIndex,
              sortAscending: provider.sortAscending,
              dividerThickness: 0.05,
              columnSpacing: 80,
              headingRowColor: WidgetStatePropertyAll(
                theme.colorScheme.primary.withAlpha(40),
              ),
              dataRowMinHeight: 52,
              dataRowMaxHeight: 52,
              columns: [
                DataColumn(
                  label: const Text('Date'),
                  onSort: (i, asc) => provider.sort<String>(
                        (t) => t.createdAt.toString(),
                    i,
                    asc,
                  ),
                ),
                DataColumn(
                  label: const Text('Account'),
                  onSort: (i, asc) =>
                      provider.sort<String>((t) => t.bankAccount.name, i, asc),
                ),
                DataColumn(
                  label: const Text('Category'),
                  onSort: (i, asc) => provider.sort<String>(
                          (t) => t.category.categoryName, i, asc),
                ),
                DataColumn(
                  label: const Text('Type'),
                  onSort: (i, asc) =>
                      provider.sort<String>((t) => t.transactionType, i, asc),
                ),
                DataColumn(
                  label: const Text('Amount'),
                  onSort: (i, asc) =>
                      provider.sort<num>((t) => t.amount, i, asc),
                ),
                const DataColumn(label: Text('Description')),
              ],
              rows: provider.sortedTransactions.map<DataRow>((t) {
                final color = t.transactionType == "Deposit"
                    ? Colors.green
                    : Colors.redAccent;
                return DataRow(cells: [
                  DataCell(Text(
                    DateHelper.formatDate2(t.createdAt.toString()),
                    style: const TextStyle(color: Colors.black54),
                  )),
                  DataCell(Text(t.bankAccount.name)),
                  DataCell(Text(t.category.categoryName)),
                  DataCell(Row(
                    children: [
                      Icon(
                        t.transactionType == "Deposit"
                            ? Iconsax.arrow_up_2_copy
                            : Iconsax.arrow_down_1_copy,
                        color: color,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(t.transactionType, style: TextStyle(color: color)),
                    ],
                  )),
                  DataCell(
                    Text(
                      "${PriceHelper.formatNumber(t.amount)} EGP",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataCell(SizedBox(
                    width: 280,
                    child: Text(
                      t.description ?? "",
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                ]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
