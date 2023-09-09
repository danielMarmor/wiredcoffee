// ignore: file_names
import 'package:flutter/material.dart';
import 'package:wiredcoffee/services/productService.dart';
import '../../screens/business/singleProduct.dart';

class ProductSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // This method is called to build actions for the AppBar (e.g., clear button)
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          // Clear the search query
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // This method is called to build the leading widget (e.g., back button)
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        // Close the search page when the back button is pressed
        close(context, null);
      },
    );
  }

//   @override
//   Widget buildResults(BuildContext context) {
//      // ignore: avoid_print
//      print("buildResults build");
//     return FutureBuilder(
//         //initialData: const <ProductSearchResult>[],
//         future: ProductService().getProductSearch(query),
//         builder: ((context, snapshot) {
//           // ignore: avoid_print
//           print("FutureBuilder build");
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               // ignore: avoid_print
//               print("snapshot error");
//               return Container();
//             }
//             if (snapshot.hasData) {
//               // ignore: avoid_print
//               print("snapshot length=${snapshot.data!.length}");
//               return Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       childAspectRatio: 150 / 250,
//                       crossAxisCount: 2, // number of items in each row
//                       mainAxisSpacing: 25.0, // spacing between rows
//                       crossAxisSpacing: 25.0,
//                     ),
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                           onTap: () {
//                             close(context, snapshot.data![index]);
//                           },
//                           child: SingleProduct(
//                               imageSrc: snapshot.data![index].imageSrc,
//                               name: snapshot.data![index].name,
//                               price: snapshot.data![index].price));
//                     }),
//               );
//             } else {
//               return Container();
//             }
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return Container();
//           }
//         }));
//   }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) {
    // ignore: avoid_print
    print("buildResults build");
    List<String> results = ['banana', 'apple', 'orange'];
    return Column(children: results.map((e) => Text(e)).toList());
  }
}
