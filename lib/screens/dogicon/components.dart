import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  bool isMainPage;
  List? breeds;
  CustomAppBar({Key? key, this.isMainPage = true, this.breeds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: true,
      expandedHeight: 250,
      pinned: true,
      elevation: 1,
      scrolledUnderElevation: 20,
      actions: isMainPage
          ? [
              IconButton(
                onPressed: () async {
                  List? fav = breeds
                      ?.where((element) => element['favourite'] == true)
                      .map((e) => e['name'])
                      .toList();
                  Navigator.pushNamed(context, '/dogicon/favourites',
                      arguments: fav);
                },
                icon: const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                splashRadius: 25,
              )
            ]
          : null,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text("Dogicon"),
        background: Image.network(
          "https://images.dog.ceo/breeds/appenzeller/n02107908_671.jpg",
          colorBlendMode: BlendMode.darken,
          color: Colors.black38,
          loadingBuilder: (context, child, loadingProgress) {
            return loadingProgress == null
                ? child
                : const Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.white24,
                      ),
                    ),
                  );
          },
          fit: BoxFit.cover,
        ),
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
          StretchMode.zoomBackground,
        ],
      ),
    );
  }
}

Widget dogiconHomeConsumer(context, value, child) {
  return value.loading
      ? const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        )
      : SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              int breedIndex = index;
              String breed = value.breeds[index]['name'].toUpperCase();
              bool isFav = value.breeds[index]['favourite'];

              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    title: Text(breed),
                    onTap: () async {
                      Navigator.pushNamed(context, '/dogicon/sub-breeds',
                          arguments: breed.toLowerCase());
                    },
                    trailing: IconButton(
                      onPressed: () =>
                          value.toggleFavouriteBreed(isFav, breedIndex),
                      icon: isFav
                          ? const Icon(
                              Icons.star,
                              color: Colors.amber,
                            )
                          : const Icon(
                              Icons.star_border,
                            ),
                      splashRadius: 25,
                    ),
                  ),
                ),
              );
            },
            childCount: value.breeds.length,
          ),
        );
}
