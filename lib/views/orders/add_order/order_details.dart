import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/add_order/add_payment.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/add_order_v_m.dart';
import 'package:warsha_app/views/orders/add_order/widgets/order_details_widget.dart';
import 'package:warsha_app/controllers/add_order/add_customer.dart';
import 'package:warsha_app/utils/default_button.dart';

class OrderDetailsStep extends StatelessWidget {
  const OrderDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const DefaultText(txt: "Add New Order")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade50,
              Colors.yellow.shade200
            ], // Replace with your colors
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
                              Expanded(
                                child: Consumer2<AddOrderVM, PaymentProvider>(
                                  builder: (context, order, payment,
                                          child) =>
                                      DefaultButton(
                                    onTap: () async {
                                      if (order.orderModel.customer != null) {
                                        await order.addOrder(
                                          customerID:
                                              order.orderModel.customer!.id,
                                          orderItems:
                                              order.orderModel.orderItems,
                                          delivery: payment.delivery.text,
                                          downPayment: payment.downPayment.text,
                                          discount: payment.discount.text,
                                          paymentMethod:
                                              payment.paymentMethod.text,
                                          orderSource:
                                              payment.platformSource.text,
                                        );

                                        Navigator.pop(context);
                                        payment.clearPaymentDetails();
                                        order.clearOrder();

                                        order.initAllOrders();
                                      }
                                    },
                                    isValid: !Provider.of<AddOrderVM>(context)
                                        .isLoading,
                                    isLoading:
                                        Provider.of<AddOrderVM>(context).isLoading,
                                    title: "Place Order",
                                    margin: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
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

