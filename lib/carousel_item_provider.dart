import 'package:firebase_storage/firebase_storage.dart';
import 'carousel_item.dart';

class CarouselItemsProvider {
  final FirebaseStorage _storage =
  FirebaseStorage.instanceFor(bucket: 'gs://firestoragecarousel.appspot.com/');

  Future<List<CarouselItem>> getCarouselItems() async {
    final ListResult result =
    await _storage.ref().child('test').listAll();

    final List<CarouselItem> carouselItems = [];

    for (final ref in result.items) {
      final downloadUrl = await ref.getDownloadURL();
      final metadata = await ref.getMetadata();

      final carouselItem = CarouselItem(
        imageUrl: downloadUrl,
        caption: metadata.name,
      );

      carouselItems.add(carouselItem);
    }

    return carouselItems;
  }
}
