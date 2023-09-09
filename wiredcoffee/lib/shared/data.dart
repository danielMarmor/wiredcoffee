import '../models/category.dart';
import '../models/product.dart';

List<Category> categories = [
  Category(
      categoryId: 'pants',
      categoryName: 'Pants',
      iconImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC3Lqs7cpgUsPmFclOC15wj7zVTsbv-ySoKw&usqp=CAU'),
  Category(
      categoryId: 'scirt',
      categoryName: 'Scirts',
      iconImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRi0RI49SwqLumxpojO3Rz9srqVyZKKSEqWPQ&usqp=CAU'),
  Category(
      categoryId: 'shirts',
      categoryName: 'Shirts',
      iconImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQScicHTSDes-8UnnwqMVupK_0Sk2wE_7w_ug&usqp=CAU'),
  Category(
      categoryId: 'tie',
      categoryName: 'Ties',
      iconImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlroKy0RMum3KXHGsPYRlng2iyT3RnOTJoog&usqp=CAU'),
  Category(
      categoryId: 'watch',
      categoryName: 'Watches',
      iconImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBti99-JBqhJYI2oIbKUIjcDICdzPrmGXUQA&usqp=CAU'),
];

const String featuredCollectionPath =
    "products/featured_products_doc/featured_products";
const String achievesCollectionPath = "products/new_achieves_doc/new_achieves";
