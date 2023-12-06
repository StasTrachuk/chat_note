import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_work/blocs/search_screen_bloc/search_screen_cubit.dart';
import 'package:home_work/screens/chat_screen/message_row_view/message_view.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/action_text_field.dart';
import 'package:home_work/widgets/arrow_back_button.dart';
import 'package:home_work/widgets/loader.dart';

class SearchScreen extends StatefulWidget {
  final int chatId;
  const SearchScreen({required this.chatId, super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<SearchScreenCubit>(),
      child: BlocBuilder<SearchScreenCubit, SearchScreenState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              if (_focusNode.hasFocus) _focusNode.unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                leading: const ArrowBackButton(),
                title: Text(
                  'Search',
                  style: TextStyle(
                    color: context.theme.textPrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              body: SafeArea(
                bottom: true,
                child: Column(
                  children: [
                    Expanded(
                      child: switch (state) {
                        SearchScreenInitial() => const SizedBox(),
                        SearchScreenLoading() => const Loader(),
                        SearchScreenLoaded(:final messages) => messages
                                .isNotEmpty
                            ? ListView.separated(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                separatorBuilder:
                                    (BuildContext context, index) =>
                                        const SizedBox(height: 10),
                                reverse: true,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MessageView(
                                        message: messages[index],
                                      ),
                                      Text(
                                        messages[index].time,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              context.theme.textNotActiveColor,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  'Not found',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: context.theme.textNotActiveColor,
                                  ),
                                ),
                              ),
                        SearchScreenError() => Center(
                            child: Text(state.error),
                          ),
                      },
                    ),
                    Divider(
                      thickness: 0.1,
                      color: context.theme.dividerColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: ActionTextField(
                            hintText: "Search",
                            focusNode: _focusNode,
                            controller: _textController,
                            onEditingComplete: () => context
                                .read<SearchScreenCubit>()
                                .search(
                                    value: _textController.text,
                                    chatId: widget.chatId),
                            onSubmitted: (value) {
                              if (_focusNode.hasFocus) _focusNode.unfocus();
                              context.read<SearchScreenCubit>().search(
                                    value: value,
                                    chatId: widget.chatId,
                                  );
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () => context
                              .read<SearchScreenCubit>()
                              .search(
                                  value: _textController.text,
                                  chatId: widget.chatId),
                          icon: Icon(
                            Icons.search,
                            size: 24,
                            color: context.theme.iconSecondaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
