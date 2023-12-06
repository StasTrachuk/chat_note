import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_work/blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:home_work/models/chat.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/arrow_back_button.dart';
import 'package:home_work/widgets/assets.dart';
import 'package:home_work/widgets/primary_button.dart';
import 'package:home_work/widgets/action_text_field.dart';
import 'package:home_work/screens/create_screen/select_icon_button.dart';

class CreateScreen extends StatefulWidget {
  final bool editMode;
  final Chat? editedChat;

  const CreateScreen.newChat({super.key})
      : editedChat = null,
        editMode = false;

  const CreateScreen.edit({
    super.key,
    required this.editedChat,
  }) : editMode = true;

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late String _selectedIcon;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.editMode) {
      _controller.text = widget.editedChat!.title;
      _selectedIcon = widget.editedChat!.icon;
    } else {
      _selectedIcon = Assets.getNotesIcon(0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const ArrowBackButton(),
        title: Text(
          widget.editMode ? 'Edit' : 'Create a New Page',
          style: TextStyle(
            color: context.theme.textPrimaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ActionTextField(
              hintText: 'Name',
              controller: _controller,
            ),
          ),
          const SizedBox(height: 28),
          GridView.count(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            crossAxisCount: 5,
            children: List.generate(
              20,
              (index) => Center(
                child: SelectIconButton(
                  asset: Assets.getNotesIcon(index),
                  isSelected: _selectedIcon == Assets.getNotesIcon(index),
                  onTap: () {
                    setState(() {
                      _selectedIcon = Assets.getNotesIcon(index);
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          Column(
            children: [
              PrimaryButton(
                onPressed: () {
                  widget.editMode
                      ? context.read<HomeScreenCubit>().editChat(
                            widget.editedChat!.copyWith(
                              icon: _selectedIcon,
                              title: _controller.text.trim(),
                            ),
                          )
                      : context.read<HomeScreenCubit>().addChat(
                            icon: _selectedIcon,
                            title: _controller.text.isEmpty
                                ? 'New Event'
                                : _controller.text.trim(),
                          );
                  Navigator.pop(context);
                },
                text: 'Confirm',
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                withBorder: true,
                onPressed: () => Navigator.pop(context),
                text: 'Cancel',
              ),
              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}
