import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tech/View%20Model/products_provider.dart';
import 'package:tech/view/widgets/product_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cateogryController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    int offset = 0;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<ProductProvider>(context, listen: false)
          .fetchproducts(offset);
    });

    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        offset = offset + 15;
        Provider.of<ProductProvider>(context, listen: false)
            .fetchproducts(offset);
      }
    });
  }

  // List<ProductModel> filtered = [];
  Filters? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProductProvider>(
      context,
    );

    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          leading: const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                child: Icon(Icons.person),
              )
            ],
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              Text('Abhishek Bansal', style: TextStyle(fontSize: 20))
            ],
          ),
          actions: [
            const Icon(Icons.notifications),
            PopupMenuButton<Filters>(
              tooltip: 'Cateogry',
              initialValue: selectedMenu,
              onSelected: (Filters item) {
                print(item);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Filters>>[
                PopupMenuItem<Filters>(
                  onTap: () {
                    provider.updatefilter('Name');
                  },
                  value: Filters.name,
                  child: const Text('Name'),
                ),
                PopupMenuItem<Filters>(
                  onTap: () {
                    provider.updatefilter('Title');
                  },
                  value: Filters.title,
                  child: const Text('Title'),
                ),
                PopupMenuItem<Filters>(
                  onTap: () {
                    provider.updatefilter('Price');
                  },
                  value: Filters.price,
                  child: const Text('Price'),
                ),
              ],
            )
          ],
        ),
        body: Stack(
          children: [
            const SizedBox(height: double.infinity, width: double.infinity),
            Positioned(
              top: 20,
              left: (w - w / 1.2) / 2,
              child: Container(
                width: w / 1.2,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 228, 223, 223),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  onChanged: (value) {
                    provider.filterProduct(value);
                  },
                  controller: _cateogryController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.category),
                    hintText: provider.selectedfilter != ''
                        ? 'Search with ${provider.selectedfilter}'
                        : 'Select a cateogry',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20 + h / 10,
              child: Container(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 200),
                  height: h,
                  width: w,
                  child: Consumer<ProductProvider>(
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          value.error==false?  value.productmodel.isEmpty?const Center(child: CircularProgressIndicator(),): Container():const Center(child: Text('Please check your internet connection'),),
                          Expanded(
                            child: GridView.builder(
                              controller: _scrollController,
                              itemCount: value.filtered.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 2 / 3),
                              itemBuilder: (context, index) {
                                return productgrid(value.filtered[index], context);
                              },
                            ),
                          ),
                         value.productmodel.isEmpty? Container(): value.isLoading == true
                              ? const CircularProgressIndicator()
                              : Container() 
                        ],
                      );
                    },
                  )),
            ),
          ],
        ));
  }

  
}