import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingIndicator extends StatefulWidget {
  const ShimmerLoadingIndicator({Key? key}) : super(key: key);

  @override
  State<ShimmerLoadingIndicator> createState() => _MobileFeedState();
}

class _MobileFeedState extends State<ShimmerLoadingIndicator> {
  Logger logger = Logger();

  @override
  void initState() {
    isLoading();
    super.initState();
  }

  Future<bool> isLoading() async {
    bool isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }

    return isLoading;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: FutureBuilder(
      future: isLoading(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return const Center(
            child: Text('display content here.'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade400,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: size.width * 0.45,
                                    height: size.height * 0.20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          color: Colors.white,
                                          width: size.width * 0.45,
                                          height: 15),
                                      const SizedBox(height: 10),
                                      Container(
                                          color: Colors.white,
                                          width: size.width * 0.22,
                                          height: 15),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 20)
                            ],
                          ),
                        );
                      }))));
        }
        if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return const Center(
          child: Text('??'),
        );
      }),
    ));
  }
  // floatingActionButton: null,
  // body: isLoading

  // return SingleChildScrollView(
  //   child: Column(children: const [
  //     Align(
  //         alignment: Alignment.center,
  //         child: Text('Search and discover recipes.')),

  //   ]),
  //);

}
