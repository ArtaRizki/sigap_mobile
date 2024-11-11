import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigap_mobile/common/helper/constant.dart';
import 'package:sigap_mobile/generated/assets.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_search_bloc.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_search_event.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_search_state.dart';

class AssetSearchSheet extends StatefulWidget {
  AssetSearchSheet(this.bloc);
  final AssetSearchBloc bloc;
  @override
  State<AssetSearchSheet> createState() => _AssetSearchSheetState();
}

class _AssetSearchSheetState extends State<AssetSearchSheet> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    widget.bloc.add(FetchAssetSearch());
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
      create: (context) => AssetSearchBloc(),
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
                widget.bloc.add(FetchAssetSearch(search: value));
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<AssetSearchBloc, AssetSearchState>(
                bloc: widget.bloc,
                builder: (context, state) {
                  if (state is AssetSearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is AssetSearchLoaded) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.assets.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.assets.length) {
                          final asset = state.assets[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              asset?.code ?? '',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(asset?.name ?? ''),
                            trailing: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0xffdddce6)),
                              child: Text(
                                asset?.jenisAssetCode ?? '',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff191654)),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pop(asset); // Return the selected asset
                            },
                          );
                        } else {
                          // Display a loading indicator at the bottom when fetching more
                          return
                              // state.hasMoreData
                              //     ? Center(child: CircularProgressIndicator())
                              //     :
                              SizedBox();
                        }
                      },
                    );
                  } else if (state is AssetSearchError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return Center(child: Text('No assets found'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
