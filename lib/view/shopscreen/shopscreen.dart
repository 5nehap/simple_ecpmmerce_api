import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ecpmmerce_api/controller/addtocartcontroller.dart';
import 'package:simple_ecpmmerce_api/controller/product_detail.dart';
import 'package:simple_ecpmmerce_api/view/add_to_cartscreen/add_cartscreen.dart';

class ProductScreen extends StatefulWidget {
  final int id;
  const ProductScreen({required this.id, super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context
            .read<ProductDetailController>()
            .getProductDetail(widget.id);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          Stack(
            children: [
              Icon(
                Icons.notifications_none_outlined,
                color: Colors.black,
                size: 35,
              ),
              Positioned(
                right: 0,
                top: 3,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 10,
                  child: Text(
                    "1",
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 15)
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Consumer<ProductDetailController>(
                builder: (context, productprovider, child) {
              if (productprovider.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (productprovider.product == null) {
                return Center(child: Text("Product not found"));
              }

              var product = productprovider.product;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(""), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.favorite_outline,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    product?.title?.toString() ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        product?.id?.toString() ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color.fromARGB(255, 97, 94, 94)),
                      ),
                      SizedBox(width: 25),
                      Text(
                        "rating",
                        style: TextStyle(
                            color: Color.fromARGB(255, 95, 92, 92),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  Text(
                    product?.body?.toString() ?? "",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    product?.id?.toString() ?? "",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Choose size",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      sizeOption("S"),
                      SizedBox(width: 10),
                      sizeOption("M"),
                      SizedBox(width: 10),
                      sizeOption("L"),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: Consumer<ProductDetailController>(
        builder: (context, priceprovider, child) => Padding(
          padding: const EdgeInsets.all(10),
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.blueGrey),
                    ),
                    Text(
                      priceprovider.product?.id?.toString() ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black),
                    )
                  ],
                ),
                SizedBox(width: 45),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context
                          .read<MyCartController>()
                          .addProduct(priceprovider.product!);
                      context.read<MyCartController>().getAllProducts();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyCart(),
                        ),
                      );
                    },
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_mall_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Add to Cart",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ],
                      ),
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

  Widget sizeOption(String size) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 2, color: Colors.grey)),
      child: Center(
        child: Text(
          size,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
