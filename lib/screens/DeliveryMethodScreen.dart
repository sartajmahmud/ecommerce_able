
import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/SellerSelectionScreen.dart';
import 'package:grocery_app/screens/PaymentMethodScreen.dart';

class DeliveryMethodScreen extends StatefulWidget {
  DeliveryMethodScreen();

  @override
  _DeliveryMethodScreenState createState() => _DeliveryMethodScreenState();
}

class _DeliveryMethodScreenState extends State<DeliveryMethodScreen> {
  int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: padded(BottomAppBar(
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
        ),
        child: InkWell(
          onTap: (){
            switch(selectedIndex){
              case 0:
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PaymentMethodScreen()));
                break;
              case 1:
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SellerSelectionScreen()));
                break;
            }
          },
          child: Container(
            height: 75,
            decoration: BoxDecoration(
                color: Color(0xff53B175),
                borderRadius: BorderRadius.circular(18)),
            child: Center(
                child: Text(
                  'Confirm',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                )),
          ),
        ),
      )),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(left: 25),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: AppText(
            text: "Select Delivery Method",
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          padded( InkWell(
            onTap: (){
              selectedIndex = 0;
              setState(() {

              });
              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PaymentMethodScreen()));
            },
            child: Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 5,
                    color: selectedIndex==0 ? Colors.green : Color(0xffE2E2E2),
                  ),
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Center(child: AppText(text: 'Home Delivery',fontWeight: FontWeight.w600,))
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Image.network('https://w1.pngwing.com/pngs/546/859/png-transparent-food-icon-delivery-icon-sushi-pizza-delivery-scooter-courier-food-delivery-text-thumbnail.png'),

                          ))
                    ],
                  ),
                ),
              ),
          ),),
          padded( InkWell(
            onTap: (){
              selectedIndex = 1;
              setState(() {

              });
              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SellerSelectionScreen()));
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: selectedIndex==1 ? Colors.green : Color(0xffE2E2E2),
                ),
                borderRadius: BorderRadius.circular(
                  18,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Center(child: AppText(text: 'Pick Up',fontWeight: FontWeight.w600,))
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Image.network('https://cdn2.iconfinder.com/data/icons/logistic-and-shipping-industry-for-export-and-impo/297/logistic-7-512.png'),

                        ))
                  ],
                ),
              ),
            ),
          ),),
        ],
      ),
    );
  }
  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: widget,
    );
  }
}
