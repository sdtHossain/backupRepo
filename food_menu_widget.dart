import '../backend/api_requests/api_calls.dart';
import '../components/bottom_navbar_widget.dart';
import '../components/cart_drawer_widget.dart';
import '../components/sidebar_menus_widget.dart';
import '../components/top_nav_bar_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FoodMenuWidget extends StatefulWidget {
  const FoodMenuWidget({
    Key? key,
    this.categoryId,
  }) : super(key: key);

  final int? categoryId;

  @override
  _FoodMenuWidgetState createState() => _FoodMenuWidgetState();
}

class _FoodMenuWidgetState extends State<FoodMenuWidget> {
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

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      drawer: Drawer(
        elevation: 16,
        child: SidebarMenusWidget(),
      ),
      endDrawer: Drawer(
        elevation: 16,
        child: CartDrawerWidget(),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                TopNavBarWidget(
                  pageTitle: 'Fast Food',
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 96, 16, 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Color(0x0E272D2F),
                          offset: Offset(0, 10),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: textController,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Search Food',
                        hintStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Inter',
                                  color: Color(0xB2575757),
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: Icon(
                          Icons.search_outlined,
                          color: Color(0xFF757575),
                          size: 24,
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).subtitle2.override(
                            fontFamily: 'Inter',
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).lightBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.food_bank_outlined,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 20,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                              child: Text(
                                FFAppState().foodItems.length.toString(),
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: FutureBuilder<ApiCallResponse>(
                    future: GetMenusByCategoryCall.call(
                      categoryId: widget.categoryId,
                      token: FFAppState().token,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }
                      final listViewGetMenusByCategoryResponse = snapshot.data!;
                      return Builder(
                        builder: (context) {
                          final menuList = GetMenusByCategoryCall.menus(
                            listViewGetMenusByCategoryResponse.jsonBody,
                          ).toList();
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: menuList.length,
                            itemBuilder: (context, menuListIndex) {
                              final menuListItem = menuList[menuListIndex];
                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                child: Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Color(0x0D272D2F),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 8, 8, 8),
                                        child: Container(
                                          width: 100,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.network(
                                                'https://images.unsplash.com/photo-1632203171982-cc0df6e9ceb4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8ZmFzdGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                                              ).image,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 8, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 0, 0, 8),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          getJsonField(
                                                            menuListItem,
                                                            r'''$.name''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText2,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      4, 0, 0),
                                                          child: Text(
                                                            '৳${getJsonField(
                                                              menuListItem,
                                                              r'''$.price''',
                                                            ).toString()}',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .subtitle2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FlutterFlowIconButton(
                                                    borderRadius: 30,
                                                    buttonSize: 48,
                                                    fillColor:
                                                        Color(0x0EF54749),
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: Color(0x80272D2F),
                                                      size: 24,
                                                    ),
                                                    onPressed: () async {
                                                      apiResultCheckTableHasOrder =
                                                          await CheckTableHasOrderCall
                                                              .call(
                                                        token:
                                                            FFAppState().token,
                                                        restaurantId:
                                                            getJsonField(
                                                          FFAppState()
                                                              .joinedRestaurant,
                                                          r'''$.id''',
                                                        ),
                                                        tableId: FFAppState()
                                                            .selectedTableId,
                                                      );
                                                      if (apiResultCheckTableHasOrder
                                                                  ?.jsonBody[
                                                              "hydra:totalItems"] >
                                                          0) {
                                                        apiResultGetOrderById =
                                                            await GetOrderByIdCall
                                                                .call(
                                                          token: FFAppState()
                                                              .token,
                                                          restaurantId:
                                                              getJsonField(
                                                            FFAppState()
                                                                .joinedRestaurant,
                                                            r'''$.id''',
                                                          ),
                                                          orderId:
                                                              CheckTableHasOrderCall
                                                                  .orderId(
                                                            (apiResultCheckTableHasOrder
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ),
                                                        );
                                                        var preOrderedItems =
                                                            apiResultGetOrderById
                                                                    ?.jsonBody[
                                                                "orderItems"];
                                                        dynamic thisItem = apiResultGetOrderById
                                                            ?.jsonBody[
                                                                "orderItems"]
                                                            .where((e) =>
                                                                e["menu"] ==
                                                                "/api/menus/" +
                                                                    getJsonField(
                                                                            menuListItem,
                                                                            r'''$.id''')
                                                                        .toString())
                                                            .toList();
                                                        if (thisItem.length >
                                                            0) {
                                                          int quantityOfItem =
                                                              thisItem[0][
                                                                      "quantity"] +
                                                                  1;
                                                          apiResultUpdateOrderItem =
                                                              await UpdateOrderItemCall
                                                                  .call(
                                                            token: FFAppState()
                                                                .token,
                                                            quantity:
                                                                quantityOfItem,
                                                            remarks:
                                                                'update order items',
                                                            price: thisItem[0]
                                                                ["price"],
                                                            orderId:
                                                                CheckTableHasOrderCall
                                                                    .orderId(
                                                              (apiResultCheckTableHasOrder
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            ),
                                                            menuId:
                                                                getJsonField(
                                                              menuListItem,
                                                              r'''$.id''',
                                                            ),
                                                            orderItemsId:
                                                                thisItem[0]
                                                                    ["id"],
                                                          );
                                                          if ((apiResultUpdateOrderItem
                                                                  ?.succeeded ??
                                                              true)) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'you ordered this item before, your order has been updated',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    Color(
                                                                        0x00000000),
                                                              ),
                                                            );
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'your order hasn\'t been updated',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    Color(
                                                                        0x00000000),
                                                              ),
                                                            );
                                                          }
                                                        } else {
                                                          print("coming here");
                                                          apiResultCreateNewOrderItem =
                                                              await CreateNewOrderItemCall
                                                                  .call(
                                                            token: FFAppState()
                                                                .token,
                                                            restaurantId:
                                                                getJsonField(
                                                              FFAppState()
                                                                  .joinedRestaurant,
                                                              r'''$.id''',
                                                            ),
                                                            quantity: 1,
                                                            remarks:
                                                                'new order item from custom',
                                                            price: 1300,
                                                            orderId:
                                                                CheckTableHasOrderCall
                                                                    .orderId(
                                                              (apiResultCheckTableHasOrder
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            ),
                                                            menuId:
                                                                getJsonField(
                                                              menuListItem,
                                                              r'''$.id''',
                                                            ),
                                                          );
                                                          if ((apiResultCreateNewOrderItem
                                                                  ?.succeeded ??
                                                              true)) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Your new order added',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    Color(
                                                                        0x00000000),
                                                              ),
                                                            );
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Your order has not been added',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    Color(
                                                                        0x00000000),
                                                              ),
                                                            );
                                                          }
                                                        }
                                                      } else {
                                                        apiResultSubmitOrder =
                                                            await SubmitOrderCall
                                                                .call(
                                                          token: FFAppState()
                                                              .token,
                                                          restaurantId:
                                                              getJsonField(
                                                            FFAppState()
                                                                .joinedRestaurant,
                                                            r'''$.id''',
                                                          ),
                                                          discount: 0,
                                                          placed: true,
                                                          served: true,
                                                          paid: true,
                                                          open: true,
                                                          tableId: FFAppState()
                                                              .selectedTableId,
                                                          quantity: 1,
                                                          remarks:
                                                              '\"new order by pressing + icon',
                                                          menuId: getJsonField(
                                                            menuListItem,
                                                            r'''$.id''',
                                                          ),
                                                        );
                                                        if ((apiResultSubmitOrder
                                                                ?.succeeded ??
                                                            true)) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'added food item',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  Color(
                                                                      0x00000000),
                                                            ),
                                                          );
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'not added food item',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  Color(
                                                                      0x00000000),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 8, 8, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      getJsonField(
                                                        menuListItem,
                                                        r'''$.description''',
                                                      ).toString(),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: BottomNavbarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
