import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/data/dummy_data/home_dummy.dart';
import 'package:matchchayn/ui/constants/app_colors.dart';
import 'package:matchchayn/ui/core/primary_button.dart';
import 'package:matchchayn/ui/likes/logic/like_screen_state.dart';

import '../../app_router/route_destinations.dart';
import '../app_theme/app_theme.dart';
import '../core/gradient_text.dart';
import 'logic/like_screen_cubit.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => LikesCubit(), child: LikesScreenView());
  }
}

class LikesScreenView extends StatefulWidget {
  const LikesScreenView({super.key});

  @override
  State<LikesScreenView> createState() => _LikesScreenViewState();
}

class _LikesScreenViewState extends State<LikesScreenView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  bool showMyLikesListing = false;
  bool showWhoLikeMeListing = false;
  bool isLoading = false;

  final tabs = ["Liked me", "My likes"];
  final icons = [
    "assets/icons/love.svg",
    "assets/icons/heart-search.svg",
  ]; // Replace with your icons

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    _scrollController = ScrollController();
    context.read<LikesCubit>().isUserSubscribed();
    super.initState();
  }

  //it should have a red background color
  _showErrorOccurredSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.criticalActionColor,
        content: Text('Something went wrong!'),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        decoration: AppTheme.surfaceGradientBox(),
        child: BlocListener<LikesCubit, LikeScreenState>(
          listener: (context, state) {
            if (state is LikeScreenStateLoading) {
              setState(() {
                isLoading = true;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
            if (state is LikeScreenStateError) {
              _showErrorOccurredSnackBar(context);
            }
            if (state is LikeScreenStateInitial) {
              setState(() {
                showMyLikesListing = false;
                showWhoLikeMeListing = false;
              });
            }
            if (state is LikeScreenStateError) {
              _showErrorOccurredSnackBar(context);
            }
            if (state is LikeScreenStateSuccess) {
              setState(() {
                showMyLikesListing = state.isUserSubscribed;
                showWhoLikeMeListing = state.isUserSubscribed;
              });
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: statusBarHeight),
            child: Column(
              children: [
                SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryLinearGradient(),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Row(
                    children: List.generate(tabs.length, (index) {
                      final isSelected = _tabController.index == index;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _tabController.index = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 25,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  icons[index],
                                  colorFilter: isSelected
                                      ? null
                                      : ColorFilter.mode(
                                          AppColors.whiteColor,
                                          BlendMode.srcIn,
                                        ),
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(width: 8),
                                isSelected
                                    ? GradientText(
                                        text: tabs[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                        gradient:
                                            AppTheme.primaryLinearGradient(),
                                      )
                                    : Text(
                                        tabs[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    gradient: isSelected
                                        ? AppTheme.primaryLinearGradient()
                                        : null,
                                    borderRadius: BorderRadius.circular(3),
                                    color: isSelected
                                        ? null
                                        : AppColors.whiteColor,
                                  ),
                                  child: isSelected
                                      ? Text(
                                          "12",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                //fontSize: 6,
                                              ),
                                        )
                                      : GradientText(
                                          text: "5",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              //  fontSize: 6,
                                              ),
                                          gradient:
                                              AppTheme.primaryLinearGradient(),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 24),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SizedBox(
                        child:  showWhoLikeMeListing
                            ? ProfileListing(
                                scrollController: _scrollController,
                              )
                            : EmptyLikesView(
                                isMyLikes: false,
                                onPressed: () async {
                                  final result = await context.push(
                                    RouteDestinations.premium,
                                  );
                                  //  showWhoLikeMeListing = true;
                                  if (context.mounted) {
                                    context
                                        .read<LikesCubit>()
                                        .isUserSubscribed();
                                  }
                                },
                              ),
                      ),
                      SizedBox(
                        child: showMyLikesListing
                            ? ProfileListing(
                                scrollController: _scrollController,
                              )
                            : EmptyLikesView(
                                isMyLikes: true,
                                onPressed: () async {
                                  final result = await context.push(
                                    RouteDestinations.premium,
                                  );
                                  //  showWhoLikeMeListing = true;
                                  if (context.mounted) {
                                    context
                                        .read<LikesCubit>()
                                        .isUserSubscribed();
                                  }
                                },
                              ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileCardInfoSmall extends StatelessWidget {
  const ProfileCardInfoSmall({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    //  fontSize: 4,
                      color: AppColors.alertBlackColor,
                    ),
                  ),
                  SizedBox(width: 4),
                  SvgPicture.asset(
                    "assets/icons/check-badge.svg",
                    width: 16,
                    height: 17,
                  ),
                ],
              ),
              // Text(
              //   "Confident, open-minded and here for real vibes only.",
              //   style: Theme.of(context).textTheme.labelSmall?.copyWith(
              //     fontSize: 3,
              //     color: AppColors.alertBlackColor,
              //   ),
              // ),
            ],
          ),

          // Expanded(
          //   child: Wrap(
          //     spacing: 4,
          //     runSpacing: 4,
          //     alignment: WrapAlignment.end,
          //     crossAxisAlignment: WrapCrossAlignment.center,
          //     children: [
          //       Container(
          //         padding: const EdgeInsets.symmetric(
          //           horizontal: 10,
          //           vertical: 5,
          //         ),
          //         decoration: BoxDecoration(
          //           color: AppColors.alertBlackColor,
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         child: Text(
          //           "Cooking",
          //           style: Theme.of(
          //             context,
          //           ).textTheme.labelSmall,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ProfileListing extends StatelessWidget {
  const ProfileListing({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      primary: false,
      padding: const EdgeInsets.all(0),
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8, // Lower value = taller cards
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: imagesMixed[index],
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: AppColors.alertGreyColor,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                  errorWidget: (context, url, error) =>
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      defaultImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                   //   Image.asset(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),

            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ProfileCardInfoSmall(
                name: names[index],
              ),
            ),
          ],
        );
      },
    );
  }
}

class EmptyLikesView extends StatelessWidget {
  const EmptyLikesView({
    super.key,
    required this.onPressed,
    this.isMyLikes = false,
  });

  final void Function() onPressed;
  final bool isMyLikes;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 86,
          height: 86,
          decoration: BoxDecoration(
            color: Colors.white, // White background
            shape: BoxShape.circle, // Circular shape
          ),
          child: Center(
            child: SvgPicture.asset(
              isMyLikes
                  ? "assets/icons/heart-search.svg"
                  : "assets/icons/love.svg",
              width: 56, // Adjust icon size as needed
              height: 56,
            ),
          ),
        ),
        SizedBox(height: 43),
        Text(
          isMyLikes ? "You haven’t made a move yet?" : "No likes yet?",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(),
        ),
        SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            isMyLikes
                ? "Your perfect match could be one swipe away. Send a like, and see where it goes. You never know who’s been waiting for you."
                : "New match requests will be shown here.  Activate premium to unlock more matches daily and boost your chances of being seen by people who are already looking for someone like you.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        SizedBox(height: 60),
        PrimaryButton(
          text: isMyLikes ? "Start exploring" : "Upgrade to premium",
          onPressed: onPressed,
        ),
      ],
    );
  }
}
