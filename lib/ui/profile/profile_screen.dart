import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchchayn/ui/profile/widgets/bio_section.dart';
import 'package:matchchayn/ui/profile/widgets/edit_field_icon.dart';
import 'package:matchchayn/ui/profile/widgets/interest_dialog.dart';
import 'package:matchchayn/ui/profile/widgets/personal_info_section.dart';
import 'package:matchchayn/ui/profile/widgets/profile_gallery_section.dart';
import 'package:matchchayn/ui/profile/widgets/profile_interest_section.dart';
import 'package:matchchayn/ui/profile_onboarding/select_interest_screen.dart';
import '../app_theme/app_theme.dart';
import '../../data/dummy_data/user_intetrests.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String bioText =
      "I'm a woman of few words but my actions speaks louder than words ever could. I'm not saying I'm a catch but I'm better than the last girl you matched with.";
  late TextEditingController bioController;
  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController genderController;
  late TextEditingController relationshipStatusController;

  @override
  void initState() {
    super.initState();
    bioController = TextEditingController(text: bioText);
    ageController = TextEditingController();
    heightController = TextEditingController();
    genderController = TextEditingController();
    relationshipStatusController = TextEditingController();
  }

  @override
  void dispose() {
    bioController.dispose();
    ageController.dispose();
    heightController.dispose();
    genderController.dispose();
    relationshipStatusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.surfaceGradientBox(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              children: [
                SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 86,
                          height: 86,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/user1.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Tiana Brooks",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(width: 4),
                                SvgPicture.asset(
                                  "assets/icons/check-badge.svg",
                                  width: 14,
                                  height: 14,
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/location_color.svg",
                                  width: 12,
                                  height: 12,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Abuja, Nigeria",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    EditFieldIconButton(),
                  ],
                ),
                SizedBox(height: 32),
                BioSection(
                  bioText: bioText,
                  onEdit: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Edit Bio'),
                          content: TextField(
                            controller: bioController,
                            maxLines: 5,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  bioText = bioController.text;
                                });
                                Navigator.pop(context);
                              },
                              child: Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 32),
                PersonalInfoSection(),
                SizedBox(height: 32),
                ProfileInterestsSection(
                  interests: userInterests,
                  onEdit: () async {
                    final updatedInterests = await showDialog<List<Interest>>(
                      context: context,
                      builder: (context) {
                        return EditInterestsDialog(
                          initialInterests: userInterests,
                        );
                      },
                    );

                    if (updatedInterests != null) {
                      setState(() {
                        // Update the main userInterests list with the changes from the dialog
                        userInterests = updatedInterests;
                      });
                    }
                  },
                ),
                SizedBox(height: 32),
                ProfileGallerySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
