import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchchayn/ui/core/gradient_text_field.dart';
import 'package:matchchayn/ui/core/intro_header_and_text.dart';
import 'package:matchchayn/ui/core/text_field_menu.dart';

class WhoAreYouLookingToMeetScreen extends StatefulWidget {
  const WhoAreYouLookingToMeetScreen({super.key});

  @override
  State<WhoAreYouLookingToMeetScreen> createState() =>
      _WhoAreYouLookingToMeetScreenState();
}

class _WhoAreYouLookingToMeetScreenState
    extends State<WhoAreYouLookingToMeetScreen> {
  late TextEditingController genderController;
  late TextEditingController relationshipStatusController;

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final List<String> _relationshipStatusOptions = [
    'Single',
    'In a relationship',
    'Married',
    'Divorced',
    'Widowed',
  ];
  int distanceValue = 0;
  int lowerAgeRangeBound = 18;
  int upperAgeRangeBound = 100;
  int lowerHeightRangeBound = 100;
  int upperHeightRangeBound = 250;

  @override
  void initState() {
    genderController = TextEditingController();
    relationshipStatusController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    genderController.dispose();
    relationshipStatusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IntroHeaderAndSubtext(
            header: "Who are you looking to meet?",
            subtext:
                "The better we know your preferences, the better your matches.",
          ),
          SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: GradientBorderTextField(
                  isReadOnly: true,
                  fieldLabel: "Gender",
                  controller: genderController,
                  onSuffixIconPressed: () {},
                  suffixIcon: TextFieldMenu(
                    menuOptions: _genderOptions,
                    onOptionSelected: (String option) {
                      setState(() {
                        genderController.text = option;
                      });
                    },
                    child: SvgPicture.asset(
                      "assets/icons/arrow-down.svg",
                      width: 16,
                      height: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: GradientBorderTextField(
                  isReadOnly: true,
                  fieldLabel: "Relationship Status",
                  controller: relationshipStatusController,
                  onSuffixIconPressed: () {},
                  suffixIcon: TextFieldMenu(
                    menuOptions: _relationshipStatusOptions,
                    onOptionSelected: (String option) {
                      setState(() {
                        relationshipStatusController.text = option;
                      });
                    },
                    child: SvgPicture.asset(
                      "assets/icons/arrow-down.svg",
                      width: 16,
                      height: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderValueLabels(
                title: "Distance (Km)",
                value: distanceValue.toString(),
              ),
              Slider(
                value: distanceValue.toDouble(),
                onChanged: (value) {
                  setState(() {
                    distanceValue = value.toInt();
                  });
                },
                min: 0,
                max: 1000,
                divisions: 1000,
                label: distanceValue.toString(),
              ),
            ],
          ),
          SizedBox(height: 16),
          SliderValueLabels(
            title: "Age Range",
            value: "$lowerAgeRangeBound - $upperAgeRangeBound",
          ),
          //age range slider
          RangeSlider(
            values: RangeValues(
              lowerAgeRangeBound.toDouble(),
              upperAgeRangeBound.toDouble(),
            ),
            onChanged: (values) {
              setState(() {
                lowerAgeRangeBound = values.start.toInt();
                upperAgeRangeBound = values.end.toInt();
              });
            },
            min: 18,
            max: 100,
            divisions: 100,
            labels: RangeLabels(
              lowerAgeRangeBound.toString(),
              upperAgeRangeBound.toString(),
            ),
          ),
          SizedBox(height: 16),
          SliderValueLabels(
            title: "Height Range (cm)",
            value: "$lowerHeightRangeBound - $upperHeightRangeBound",
          ),
          //height range slider
          RangeSlider(
            values: RangeValues(
              lowerHeightRangeBound.toDouble(),
              upperHeightRangeBound.toDouble(),
            ),
            onChanged: (values) {
              setState(() {
                lowerHeightRangeBound = values.start.toInt();
                upperHeightRangeBound = values.end.toInt();
              });
            },
            min: 100,
            max: 200,
            divisions: 100,
            labels: RangeLabels(
              lowerHeightRangeBound.toString(),
              upperHeightRangeBound.toString(),
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

class SliderValueLabels extends StatelessWidget {
  const SliderValueLabels({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
