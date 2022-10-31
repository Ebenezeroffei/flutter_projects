import 'package:flutter/material.dart';
import './utils.dart';

class DogiconSubBreeds extends StatelessWidget {
  String breed;
  DogiconSubBreeds(this.breed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils();
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(breed.toUpperCase()),
        elevation: 1,
      ),
      body: FutureBuilder<List>(
        future: utils.getSubBreeds(breed),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.requireData;
            return PageView(
              children: <Widget>[
                ...data.map(
                  (e) {
                    Image image = Image.network(e, fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                      double? expected =
                          loadingProgress?.expectedTotalBytes?.toDouble();
                      double? downloaded =
                          loadingProgress?.cumulativeBytesLoaded.toDouble();
                      return loadingProgress == null
                          ? child
                          : Center(
                              child: CircularProgressIndicator(
                                value: (downloaded! / expected!) * 1,
                              ),
                            );
                    });
                    return InteractiveViewer(
                      panEnabled: false,
                      boundaryMargin: const EdgeInsets.all(5),
                      maxScale: 2,
                      minScale: 0.5,
                      child: image,
                    );
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "400",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w200,
                        ),
                  ),
                  Text(
                    "Error Loading Page",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
