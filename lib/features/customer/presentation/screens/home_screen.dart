import 'package:flutter/material.dart';
import 'cart_screen.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          title: const Text('Discover'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const CustomerCartScreen()));
                },
                child: const CircleAvatar(backgroundColor: Color(0xFFFF2C6D), child: Icon(Icons.shopping_bag, color: Colors.white)),
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search restaurants or dishes',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Popular near you', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (BuildContext context, int index) {
                      return AspectRatio(
                        aspectRatio: 1.2,
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.pink.shade50,
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                  ),
                                  child: const Center(child: Icon(Icons.restaurant, size: 48, color: Color(0xFFE01E5A))),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text('Sample Restaurant', style: TextStyle(fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

