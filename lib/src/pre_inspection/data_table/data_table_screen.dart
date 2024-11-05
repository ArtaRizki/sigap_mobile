import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigap_mobile/common/component/custom_navigator.dart';
import 'package:sigap_mobile/common/helper/constant.dart';
import 'package:sigap_mobile/generated/assets.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table/data_table_bloc.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table/data_table_event.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table/data_table_state.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table_create/data_table_create_screen.dart';
import 'package:sigap_mobile/utils/utils.dart';

class DataTableScreen extends StatefulWidget {
  const DataTableScreen({super.key});

  @override
  State<DataTableScreen> createState() => _DataTableScreenState();
}

class _DataTableScreenState extends State<DataTableScreen> {
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

    Widget preInspectionList() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constant.xSizedBox8,
            BlocBuilder<DataTableBloc, DataTableState>(
              builder: (context, state) {
                if (state is DataTableSuccess)
                  return Table(
                    border: TableBorder.all(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5)),
                    columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(flex: 0.4),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                      3: FlexColumnWidth(),
                      4: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    children: [
                      // title
                      TableRow(
                        decoration: BoxDecoration(color: Color(0xffDEEDFF)),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Text(
                              'No',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff100629),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Text(
                              'Tanggal',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff100629),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Text(
                              'Alat',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff100629),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Text(
                              'Creator',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff100629),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Text(
                              'Terminal',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff100629),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // content
                      ...List.generate(
                        state.data.data?.length ?? 0,
                        (index) {
                          final item = state.data.data?[index];
                          return TableRow(
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            children: [
                              TableRowInkWell(
                                onTap: () {
                                  CusNav.nPush(
                                      context, DataTableCreateScreen(isEdit: true, ));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: Text(
                                    ' ${index + 1}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xff100629),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              TableRowInkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    '${item?.dateDoc?.trim().replaceAll('   20', ' 20')}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xff100629),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              TableRowInkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    item?.assetName ?? '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff100629),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              TableRowInkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    item?.personilName ?? '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff100629),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              TableRowInkWell(
                                onTap: () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, right: 8),
                                  child: Text(
                                    item?.companyName ?? '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff100629),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                return Center(
                    child: CircularProgressIndicator(
                        color: Constant.primaryColor));
              },
            ),
          ],
        ),
      );
    }

    Widget addButton() {
      return Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Constant.primaryColor,
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            'Tambah Data',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return BlocProvider(
      create: (_) => DataTableBloc()..add(FetchDataTable()),
      child: Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [preInspectionList()],
          ),
        ),
        bottomNavigationBar: addButton(),
      ),
    );
  }
}
