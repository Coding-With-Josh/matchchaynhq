import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchchayn/ui/core/gradient_text_field.dart';
import 'package:matchchayn/ui/core/intro_header_and_text.dart';

import '../constants/app_colors.dart';
import '../core/text_field_menu.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController userNameController;
  late TextEditingController dateOfBirthController;
  late TextEditingController cityController;
  late TextEditingController genderController;
  late TextEditingController relationshipStatusController;
  late TextEditingController bioController;

  DateTime? _selectedDate;
  String selectedCountryCode = "NG";

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final List<String> _relationshipStatusOptions = [
    'Single',
    'In a relationship',
    'Married',
    'Divorced',
    'Widowed'
  ];

  Future<void> _selectDateFromCalendar(BuildContext context) async {
    // --- Define your desired age range ---
    final int minAllowedAge = 18; // User must be at least 18 years old
    final int maxAllowedAge = 150; // User must be at most 99 years old

    // --- Calculate the firstDate and lastDate for the DatePicker ---
    // firstDate: The earliest possible birthdate (for the oldest person allowed)
    // This means `now.year - maxAllowedAge`.
    final DateTime now = DateTime.now();
    final DateTime firstSelectableDate = DateTime(
      now.year - maxAllowedAge,
      now.month,
      now.day,
    );

    // lastDate: The latest possible birthdate (for the youngest person allowed)
    // This means `now.year - minAllowedAge`.
    final DateTime lastSelectableDate = DateTime(
      now.year - minAllowedAge,
      now.month,
      now.day,
    );

    // Set initialDate to something sensible.
    // A common practice is to default to an age like 20-30 years ago.
    // Or, if a date has already been selected, use that.
    DateTime initialDateForPicker =
        _selectedDate ??
        DateTime(
          now.year - 25,
          now.month,
          now.day,
        ); // Default to ~25 years ago if nothing selected

    // Ensure initialDateForPicker is within the bounds, if not, adjust it.
    if (initialDateForPicker.isBefore(firstSelectableDate)) {
      initialDateForPicker = firstSelectableDate;
    } else if (initialDateForPicker.isAfter(lastSelectableDate)) {
      initialDateForPicker = lastSelectableDate;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDateForPicker,
      firstDate: firstSelectableDate,
      lastDate: lastSelectableDate,
      helpText: 'Select your Birth Date',
      // Optional: customize the title
      errorFormatText: 'Enter valid date',
      // Optional
      errorInvalidText: 'Enter date in valid range',
      // Optional
      fieldLabelText: 'Birth Date',
      // Optional: label for the input field in the picker itself
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateOfBirthController.text = _formatDateToMMDDYYYY(
          picked,
        ); // Use your formatting function
      });
    }
  }

  String _formatDateToMMDDYYYY(DateTime dateTime) {
    // Extract month, day, and year components
    final int month = dateTime.month;
    final int day = dateTime.day;
    final int year = dateTime.year;

    // Pad single-digit month/day with a leading zero if necessary
    final String monthString = month.toString().padLeft(2, '0');
    final String dayString = day.toString().padLeft(2, '0');

    // Construct the "MM-dd-yyyy" string
    return '$monthString-$dayString-$year';
  }

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    userNameController = TextEditingController();
    dateOfBirthController = TextEditingController();
    cityController = TextEditingController();
    genderController = TextEditingController();
    relationshipStatusController = TextEditingController();
    bioController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    dateOfBirthController.dispose();
    cityController.dispose();
    genderController.dispose();
    relationshipStatusController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IntroHeaderAndSubtext(
            header: "Create a Profile",
            subtext: "Complete your profile to find better matches",
          ),
          SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: GradientBorderTextField(
                  fieldLabel: "First Name",
                  controller: firstNameController,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: GradientBorderTextField(
                  fieldLabel: "Last Name",
                  controller: lastNameController,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GradientBorderTextField(
                  fieldLabel: "Username",
                  controller: userNameController,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: GradientBorderTextField(
                  isReadOnly: true,
                  fieldLabel: "Date of Birth",
                  controller: dateOfBirthController,
                  hintText: "mm-dd-yyyy",
                  onSuffixIconPressed: () {
                    _selectDateFromCalendar(context);
                  },
                  suffixIcon: SvgPicture.asset(
                    "assets/icons/calendar.svg",
                    width: 16,
                    height: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Country",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.whiteColor, // Red border color
                          width: 1.0, // 2px border width
                        ),
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ), // 16px border radius
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountryFlag.fromCountryCode(
                            selectedCountryCode,
                            shape: const Circle(),
                            width: 20,
                            height: 20,
                          ),
                          Expanded(
                            child: CountryCodePicker(
                              margin: EdgeInsets.zero,
                              showDropDownButton: true,
                              padding: EdgeInsets.zero,
                              dialogTextStyle: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: AppColors.blackColor),
                              textStyle: Theme.of(
                                context,
                              ).textTheme.labelMedium,
                              searchStyle: TextStyle(color: Colors.black),
                              searchDecoration: InputDecoration(
                                hintText: "Search",
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              onChanged: (code) {
                                setState(() {
                                  if (code.code != null) {
                                    selectedCountryCode = code.code!;
                                  }
                                });
                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: 'NG',
                              favorite: ['NG'],
                              showCountryOnly: true,
                              showFlagDialog: true,
                              showFlagMain: false,
                              showOnlyCountryWhenClosed: true,
                              alignLeft: false,
                              headerTextStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          // SvgPicture.asset(
                          //   "assets/icons/arrow-down.svg",
                          //   width: 16,
                          //   height: 16,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: GradientBorderTextField(
                  fieldLabel: "City",
                  controller: cityController,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GradientBorderTextField(
                  fieldLabel: "Gender",
                  isReadOnly: true,
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
          SizedBox(height: 16),
          GradientBorderTextField(
            fieldLabel: "Bio (optional)",
            controller: bioController,
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
