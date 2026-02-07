import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/add_order/add_customer.dart';
import 'package:warsha_app/controllers/update_order/updatePaymentDetails.dart';
import 'package:warsha_app/models/orderModel.dart';
import 'package:warsha_app/view_models/order_v_m.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/deafualt_form_field.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/customers_v_m.dart';
import 'package:warsha_app/view_models/add_product_v_m.dart';
import 'package:warsha_app/view_models/update_order_v_m.dart';
import 'package:warsha_app/views/orders/update_order/customer_to_update.dart';
import 'package:warsha_app/views/orders/update_order/product_to_update.dart';
import 'package:warsha_app/views/orders/update_order/update_order_details.dart';

class UpdateOrder extends StatelessWidget {
  final OrderModel existingOrder;
  const UpdateOrder({super.key, required this.existingOrder});

  @override
  Widget build(BuildContext context) {
    final orderVM = context.read<UpdateOrderVM>();
    final payment = context.read<UpdatePaymentDetails>();

    // Pre-fill only once if editing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderVM.loadOrder(existingOrder);
      payment.loadPayment(existingOrder);
    });

    return Consumer<CustomerProvider>(
      builder: (context, value, child) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const DefaultText(
            txt: "Update Order",
          ),
        ),
        body: Container(
          child: Row(
            children: [
              // Order details panel
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
                        const UpdateOrderDetails(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DefaultButton(
                                    onTap: () async {
                                      final customer =
                                          orderVM.orderModel.customer;
                                      if (customer == null) return;

                                      await Provider.of<OrderVM>(context, listen: false).updateOrder(
                                        orderID: orderVM.orderModel.orderId.toString(),
                                        customerID: customer.customerId.toString(),
                                        orderItems:
                                        orderVM.orderModel.orderItems,
                                        delivery: payment.delivery.text,
                                        downPayment: payment.downPayment.text,
                                        discount: payment.discount.text,
                                        notes: payment.notes.text,
                                        paymentMethod:
                                        payment.paymentMethod.text,
                                        orderSource:
                                        payment.platformSource.text,
                                      );

                                      Navigator.pop(context);
                                      payment.clearPaymentDetails();
                                      value.clearCustomer();
                                      Provider.of<ProductVM>(context, listen: false).initAllProducts();
                                    },
                                    isValid: !Provider.of<OrderVM>(context).isSaving,
                                    isLoading: Provider.of<OrderVM>(context).isSaving,
                                    title: "Update Order",
                                    margin: EdgeInsets.zero,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 30),
                                  decoration: BoxDecoration(
                                    borderRadius: Constants.BORDER_RADIUS_15,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
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
                                        "${(Provider.of<UpdatePaymentDetails>(context).totalPrice + Provider.of<UpdateOrderVM>(context).getTotalPrice())} EGP",
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

              // Products panel
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 15, right: 7, left: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: Constants.BORDER_RADIUS_15,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [DefaultText(txt: "Products")],
                            ),
                          ),
                          const SizedBox(height: 20),
                          DefaultForm(
                            title: 'Search For Products',
                            controller:
                                context.read<ProductVM>().searchController,
                            numberOfLines: 1,
                          ),
                          const SizedBox(height: 20),
                          const ProductToUpdate(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Customers panel
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 15, right: 15, left: 7),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: Constants.BORDER_RADIUS_15,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [DefaultText(txt: "Customers")],
                            ),
                          ),
                          const SizedBox(height: 20),
                          DefaultForm(
                            title: 'Search For Customer',
                            controller:
                                context.read<CustomerVM>().searchController,
                            numberOfLines: 1,
                          ),
                          const SizedBox(height: 20),
                          const CustomerToUpdate(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

