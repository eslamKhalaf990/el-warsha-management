import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/account_balance.dart';
import 'package:warsha_app/models/create_order_request.dart';

// Models & Values
import 'package:warsha_app/models/customerModel.dart';
import 'package:warsha_app/models/orderItemModel.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/utils/navigator.dart';
import 'package:warsha_app/view_models/accountings_v_m.dart';

// View Models
import 'package:warsha_app/view_models/add_order_v_m.dart';
import 'package:warsha_app/view_models/add_product_v_m.dart';
import 'package:warsha_app/view_models/customers_v_m.dart';
import 'package:warsha_app/controllers/add_order/add_payment.dart';
import 'package:warsha_app/view_models/order_v_m.dart';

class AddOrderBeta extends StatelessWidget {
  const AddOrderBeta({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: isDesktop
              ? _buildDesktopLayout(context)
              : _buildMobileLayout(context),
        ),
      ),
    );
  }

  // --- Mobile Layout (Single Column) ---
  Widget _buildMobileLayout(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 40), // Space for scrolling
      child: Column(
        children: [
          CustomerSelectionSection(),
          SizedBox(height: 20),
          OrderLineItemsSection(),
          SizedBox(height: 20),
          OrderSummaryCard(), // Summary at bottom of scroll to avoid keyboard overlap
        ],
      ),
    );
  }

  // --- Desktop Layout (Row) ---
  Widget _buildDesktopLayout(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomerSelectionSection(),
                SizedBox(height: 24),
                OrderLineItemsSection(),
              ],
            ),
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(child: OrderSummaryCard()),
        ),
      ],
    );
  }
}

// --- REUSABLE DECORATION STYLE ---
InputDecoration _inputDecoration(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, size: 20),
    filled: true,
    fillColor: Colors.white,
    hintStyle: const TextStyle(color: Colors.grey),
    labelStyle: const TextStyle(color: Colors.grey),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(
          color: Colors.blue, width: 2), // Use your primary color
    ),
  );
}

