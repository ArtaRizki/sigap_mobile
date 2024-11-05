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
          'Index Pre Inspection List',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {},
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Image.asset(Assets.iconsIcFilter),
            ),
          ),
        ],
      );
    }

    Widget addButton() {
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

    return BlocProvider(
      create: (context) {
        if (widget.isEdit)
          return DataTableCreateBloc()..add(InitEditForm(widget.data?.id ?? 0));
        return DataTableCreateBloc();
      },
      child: Scaffold(
        appBar: appBar(),
        body: BlocListener<DataTableCreateBloc, DataTableCreateState>(
          listener: (context, state) {
            if (state.selectedToolId != null)
            
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
                    Text('Tanggal Pre Inspection *',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          context
                              .read<DataTableCreateBloc>()
                              .add(DateSelected(pickedDate));
                        }
                      },
                      child: TextField(
                        controller: dateTimeC,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Pilih Tanggal',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Terminal *', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    TextField(
                      controller: terminalC,
                      onChanged: (value) {
                        context
                            .read<DataTableCreateBloc>()
                            .add(TerminalSelected(value));
                      },
                      decoration: InputDecoration(
                        hintText: 'Pilih Terminal',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Alat *', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    TextField(
                      controller: toolC,
                      onChanged: (value) {
                        context
                            .read<DataTableCreateBloc>()
                            .add(ToolSelected(value));
                      },
                      decoration: InputDecoration(
                        hintText: 'Pilih Alat',
                        border: OutlineInputBorder(),
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
