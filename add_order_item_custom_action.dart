// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future addOrderItemCustomAction(
    dynamic menuListItem, BuildContext context) async {
  // Add your function code here!
  ApiCallResponse? apiResultCheckTableHasOrder;
  ApiCallResponse? apiResultGetOrderById;
  ApiCallResponse? apiResultUpdateOrder;
  ApiCallResponse? apiResultUpdateOrderItem;
  ApiCallResponse? apiResultCreateNewOrderItem;
  ApiCallResponse? apiResultSubmitOrder2nd;
  ApiCallResponse? apiResultUpdateItemToOrder;
  ApiCallResponse? apiResultSubmitOrder;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  apiResultCheckTableHasOrder = await CheckTableHasOrderCall.call(
    token: FFAppState().token,
    restaurantId: getJsonField(
      FFAppState().joinedRestaurant,
      r'''$.id''',
    ),
    tableId: FFAppState().selectedTableId,
  );
  if (apiResultCheckTableHasOrder?.jsonBody["hydra:totalItems"] > 0) {
    apiResultGetOrderById = await GetOrderByIdCall.call(
      token: FFAppState().token,
      restaurantId: getJsonField(
        FFAppState().joinedRestaurant,
        r'''$.id''',
      ),
      orderId: CheckTableHasOrderCall.orderId(
        (apiResultCheckTableHasOrder?.jsonBody ?? ''),
      ),
    );
    var preOrderedItems = apiResultGetOrderById?.jsonBody["orderItems"];
    dynamic thisItem = apiResultGetOrderById?.jsonBody["orderItems"]
        .where((e) =>
            e["menu"] ==
            "/api/menus/" + getJsonField(menuListItem, r'''$.id''').toString())
        .toList();
    if (thisItem.length > 0) {
      int quantityOfItem = thisItem[0]["quantity"] + 1;
      apiResultUpdateOrderItem = await UpdateOrderItemCall.call(
        token: FFAppState().token,
        quantity: quantityOfItem,
        remarks: 'update order items',
        price: thisItem[0]["price"],
        orderId: CheckTableHasOrderCall.orderId(
          (apiResultCheckTableHasOrder?.jsonBody ?? ''),
        ),
        menuId: getJsonField(
          menuListItem,
          r'''$.id''',
        ),
        orderItemsId: thisItem[0]["id"],
      );
      if ((apiResultUpdateOrderItem?.succeeded ?? true)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'you ordered this item before, your order has been updated',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: Color(0x00000000),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'your order hasn\'t been updated',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: Color(0x00000000),
          ),
        );
      }
    } else {
      print("coming here");
      apiResultCreateNewOrderItem = await CreateNewOrderItemCall.call(
        token: FFAppState().token,
        restaurantId: getJsonField(
          FFAppState().joinedRestaurant,
          r'''$.id''',
        ),
        quantity: 1,
        remarks: 'new order item from custom',
        price: 1300,
        orderId: CheckTableHasOrderCall.orderId(
          (apiResultCheckTableHasOrder?.jsonBody ?? ''),
        ),
        menuId: getJsonField(
          menuListItem,
          r'''$.id''',
        ),
      );
      if ((apiResultCreateNewOrderItem?.succeeded ?? true)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Your new order added',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: Color(0x00000000),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Your order has not been added',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: Color(0x00000000),
          ),
        );
      }
    }
  } else {
    apiResultSubmitOrder = await SubmitOrderCall.call(
      token: FFAppState().token,
      restaurantId: getJsonField(
        FFAppState().joinedRestaurant,
        r'''$.id''',
      ),
      discount: 0,
      placed: true,
      served: true,
      paid: true,
      open: true,
      tableId: FFAppState().selectedTableId,
      quantity: 1,
      remarks: '\"new order by pressing + icon',
      menuId: getJsonField(
        menuListItem,
        r'''$.id''',
      ),
    );
    if ((apiResultSubmitOrder?.succeeded ?? true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'added food item',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: Color(0x00000000),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'not added food item',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: Color(0x00000000),
        ),
      );
    }
  }
}
