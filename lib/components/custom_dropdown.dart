import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';

class SimpleDropdownButton extends StatefulWidget {
  const SimpleDropdownButton({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    super.key,
  });

  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  @override
  State<SimpleDropdownButton> createState() => _SimpleDropdownButtonState();
}

class _SimpleDropdownButtonState extends State<SimpleDropdownButton> {
  final GlobalKey _buttonKey = GlobalKey();
  double buttonWidth = 0;
  double buttonHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_buttonKey.currentContext != null) {
        final RenderBox renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
        final Size size = renderBox.size;
        setState(() {
          buttonWidth = size.width;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final TextEditingController countryController = TextEditingController();
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        //To avoid long text overflowing.
        isExpanded: true,
        isDense: true,
        key: _buttonKey,
        hint: TextBodyMedium(
          text: widget.hint,
          color: AppColors.textSecondary,
        ),
        value: widget.value,
        items: widget.dropdownItems
            .map(
              (String item) => DropdownMenuItem<String>(
                value: item,
                child: Container(
                  alignment: widget.valueAlignment,
                  child: TextBodySmall(
                    text: item,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: widget.onChanged,
        selectedItemBuilder: widget.selectedItemBuilder,
        buttonStyleData: ButtonStyleData(
          height: 40,
          padding: widget.buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
          decoration: widget.buttonDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(AppCorner.textField),
                border: const Border.fromBorderSide(
                  BorderSide(
                    color: AppColors.borderTertiary,
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                color: AppColors.surfaceTertiary,
              ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: widget.icon ?? const Icon(Icons.expand_more),
          iconSize: 22,
          iconEnabledColor: AppColors.iconSecondary,
          iconDisabledColor: AppColors.iconSecondary,
          openMenuIcon: const Icon(
            Icons.expand_less,
            size: 22,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          maxHeight: widget.dropdownHeight ?? 25.h,
          width: widget.dropdownWidth ?? buttonWidth,
          padding: widget.dropdownPadding,
          decoration: widget.dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(AppCorner.textField),
                color: AppColors.surfaceTertiary,
                border: Border.all(
                  color: AppColors.borderTertiary,
                ),
              ),
          elevation: widget.dropdownElevation ?? 0,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: widget.offset,
          scrollbarTheme: ScrollbarThemeData(
            radius: widget.scrollbarRadius ?? const Radius.circular(40),
            thickness: widget.scrollbarThickness != null
                ? WidgetStateProperty.all<double>(widget.scrollbarThickness!)
                : null,
            thumbVisibility: widget.scrollbarAlwaysShow != null
                ? WidgetStateProperty.all<bool>(widget.scrollbarAlwaysShow!)
                : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: widget.itemHeight ?? 40,
          padding: widget.itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}

class SimpleCheckBoxDropdownButton extends StatefulWidget {
  const SimpleCheckBoxDropdownButton({
    required this.hint,
    required this.selectedValues,
    required this.dropdownItems,
    required this.onChanged,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.dropdownWidth,
    this.dropdownHeight,
    this.dropdownDecoration,
    this.dropdownElevation,
    super.key,
  });

  final String hint;
  final List<String> selectedValues;
  final List<String> dropdownItems;
  final ValueChanged<List<String>> onChanged;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? dropdownWidth, dropdownHeight;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;

  @override
  State<SimpleCheckBoxDropdownButton> createState() => _SimpleCheckBoxDropdownButtonState();
}

class _SimpleCheckBoxDropdownButtonState extends State<SimpleCheckBoxDropdownButton> {
  late List<String> _selectedValues;
  final GlobalKey _buttonKey = GlobalKey();
  double buttonWidth = 0;

  @override
  void initState() {
    super.initState();
    _selectedValues = List.from(widget.selectedValues);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_buttonKey.currentContext != null) {
        final RenderBox renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
        final Size size = renderBox.size;
        setState(() {
          buttonWidth = size.width;
        });
      }
    });
  }

  @override
  void didUpdateWidget(SimpleCheckBoxDropdownButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedValues != widget.selectedValues) {
      setState(() {
        _selectedValues = List.from(widget.selectedValues);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        key: _buttonKey,
        isExpanded: true,
        hint: TextBodyMedium(
          text: widget.hint,
          color: AppColors.textSecondary,
        ),
        // When at least one item is selected we provide a value so that selectedItemBuilder is used
        value: _selectedValues.isNotEmpty ? _selectedValues.first : null,
        items: widget.dropdownItems.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            enabled: false, // Disable default selection behavior
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateItem) {
                final bool isSelected = _selectedValues.contains(item);
                return InkWell(
                  onTap: () {
                    setStateItem(() {
                      if (isSelected) {
                        _selectedValues.remove(item);
                      } else {
                        _selectedValues.add(item);
                      }
                      widget.onChanged(_selectedValues);
                    });
                    // Refresh the outer widget to update the display text
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            activeColor: AppColors.surfaceGreen,
                            value: isSelected,
                            onChanged: (bool? checked) {
                              setStateItem(() {
                                if (checked ?? false) {
                                  if (!_selectedValues.contains(item)) {
                                    _selectedValues.add(item);
                                  }
                                } else {
                                  _selectedValues.remove(item);
                                }
                                widget.onChanged(_selectedValues);
                              });
                              // Refresh the outer widget to update the display text
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextBodySmall(
                            text: item,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return widget.dropdownItems.map((item) {
            return Container(
              alignment: Alignment.centerLeft,
              child: TextBodyMedium(
                text: _selectedValues.isNotEmpty ? _selectedValues.join(', ') : widget.hint,
                color: AppColors.textSecondary,
                maxLine: 1,
              ),
            );
          }).toList();
        },
        // Provide a dummy onChanged callback since value selection is managed within the menu items
        onChanged: (_) {
          // No action needed. The selection is managed via the checkbox onTap callbacks.
        },
        buttonStyleData: ButtonStyleData(
          height: widget.buttonHeight ?? 40,
          width: widget.buttonWidth,
          padding: widget.buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
          decoration: widget.buttonDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(AppCorner.textField),
                border: Border.all(color: AppColors.borderTertiary, width: 1),
                color: AppColors.surfaceTertiary,
              ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: widget.icon ?? const Icon(Icons.expand_more),
          iconSize: widget.iconSize ?? 22,
          iconEnabledColor: widget.iconEnabledColor ?? AppColors.iconSecondary,
          iconDisabledColor: widget.iconDisabledColor ?? AppColors.iconSecondary,
          openMenuIcon: const Icon(
            Icons.expand_less,
            size: 22,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: widget.dropdownHeight ?? 25.h,
          width: widget.dropdownWidth ?? buttonWidth,
          decoration: widget.dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(AppCorner.textField),
                color: AppColors.surfaceTertiary,
                border: Border.all(
                  color: AppColors.borderTertiary,
                ),
              ),
          elevation: widget.dropdownElevation ?? 0,
          offset: const Offset(0, 0),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
