import 'package:flutter/material.dart';
import 'package:flutter_tuts/screens/dogicon/components.dart';

class DogiconFavourites extends StatelessWidget {
  List favourites;
  DogiconFavourites(this.favourites, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 240),
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            isMainPage: false,
          ),
          favourites.isNotEmpty
              ? SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    String breed = favourites[index].toUpperCase();
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Card(
                        elevation: 0,
                        child: ListTile(
                          title: Text(breed),
                        ),
                      ),
                    );
                  }, childCount: favourites.length),
                )
              : SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 100, left: 10, right: 10),
                    child: Text(
                      "No Favourites Have Been Added...",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.black54),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
