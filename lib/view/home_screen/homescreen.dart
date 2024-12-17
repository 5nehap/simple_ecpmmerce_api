import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ecpmmerce_api/controller/addtocartcontroller.dart';
import 'package:simple_ecpmmerce_api/controller/homescreenproductcontroller.dart'; 
import 'package:simple_ecpmmerce_api/view/shopscreen/shopscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController =
      TextEditingController(); 

  @override
  void initState() {
    super.initState();
  
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<Homescreenproductcontroller>().getshop();
      await context.read<MyCartController>().initDb();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LET'S SHOP",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
        actions: [
          Stack(
            children: [
              Icon(
                Icons.notifications_outlined,
                color: Colors.black,
                size: 30,
              ),
              Positioned(
                right: 0,
                top: 2,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.black,
                  child: Text(
                    "1",
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black, size: 30),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: Consumer<Homescreenproductcontroller>(
        builder: (context, providerObj, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 230, 228, 228),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller:
                                searchController, // Use the search controller
                            decoration: InputDecoration(
                              hintText: "Search Anything",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 129, 129, 129),
                                  fontSize: 16),
                              prefixIcon: Icon(
                                Icons.search_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  
                  
                  
                  SizedBox(height: 20),

                  
                  GridView.builder(
                    itemCount: providerObj.shopobj?.length ?? 0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 250,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductScreen(id: index),
                                  )),
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://assets.ajio.com/medias/sys_master/root/20240406/jTor/6610dc8616fd2c6e6aa17c06/-473Wx593H-466855053-yellow-MODEL.jpg"),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                height: 35,
                                width: 35,
                                child: Icon(
                                  Icons.favorite_outline,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          providerObj.shopobj?[index].id.toString() ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          providerObj.shopobj?[index].title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          providerObj.shopobj?[index].body ?? "",
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


