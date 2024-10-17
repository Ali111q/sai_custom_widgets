import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// CustomDropdown Builder typedef
typedef DropdownBuilder = Widget Function(
  BuildContext context,
  String? selectedItem,
);

/// SearchableDropdown Builder typedef
typedef SearchableDropdownBuilder = Widget Function(
  BuildContext context,
  String? selectedItem,
);

/// Custom Dropdown with Builder Support
class CustomDropdown extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final String? selectedItem;
  final Function(String)? onChanged;
  final double? borderRadius;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.borderRadius,
  });

  /// Static builder method to allow custom UI
  static Widget builder({
    required String hintText,
    required List<String> items,
    String? selectedItem,
    Function(String)? onChanged,
    double? borderRadius,
    required DropdownBuilder builder,
  }) {
    return UCustomDropdownBuilder(
      hintText: hintText,
      items: items,
      selectedItem: selectedItem,
      onChanged: onChanged,
      borderRadius: borderRadius,
      builder: builder,
    );
  }

  @override
  State<CustomDropdown> createState() => UCustomDropdownState();
}

class UCustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return GestureDetector(
        onTap: UshowCupertinoPicker,
        child: UbuildCupertinoDropdown(),
      );
    } else {
      return GestureDetector(
        onTap: UshowMaterialDropdown,
        child: UbuildMaterialDropdown(),
      );
    }
  }

  Widget UbuildCupertinoDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedValue ?? widget.hintText,
            style: TextStyle(
              color: selectedValue == null
                  ? CupertinoColors.systemGrey
                  : CupertinoColors.black,
            ),
          ),
          const Icon(CupertinoIcons.arrow_down),
        ],
      ),
    );
  }

  void UshowCupertinoPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: widget.items.map((item) {
          return CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                selectedValue = item;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(item);
              }
              Navigator.pop(context);
            },
            child: Text(item),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  Widget UbuildMaterialDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedValue ?? widget.hintText,
            style: TextStyle(
              color: selectedValue == null ? Colors.grey : Colors.black,
            ),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  void UshowMaterialDropdown() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: widget.items.map((item) {
            return SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedValue = item;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(item);
                }
                Navigator.pop(context);
              },
              child: Text(item),
            );
          }).toList(),
        );
      },
    );
  }
}

/// The private builder implementation for `CustomDropdown`
class UCustomDropdownBuilder extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final String? selectedItem;
  final Function(String)? onChanged;
  final double? borderRadius;
  final DropdownBuilder builder;

  const UCustomDropdownBuilder({
    required this.hintText,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.borderRadius,
    required this.builder,
  });

  @override
  State<UCustomDropdownBuilder> createState() => UCustomDropdownBuilderState();
}

class UCustomDropdownBuilderState extends State<UCustomDropdownBuilder> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Platform.isIOS) {
          UshowCupertinoPicker();
        } else {
          UshowMaterialDropdown();
        }
      },
      child: widget.builder(context, selectedValue),
    );
  }

  void UshowCupertinoPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: widget.items.map((item) {
          return CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                selectedValue = item;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(item);
              }
              Navigator.pop(context);
            },
            child: Text(item),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  void UshowMaterialDropdown() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: widget.items.map((item) {
            return SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedValue = item;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(item);
                }
                Navigator.pop(context);
              },
              child: Text(item),
            );
          }).toList(),
        );
      },
    );
  }
}

/// Searchable Dropdown with Builder Support
class SearchableDropdown extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final String? selectedItem;
  final Function(String)? onChanged;
  final double? borderRadius;
  final Function(String)? onSearch;

  const SearchableDropdown({
    super.key,
    required this.hintText,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.borderRadius,
    this.onSearch,
  });

  /// Static builder method to allow custom UI
  static Widget builder({
    required String hintText,
    required List<String> items,
    String? selectedItem,
    Function(String)? onChanged,
    double? borderRadius,
    Function(String)? onSearch,
    required SearchableDropdownBuilder builder,
  }) {
    return USearchableDropdownBuilder(
      hintText: hintText,
      items: items,
      selectedItem: selectedItem,
      onChanged: onChanged,
      borderRadius: borderRadius,
      onSearch: onSearch,
      builder: builder,
    );
  }

  @override
  USearchableDropdownState createState() => USearchableDropdownState();
}

class USearchableDropdownState extends State<SearchableDropdown> {
  String? selectedValue;
  List<String> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedItem;
    filteredItems = widget.items;
  }

  void UonSearchChanged(String query) {
    setState(() {
      filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
    if (widget.onSearch != null) {
      widget.onSearch!(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: UshowSearchablePicker,
      child: UbuildDropdownContent(),
    );
  }

  Widget UbuildDropdownContent() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedValue ?? widget.hintText,
            style: TextStyle(
                color: selectedValue == null ? Colors.grey : Colors.black),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  void UshowSearchablePicker() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search...',
                  ),
                  onChanged: (value) {
                    UonSearchChanged(value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredItems[index]),
                      onTap: () {
                        setState(() {
                          selectedValue = filteredItems[index];
                        });
                        if (widget.onChanged != null) {
                          widget.onChanged!(filteredItems[index]);
                        }
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// The private builder implementation for `SearchableDropdown`
class USearchableDropdownBuilder extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final String? selectedItem;
  final Function(String)? onChanged;
  final double? borderRadius;
  final Function(String)? onSearch;
  final SearchableDropdownBuilder builder;

  const USearchableDropdownBuilder({
    required this.hintText,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.borderRadius,
    this.onSearch,
    required this.builder,
  });

  @override
  State<USearchableDropdownBuilder> createState() =>
      USearchableDropdownBuilderState();
}

class USearchableDropdownBuilderState
    extends State<USearchableDropdownBuilder> {
  String? selectedValue;
  List<String> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedItem;
    filteredItems = widget.items;
  }

  void UonSearchChanged(String query) {
    setState(() {
      filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
    if (widget.onSearch != null) {
      widget.onSearch!(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: UshowSearchablePicker,
      child: widget.builder(context, selectedValue),
    );
  }

  void UshowSearchablePicker() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search...',
                  ),
                  onChanged: (value) {
                    UonSearchChanged(value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredItems[index]),
                      onTap: () {
                        setState(() {
                          selectedValue = filteredItems[index];
                        });
                        if (widget.onChanged != null) {
                          widget.onChanged!(filteredItems[index]);
                        }
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
