import 'package:flutter/material.dart';
import 'package:sai_custom_widgets/sai_custom_widgets.dart'; // Your custom widget package
import 'package:get/get.dart'; // For theming support

/// Main entry point of the application
void main(List<String> args) {
  runApp(MyApp());
}

/// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sai Custom Widgets Example',
      theme: ThemeData.light(), // Optional: Add light theme customization
      darkTheme: ThemeData.dark(), // Optional: Add dark theme customization
      home: const CustomWidgetsExampleScreen(),
    );
  }
}

/// A screen demonstrating the usage of various custom widgets
class CustomWidgetsExampleScreen extends StatelessWidget {
  const CustomWidgetsExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            /// Custom Date Picker
            _buildCustomDatePicker(),

            /// Custom Button Example
            _buildCustomButton(),

            /// Custom Outlined Button Example
            _buildCustomOutlinedButton(),

            /// Custom Text Button Example
            _buildCustomTextButton(),

            /// Searchable Dropdown Example
            _buildSearchableDropdown(),

            /// Simple Dropdown Example
            _buildCustomDropdown(),

            /// Custom Switch Example
            _buildCustomSwitch(),

            /// Custom Text Field Example
            _buildCustomTextFields(),

            /// Platform Native List Tile Example
            _buildPlatformNativeListTile(),

            /// Platform Native List Section Example
            _buildPlatformNativeListSection(),

            const SizedBox(height: 20),
          ],
        )
            .withSpacing(spacing: 15)
            .withPadding(padding: 10), // Consistent spacing and padding
      ),
    );
  }

  /// Builds the custom date picker widget
  Widget _buildCustomDatePicker() {
    return CustomDatePickerWidget.builder(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      onDateSelected: (selectedDate) {
        print("Date selected: $selectedDate");
      },
      builder: (context, selectedDate) {
        return Text('Selected Date: ${selectedDate.toString()}');
      },
    );
  }

  /// Builds the custom button widget
  Widget _buildCustomButton() {
    return CustomButton(
      text: "Custom Button",
      onPressed: () {
        print("Custom Button Pressed");
      },
      isLoading: false,
      isDisabled: false,
      isOutlined: false,
    );
  }

  /// Builds the custom outlined button widget
  Widget _buildCustomOutlinedButton() {
    return CustomOutlinedButton(
      text: "Outlined Button",
      onPressed: () {
        print("Outlined Button Pressed");
      },
    );
  }

  /// Builds the custom text button widget
  Widget _buildCustomTextButton() {
    return CustomTextButton(
      text: "Text Button",
      onPressed: () {
        print("Text Button Pressed");
      },
    );
  }

  /// Builds the searchable dropdown widget
  Widget _buildSearchableDropdown() {
    return SearchableDropdown.builder(
      hintText: 'Search and select',
      items: ['Apple', 'Banana', 'Orange', 'Grapes', 'Pineapple'],
      selectedItem: null,
      onChanged: (selectedItem) {
        print('Selected: $selectedItem');
      },
      onSearch: (searchText) {
        print('Searching for: $searchText');
      },
      builder: (context, selectedItem) {
        return _buildDropdownTile(selectedItem ?? 'Search and select');
      },
    );
  }

  /// Builds a simple dropdown widget
  Widget _buildCustomDropdown() {
    return CustomDropdown.builder(
      hintText: 'Select an option',
      items: ['Option 1', 'Option 2', 'Option 3'],
      selectedItem: 'Option 1',
      onChanged: (selectedItem) {
        print('Selected: $selectedItem');
      },
      borderRadius: 12.0,
      builder: (context, selectedItem) {
        return _buildDropdownTile(selectedItem ?? 'Select an option');
      },
    );
  }

  /// Builds the custom switch widget
  Widget _buildCustomSwitch() {
    return CustomSwitch.builder(
      onSwitch: (isSwitched) {
        print('Switch value: $isSwitched');
      },
      initialValue: false,
      builder: (context, isSwitched, inChange) {
        return GestureDetector(
          onTap: () {
            final newValue = !isSwitched;
            inChange(newValue);
          },
          child: Text(
            'Current value: $isSwitched',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        );
      },
    );
  }

  /// Builds custom text fields (username and password)
  Widget _buildCustomTextFields() {
    return Column(
      children: [
        CustomTextField(
          hintText: "Enter your name",
          onChanged: (value) {
            print("Name: $value");
          },
          validators: [
            IsRequiredRule(),
          ],
        ),
        CustomTextField(
          hintText: "Enter your password",
          isPassword: true,
          onChanged: (value) {
            print("Password: $value");
          },
          validators: [
            IsRequiredRule(),
            MinLengthRule(6),
          ],
        ),
      ],
    ).withSpacing(spacing: 15);
  }

  /// Builds a single platform-native list tile
  Widget _buildPlatformNativeListTile() {
    return PlatformNativeListTile(
      title: "List Tile Example",
      subtitle: "This is an example of a platform-specific list tile.",
      leading: const Icon(Icons.account_balance),
      onTap: () {
        print("List Tile tapped");
      },
    );
  }

  /// Builds a platform-native list section
  Widget _buildPlatformNativeListSection() {
    return PlatformNativeListSection(
      sectionHeader: "Example Section",
      tiles: [
        PlatformNativeListTile(
          title: "Tile 1",
          subtitle: "Subtitle 1",
          leading: const Icon(Icons.account_circle),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            print("Tile 1 tapped");
          },
        ),
        PlatformNativeListTile(
          title: "Tile 2",
          subtitle: "Subtitle 2",
          leading: const Icon(Icons.email),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            print("Tile 2 tapped");
          },
        ),
      ],
      padding: const EdgeInsets.all(8.0),
    );
  }

  /// Helper method to build a dropdown tile
  Widget _buildDropdownTile(String text) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
