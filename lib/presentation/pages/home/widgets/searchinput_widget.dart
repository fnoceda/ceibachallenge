import 'package:ceiba_challenge/presentation/resources/color_manager.dart';
import 'package:ceiba_challenge/presentation/resources/strings_manager.dart';
import 'package:ceiba_challenge/presentation/resources/values_manager.dart';
import 'package:ceiba_challenge/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchInput extends StatefulWidget {
  final UserService userService;

  const SearchInput({Key? key, required this.userService}) : super(key: key);
  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  FocusNode _focus = FocusNode();
  TextEditingController _controller = TextEditingController();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    // userService = Provider.of<UserService>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
  }

  void _onFocusChange() {
    isFocused = _focus.hasFocus;
    // debugPrint("Focus: ${}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: AppSize.s20, vertical: AppSize.s20),
      child: TextField(
        controller: _controller,
        focusNode: _focus,
        onSubmitted: (value) {
          setState(() {
            isFocused = false;
            FocusScope.of(context).unfocus();
            widget.userService.findUsers(str: '');
          });
        },
        onTap: () {
          setState(() {
            isFocused = true;
          });
        },
        onChanged: (value) {
          if (value.trim().isNotEmpty) {
            setState(() {
              isFocused = true;
              widget.userService.findUsers(str: value);
            });
          } else {
            setState(() {
              isFocused = false;
              widget.userService.findUsers(str: '');
            });
          }
        },
        decoration: _inputSearchdecoration(context),
      ),
    );
  }

  InputDecoration _inputSearchdecoration(BuildContext context) {
    return InputDecoration(
      // hintText: AppStrings.searchLabel,
      label: Text(AppStrings.searchLabel),
      suffixIcon: (this.isFocused)
          ? GestureDetector(
              child: Icon(
                Icons.close,
                color: ColorManager.error,
              ),
              onTap: () {
                setState(() {
                  isFocused = false;
                  _controller.clear();
                  FocusScope.of(context).unfocus();
                  widget.userService.findUsers(str: '');
                });
              },
            )
          : Icon(Icons.search),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary),
      ),
    );
  }
}
