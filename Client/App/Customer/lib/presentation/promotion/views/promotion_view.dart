import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PromotionView extends StatelessWidget {
  const PromotionView({super.key});
  @override
  Widget build(BuildContext context) {
    final List itemPromotions = [
      {
        "name": "GoCar",
        "item": "Giảm 50% tối đa 20k cho 2 đơn hàng đầu tiên",
      },
      {
        "name": "GoBike",
        "item": "Giảm 30% tối đa 60k cho 1 đơn hàng đầu tiên",
      }
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text('Ưu đãi',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.black)),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_offer_outlined,
                      color: Colors.amber,
                    ),
                    Text(' Bạn có khuyến mãi? Hãy nhập vào đây',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.black)),
                    const Spacer(), // This wil
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Ưu đãi hot phải đặt ngay",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black)),
              Row(
                children: [
                  ...itemPromotions.map((promotionItem) => Container(
                        margin: const EdgeInsets.only(right: 10, top: 10),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(promotionItem['name'],
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.black)),
                        ),
                      ))
                ],
              ),
              const Divider(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                        2,
                        (index) => Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                      itemPromotions[index]['item'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          color: Colors.white)),
                                ),
                              ),
                            )).toList()
                  ],
                ),
              )
            ],
          )),
    );
  }
}
