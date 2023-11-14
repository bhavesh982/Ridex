import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:login/pages/dashboard.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({ Key? key }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _current = 0;
  dynamic _selectedIndex = {};

  final CarouselController _carouselController = CarouselController();

  final List<dynamic> _products = [
    {
      'title': 'Adidas Originals \nby Alexander Wang',
      'image': 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzV8fGFkaWRhc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
      'description': 'Limited collection'
    },
    {
      'title': 'Adidas Originals \nby Alexander Wang',
      'image': 'https://images.unsplash.com/photo-1582588678413-dbf45f4823e9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2265&q=80',
      'description': 'Limited collection'
    },
    {
      'title': 'Adidas Originals \nby Alexander Wang',
      'image': 'https://images.unsplash.com/photo-1589188056053-28910dc61d38?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2264&q=80',
      'description': 'Limited collection'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedIndex.length > 0 ? FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.arrow_forward_ios),
      ) : null,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('@theflutterlover', style: TextStyle(
          color: Colors.black,
        ),),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
                height: 450.0,
                aspectRatio: 16/9,
                viewportFraction: 0.70,
                enlargeCenterPage: true,
                pageSnapping: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }
            ),
            items: _products.map((movie) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedIndex == movie) {
                          _selectedIndex = {};
                        } else {
                          _selectedIndex = movie;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: _selectedIndex == movie ? Border.all(color: Colors.blue.shade500, width: 3) : null,
                          boxShadow: _selectedIndex == movie ? [
                            BoxShadow(
                                color: Colors.blue.shade100,
                                blurRadius: 30,
                                offset: const Offset(0, 10)
                            )
                          ] : [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 5)
                            )
                          ]
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 320,
                              margin: const EdgeInsets.only(top: 10),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                  imageUrl: movie['image'],
                                  placeholder:(context,url)=> const LinearProgressIndicator(),
                                  imageBuilder: (context,imageprovider){
                                    return Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageprovider,
                                            fit: BoxFit.fill
                                          )
                                        ),
                                    );
                                  },
                                ),
                            ),
                            const SizedBox(height: 20,),
                            Text(movie['title'], style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                            const SizedBox(height: 20,),
                            TextButton(onPressed:(){
                              Navigator.push(context, MaterialPageRoute(builder: (c)=>const Dashboard()));
                            }, child: Text("go")),
                            Text(movie['description'], style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600
                            ),),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList()
        ),
      ),
    );
  }
}