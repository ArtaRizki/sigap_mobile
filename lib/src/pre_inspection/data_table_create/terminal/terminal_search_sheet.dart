import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigap_mobile/common/helper/constant.dart';
import 'package:sigap_mobile/generated/assets.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/terminal/terminal_search_bloc.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/terminal/terminal_search_event.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/terminal/terminal_search_state.dart';

class TerminalSearchSheet extends StatefulWidget {
  TerminalSearchSheet(this.bloc);
  final TerminalSearchBloc bloc;
  @override
  State<TerminalSearchSheet> createState() => _TerminalSearchSheetState();
}

class _TerminalSearchSheetState extends State<TerminalSearchSheet> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    widget.bloc.add(FetchTerminalSearch());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      // We're at the bottom of the list
      widget.bloc.add(LoadNextPage(
          _textEditingController.text)); // Pass search term if needed
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TerminalSearchBloc(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Constant.xSizedBox8,
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
            Constant.xSizedBox16,
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                suffixIcon: Image.asset(Assets.iconsIcSearch),
                contentPadding: EdgeInsets.all(10),
                hintText: 'Cari Alat',
                hintStyle: TextStyle(color: Color(0xffB9B9B9)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Color(0xffB9B9B9)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Color(0xffB9B9B9)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Constant.primaryColor),
                ),
              ),
              onChanged: (value) {
                widget.bloc.add(FetchTerminalSearch(search: value));
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<TerminalSearchBloc, TerminalSearchState>(
                bloc: widget.bloc,
                builder: (context, state) {
                  if (state is TerminalSearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TerminalSearchLoaded) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.terminals.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.terminals.length) {
                          final terminal = state.terminals[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              terminal?.code ?? '',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(terminal?.name ?? ''),
                            onTap: () {
                              Navigator.of(context).pop(
                                  terminal); // Return the selected terminal
                            },
                          );
                        } else {
                          // Display a loading indicator at the bottom when fetching more
                          return state.hasMoreData
                              ? Center(child: CircularProgressIndicator())
                              : SizedBox();
                        }
                      },
                    );
                  } else if (state is TerminalSearchError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return Center(child: Text('No terminals found'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