class CustomerSelectionSection extends StatelessWidget {
  const CustomerSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade100, blurRadius: 10, spreadRadius: 1)
        ],
      ),
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Iconsax.user_tag, color: Colors.blue),
              SizedBox(width: 10),
              DefaultText(txt: "Customer Info", bold: true, size: 18),
            ],
          ),
          const SizedBox(height: 20),

          // CUSTOMER DROPDOWN
          Consumer<CustomerVM>(
            builder: (context, customerVM, _) {
              if (customerVM.allCustomers == null) {
                return const LinearProgressIndicator();
              }

              return FutureBuilder(
                future: customerVM.allCustomers,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox();

                  return DropdownButtonFormField<CustomerModel>(
                    decoration: _inputDecoration(
                        "Select Customer", Iconsax.profile_circle),
                    items: snapshot.data!.map((customer) {
                      return DropdownMenuItem(
                        value: customer,
                        child: Text("${customer.fullName} - ${customer.phone}",
                            overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                    onChanged: (CustomerModel? selected) {
                      if (selected != null) {
                        Provider.of<AddOrderVM>(context, listen: false)
                            .addCustomer = selected;
                      }
                    },
                  );
                },
              );
            },
          ),

          const SizedBox(height: 20),

          // ADDRESS DISPLAY
          Consumer<AddOrderVM>(
            builder: (context, vm, _) {
              if (vm.orderModel.customer == null) {
                return const SizedBox.shrink();
              }
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Iconsax.location, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Delivery Address",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.blue)),
                          const SizedBox(height: 4),
                          Text(
                            "${vm.orderModel.customer!.address}, ${vm.orderModel.customer!.governorate}",
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class OrderLineItemsSection extends StatefulWidget {
  const OrderLineItemsSection({super.key});

  @override
  State<OrderLineItemsSection> createState() => _OrderLineItemsSectionState();
}

class _OrderLineItemsSectionState extends State<OrderLineItemsSection> {
  ProductModel? selectedProduct;
  final TextEditingController _qtyController = TextEditingController(text: "1");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade100, blurRadius: 10, spreadRadius: 1)
        ],
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Iconsax.box, color: Colors.blue),
              SizedBox(width: 10),
              DefaultText(txt: "Order Items", bold: true, size: 18),
            ],
          ),
          const SizedBox(height: 20),

          // --- ADD ITEM ROW ---
          // Using Wrap or Layout logic to handle very small screens inside the card
          Column(
            children: [
              Consumer<ProductVM>(
                builder: (context, productVM, _) {
                  return FutureBuilder(
                    future: productVM.allProducts,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const SizedBox();
                      return DropdownButtonFormField<ProductModel>(
                        initialValue: selectedProduct,
                        isExpanded: true,
                        decoration:
                            _inputDecoration("Select Product", Iconsax.box_1),
                        items: snapshot.data!.map((prod) {
                          return DropdownMenuItem(
                            value: prod,
                            child: Text(prod.name,
                                overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => selectedProduct = val),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _qtyController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration("Qty", Iconsax.hashtag),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor:
                              Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (selectedProduct != null) {
                            // print(_qtyController.text);
                            final vm =
                                Provider.of<AddOrderVM>(context, listen: false);
                            OrderItemModel item = OrderItemModel(
                              productId: int.parse(selectedProduct!.id),
                              quantity: int.tryParse(_qtyController.text) ?? 1,
                              unitPrice:
                                  double.parse(selectedProduct!.sellingPrice),
                              productName: selectedProduct!.name,
                            );
                            vm.addToOrderItems = item;
                            setState(() {
                              selectedProduct = null;
                              _qtyController.text = "1";
                            });
                          }
                        },
                        icon: const Icon(Iconsax.add_circle),
                        label: const Text("Add Item"),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),

          const SizedBox(height: 25),
          Divider(
            color: Theme.of(context).colorScheme.tertiary.withAlpha(50),
          ),

          // --- ADDED ITEMS LIST ---
          Consumer<AddOrderVM>(
            builder: (context, vm, _) {
              if (vm.orderModel.orderItems.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      children: [
                        Icon(Iconsax.shopping_cart,
                            size: 40, color: Colors.grey.shade300),
                        const SizedBox(height: 10),
                        const Text("No items added yet",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: vm.orderModel.orderItems.length,
                separatorBuilder: (_, __) => Divider(
                  color: Theme.of(context).colorScheme.tertiary.withAlpha(50),
                ),
                itemBuilder: (context, index) {
                  final item = vm.orderModel.orderItems[index];
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(25)),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: const Icon(Iconsax.box, size: 20),
                      ),
                      title: Text(item.productName,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          "${item.unitPrice} EGP | ${item.quantity} pieces"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${item.unitPrice * item.quantity} EGP",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.green),
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            icon: const Icon(Iconsax.trash,
                                color: Colors.redAccent),
                            onPressed: () {
                              vm.removeFromOrderItems = item.productId;
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final payment = Provider.of<PaymentProvider>(context);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade100, blurRadius: 10, spreadRadius: 1)
          ],
          border: Border.all(color: Colors.grey.shade100)),
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              Icon(Iconsax.wallet_2, color: Colors.blue),
              SizedBox(width: 10),
              DefaultText(txt: "Payment", bold: true, size: 18),
            ],
          ),
          const SizedBox(height: 20),

          // 1. Platform Source
          DropdownButtonFormField<String>(
            decoration: _inputDecoration("Source", Iconsax.global),
            initialValue: payment.platformSource.text.isNotEmpty
                ? payment.platformSource.text
                : null,
            items: const [
              DropdownMenuItem(
                  value: "facebook", child: Text("Facebook")),
              DropdownMenuItem(value: "tiktok", child: Text("TikTok")),
              DropdownMenuItem(
                  value: "instagram", child: Text("Instagram")),
              DropdownMenuItem(
                  value: "ecommerce", child: Text("E-commerce")),
            ],
            onChanged: (val) => payment.platformSource.text = val ?? "",
          ),
          const SizedBox(height: 15),

          // 2. Payment Method
          DropdownButtonFormField<String>(
            decoration: _inputDecoration("Method", Iconsax.card),
            initialValue: payment.paymentMethod.text.isNotEmpty
                ? payment.paymentMethod.text
                : null,
            items: const [
              DropdownMenuItem(
                  value: "vodafone cash",
                  child: Text("Vodafone Cash")),
              DropdownMenuItem(
                  value: "instapay", child: Text("Instapay")),
              DropdownMenuItem(value: "cash", child: Text("Cash")),
            ],
            onChanged: (val) => payment.paymentMethod.text = val ?? "",
          ),
          const SizedBox(height: 15),

          // 3. Financials
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: payment.delivery,
                  decoration: _inputDecoration("Delivery", Iconsax.truck),
                  keyboardType: TextInputType.number,
                  // onChanged: (v) => payment.notifyListeners(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: payment.discount,
                  decoration:
                      _inputDecoration("Discount", Iconsax.discount_shape),
                  keyboardType: TextInputType.number,
                  // onChanged: (v) => payment.notifyListeners(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          TextField(
            controller: payment.downPayment,
            decoration: _inputDecoration("Down Payment", Iconsax.moneys),
            keyboardType: TextInputType.number,
            // onChanged: (v) => payment.notifyListeners(),
          ),

          const SizedBox(height: 10),
          TextField(
            controller: payment.notes,
            maxLines: 2,
            decoration: _inputDecoration("Notes", Iconsax.note_1),
            keyboardType: TextInputType.text,
            // onChanged: (v) => payment.notifyListeners(),
          ),

          const SizedBox(height: 25),

          Divider(
            color: Theme.of(context).colorScheme.tertiary.withAlpha(50),
          ),

          // 4. TOTAL
          Consumer<AddOrderVM>(builder: (context, orderVM, _) {
            double productsTotal = orderVM.getTotalPrice();
            double delivery = double.tryParse(payment.delivery.text) ?? 0;
            double discount = double.tryParse(payment.discount.text) ?? 0;
            double downPayment = double.tryParse(payment.downPayment.text) ?? 0;
            double grandTotal = productsTotal + delivery - discount - downPayment;

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Grand Total",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                    "$grandTotal EGP",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 25),

          // 5. SUBMIT BUTTON
          SizedBox(
            width: double.infinity,
            height: 55,
            child: DefaultButton(
              title: "Save Order",
              onTap: () {
                _submitOrder(context);
              },
              margin: EdgeInsets.zero,
              isValid: !Provider.of<OrderVM>(context).isSaving,
              isLoading: Provider.of<OrderVM>(context).isSaving,
              border: 25,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _submitOrder(BuildContext context) async {
    final addOrderVM = Provider.of<AddOrderVM>(context, listen: false);
    final payment = Provider.of<PaymentProvider>(context, listen: false);
    final orderVM = Provider.of<OrderVM>(context, listen: false);

    // --- VALIDATION STEP ---

    // Check Customer
    if (addOrderVM.orderModel.customer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a customer first'),
            backgroundColor: Colors.red),
      );
      return;
    }

    // Check Items (Logic Fix: Don't allow empty orders)
    if (addOrderVM.orderModel.orderItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please add at least one product'),
            backgroundColor: Colors.red),
      );
      return;
    }

    // --- PREPARATION STEP ---

    // Safe Parsing (Logic Fix: Prevent crash if text is empty)
    final double deliveryCost = double.tryParse(payment.delivery.text) ?? 0.0;
    final double discountAmount = double.tryParse(payment.discount.text) ?? 0.0;
    final double downPaymentAmount =
        double.tryParse(payment.downPayment.text) ?? 0.0;

    String? bankAccountIdStr;

    // Logic Fix: Only ask for Bank Account if there is a down payment
    if (downPaymentAmount > 0) {
      final bankAccount = await showTransferDialog(context, downPaymentAmount);

      if (bankAccount == null) {
        // User cancelled the dialog, so we stop the save process
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'Bank account selection is required for down payments'),
                backgroundColor: Colors.orange),
          );
        }
        return;
      }
      bankAccountIdStr = bankAccount.id.toString();
    }

    try {
      // Map Items
      final List<CreateOrderItem> itemsToCreate =
          addOrderVM.orderModel.orderItems.map((item) {
        return CreateOrderItem(
          productId: item.productId,
          quantity: item.quantity,
          unitPrice: item.unitPrice,
        );
      }).toList();

      // Build Request
      final CreateOrderRequest request = CreateOrderRequest(
        customerId: addOrderVM.orderModel.customer!.customerId,
        delivery: deliveryCost,
        discount: discountAmount,
        downPayment: payment.downPayment
            .text,
        notes: payment.notes.text,
        orderSource: payment.platformSource.text,
        paymentMethod: payment.paymentMethod.text,
        items: itemsToCreate,
        bankAccountId: bankAccountIdStr ?? "0",
      );

      final bool success = await orderVM.addOrder(request);

      if (!context.mounted) return;

      if (success) {
        Provider.of<ProductVM>(context, listen: false).initAllProducts();
        Provider.of<AccountingVM>(context, listen: false).initAccounting();

        // Clear Forms
        payment.clearPaymentDetails();
        addOrderVM.clearOrder();

        // Navigation (Pop twice as per your logic)
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed: ${orderVM.errorMessage}'),
              backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red),
      );
    }
  }

  Future<BankAccount?> showTransferDialog(
      BuildContext context, double totalPrice) async {
    BankAccount? selectedAccount;

    final bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Confirm Completion'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black87,
                        height: 1.5,
                      ),
                  children: [
                    const TextSpan(
                        text: 'Once the order is completed, the payment ',
                        style: TextStyle(fontSize: 16)),
                    TextSpan(
                      text: '$totalPrice EGP',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const TextSpan(
                        text: ' will be transferred.\n\n',
                        style: TextStyle(fontSize: 16)),
                    const TextSpan(
                        text: 'Select the account to transfer your money to:'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Consumer<AccountingVM>(
                builder: (context, accounting, child) => accounting
                            .accountsBalance ==
                        null
                    ? Container()
                    : DropdownButtonFormField<BankAccount>(
                        initialValue: selectedAccount,
                        hint: const Text('Choose account'),
                        items: accounting.accountsBalance!
                            .map((account) => DropdownMenuItem<BankAccount>(
                                  value: account,
                                  child: Text(account.name),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => selectedAccount = value),
                        borderRadius: Constants.BORDER_RADIUS_20,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          labelStyle:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                              borderRadius: Constants.BORDER_RADIUS_15),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Iconsax.bank_copy,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.grey.shade500),
              ),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: selectedAccount == null
                  ? null
                  : () => Navigator.pop(context, true),
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.green.shade400),
              ),
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );

    if (result == true && selectedAccount != null) {
      return selectedAccount;
    }
    return null;
  }
}
