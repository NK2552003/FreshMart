import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _textAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final imgUrl = [
      "lib/assets/images/ingredients.jpeg",
      "lib/assets/images/vegi.jpeg",
      "lib/assets/images/spices.jpeg",
      "lib/assets/images/fruits.jpeg",
    ];
    final popularUrl = [
      "lib/assets/popular/banana.jpeg",
      "lib/assets/popular/carrot.jpeg",
      "lib/assets/popular/cauliflower.jpeg",
      "lib/assets/popular/vegi_2.webp",
    ];
    final popular = ['Banana', 'Carrot', 'CauliFlower', 'Vegitable'];
    final detail = [
      "Highly Rich in Protein and Calcium",
      "Best for Making GajarPak",
      "Rich in Calcuim",
      "Good for Health"
    ];
    final categ = ['Ingredients', 'Vegitables', 'Spices', 'Fruits'];
    final randomImg = [
      "https://source.unsplash.com/random/100×100/?peas",
      "https://source.unsplash.com/random/100×100/?cabbages",
      "https://source.unsplash.com/random/100x100/?onions",
      "https://source.unsplash.com/random/100x100/?potatoes",
      "https://source.unsplash.com/random/100x100/?beetroot",
      "https://source.unsplash.com/random/100x100/?broccoli",
      "https://source.unsplash.com/random/100x100/?dill",
      "https://source.unsplash.com/random/100x100/?garlic",
      "https://source.unsplash.com/random/100x100/?beans",
    ];
    final radomImgName = [
      "Peas",
      "Cabbages",
      "Onions",
      "Potatoes",
      "beetroot",
      "broccoli",
      "dill",
      "garlic",
      "beans"
    ];
    final proImg = [
      "https://source.unsplash.com/random/200x150/?garlic",
      "https://source.unsplash.com/random/200x150/?meat",
      "https://source.unsplash.com/random/200x150/?beef",
      "https://source.unsplash.com/random/200x150/?soda",
      "https://source.unsplash.com/random/200x150/?juice",
      "https://source.unsplash.com/random/200x150/?oil",
      "https://source.unsplash.com/random/200x150/?refind",
      "https://source.unsplash.com/random/200x150/?chilli",
      "https://source.unsplash.com/random/200x150/?leaf",
    ];
    final proDesc = [
      "Garlic",
      "Meat",
      "Beaf",
      "Soda",
      "Juice",
      "Oil",
      "Refind",
      "Chilli",
      "Leaf"
    ];
    final proPrice = ["60", "70", "100", "300", "30", "560", "70", "665", "70"];
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: AnimatedBuilder(
                animation: _textAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textAnimation.value,
                    child: Text(
                      'Good Day!🤗',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 80, 79, 79)
                            .withOpacity(_textAnimation.value),
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: AnimatedBuilder(
                animation: _textAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textAnimation.value,
                    child: Text(
                      'Let\'s order fresh items for you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade900
                            .withOpacity(_textAnimation.value),
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Must Order",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: 280,
            child: Swiper(
              autoplay: true,
              autoplayDelay: 3000,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Image.asset(
                      width: 449,
                      height: 280,
                      popularUrl[index],
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 22,
                      left: 26,
                      right: 26,
                      child: Card(
                        color: Colors.blueGrey.shade900,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                popular[index],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 8),
                              Text(
                                detail[index],
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle order button click
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.blueGrey.shade100,
                                        foregroundColor: Colors.black),
                                    child: Text('Order Now'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: 4,
              pagination: SwiperPagination(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Freshly Added",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: randomImg.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(left: 8),
                    width: 103,
                    margin: EdgeInsets.only(right: 8),
                    child: Column(
                      children: [
                        Container(
                          width: 103,
                          height: 160,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(randomImg[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          radomImgName[index],
                          maxLines: 2,
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Categories",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(left: 8),
                    width: 440,
                    margin: EdgeInsets.only(right: 8),
                    child: Column(
                      children: [
                        Image.asset(
                          width: 500,
                          height: 200,
                          imgUrl[index],
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          categ[index],
                          maxLines: 2,
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Deal of the Day",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: proImg.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        width: 150,
                        height: 110,
                        proImg[index],
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 16),
                      Container(
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    proDesc[index],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    'Rs. ${proPrice[index]}/kg',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle add button click
                                  },
                                  child: Text('Add to Cart+'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 130,
            width: MediaQuery.sizeOf(context).width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blueAccent.shade100,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("Rate This Application",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ),
                RatingBar.builder(
                  initialRating: 3.5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding:
                      EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.yellow.shade500,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
