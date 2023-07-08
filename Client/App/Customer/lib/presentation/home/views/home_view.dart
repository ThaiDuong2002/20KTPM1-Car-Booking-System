import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            flexibleSpace: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchBar(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            leading: InkWell(
                              child: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              onTap: () {
                                print('search');
                              },
                            ),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2)),
                            hintText: 'Tìm dịch vụ , món ngon, địa điểm',
                            hintStyle: const MaterialStatePropertyAll(TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.grey)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('account');
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.account_circle,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            automaticallyImplyLeading: false,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage("assets/images/home/bike.png"),
                            fit: BoxFit.fitWidth,
                          ),
                          Text(
                            'GoBike',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage("assets/images/home/car.png"),
                            fit: BoxFit.fitWidth,
                          ),
                          Text(
                            'GoCar',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage("assets/images/home/food.png"),
                            fit: BoxFit.fitWidth,
                          ),
                          Text(
                            'GoFood',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  Expanded(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage("assets/images/home/send.png"),
                            fit: BoxFit.fitWidth,
                          ),
                          Text(
                            'GoSend',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
