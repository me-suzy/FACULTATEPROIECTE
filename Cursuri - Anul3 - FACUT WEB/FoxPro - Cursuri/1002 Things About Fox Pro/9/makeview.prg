*** Create the Orderlines view from the Tastrade data
OPEN DATABASE CH09 
SET DATABASE TO CH09
CREATE SQL VIEW "lvOrderLines" ; 
   AS SELECT Products.product_id, Products.prod_name, Products.eng_name, Orditems.unit_price, Orditems.quantity FROM ( HOME( 2 ) + 'Data\testdata!products' ) INNER JOIN ( HOME( 2 ) + 'Data\testdata!orditems' ) ON  Products.product_id = Orditems.product_id WHERE Orditems.order_id = ?vp_order_id ORDER BY Products.prod_name

DBSetProp('lvOrderLines', 'View', 'UpdateType', 1)
DBSetProp('lvOrderLines', 'View', 'WhereType', 3)
DBSetProp('lvOrderLines', 'View', 'FetchMemo', .T.)
DBSetProp('lvOrderLines', 'View', 'SendUpdates', .F.)
DBSetProp('lvOrderLines', 'View', 'UseMemoSize', 255)
DBSetProp('lvOrderLines', 'View', 'FetchSize', 100)
DBSetProp('lvOrderLines', 'View', 'MaxRecords', -1)
DBSetProp('lvOrderLines', 'View', 'Tables', '')
DBSetProp('lvOrderLines', 'View', 'Prepared', .F.)
DBSetProp('lvOrderLines', 'View', 'CompareMemo', .T.)
DBSetProp('lvOrderLines', 'View', 'FetchAsNeeded', .F.)
DBSetProp('lvOrderLines', 'View', 'FetchSize', 100)
DBSetProp('lvOrderLines', 'View', 'Comment', "")
DBSetProp('lvOrderLines', 'View', 'BatchUpdateCount', 1)
DBSetProp('lvOrderLines', 'View', 'ShareConnection', .F.)

*!* Field Level Properties for lvOrderLines
* Props for the lvOrderLines.product_id field.
DBSetProp('lvOrderLines.prod_name', 'Field', 'KeyField', .T.)
DBSetProp('lvOrderLines.prod_name', 'Field', 'Updatable', .F.)
DBSetProp('lvOrderLines.prod_name', 'Field', 'UpdateName', 'testdata!products.product_id')
DBSetProp('lvOrderLines.prod_name', 'Field', 'DataType', "C(6)")
* Props for the lvOrderLines.prod_name field.
DBSetProp('lvOrderLines.prod_name', 'Field', 'KeyField', .F.)
DBSetProp('lvOrderLines.prod_name', 'Field', 'Updatable', .F.)
DBSetProp('lvOrderLines.prod_name', 'Field', 'UpdateName', 'testdata!products.prod_name')
DBSetProp('lvOrderLines.prod_name', 'Field', 'DataType', "C(40)")
* Props for the lvOrderLines.eng_name field.
DBSetProp('lvOrderLines.prod_name', 'Field', 'KeyField', .F.)
DBSetProp('lvOrderLines.prod_name', 'Field', 'Updatable', .F.)
DBSetProp('lvOrderLines.prod_name', 'Field', 'UpdateName', 'testdata!products.eng_name')
DBSetProp('lvOrderLines.prod_name', 'Field', 'DataType', "C(40)")
* Props for the lvOrderLines.unit_price field.
DBSetProp('lvOrderLines.unit_price', 'Field', 'KeyField', .F.)
DBSetProp('lvOrderLines.unit_price', 'Field', 'Updatable', .F.)
DBSetProp('lvOrderLines.unit_price', 'Field', 'UpdateName', 'testdata!orditems.unit_price')
DBSetProp('lvOrderLines.unit_price', 'Field', 'DataType', "Y")
* Props for the lvOrderLines.quantity field.
DBSetProp('lvOrderLines.quantity', 'Field', 'KeyField', .F.)
DBSetProp('lvOrderLines.quantity', 'Field', 'Updatable', .F.)
DBSetProp('lvOrderLines.quantity', 'Field', 'UpdateName', 'testdata!orditems.quantity')
DBSetProp('lvOrderLines.quantity', 'Field', 'DataType', "N(12,3)")
