import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigap_mobile/common/component/custom_navigator.dart';
import 'package:sigap_mobile/common/helper/constant.dart';
import 'package:sigap_mobile/generated/assets.dart';
import 'package:sigap_mobile/src/home/home_screen.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table/data_table_response.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table/data_table_state.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_response.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_search_bloc.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_search_sheet.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/asset_search/asset_search_state.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_bloc.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_event.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_state.dart';
import 'package:sigap_mobile/utils/utils.dart';

class DataTableCreateScreen extends StatefulWidget {
  DataTableCreateScreen({super.key, this.isEdit = false, this.data});
  bool isEdit;
  DataTableResponseData? data;
  @override
  State<DataTableCreateScreen> createState() => _DataTableCreateScreenState();
}

class _DataTableCreateScreenState extends State<DataTableCreateScreen> {
  TextEditingController dateTimeC = TextEditingController();
  TextEditingController terminalC = TextEditingController();
  TextEditingController toolC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black, // navigation bar color
          statusBarColor: Colors.white, // status bar color
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          '${widget.isEdit ? 'View' : 'Input'} Pre Inspection List',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      );
    }

    Widget addButton() {
      if (widget.isEdit) return SizedBox();
      return InkWell(
        onTap: () async {},
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Constant.primaryColor,
            ),
            padding: EdgeInsets.all(16),
            child: Text(
              'Selanjutnya',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    Future<AssetResponseData?> _showAssetSearchSheet(
        BuildContext context, AssetSearchBloc bloc) async {
      return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: AssetSearchSheet(bloc),
          );
        },
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<DataTableCreateBloc>(
          create: (context) {
            if (widget.isEdit)
              return DataTableCreateBloc()
                ..add(InitEditForm(widget.data?.id ?? 0));
            return DataTableCreateBloc()..add(InitForm());
          },
        ),
        BlocProvider<AssetSearchBloc>(create: (context) => AssetSearchBloc()),
      ],
      child: Scaffold(
        appBar: appBar(),
        body: BlocListener<DataTableCreateBloc, DataTableCreateState>(
          listener: (context, state) {
            if (state.selectedTerminal != null)
              terminalC.text = state.selectedTerminal ?? '';
            if (state.selectedToolId != null) {
              dateTimeC.text =
                  Utils.convertDateddMMMMyyyy(state.selectedDate.toString());
              toolC.text = state.selectedTool ?? '';
            }

            if (state.isFailure)
              Utils.showFailed(msg: "Submit failed. Please try again.");
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Submit Successful')),
              );
              CusNav.nPushReplace(context, HomeScreen());
            }
          },
          child: BlocBuilder<DataTableCreateBloc, DataTableCreateState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                      color: Color(0xffF6F6F6),
                      child: Text(
                        'Silahkan lengkapi form di bawah ini',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ),
                    Constant.xSizedBox16,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(text: 'Tanggal Pre Inspection '),
                                  TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red)),
                                ],
                                style: TextStyle(
                                    fontSize: 12, color: Constant.grayColor)),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            onTap: () async {
                              if (!widget.isEdit) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  dateTimeC.text = Utils.convertDateddMMMMyyyy(
                                      '${pickedDate}');
                                  context
                                      .read<DataTableCreateBloc>()
                                      .add(DateSelected(pickedDate));
                                }
                              }
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            enabled: !widget.isEdit,
                            controller: dateTimeC,
                            onChanged: (value) {
                              // setState(() {});
                            },
                            decoration: InputDecoration(
                              suffixIcon: Image.asset(Assets.iconsIcCalendar),
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Pilih Tanggal',
                              hintStyle: TextStyle(color: Color(0xffB9B9B9)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(color: Color(0xffB9B9B9)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(color: Color(0xffB9B9B9)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(color: Constant.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(text: 'Terminal '),
                                  TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red)),
                                ],
                                style: TextStyle(
                                    fontSize: 12, color: Constant.grayColor)),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            enabled: false,
                            controller: terminalC,
                            onChanged: (value) {
                              // context
                              //     .read<DataTableCreateBloc>()
                              //     .add(TerminalSelected(value));
                            },
                            decoration: InputDecoration(
                              suffixIcon: Image.asset(Assets.iconsIcSearch),
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Pilih Terminal',
                              hintStyle: TextStyle(color: Color(0xffB9B9B9)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(color: Color(0xffB9B9B9)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(color: Color(0xffB9B9B9)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(color: Constant.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(text: 'Alat '),
                                  TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red)),
                                ],
                                style: TextStyle(
                                    fontSize: 12, color: Constant.grayColor)),
                          ),
                          SizedBox(height: 8),
                          BlocListener<AssetSearchBloc, AssetSearchState>(
                            listener: (context, state) {
                              if (state is AssetSelected &&
                                  state.assetSelected != null)
                                context
                                    .read<DataTableCreateBloc>()
                                    .add(ToolSelected(state.assetSelected!));
                            },
                            child: TextField(
                              enabled: !widget.isEdit,
                              controller: toolC,
                              onChanged: (value) {},
                              onTap: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                var _assetSearchBloc =
                                    context.read<AssetSearchBloc>();

                                var selectedAsset = await _showAssetSearchSheet(
                                    context, _assetSearchBloc);
                                log("ASSET : ${selectedAsset?.name}");
                                if (selectedAsset != null) {
                                  toolC.text = selectedAsset.name ?? '';
                                  context
                                      .read<DataTableCreateBloc>()
                                      .add(ToolSelected(selectedAsset));
                                }
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              decoration: InputDecoration(
                                suffixIcon: Image.asset(Assets.iconsIcSearch),
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Pilih Alat',
                                hintStyle: TextStyle(color: Color(0xffB9B9B9)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide:
                                      BorderSide(color: Color(0xffB9B9B9)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide:
                                      BorderSide(color: Color(0xffB9B9B9)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide:
                                      BorderSide(color: Constant.primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: addButton(),
      ),
    );
  }
}
