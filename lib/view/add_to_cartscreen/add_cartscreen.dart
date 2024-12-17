import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:simple_ecpmmerce_api/controller/addtocartcontroller.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<MyCartController>().getAllProducts();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Cart")),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            context.watch<MyCartController>().storedProducts.length,
            (index) {
              final cartController = context.watch<MyCartController>();
              return Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                height: 230,
                width: double.infinity,
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 191, 196, 200)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(""))),
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                cartController.storedProducts[index]["name"],
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: 200,
                              child: Text(
                                "\$ ${cartController.storedProducts[index]["title"]}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                int currentQty =
                                    cartController.storedProducts[index]['qty'];
                                cartController.incrementQty(
                                    cartController.storedProducts[index]['id'],
                                    currentQty);
                              },
                              child: Container(
                                  height: 25,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Icon(Icons.add)),
                            ),
                            Text(
                              context
                                  .watch<MyCartController>()
                                  .storedProducts[index]["qty"]
                                  .toString(),
                            ),
                            InkWell(
                              onTap: () {
                                int currentQty =
                                    cartController.storedProducts[index]['qty'];
                                cartController.decrementQty(
                                    cartController.storedProducts[index]['id'],
                                    currentQty);
                              },
                              child: Container(
                                  height: 25,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Icon(
                                    Icons.remove,
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        context.read<MyCartController>().removeProduct(
                            cartController.storedProducts[index]['id']);
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          "Remove",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Total Amount :",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Text(
                      context
                          .read<MyCartController>()
                          .totalCartVAlue
                          .toStringAsFixed(2),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 29,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Razorpay razorpay = Razorpay();
                    var options = {
                      'key': 'rzp_test_1DP5mmOlF5G5ag',
                      'amount': 100,
                      'name': 'Acme Corp.',
                      'description': 'Fine T-Shirt',
                      'retry': {'enabled': false, 'max_count': 1},
                      'send_sms_hash': true,
                      'prefill': {
                        'contact': '8888888888',
                        'email': 'test@razorpay.com'
                      },
                      'external': {'wallets': ['paytm']}
                    };
                    razorpay.on(
                      Razorpay.EVENT_PAYMENT_ERROR,
                      handlePaymentErrorResponse,
                    );
                    razorpay.on(
                      Razorpay.EVENT_PAYMENT_SUCCESS,
                      handlePaymentSuccessResponse,
                    );
                    razorpay.on(
                      Razorpay.EVENT_EXTERNAL_WALLET,
                      handleExternalWalletSelected,
                    );
                    razorpay.open(options);
                  },
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Checkout",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(
      context,
      'Payment Failed',
      'Code: ${response.code}\n'
          'Description: ${response.message}\n'
          'Metadata: ${response.error.toString()}',
    );
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    showAlertDialog(
      context,
      'Payment Successful',
      'Payment ID: ${response.paymentId}',
    );
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
      context,
      'External Wallet Selected',
      '${response.walletName}',
    );
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }
}
