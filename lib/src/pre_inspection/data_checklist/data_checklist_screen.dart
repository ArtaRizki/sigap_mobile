import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sigap_mobile/common/component/custom_image_picker.dart';
import 'package:sigap_mobile/common/component/custom_navigator.dart';
import 'package:sigap_mobile/common/helper/constant.dart';
import 'package:sigap_mobile/generated/assets.dart';
import 'package:sigap_mobile/src/home/home_screen.dart';
import 'package:sigap_mobile/src/pre_inspection/data_checklist/data_checklist_bloc.dart';
import 'package:sigap_mobile/src/pre_inspection/data_checklist/data_checklist_event.dart';
import 'package:sigap_mobile/src/pre_inspection/data_checklist/data_checklist_response.dart';
import 'package:sigap_mobile/src/pre_inspection/data_checklist/data_checklist_state.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table/data_table_screen.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_bloc.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_event.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_param.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_state.dart';

class DataChecklistScreen extends StatelessWidget {
  final DataTableCreateParam dataTableCreateParam;

  const DataChecklistScreen({super.key, required this.dataTableCreateParam});
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
          'Detail Pre Inspection',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      );
    }

    Future showNotesDialog(BuildContext context, int index,
        List<DataChecklistResponseData?> data) async {
      TextEditingController _controller = TextEditingController();
      File? _image;
      var item = data[index];
      if (item?.reason != null) _controller.text = item?.reason ?? '';
      if (item?.filename != null) {
        _image = File(item?.filename ?? '');
      }
      showDialog(
        context: context,
        builder: (BuildContext c) {
          return StatefulBuilder(
            builder: (c2, state) {
              return AlertDialog(
                insetPadding: EdgeInsets.all(16),
                title: InkWell(
                  onTap: () => Navigator.pop(c),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
                content: SingleChildScrollView(
                  child: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Container(
                      width: MediaQuery.of(c2).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Foto Alat',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff6D7588),
                                ),
                              ),
                              if (_image == null)
                                InkWell(
                                  onTap: () async {
                                    var image =
                                        await CustomImagePicker.cameraOrGallery(
                                            c2);
                                    if (image != null) _image = image;
                                    state(() {});
                                  },
                                  child: Text(
                                    'Tambah Foto',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Constant.primaryColor,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (_image != null)
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Stack(
                                children: [
                                  Image.file(
                                    _image!,
                                    height: 264,
                                    width: double.infinity,
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: InkWell(
                                      onTap: () async {
                                        // var bloc =
                                        //     context.read<DataChecklistBloc>();
                                        // bloc.add(
                                        //     DeleteImageNoteDataChecklistEvent(
                                        //         index,
                                        //         data: data));
                                        _image = null;
                                        state(() {});
                                        // CusNav.nPop(c2);
                                      },
                                      child: Image.asset(Assets.iconsIcClose),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Constant.xSizedBox16,
                          Row(
                            children: [
                              Text(
                                'Keterangan',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff6D7588),
                                ),
                              ),
                            ],
                          ),
                          Constant.xSizedBox12,
                          TextField(
                            controller: _controller,
                            onChanged: (v) {
                              state(() {});
                            },
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(top: 16, right: 4),
                                child: Image.asset(Assets.iconsIcNotes),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              hintText: '',
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
                            maxLines: 4,
                          ),
                          Constant.xSizedBox16,
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    var bloc =
                                        context.read<DataChecklistBloc>();

                                    if (_controller.text.isNotEmpty &&
                                        _image != null) {
                                      bloc.add(
                                        SaveNoteDataChecklistEvent(
                                          data: data,
                                          index: index,
                                          note: _controller.text,
                                          imagePath: _image!.path,
                                        ),
                                      );
                                      bloc.add(
                                        ChangeStatuseDataChecklistEvent(
                                          data: data,
                                          index: index,
                                          status: 0,
                                        ),
                                      );
                                      CusNav.nPop(c2);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 12, 0, 24),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: _controller.text.isNotEmpty &&
                                                _image != null
                                            ? Constant.primaryColor
                                            : Constant.grayColor,
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Simpan Catatan',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }

    Widget submitButton() {
      return BlocBuilder<DataTableCreateBloc, DataTableCreateState>(
        builder: (context, state) {
          return BlocBuilder<DataChecklistBloc, DataChecklistState>(
            builder: (context2, state2) {
              return InkWell(
                onTap: () async {
                  if (state2 is DataChecklistLoaded) {
                    log("SELECTED TOOL : ${state.selectedTool}");
                    final bloc = context.read<DataTableCreateBloc>();
                    bloc.add(
                      SendForm(
                        DataTableCreateParam(
                          assetId: dataTableCreateParam.assetId,
                          assetCategoryCode:
                              dataTableCreateParam.assetCategoryCode,
                          dateDoc: dataTableCreateParam.dateDoc,
                          docType: 'OPR',
                          cabangId: dataTableCreateParam.cabangId,
                        ),
                        state2.checklists,
                      ),
                    );
                  }
                },
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
                      'Simpan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<DataChecklistBloc>(
          create: (_) => DataChecklistBloc()
            ..add(FetchDataChecklist(type: 'MKN', code: 'GSU')),
        ),
        BlocProvider<DataTableCreateBloc>(create: (_) => DataTableCreateBloc()),
      ],
      child: Scaffold(
        appBar: appBar(),
        body: Container(
          margin: EdgeInsets.only(top: 12),
          color: Colors.white,
          child: BlocListener<DataTableCreateBloc, DataTableCreateState>(
            listener: (context, state) {
              if (state.isSuccessSend)
                CusNav.nPushAndRemoveUntil(context, HomeScreen());
            },
            child: BlocBuilder<DataChecklistBloc, DataChecklistState>(
              builder: (context, state) {
                if (state is DataChecklistLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is DataChecklistLoaded) {
                  return ListView.separated(
                    itemCount: state.checklists.length,
                    separatorBuilder: (_, __) => Constant.xSizedBox16,
                    itemBuilder: (context, index) {
                      final checklist = state.checklists[index];
                      return ListTile(
                        title: Row(
                          children: [
                            Image.asset(Assets.iconsIcInspection),
                            Constant.xSizedBox8,
                            Text(
                              checklist?.checkName ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        final bloc =
                                            context.read<DataChecklistBloc>();
                                        bloc.add(
                                          ChangeStatuseDataChecklistEvent(
                                            index: index,
                                            status: 1,
                                            data: state.checklists,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 15),
                                        decoration: BoxDecoration(
                                          color: checklist?.status == 1
                                              ? Constant.primaryColor
                                              : Constant.tertiaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 5),
                                                blurRadius: 5,
                                                spreadRadius: 0,
                                                color: Colors.black
                                                    .withOpacity(0.15))
                                          ],
                                        ),
                                        child: Text(
                                          'Baik',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: checklist?.status == 1
                                                  ? Colors.white
                                                  : Constant.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Constant.xSizedBox16,
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        await showNotesDialog(
                                            context, index, state.checklists);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 15),
                                        decoration: BoxDecoration(
                                          color: checklist?.status == 1
                                              ? Constant.tertiaryColor
                                              : Constant.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 5),
                                                blurRadius: 5,
                                                spreadRadius: 0,
                                                color: Colors.black
                                                    .withOpacity(0.15))
                                          ],
                                        ),
                                        child: Text(
                                          'Tidak Baik',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: checklist?.status == 1
                                                  ? Constant.primaryColor
                                                  : Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (checklist?.status == 0 &&
                                  checklist?.reason != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: FileImage(
                                              File(checklist?.filename ?? ''),
                                            ),
                                            onError: (exception, stackTrace) =>
                                                SizedBox(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Constant.xSizedBox16,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Keterangan',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff6D7588),
                                            ),
                                          ),
                                          Constant.xSizedBox4,
                                          Text(
                                            checklist?.reason ?? '',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is DataChecklistError) {
                  return Center(child: Text('Error: ${state.message}'));
                }

                return SizedBox();
              },
            ),
          ),
        ),
        bottomNavigationBar: submitButton(),
      ),
    );
  }
}
