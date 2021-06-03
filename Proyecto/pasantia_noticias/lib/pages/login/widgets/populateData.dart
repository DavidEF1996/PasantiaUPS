import 'package:flutter/material.dart';
import 'package:pasantia_noticias/pages/login/widgets/notices.dart';

List<Noticias> noticias = Noticias.noticias_album();
List<Noticias> populateData() {
  final List<Noticias> pagingProducts = [];
  var index = 0;
  for (int i = 0; i < noticias.length; i++) {
    if (index == 3) index = 0;
    print(index);

    /* var p = new Noticias(
        name: pagingProductRepository.names[i],
        price: pagingProductRepository.prices[i],
        image: 'images/${pagingProductRepository.names1[i % 22] + '.jpg'}',
        offer: pagingProductRepository.offer[i],
        ratings: pagingProductRepository.ratings[i],
        reviewValue: pagingProductRepository.reviewValue[i],
        weight: pagingProductRepository.weights[i]);*/

    index++;
  }

  return pagingProducts;
}
