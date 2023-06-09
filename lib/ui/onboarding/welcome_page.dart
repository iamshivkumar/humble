import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:humble/ui/auth/login_page.dart';
import 'package:humble/ui/utils/extensions.dart';

import 'data.dart';

class WelcomePage extends HookWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        useTabController(initialLength: OnboardingData.intros.length);

    final index = useState(0);

    controller.addListener(() {
      if (index.value != controller.index) {
        index.value = controller.index;
      }
    });

    return Scaffold(
      backgroundColor: context.scheme.surface,
      appBar: AppBar(
        centerTitle: false,
        // titleSpacing: 0,
        // leadingWidth: 40 + 16 + 8,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 16.0),
        //   child: Row(
        //     children: [
        //       // ClipRRect(
        //       //   // borderRadius: BorderRadius.circular(3000),
        //       //   child: SvgPicture.asset(
        //       //     Assets.logo,
        //       //     height: 40,
        //       //     width: 40,
        //       //   ),
        //       // ),
        //       const SizedBox(width: 8),
        //     ],
        //   ),
        // ),
        title: const Text('Humble'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TabBarView(
                controller: controller,
                children: OnboardingData.intros
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                e.title,
                                style: context.style.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.scheme.onSurface,
                                ),
                              ),
                            ),
                            e.description != null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e.description!,
                                      style: context.style.titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.normal),
                                    ),
                                  )
                                : const SizedBox(),
                            // Expanded(
                            //   flex: 6,
                            //   child: SvgPicture.asset(
                            //     e.path,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: OnboardingData.intros
                    .map(
                      (e) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index.value == OnboardingData.intros.indexOf(e)
                              ? context.scheme.primary
                              : context.scheme.outline,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      color: context.scheme.tertiary,
                      textColor: context.scheme.onTertiary,
                      onPressed: () {},
                      padding: const EdgeInsets.all(24),
                      // child: const Text('Register'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: MaterialButton(
                      color: context.scheme.primary,
                      textColor: context.scheme.onPrimary,
                      onPressed: () {
                        // context.pushNamed(LoginPage.route);
                      },
                      padding: const EdgeInsets.all(24),
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
