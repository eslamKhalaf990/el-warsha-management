import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/add_order/add_payment.dart';
import 'package:warsha_app/models/create_order_request.dart';
import 'package:warsha_app/view_models/accountings_v_m.dart';
import 'package:warsha_app/view_models/order_v_m.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/add_order_v_m.dart';
import 'package:warsha_app/view_models/add_product_v_m.dart';
import 'package:warsha_app/views/orders/add_order/widgets/order_details_widget.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/views/orders/order_table.dart';

class OrderDetailsStep extends StatelessWidget {
  const OrderDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const DefaultText(txt: "Add New Order"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.yellow.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 15, left: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: Constants.BORDER_RADIUS_15,
                  ),
                  child: Stack(
                    children: [
                      const OrderDetailsWidget(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              //todo: needs refactor
                              Expanded(
                                child: Consumer2<AddOrderVM, PaymentProvider>(
                                  builder:
                                      (context, addOrderVM, payment, child) {
                                    // Get the GetDeleteOrderVM so we can call its methods
                                    // We use 'watch' so the button's loading state updates
                                    final listVM = context.watch<OrderVM>();
                                    final isSaving = listVM.isSaving;

                                    return DefaultButton(
                                      onTap: () async {
                                        // 1. Check if customer is selected (from AddOrderVM)
                                        if (addOrderVM.orderModel.customer ==
                                            null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Please select a customer first.'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }

                                        try {
                                          // 2. Map the OrderItems to CreateOrderItems (from AddOrderVM)
                                          final List<CreateOrderItem>
                                              itemsToCreate = addOrderVM
                                                  .orderModel.orderItems
                                                  .map((item) {
                                            return CreateOrderItem(
                                              productId: item.productId,
                                              quantity: item.quantityToOrder,
                                              unitPrice: item.unitPrice,
                                            );
                                          }).toList();

                                          // 3. Parse all text fields into numbers (from PaymentProvider)
                                          final double deliveryCost =
                                              double.tryParse(
                                                      payment.delivery.text) ??
                                                  0.0;
                                          final double discountAmount =
                                              double.tryParse(
                                                      payment.discount.text) ??
                                                  0.0;

                                          final orderSourceId =
                                              payment.platformSource.text;
                                          final paymentMethodId =
                                              payment.paymentMethod.text;

                                          final bankAccountId =
                                              await showTransferDialog(
                                                  context,
                                                  double.parse(payment
                                                      .downPayment.text));
                                          if (bankAccountId != null) {
                                            // 4. Build the Request Object
                                            final CreateOrderRequest request =
                                                CreateOrderRequest(
                                              customerId: addOrderVM.orderModel
                                                  .customer!.customerId,
                                              delivery: deliveryCost,
                                              discount: discountAmount,
                                              downPayment:
                                                  payment.downPayment.text,
                                              notes: payment.notes.text,
                                              orderSource: orderSourceId,
                                              paymentMethod: paymentMethodId,
                                              items: itemsToCreate,
                                              bankAccountId:
                                                  bankAccountId.id.toString(),
                                            );

                                            // 5. Call the addOrder method (from GetDeleteOrderVM)
                                            // We use context.read inside a callback
                                            final bool success = await context
                                                .read<OrderVM>()
                                                .addOrder(request);

                                            if (success) {
                                              // Run your success logic
                                              if (context.mounted) {
                                                Provider.of<ProductVM>(context,
                                                        listen: false)
                                                    .initAllProducts();
                                                Provider.of<AccountingVM>(
                                                        context,
                                                        listen: false)
                                                    .initAccounting();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                payment.clearPaymentDetails();
                                                addOrderVM
                                                    .clearOrder(); // Call clear on the correct provider
                                              }
                                            } else {
                                              // Show the error from the provider
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    // Read the error message from the correct provider
                                                    content: Text(
                                                        'Failed to add order: ${listVM.errorMessage}'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('Pick bank account'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          // Catch any local parsing errors
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Error: ${e.toString()}'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                      isValid: !isSaving,
                                      isLoading: isSaving,
                                      title: "Place Order",
                                      margin: EdgeInsets.zero,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 30),
                                decoration: BoxDecoration(
                                    borderRadius: Constants.BORDER_RADIUS_15,
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const DefaultText(
                                      txt: "Total Price",
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    DefaultText(
                                      txt:
                                          "${(Provider.of<PaymentProvider>(context).totalPrice + Provider.of<AddOrderVM>(context).getTotalPrice())} EGP",
                                      color: Colors.white,
                                      bold: true,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
