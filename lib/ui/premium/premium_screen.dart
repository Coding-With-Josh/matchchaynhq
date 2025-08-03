import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:matchchayn/ui/core/primary_button.dart';
import 'package:matchchayn/ui/premium/logic/WalletCubit.dart';
import 'package:matchchayn/ui/premium/logic/config.dart';
import 'package:matchchayn/ui/premium/logic/wallet_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme/app_theme.dart';
import '../constants/app_colors.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WalletCubit(),
      child: PremiumScreenView(),
    );
  }
}

class PremiumScreenView extends StatefulWidget {
  const PremiumScreenView({super.key});

  @override
  State<PremiumScreenView> createState() => _PremiumScreenViewState();
}

class _PremiumScreenViewState extends State<PremiumScreenView> {
  static const solflarePlaystoreUrl =
      "https://play.google.com/store/apps/details?id=com.solflare.mobile";
  bool isWalletConnected = false;
  String walletAddress = "";
  String walletName = "";
  double balance = 0.0;
  bool isLoading = false;
  bool isUserSubscribed = false;

  String getWalletAddress() {
    if (walletAddress.isEmpty) {
      return "";
    } else if (walletAddress.length <= 6) {
      return walletAddress;
    } else {
      return "${walletAddress.substring(0, 4)}...${walletAddress.substring(walletAddress.length - 4)}";
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri parsedUrl = Uri.parse(url);
    if (!await launchUrl(parsedUrl)) {
      throw Exception('Could not launch $parsedUrl');
    }
  }

  _copySuccessfulSnackBar(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Copied to clipboard!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // return isUserSubscribed to previous screen
                context.pop();
              },
              child: SvgPicture.asset(
                "assets/icons/arrow-left.svg",
                width: 32,
                height: 32,
              ),
            ),
            SizedBox(width: 16),
            Text(
              "premium subscription",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontSize: 24),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: AppTheme.surfaceGradientBox(),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: BlocListener<WalletCubit, WalletState>(
                  listener: (context, state) async {
                    if (state.authorizationResult != null) {
                      setState(() {
                        isUserSubscribed = state.isUserSubscribed;
                        isWalletConnected = true;
                        walletName =
                            state.authorizationResult!.accountLabel ?? "";
                        balance = state.accountBalance ?? 0.0;
                      });
                    } else {
                      setState(() {
                        isWalletConnected = false;
                        walletAddress = "";
                        walletName = "";
                        balance = 0.0;
                      });
                    }
                    if (state.isLoading) {
                      setState(() {
                        isLoading = true;
                      });
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                    }
                    if (state.isAuthorized && state.address != null) {
                      setState(() {
                        isWalletConnected = true;
                        walletAddress = state.address!;
                      });
                    } else {
                      setState(() {
                        isWalletConnected = false;
                        walletAddress = "";
                      });
                    }
                  },
                  child: ListView(
                    children: [
                      Visibility(
                        visible: isWalletConnected,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("your wallet is connected! : $walletName"),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(getWalletAddress()),
                                      SizedBox(width: 8),
                                      IconButton(
                                        onPressed: () async {
                                          try {
                                            await Clipboard.setData(
                                              ClipboardData(
                                                text: walletAddress,
                                              ),
                                            );
                                            if (context.mounted) {
                                              _copySuccessfulSnackBar(context);
                                            }
                                          } catch (e) {
                                            // error copying do nothing
                                          }
                                        },
                                        icon: Icon(Icons.copy),
                                      ),
                                    ],
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    context.read<WalletCubit>().deauthorize();
                                  },
                                  child: Text(
                                    "Disconnect Wallet",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall?.copyWith(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Your wallet Balance: ${balance.toStringAsFixed(2)} Sol",
                            ),
                            SizedBox(height: 8),
                            OutlinedButton(
                              onPressed: () {
                                context.read<WalletCubit>().getBalance();
                              },
                              child: Text(
                                "Refresh Wallet Balance",
                                style: Theme.of(
                                  context,
                                ).textTheme.labelSmall?.copyWith(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Visibility(
                        visible: !isWalletConnected && !isUserSubscribed,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                "assets/icons/Diamond.svg",
                                height: 100,
                                width: 100,
                              ),
                            ),
                            Text(
                              "you are missing out on awesome features on MatchChayn:",
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall?.copyWith(),
                            ),
                            SizedBox(height: 16),
                            Text("# Full access to likes 💛"),
                            Text("# AI assisted chats 🤖"),
                            Text("# Full access to events 🥇"),
                            Text("# Instant notifications 🔔"),
                            Text("And more 💪 ......"),
                            SizedBox(height: 48),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !isUserSubscribed,
                        child: Column(
                          children: [

                            SvgPicture.asset(
                              "assets/icons/King.svg",
                              height: 100,
                              width: 100,
                            ),
                            Text(
                              "Subscribe to premium to access Matchayn Pro features today, its just 0.05 Sol ",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Visibility(
                        visible: !isWalletConnected,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text("your wallet is not connected!"),
                            ),
                            OutlinedButton(
                              onPressed: () async {
                                final result = await context
                                    .read<WalletCubit>()
                                    .isWalletAvailable();
                                if (context.mounted) {
                                  if (result) {
                                    context.read<WalletCubit>().authorize();
                                  } else {
                                    //show alert screen saying user has no solana wallet
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('No Solana Wallet Found'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'You have no Solana wallet on your device, Please install a Solana wallet to connect.',
                                              ),
                                              SizedBox(height: 16),
                                              Text(
                                                "install wallets like Solflare and Phantom to continue",
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            OutlinedButton(
                                              onPressed: () async {
                                                await _launchUrl(
                                                  solflarePlaystoreUrl,
                                                );
                                                if (context.mounted) {
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: Text(
                                                'Go to Playstore',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            FilledButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'OK',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                              child: Text(
                                "Connect Wallet",
                                style: Theme.of(
                                  context,
                                ).textTheme.labelSmall?.copyWith(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isUserSubscribed,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                "assets/icons/premium.svg",
                                height: 150,
                                width: 150,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "you are subscribed to MatchChayn Premium",
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !isUserSubscribed,
                        child: Column(
                          children: [
                            SizedBox(height: 24),
                            PrimaryButton(
                              isInactive: !isWalletConnected,
                              text: "Subscribe",
                              onPressed: () {
                                context.read<WalletCubit>().transferSol(
                                  recipientAddress: companySolanaAddress,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: OutlinedButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            'Back',
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium?.copyWith(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.whiteColor.withValues(alpha: 0.5),
                    ),
                    child: Center(child: CircularProgressIndicator()),
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

//wave south artist heavy horror photo choice talk phrase bubble doll body