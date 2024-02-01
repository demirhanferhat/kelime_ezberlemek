import 'package:flutter/material.dart';

PreferredSize appBar(context,
    {required Widget? left,
    required Widget center,
    Widget? right,
    Function? leftWidgetObClick}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width * 0.20,
            child: InkWell(
              onTap: () => leftWidgetObClick!(),
              child: left,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.5,
            child: center,
          ),
          Container(
            alignment: Alignment.centerRight,
            width: MediaQuery.of(context).size.width * 0.2,
            child: right,
          ),
        ],
      ),
    ),
  );
}
