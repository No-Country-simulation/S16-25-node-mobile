import 'package:app_patitas/onboarding/widgets/onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<OnboardingPage> {
  final getStorage = GetStorage();
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"text": "Bienvenido a Tianguis!", "image": "assets/images/splash_1.png"},
    {
      "text":
          "Aca encontramos los mejores productos para ti. \nEncontra el que mejor se adapte a ti",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "Contamos con variedad de libros para ti.",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    print(getStorage.read('token'));
    final myColors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => OnboardingWidget(
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 20 : 6,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? myColors.primary
                                  : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myColors.primary,
                        ),
                        onPressed: () async {
                          await getStorage.write("skipOnboarding", true);
                          //Get.offAllNamed(Routes.LOGIN);
                        },
                        child: const Text("Continue",
                            style: TextStyle(color: Colors.white)),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
