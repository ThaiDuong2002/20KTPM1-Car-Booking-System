import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/presentation/verify_promotion/views/verify_promotion_page.dart';
import 'package:user/presentation/widget/custom_text.dart';

class PromotionView extends StatelessWidget {
  const PromotionView({super.key});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => const FractionallySizedBox(
          heightFactor: 0.85, child: VerifyPromotionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List promotion = [
      {
        "image": "assets/images/promotion/2.png",
        "title": "Ưu đãi cuốc xe cho thành viên mới",
        "description": "Giảm 50% cho đơn hàng đầu tiên",
      },
      {
        "image": "assets/images/promotion/2.png",
        "title": "Ưu đãi cuốc xe cho thành viên mới",
        "description": "Giảm 50% cho đơn hàng đầu tiên",
      },
      {
        "image": "assets/images/promotion/2.png",
        "title": "Ưu đãi cuốc xe cho thành viên mới",
        "description": "Giảm 50% cho đơn hàng đầu tiên",
      },
    ];
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
        actions: [
          Center(
            child: InkWell(
              onTap: () {
                print("Ưu đãi của tôi");
              },
              child: const TextCustom(
                  text: "Ưu đãi của tôi",
                  color: COLOR_TEXT_BLACK,
                  fontSize: FONT_SIZE_NORMAL,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 10),
        ],
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                child: InkWell(
                  onTap: () {
                    _showBottomSheet(context);
                  },
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
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
              Expanded(
                  child: ListView.builder(
                itemCount: promotion.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/detailPromotionPage',
                          arguments: promotion[index]);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            promotion[index]['title'],
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            promotion[index]['description'],
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(promotion[index]['image'])),
                        ],
                      ),
                    ),
                  );
                },
              ))
            ],
          )),
    );
  }
}
