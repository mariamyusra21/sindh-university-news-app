import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:usindh_news/constants.dart';

class DateFilter extends StatefulWidget {
  final Function(DateTime, DateTime) onApplyFilter;
  const DateFilter({super.key, required this.onApplyFilter});

  @override
  State<DateFilter> createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime startdate = DateTime.now();
    DateTime enddate = DateTime.now();

    // String startformatedDate = DateFormat('MMMM d, yyyy').format(startdate);
    // String endformatedDate = DateFormat('MMMM d, yyyy').format(enddate);
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text(
          'Filter News by Date',
          style: appBarTextStyle,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              cursorColor: mainColor,
              readOnly: true,
              controller: startDateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                // iconColor: mainColor,
                labelText: 'Start Date: ',
                labelStyle: postTextStyle,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () async {
                    DateTime? newStartDate = await showDatePicker(
                      context: context,
                      initialDate: startdate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    //if 'cancel' => null
                    if (newStartDate == null) {
                      return;
                    }
                    //if 'ok' => Datetime
                    setState(() {
                      startdate = newStartDate;
                      startDateController.text =
                          DateFormat('MMMM d, yyyy').format(startdate);
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              cursorColor: mainColor,
              readOnly: true,
              controller: endDateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: 'End Date: ',
                labelStyle: postTextStyle,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () async {
                    DateTime? newEndDate = await showDatePicker(
                      context: context,
                      initialDate: enddate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    //if 'cancel' => null
                    if (newEndDate == null) {
                      return;
                    }
                    //if 'ok' => Datetime
                    setState(() {
                      enddate = newEndDate;
                      endDateController.text =
                          DateFormat('MMMM d, yyyy').format(enddate);
                    });
                  },
                ),
              ),
              // initialValue: '${enddate.day}-${enddate.month}-${enddate.year}',
            ),
            SizedBox(height: 10),
            //
          ],
        ),
        actions: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            // surfaceTintColor: Colors.grey,
            color: mainColor,
            margin:
                const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            // surfaceTintColor: Colors.grey,
            color: mainColor,
            margin:
                const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
            child: TextButton(
              onPressed: () {
                String formatStartDate =
                    DateFormat("yyyy-MM-dd").format(startdate);
                DateTime _startDate = DateTime.parse(formatStartDate);
                String formatEndDate = DateFormat("yyyy-MM-dd").format(enddate);
                DateTime _endDate = DateTime.parse(formatEndDate);
                widget.onApplyFilter(_startDate, _endDate);
                Navigator.pop(context);
              },
              child: Text(
                'Filter News',
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ),
        ],
      );
    });
  }
}
