
// Extract the AlertDialog content into a StatefulWidget
import 'package:flutter/material.dart';

import '../../profile_onboarding/select_interest_screen.dart';

class EditInterestsDialog extends StatefulWidget {
  final List<Interest> initialInterests;

  const EditInterestsDialog({super.key, required this.initialInterests});

  @override
  _EditInterestsDialogState createState() => _EditInterestsDialogState();
}

class _EditInterestsDialogState extends State<EditInterestsDialog> {
  // Create a copy of the interests to modify locally within the dialog
  late List<Interest> _dialogInterests;

  @override
  void initState() {
    super.initState();
    // Deep copy to avoid modifying the original list directly until saved
    _dialogInterests = widget.initialInterests.map((e) => e.copyWith()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Interests'),
      content: SizedBox(
        height: 200,
        child: SingleChildScrollView(
          child: InterestListing(
            interests: _dialogInterests,
            onTap: (index) {
              setState(() {
                // Toggle the selection state of the interest
                _dialogInterests[index] = _dialogInterests[index].copyWith(
                  isSelected: !_dialogInterests[index].isSelected,
                );
              });
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Dismiss without saving
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // When "Save" is pressed, pass the updated interests back.
            // You can use Navigator.pop with a result, or a callback.
            Navigator.pop(context, _dialogInterests);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
