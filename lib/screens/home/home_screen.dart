import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/controllers/HomeScreenController.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';
import 'package:grocery_app/widgets/search_bar_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../models/Product.dart';
import 'home_banner_widget.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeScreen({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends StateMVC<HomeScreen> {
  HomeScreenController _con;
  _HomeScreenState() : super(HomeScreenController()) {
    _con = controller;
  }

  Future<void> refresh() async {
    // _showDialog();
    await _con.refreshHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    //Image.asset("assets/images/grocery_images/engine-oil.jpg", scale: 7,),

                    SizedBox(
                      height: 5,
                    ),
                    padded(locationWidget()),
                    SizedBox(
                      height: 15,
                    ),
                    padded(SearchBarWidget()),
                    SizedBox(
                      height: 25,
                    ),
                    //HomeSliderWidget(),
                    padded(HomeBanner()),
                    SizedBox(
                      height: 25,
                    ),
                    padded(subTitle("Top Categories")),
                    //getHorizontalItemSlider(exclusiveOffers),
                    Container(
                      height: 250.0,
                      child: new ListView.builder(
                        itemCount: _con.topCategoryProducts.length,
                        itemBuilder: (context, index) {
                          return sliderWidget(index,  _con.topCategoryProducts);
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    padded(subTitle("Today's Deal")),
                    //getHorizontalItemSlider(bestSelling),
                    Container(
                      height: 250.0,
                      child: new ListView.builder(
                        itemCount: _con.todaysDealProducts.length,
                        itemBuilder: (context, index) {
                          return sliderWidget(index,  _con.todaysDealProducts);
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    padded(subTitle("Flash Sale")),
                    Container(
                      height: 250.0,
                      child: new ListView.builder(
                        itemCount: _con.flashCategoryProducts.length,
                        itemBuilder: (context, index) {
                          return sliderWidget(index,  _con.flashCategoryProducts);
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Container(
                    //   height: 105,
                    //   child: ListView(
                    //     padding: EdgeInsets.zero,
                    //     scrollDirection: Axis.horizontal,
                    //     children: [
                    //       SizedBox(
                    //         width: 20,
                    //       ),
                    //       GroceryFeaturedCard(
                    //         groceryFeaturedItems[0],
                    //         color: Color(0xffF8A44C),
                    //       ),
                    //       SizedBox(
                    //         width: 20,
                    //       ),
                    //       GroceryFeaturedCard(
                    //         groceryFeaturedItems[1],
                    //         color: AppColors.primaryColor,
                    //       ),
                    //       SizedBox(
                    //         width: 20,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    //getHorizontalItemSlider(groceries),
                    SizedBox(
                      height: 15,
                    ),
                    padded(subTitle("Featured Products")),
                    Container(
                      height: 250.0,
                      child: new ListView.builder(
                        itemCount: _con.featuredProducts.length,
                        itemBuilder: (context, index) {
                          return sliderWidget(index,  _con.featuredProducts);
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    //getHorizontalItemSlider(bestSelling),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // padded(subTitle("Our Sellers")),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // padded(SellerCardWidget("AXYZ imports", "assets/images/Banner_mobil.jpg", 'Dhanmondi, Dhaka')),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget getHorizontalItemSlider(List<Product> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 250,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onItemClicked(context, items[index]);
            },
            child: GroceryItemCardWidget(
              item: items[index],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20,
          );
        },
      ),
    );
  }

  void onItemClicked(BuildContext context, Product groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(groceryItem)),
    );
  }

  Widget subTitle(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          "See All",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
      ],
    );
  }

  Widget locationWidget() {
    String locationIconPath = "assets/icons/location_icon.svg";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          locationIconPath,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "Dhaka,Bangladesh",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
  Widget sliderWidget(int index, List prod){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 174,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffE2E2E2),
          ),
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.network(prod[index].product.media.url),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AppText(
                text: prod[index].product.name,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              AppText(
                text: prod[index].product.description,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF7C7C7C),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  AppText(
                    text: "\৳${prod[index].product.price.toStringAsFixed(2)}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      //add to cart function here
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: AppColors.primaryColor),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

