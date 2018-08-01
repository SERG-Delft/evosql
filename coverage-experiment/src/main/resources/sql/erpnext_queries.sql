select name, is_group from `tabwarehouse` where `tabwarehouse`.company = '_Test Company' order by `tabwarehouse`.`modified` desc
select `supplier_name` from `tabsupplier` where `name` = '_Test Supplier' order by modified desc
select name from `tabStock Entry` where production_order = 'PRO-00003' and docstatus ='1'
select `name` from `tabAuto Email Report` where `name` = 'Permitted Documents For User' order by modified desc
select `stock_uom` from `tabitem` where `name` = '_Test Item Home Desktop 200' order by modified desc
select `program_abbreviation` from `tabprogram` where `name` = '_Test Program' order by modified desc
select max(char_length(`event_type`)) from `tabevent`
select `name` from `tabWebsite Theme` where `name` = 'Standard' order by modified desc
select name, from_time, to_time from `tabAssessment Plan` where `student_group`='TC-TP-2014-2015-2014-2015 (_Test Academic Term)' and schedule_date = '2017-02-09' and ( (from_time > '3:00:00' and from_time < '4:00:00') or (to_time > '3:00:00' and to_time < '4:00:00') or ('3:00:00' > from_time and '3:00:00' < to_time) or ('3:00:00' = from_time and '4:00:00' = to_time)) and name!='SH00023'
select * from `tabEvent Role` where `parenttype` = 'Event' and `parent` = 'EV00013' and `parentfield` = 'roles' order by idx asc
select `name` from `tabAddress Template` where `is_default` ='1'and `name` != 'United States' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabasset` where `amended_from` = 'Macbook Pro 1' order by modified desc
select `account_type`, `root_type`, `account_currency`, `company` from `tabaccount` where `name` = '_Test Receivable USD - _TC' order by modified desc
select parent from tabDocField where fieldtype='Table' and options='Customer'
select * from `tabMode of Payment` where `name` = 'Cash' order by modified desc
select distinct invoice_type from `tabPayment Reconciliation Invoice`
select `route` from `tabBlog Category` where `name` = '_Test Blog Category' order by modified desc
select name from `tabBOM Item` where parent='BOM-_Test PPT Item Master-001' and parenttype='BOM' and parentfield='items' and name not in ('499bf31b7c','a33c2aae0c','48fb7b5443','7faa8df7b2')
select `docstatus` from `tabMaterial Request` where `name` = '_T-Material Request-00013' order by modified desc
select t1.name from `tabPurchase Invoice` t1,`tabPurchase Invoice Item` t2 where t1.name = t2.parent and t2.purchase_receipt = 'PREC-00016' and t1.docstatus ='1'
select `first_name`, `last_name` from `tabuser` where `name` = 'Bimonthly_test_employee@salary.com' order by modified desc
SELECT * FROM tabDocField WHERE parent = 'ToDo'
select `name` from `tabuserrole` where `role` = 'Blogger' and `parent` = 'test_import_userrole@example.com' order by modified desc
select `smallest_currency_fraction_value` from `tabcurrency` where `name` = 'USD' order by modified desc
select * from `tabSalary Slip` where `name` = 'Sal Slip/EMP-0003/00001' order by modified desc
select * from `tabPOS Profile` where user = 'Administrator' and company = '_Test Company'
select modified, docstatus from `tabcompany` where name = 'COA from Existing Company' for update
SELECT DISTINCT(parent) FROM `tabUser Email` WHERE awaiting_password ='1'
select name from `tabuser` where enabled='1'
select `item_name`, `description` from `tabitem` where `name` = '_Test Item Home Desktop 100' order by modified desc
select warehouse, name, account_currency from tabAccount where account_type = 'Stock' and (warehouse is not null and warehouse != '') and is_group='0'
select `name` from `tabSalary Structure Employee` where `employee` = 'EMP-0002' and `parent` = 'Monthly Salary Structure Test for Salary Slip' order by modified desc
select name, subject, description, starts_on, ends_on, owner, all_day, event_type, repeat_this_event, repeat_on,repeat_till, monday, tuesday, wednesday, thursday, friday, saturday, sunday from tabevent where (( (date(starts_on) between date('2015-02-01') and date('2015-02-01')) or (date(ends_on) between date('2015-02-01') and date('2015-02-01')) or (date(starts_on) <= date('2015-02-01') and date(ends_on) >= date('2015-02-01')) ) or ( date(starts_on) <= date('2015-02-01') and repeat_this_event='1'and ifnull(repeat_till, '3000-01-01') > date('2015-02-01') )) and ifnull(send_reminder,0)='1'and (event_type='Public' or owner='Administrator' or exists(select name from `tabdocshare` where tabDocShare.share_doctype='Event' and `tabdocshare`.share_name=tabevent.name and tabDocShare.user='Administrator') or exists(select * from `tabEvent Role` where `tabEvent Role`.parent=tabevent.name and `tabEvent Role`.role in ('Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest'))) order by starts_on
select * from `tabdefaultvalue` where parent='Guest' and parentfield='defaults' order by idx
select * from `tabPOS Customer Group` where `parenttype` = 'POS Profile' and `parent` = '6125d62f89' and `parentfield` = 'customer_groups' order by idx asc
select `name`, `parent`, `parenttype`, `docstatus` from `tabSales Order Item` where `prevdoc_docname` = 'QTN-00005' order by modified desc
select t1.name, t1.salary_structure from `tabSalary Slip` t1 where t1.docstatus ='0'and t1.start_date >= '2016-11-01' and t1.end_date <= '2016-11-30' and (t1.journal_entry is null or t1.journal_entry = '') and ifnull(salary_slip_based_on_timesheet,0) ='0'and t1.company = 'Wind Power LLC'
select name, has_batch_no, docstatus, is_stock_item, has_variants, stock_uom from tabItem where name='_Test Item'
select * from `tabterritory` where lft='4'or rgt='5'
select * from `tabdocfield` where `parenttype` = 'DocType' and `parent` = 'Website Slideshow Item' and `parentfield` = 'fields' order by idx asc
select `name` from `tabbom` where `is_default` ='1'and `item` = '_Test FG Item 2' and `is_active` ='1'order by modified desc
select `name` from `tabSales Invoice` where `name` = '_T-Sales Invoice-00004' order by modified desc
select `name` from `tabemployee` where `name` = 'EMP-0004' order by modified desc
select name from `tabrole` where desk_access='1'and name in ('_Test Role', 'System Manager', 'Employee', 'Blogger', '_Test Role 3') limit 1
select `name`, `designation`, `branch` from `tabemployee` where `name` = 'EMP-0001' order by modified desc
select name, has_batch_no, docstatus, is_stock_item, has_serial_no, serial_no_series from tabItem where name='_Test Serialized Item'
select `name` from `tabStock Entry` where `name` = 'STE-00044' order by modified desc
select name from `tabtask` where `tabtask`.project = '_Test Project' and ifnull(`tabtask`.name, '') not in ('TASK00004') order by `tabtask`.`modified` desc
select item_code, `amount`, `billed_amt`, parenttype, parent from `tabSales Order Item` where `amount` < `billed_amt` and name='e2a298d36d' and docstatus='1'
select * from `tabSales Invoice Advance` where `parenttype` = 'Sales Invoice' and `parent` = 'SINV-00015' and `parentfield` = 'advances' order by idx asc
select * from `tabEmail Queue` where `name` = 'c4031dcc1c' order by modified desc
select employee, leave_type, total_leaves_allocated, from_date, to_date from `tabLeave Allocation` where '2013-01-01' between from_date and to_date and docstatus='1'and employee='_T-Employee-0002'
select `name` from `tabSales Person` where `employee` = NULL order by modified desc
select * from `tabSales Invoice Item` where `parenttype` = 'Sales Invoice' and `parent` = '_T-Sales Invoice-00004' and `parentfield` = 'items' order by idx asc
select `is_stock_item` from `tabitem` where `name` = '_Test Item for Auto Price List' order by modified desc
select `is_group` from `tabwarehouse` where `name` = 'Test Warehouse for Merging 1 - _TC' order by modified desc
select name from tabDocType
select `parenttype`, `parent` from `tabtodo` where `name` = '258546aad7' order by modified desc
select `tabitem`.`name` from `tabitem` where `tabitem`.variant_of = '_Test Numeric Template Item' order by `tabitem`.`idx` desc, `tabitem`.`modified` desc
select route, name, modified from `tabJob Opening` where publish='1'and `route`='test-route-000' limit 1
select * from `tabreport` where `name` = 'Permitted Documents For User' order by modified desc
select * from `tabPricing Rule` where (item_code='_Test Item Home Desktop 200' or ifnull(item_group, '') in ('_Test Item Group Desktops', 'All Item Groups') or brand=NULL) and docstatus < 2 and `tabPricing Rule`."disable" ='0'and buying ='1'and ifnull(company, '') in ('_Test Company', '') and ifnull(customer, '') = '' and ifnull(supplier, '') = '' and ifnull(supplier_type, '') = '' and ifnull(campaign, '') = '' and ifnull(sales_partner, '') = '' and ifnull(for_price_list, '') in ('Standard Buying', '') and '2017-02-09' between ifnull(valid_from, '2000-01-01') and ifnull(valid_upto, '2500-12-31') order by priority desc, name desc
select `lead_name`, `email_id`, `phone`, `mobile_no` from `tablead` where `name` = '_T-Lead-00001' order by modified desc
select * from `tabGL Entry` where posting_date >= '2012-12-26' and voucher_no in ('SR/00006', 'STE-00007', 'STE-00010')
select distinct reference_doctype from `tabPayment Entry Reference`
select name from `tabuserrole` where parent='test2@example.com' and parenttype='User' and parentfield='user_roles' and name not in ('fb6624c2ad','7dcdf83959','48b461aefc','79ec8a8cb6')
select `name` from `tabTax Rule` where `use_for_shopping_cart` ='1'order by modified desc
select user_id from `tabemployee` where `tabemployee`.status = 'Active' and `tabemployee`.company = '_Test Company' order by `tabemployee`.`modified` DESC
select sum(amount) from `tabSales Invoice Item` where so_detail='21b1167610' and (dn_detail is null or dn_detail = '') and docstatus='1'
select `name` from `tabAsset Category` where `name` = 'Computers' order by modified desc
select `rate` from `tabPurchase Receipt Item` where `name` = '5018a5031a' order by modified desc
select distinct payment_document from `tabBank Reconciliation Detail`
select name from `tabParty Account` where parent='_Test Supplier USD' and parenttype='Supplier' and parentfield='accounts' and name not in ('134cac726d')
select `name` from `tabbudget` where `docstatus` !='2'and `cost_center` = '_Test Cost Center - _TC' and `company` = '_Test Company' and `fiscal_year` = '_Test Fiscal Year 2013' and `name` != '_Test Cost Center - _TC/_Test Fiscal Year 2013/002' order by modified desc
select `thumbnail`, `website_image`, `description`, `route` from `tabitem` where `name` = '_Test Item 2' order by modified desc
select sum(base_net_amount) / sum(qty) from `tabPurchase Invoice Item` where item_code = '_Test Service Product Bundle Item 2' and docstatus='1'
select `email_id` from `tabEmail Account` where `append_to` = 'ToDo' order by modified desc
select owner from `tabtodo` where reference_type='Task' and reference_name='TASK00009'
select `name` from `tabStock Ledger Entry` where `voucher_no` = 'SR/00009' and `voucher_type` = 'Stock Reconciliation' order by modified desc
select name from `tabLanded Cost Taxes and Charges` where parent='LCV00003' and parenttype='Landed Cost Voucher' and parentfield='taxes' and name not in ('a05dcf7415')
select bom_item.item_code, bom_item.item_name, bom_item.description, bom_item.stock_uom, bom_item.qty, bom_item.rate, bom_item.qty / ifnull(bom.quantity, 1) as qty_consumed_per_unit from `tabBOM Explosion Item` bom_item, tabBOM bom where bom_item.parent = bom.name and bom.name = 'BOM-_Test PPT Item Sub A-001' and bom.docstatus ='1'
select `name`, `parent`, `parenttype`, `docstatus` from `tabtimesheet` where `salary_slip` = 'Sal Slip/_T-Employee-0001/00001' order by modified desc
select `item_group`, `buying_cost_center` from `tabitem` where `name` = '_Test Item' order by modified desc
select `name`, `full_name` from `tabuser` where `name` = 'Administrator' order by modified desc
select name from `tabcustomer` where `tabcustomer`.status = 'Open' order by `tabcustomer`.`modified` desc limit 0, 100
select distinct share_doctype from tabDocShare where (user='Administrator' or everyone='1'
select `name` from `tabStock Entry` where `docstatus` !='2'and `production_order` = 'PRO-00002' and `purpose` = 'Manufacture' and `name` != 'STE-00039' order by modified desc
select name from `tabuserrole` where parent='Administrator' and parenttype='User' and parentfield='user_roles' and name not in ('840a017172','a8aeb4dda8','fb92eac658','2f0b4f7942','295edbfb91','ea3354d8bd','ae196db87f','14607b04e4','ee65d39cdb','9a873503c7','63ddbbc65d','550f629631','f88424d645','93962fb409','2776be196f','767caf1a89','eef45bb10b','8606e302fa','0dc15b9feb','d07210c929','15e0ff6ecd','4dabbc20ab','bbd0220737','8fc9cf07fb','4e3bdaa967','ff26dd60d4','e6e009ef82','bb58f2d291','0ae1a69f66','27d84ccc37','1953579051','e709bd7103','5d9817f9d9','9e29a83a26','d79f19b8c9','dcdf15a4fe','1403958824','713d246c3f','daa263b410','b28ba6a464','6f9c3a94b8','7d2fb9484f','6c0b5d5cef','d6cff724e6')
select distinct `link_doctype`, parenttype from `tabcommunication` where `link_doctype`='Role'
select * from `tabPurchase Receipt Item` where `name` = '68842f9afa' order by modified desc
select name from `tabWarranty Claim` where `tabWarranty Claim`.status = 'Open' order by `tabWarranty Claim`.`modified` DESC limit 0, 100
select name from `tabrole` where desk_access='1'and name in ('Customer') limit 1
select `name`, `operating_cost` from `tabbom` where `is_default` ='1'and `item` = '_Test FG Item 2' and `docstatus` ='1'order by modified desc
select sum(purchase_rate) from `tabSerial No` where name in ('ABCD00001', 'ABCD00002')
select * from `tabSalary Component Account` where `parenttype` = 'Salary Component' and `parent` = 'Basic' and `parentfield` = 'accounts' order by idx asc
select max(char_length(`test_ref_name`)) from `tabevent`
select name from `tabquotation` where `tabquotation`.customer = '_Test Customer 1' and ifnull(`tabquotation`.docstatus, 0) = 0.0 order by `tabquotation`.docstatus asc, `tabquotation`.`modified` DESC limit 0, 1
select count(name) from tabCustomer where customer_group = '_Test Customer Group'
select `name` from `tabPayment Request` where `docstatus` ='1'and `reference_doctype` = 'Sales Invoice' and `reference_name` = 'SINV-00019' order by modified desc
select `name`, `user`, `read`, `write`, `share`, `everyone` from tabDocShare where share_doctype='Blog Post' and share_name='-test-blog-post'
select `name`, `parent`, `parenttype`, `docstatus` from `tabPurchase Order Item` where `sales_order` = 'SO-00033' order by modified desc
select name from `tabError Snapshot` where `tabError Snapshot`.seen = 0.0 and `tabError Snapshot`.parent_error_snapshot ='0'order by `tabError Snapshot`.`timestamp` DESC limit 0, 100
select * from `tabGL Entry` where posting_date >= '2017-02-07' and voucher_no in ('STE-00012', '_T-Purchase Receipt-00003', 'PINV-00001', 'DN-00001', 'STE-00011', 'DN-00002')
select dt as doctype, fieldname, options as doctype_fieldname from `tabCustom Field` where fieldtype='Dynamic Link'
select `_comments` from `tabEmail Account` where `name` = '_Test Email Account 1' order by modified desc
select * from `tabEmployee Internal Work History` where `parenttype` = 'Employee' and `parent` = 'EMP-0005' and `parentfield` = 'internal_work_history' order by idx asc
select warehouse, stock_value_difference, voucher_detail_no, item_code, posting_date, posting_time, actual_qty, qty_after_transaction from `tabStock Ledger Entry` where voucher_type='Delivery Note' and voucher_no='DN-00003'
select `owner` from `tabSales Invoice` where `name` = '_T-Sales Invoice-00001' order by modified desc
select modified, docstatus from `tabbom` where name = 'BOM-_Test FG Item 2-001' for update
select name from `tabPacked Item` where parent='SO-00027' and parenttype='Sales Order' and parentfield='packed_items' and name not in ('7db742e2e8','7265ab15ca')
select * from `tabProduction Plan Material Request` where `parenttype` = 'Production Planning Tool' and `parent` = 'Production Planning Tool' and `parentfield` = 'material_requests' order by idx asc
select `name`, `parent`, `parenttype`, `docstatus` from `tabPurchase Invoice Item` where `asset` = 'Macbook Pro 1' order by modified desc
select `website_image` from `tabitem` where `name` = '_Test PPT Item Sub B' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabC-Form Invoice Detail` where `invoice_no` = 'SINV-00016' order by modified desc
select `name` from `tabPayment Gateway` where `name` = '_Test Gateway' order by modified desc
select `name` from `tabDesktop Icon` where `owner` = 'test@example.com' and `module_name` = 'BOM' and `standard` ='0'order by modified desc
select * from `tabdoctype` where `name` = 'SMS Center' order by modified desc
select `docstatus` from `tabJournal Entry` where `name` = '_T-Journal Entry-00004' order by modified desc
select `stock_value_difference` from `tabStock Ledger Entry` where `warehouse` = '_Test Warehouse - _TC' and `voucher_no` = 'STE-00011' and `voucher_type` = 'Stock Entry' order by modified desc
select distinct sle.voucher_type, sle.voucher_no from `tabStock Ledger Entry` sle where timestamp(sle.posting_date, sle.posting_time) >= timestamp('2017-02-09', '12:25:34.138998') and item_code in ('_Test Item') and warehouse in ('_Test Warehouse - _TC', '_Test Warehouse 1 - _TC') order by timestamp(sle.posting_date, sle.posting_time) asc, name asc
select * from `tabTax Rule` where (from_date is null or from_date = '' or from_date <= '2015-01-01') and (to_date is null or to_date = '' or to_date >= '2015-01-01') and ifnull(customer, '') in ('', '_Test Customer') and ifnull(shipping_state, '') in ('', 'Test State')
select account, posting_date, party_type, party, cost_center, fiscal_year,voucher_type, voucher_no, against_voucher_type, against_voucher, cost_center, company from `tabGL Entry` where voucher_type='Stock Reconciliation' and voucher_no='SR/00001'
select `costing_rate`, `billing_rate` from `tabActivity Type` where `activity_type` = '_Test Activity Type' order by modified desc
select `max_days_allowed` from `tabLeave Type` where `name` = '_Test Leave Type' order by modified desc
select * from `tabVehicle Log` where `name` = 'VLOG00001' order by modified desc
select modified, docstatus from `tabcustomer` where name = '_Test Customer' for update
select * from `tabtodo` where `name` = '258546aad7' order by modified desc
select `company` from `tabemployee` where `name` = '_T-Employee-0001' order by modified desc
select max(char_length(`assigned_by`)) from `tabtodo`
select * from `tabParty Account` where `parenttype` = 'Customer' and `parent` = 'Party Status Test' and `parentfield` = 'accounts' order by idx asc
select name from `tabSalary Detail` where parent='Monthly Salary Structure Test for Salary Slip' and parenttype='Salary Structure' and parentfield='earnings' and name not in ('034a7da75e','8cc22132c5','6f74fa19d5','50467f0ee9')
select `name` from `tabItem Price` where `name` = 'ITEM-PRICE-00005' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabSales Invoice` where `return_against` = 'SINV-00013' order by modified desc
select share_name from tabDocShare where (user='Guest' ) and share_doctype='Website Settings' and `write`='1'
select `tabEmail Unsubscribe`.`name` from `tabEmail Unsubscribe` where `tabEmail Unsubscribe`.reference_doctype = 'Event' and `tabEmail Unsubscribe`.email = 'test@example.com' and ifnull(`tabEmail Unsubscribe`.name, '') != '5b6fee6b2a' and `tabEmail Unsubscribe`.reference_name = 'EV00016' order by `tabEmail Unsubscribe`.`modified` DESC
select distinct `share_doctype`, parenttype from `tabdocshare` where `share_doctype`='Role'
select name from `tabBOM Explosion Item` where parent='BOM-_Test FG Item 2-001' and parenttype='BOM' and parentfield='exploded_items' and name not in ('4b60b0190a','8dc9f0b3f7','c52dc866f3')
select distinct `against_voucher_type`, parenttype from `tabGL Entry` where `against_voucher_type`='Role'
select grade_code, threshold from `tabGrading Scale Interval` where `tabGrading Scale Interval`.parent = '_Test Grading Scale' order by `tabGrading Scale Interval`.`modified` DESC
select * from `tabLeave Application` where `name` = 'LAP/00003' order by modified desc
select * from `tabProject User` where `parenttype` = 'Project' and `parent` = '_Test Project 1' and `parentfield` = 'users' order by idx asc
select name from `tabrole` where desk_access='1'and name in ('System Manager', 'Academics User', 'Accounts Manager', 'Accounts User', 'Analytics', 'Auditor', 'Blogger', 'Expense Approver', 'Fleet Manager', 'HR Manager', 'HR User', 'Instructor', 'Item Manager', 'Knowledge Base Contributor', 'Knowledge Base Editor', 'Leave Approver', 'Maintenance Manager', 'Maintenance User', 'Manufacturing Manager', 'Manufacturing User', 'Newsletter Manager', 'Projects Manager', 'Projects User', 'Purchase Manager', 'Purchase Master Manager', 'Purchase User', 'Quality Manager', 'Report Manager', 'Sales Manager', 'Sales Master Manager', 'Sales User', 'Stock Manager', 'Stock User', 'Student', 'Support Team', 'System Manager', 'Website Manager') limit 1
select `tabrole`.`name` from `tabrole` where `tabrole`.disabled = 1.0 order by `tabrole`.`modified` desc
select modified, docstatus from `tabnote` where name = 'test note' for update
select `name`, `is_group`, `company` from `tabaccount` where `name` = 'Income - CFEC' order by modified desc
select `email` from `tabuser` where `name` = 'test2@example.com' order by modified desc
select * from `tabSales Taxes and Charges` where `parenttype` = 'Delivery Note' and `parent` = 'DN-00014' and `parentfield` = 'taxes' order by idx asc
select name from `tabterritory` where lft <='1'and rgt >='6'
select name from `tablead` where `tablead`.status = 'Open' order by `tablead`.`modified` DESC limit 0, 100
select name from `tabQuotation Item` where parent='QTN-00002' and parenttype='Quotation' and parentfield='items' and name not in ('QUOD/00003')
select `name` from `tabaccount` where `name` = 'Postal Expenses - _TC1' order by modified desc
select distinct reference_type from `tabSales Invoice Advance`
select `name`, `parent`, `parenttype`, `docstatus` from `tabSales Invoice Item` where `delivery_note` = 'DN-00022' order by modified desc
select `name` from `tabEmail Account` where `default_outgoing` ='1'and `enable_outgoing` ='1'order by modified desc
select name from `tabSalary Detail` where parent='Sal Slip/_T-Employee-0001/00001' and parenttype='Salary Slip' and parentfield='deductions' and name not in ('546db97b86')
select max(char_length(`background_style`)) from `tabuser`
select `name`, `parent`, `parenttype`, `docstatus` from `tabDelivery Note` where `return_against` = 'DN-00030' order by modified desc
select `supplier`, `company`, `currency` from `tabSupplier Quotation` where `name` = '_T-Supplier Quotation-00002' order by modified desc
select field, value from tabSingles where field in ('stock_frozen_upto_days') and doctype='Stock Settings'
select name from `tabProduction Order` where sales_order = 'SO-00027' and docstatus ='1'
select * from `tabitem` where `name` = '_Test PPT Item Sub B' order by modified desc
select sum(debit - credit) as amount, sum(debit_in_account_currency - credit_in_account_currency) as amount_in_account_currency from `tabGL Entry` where voucher_type='Period Closing Voucher' and voucher_no='PCE/001' and account ='_Test Account Cost for Goods Sold - _TC'
select * from `tabBOM Operation` where `parenttype` = 'BOM' and `parent` = 'BOM-_Test PPT Item Sub B-001' and `parentfield` = 'operations' order by idx asc
select * from `tabTax Rule` where (from_date is null or from_date = '' or from_date <= '2017-02-09') and (to_date is null or to_date = '' or to_date >= '2017-02-09') and ifnull(customer, '') in ('', '_Test Customer') and use_for_shopping_cart ='1'and ifnull(shipping_city, '') in ('', '_Test City') and ifnull(customer_group, '') in ('', '') and ifnull(tax_type, '') in ('', 'Sales') and ifnull(shipping_country, '') in ('', 'India') and ifnull(company, '') in ('', '_Test Company') and ifnull(shipping_state, '') in ('', 'Test State') and ifnull(shipping_county, '') in ('', '') and ifnull(supplier_type, '') in ('', '') and ifnull(billing_county, '') in ('', '') and ifnull(billing_country, '') in ('', 'India') and ifnull(billing_state, '') in ('', 'Test State') and ifnull(billing_city, '') in ('', '_Test City')
select * from `tabProduction Order Operation` where `parenttype` = 'Production Order' and `parent` = 'PRO-00001' and `parentfield` = 'operations' order by idx asc
select `is_default` from `tabAddress Template` where `name` = 'India' order by modified desc
select * from `tabStock Ledger Entry` where serial_no like '%ABCD00007%' and item_code='_Test Serialized Item With Series' and ifnull(is_cancelled, 'No')='No' order by posting_date desc, posting_time desc, name desc
select * from `tabDelivery Note Item` where `parenttype` = 'Delivery Note' and `parent` = 'DN-00007' and `parentfield` = 'items' order by idx asc
select * from `tabEmail Alert Recipient` where `parenttype` = 'Email Alert' and `parent` = '_Test Email Alert 2' and `parentfield` = 'recipients' order by idx asc
select `name` from `tabbom` where `is_default` ='1'and `docstatus` ='1'and `is_active` ='1'and `item` = '_Test FG Item' order by modified desc
select distinct `reference_doctype`, parenttype from `tabPayment Entry Reference` where `reference_doctype`='Role'
select * from `tabdocperm` where docstatus='0'and ifnull(permlevel,0)='0'and role in ('Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest')
select * from `tabItem Price` where `name` = 'ITEM-PRICE-00005' order by modified desc
select name from `tabStock Entry Detail` where parent='STE-00047' and parenttype='Stock Entry' and parentfield='items' and name not in ('dcf63a3e55','8393591a6f')
select `last_odometer` from `tabvehicle` where `name` = 'Z29BOJUG0R' order by modified desc
select `name` from `tabdoctype` where `name` = 'Lead' order by modified desc
select modified, docstatus from `tabSerial No` where name = 'SN005' for update
select parent, options from tabDocField where fieldtype='Table' and options in (select name from tabDocType where istable='1'and name in ('Portal Settings', 'Workflow Transition', 'Page Role', 'Stock Settings', 'Event Role', 'Authorization Rule', 'Email Alert Recipient', 'DocPerm', 'Portal Menu Item', 'Accounts Settings', 'Custom DocPerm', 'ToDo', 'Workflow Document State', 'UserRole'))
select name, from_time, to_time from `tabCourse Schedule` where `room`='RM0001' and schedule_date = '2017-02-09' and ( (from_time > '1:00:00' and from_time < '2:00:00') or (to_time > '1:00:00' and to_time < '2:00:00') or ('1:00:00' > from_time and '1:00:00' < to_time) or ('1:00:00' = from_time and '2:00:00' = to_time)) and name!='SH00001'
select `name` from `tabProduct Bundle` where `name` = 'Test Variant PRT' order by modified desc
select email from `tabEmail Unsubscribe` where `tabEmail Unsubscribe`.reference_doctype = 'Event' and `tabEmail Unsubscribe`.reference_name = 'EV00006' order by `tabEmail Unsubscribe`.`modified` DESC
select * from `tabSales Team` where `parenttype` = 'Delivery Note' and `parent` = 'DN-00001' and `parentfield` = 'sales_team' order by idx asc
select `credit_limit` from `tabCustomer Group` where `name` = '_Test Customer Group' order by modified desc
select * from `tabEmail Digest` where `name` = 'Default Weekly Digest - Wind Power LLC' order by modified desc
SELECT sum(debit_in_account_currency) - sum(credit_in_account_currency) FROM `tabGL Entry` gle WHERE gle.account = '_Test Cash - _TC'
select `first_name`, `email` from `tabuser` where `email` = 'test@example.com' order by modified desc
select name from `tabtimesheet` where `tabtimesheet`.status = 'Draft' order by `tabtimesheet`.docstatus asc, `tabtimesheet`.`modified` desc limit 0, 100
select name from `tabSales Taxes and Charges` where parent='_T-Quotation-00004' and parenttype='Quotation' and parentfield='taxes' and name not in ('INVTD000044','INVTD000045')
select `name`, `parent`, `parenttype`, `docstatus` from `tabPurchase Receipt` where `amended_from` = '_T-Purchase Receipt-00005' order by modified desc
select name from `tabStock Entry` where `tabStock Entry`.docstatus = 0.0 order by `tabStock Entry`.docstatus asc, `tabStock Entry`.`modified` DESC limit 0, 100
select name from `tabSalary Slip Timesheet` where parent='Sal Slip/_T-Employee-0001/00001' and parenttype='Salary Slip' and parentfield='timesheets' and name not in ('4a79ec1b35')
select * from `tabTax Rule` where (from_date is null or from_date = '' or from_date <= '2015-01-01') and (to_date is null or to_date = '' or to_date >= '2015-01-01') and ifnull(customer, '') in ('', '_Test Customer 2')
select `course` from `tabStudent Group` where `name` = 'TC-TP-2014-2015-2014-2015 (_Test Academic Term)' order by modified desc
select name from `tabfile` where lft <='2'and rgt >='3'
select * from `tabSalary Slip Timesheet` where `parenttype` = 'Salary Slip' and `parent` = 'Sal Slip/EMP-0002/00001' and `parentfield` = 'timesheets' order by idx asc
select name, module from tabDocType
select * from `tabEmail Account` where `name` = '_Test Email Account 1' order by modified desc
select name from `tabattendance` where employee = '_T-Employee-0002' and (attendance_date between '2013-01-01' and '2013-01-05') and status = 'Present' and docstatus ='1'
select `subject` from `tabevent` where `name` = 'EV00018' order by modified desc
select * from `tabterritory` where `name` = 'Rest Of The World' order by modified desc
select `supplier`, `company`, `currency` from `tabPurchase Order` where `name` = 'PO-00001' order by modified desc
select route, name, modified from `tabBlog Category` where `route`='test-route-000' limit 1
select * from `tabPOS Profile` where `name` = '6125d62f89' order by modified desc
select mdp.month, mdp.percentage_allocation from `tabMonthly Distribution Percentage` mdp, `tabMonthly Distribution` md where mdp.parent=md.name and md.fiscal_year='_Test Fiscal Year 2013'
select `name` from `tabuom` where `name` = 'Nos' order by modified desc
select `parent_item_group` from `tabItem Group` where `name` = '_Test Item Group B - 3' order by modified desc
select name from `tabissue` where `tabissue`.status = 'Open' order by `tabissue`.`modified` desc limit 0, 100
select `name` from `tabStudent Group` where `name` = 'TC-TP-2014-2015-2014-2015 (_Test Academic Term)' order by modified desc
select share_name from tabDocShare where (user='test@example.com' or everyone='1' and share_doctype='Event' and `share`='1'
select `end_of_life`, `disabled` from `tabitem` where `name` = '_Test FG Item 2' order by modified desc
select name from `tabwarehouse` where lft <='1'and rgt >='2'
select `round_off_account`, `round_off_cost_center` from `tabcompany` where `name` = '_Test Company' order by modified desc
select name from `tabSupplier Quotation` where `tabSupplier Quotation`.docstatus = 0.0 order by `tabSupplier Quotation`.docstatus asc, `tabSupplier Quotation`.`modified` DESC limit 0, 100
select `serial_no` from `tabStock Entry Detail` where `item_code` = '_Test Item 2' and `parent` = NULL order by modified desc
select * from `tabissue` where `name` = '_T-Issue-00001' order by modified desc
select * from `tabTax Rule` where (from_date is null or from_date = '' or from_date <= 'None') and (to_date is null or to_date = '' or to_date >= 'None') and ifnull(supplier, '') in ('', '_Test Supplier 1') and ifnull(customer_group, '') in ('', '') and ifnull(supplier_type, '') in ('', '_Test Supplier Type') and ifnull(company, '') in ('', '') and ifnull(tax_type, '') in ('', 'Purchase')
select `stock_value_difference` from `tabStock Ledger Entry` where `voucher_no` = 'STE-00009' and `voucher_type` = 'Stock Entry' order by modified desc
select max(char_length(`status`)) from `tabtodo`
select `name`, `parent`, `parenttype`, `docstatus` from `tabMaintenance Schedule Item` where `sales_order` = 'SO-00013' order by modified desc
select name from `tabtodo` where ifnull(`tabtodo`.creation, '') > '2017-01-30' and `tabtodo`.sender = 'test_sender@example.com' and `tabtodo`.description like '%%test%%' order by `tabtodo`.`modified` desc
select `name` from `tabblogger` where `name` = '_Test Blogger 1' order by modified desc
select max(char_length(`frappe_userid`)) from `tabuser`
select modified, docstatus from `tabdoctype` where name = 'ToDo' for update
select * from `tabEmail Unsubscribe` where `name` = '624d3b0343' order by modified desc
select * from `tabPurchase Receipt` where `name` = 'PREC-00015' order by modified desc
select modified, docstatus from `tabStock Ledger Entry` where name = 'SLE/00000170' for update
select * from `tabBlog Category` where `name` = '_Test Blog Category' order by modified desc
select `tabdoctype`.`name` from `tabdoctype` where `tabdoctype`.istable = 0.0 order by `tabdoctype`.`modified` DESC
select `first_name`, `email` from `tabuser` where `first_name` = '_Test' and `email` = 'test@example.com' order by modified desc
select name from `tabStock Entry Detail` where parent='STE-00034' and parenttype='Stock Entry' and parentfield='items' and name not in ('2eab941bc2','3d47f969d4','20da1cea39','faaf85ebff')
select `has_serial_no`, `is_stock_item`, `valuation_method`, `has_batch_no`, `is_fixed_asset` from `tabitem` where `name` = '_Test FG Item' order by modified desc
select modified, docstatus from `tabMode of Payment` where name = 'Cash' for update
select `title`, `route` from `tabBlog Category` where `name` = '_Test Blog Category 1' order by modified desc
select item_group from `tabWebsite Item Group` where parentfield='website_item_groups' and parenttype='Item' and parent='_Test PPT Item Sub C'
select modified, docstatus from `tabtodo` where name = 'a7cafe70e0' for update
select `name` from `tabPurchase Order` where `name` = 'PO-00001' order by modified desc
select *, timestamp(posting_date, posting_time) as "timestamp" from `tabStock Ledger Entry` where item_code = '_Test Item Home Desktop 200' and warehouse = '_Test Warehouse - _TC' and ifnull(is_cancelled, 'No')='No' and timestamp(posting_date, posting_time) < timestamp('2013-03-01', '00:00') order by timestamp(posting_date, posting_time) desc, name desc limit 1
select name from `tabEmail Queue` order by creation desc limit 0, 1
select `name` from `tabPurchase Invoice` where `name` = 'PINV-00005' order by modified desc
select * from `tabDelivery Note` where `name` = 'DN-00023' order by modified desc
select * from `tabBOM Operation` where `name` = '44752a0688' order by modified desc
select `status` from `tabtodo` where `name` = 'd915c02fde' order by modified desc
select 'Payment Entry' as reference_type, t1.name as reference_name, t1.remarks, t2.allocated_amount as amount, t2.name as reference_row, t2.reference_name as against_order, t1.posting_date from `tabPayment Entry` t1, `tabPayment Entry Reference` t2 where t1.name = t2.parent and t1.paid_from = 'Debtors - _TC' and t1.payment_type = 'Receive' and t1.party_type = 'Customer' and t1.party = '_Test Customer' and t1.docstatus ='1'and t2.reference_doctype = 'Sales Order' and t2.reference_name in ('SO-00004')
select `name` from `tabItem Price` where `price_list` = '_Test Price List' and `item_code` = '_Test Item for Auto Price List' order by modified desc
select sum(amount) from `tabPurchase Invoice Item` where pr_detail='04f74702ca' and docstatus='1'
select item_code, `qty`, `delivered_qty`, parenttype, parent from `tabSales Invoice Item` where `qty` < `delivered_qty` and name='b8c3e2bc27' and docstatus='1'
select sum(debit_in_account_currency) - sum(credit_in_account_currency) from `tabGL Entry` where against_voucher_type='Purchase Invoice' and against_voucher='PINV-00001' and account = 'Creditors - _TC' and party_type='Supplier' and party='_Test Supplier'
select name, route from `tabBlog Post` where ifnull(`tabBlog Post`.route, '') != '' and `tabBlog Post`.published = 1.0 order by `tabBlog Post`.`modified` desc limit 0, 1
select sum(gle.debit) - sum(gle.credit) from `tabGL Entry` gle where gle.account='_Test Account Cost for Goods Sold - _TC' and gle.fiscal_year='_Test Fiscal Year 2013' and gle.company='_Test Company' and gle.docstatus='1'and exists(select name from `tabCost Center` where lft>='10'and rgt<='11'and name=gle.cost_center)
select * from `tabGL Entry` where posting_date >= '2017-02-09' and voucher_no in ('PREC-00007')
select * from `tabdocshare` where `name` = 'c706681d76' order by modified desc
select name from `tabitem` where has_serial_no='1'and name in ('_Test Serialized Item')
select `tabuser`.`location`, `tabuser`.`user_type`, `tabuser`.`name`, `tabuser`.`modified`, `tabuser`.`docstatus` from `tabuser` left join `tabuserrole` on (`tabuserrole`.parent = `tabuser`.name) where `tabuserrole`.role = 'System Manager' order by `tabuser`.`modified` desc
select name from `tabPayment Entry` where `tabPayment Entry`.docstatus = 0.0 order by `tabPayment Entry`.docstatus asc, `tabPayment Entry`.`modified` DESC limit 0, 100
select modified, docstatus from `tabPurchase Receipt` where name = 'PREC-00011' for update
select 'Journal Entry' as reference_type, t1.name as reference_name, t1.remark as remarks, t2.credit_in_account_currency as amount, t2.name as reference_row, t2.reference_name as against_order from `tabJournal Entry` t1, `tabJournal Entry Account` t2 where t1.name = t2.parent and t2.account = 'Debtors - _TC' and t2.party_type = 'Customer' and t2.party = '_Test Customer' and t2.is_advance = 'Yes' and t1.docstatus ='1'and credit_in_account_currency > 0 and (ifnull(t2.reference_name, '')='' or (t2.reference_type = 'Sales Order' and ifnull(t2.reference_name, '') in ('_T-Quotation-00002'))) order by t1.posting_date
select distinct reference_doctype from `tabEmail Unsubscribe`
select `customer`, `company`, `project`, `currency` from `tabSales Order` where `name` = 'SO-00003' order by modified desc
select `credit_days_based_on`, `credit_days`, `supplier_type` from `tabsupplier` where `name` = '_Test Supplier USD' order by modified desc
select `parenttype`, `parent` from `tabrole` where `name` = 'System Manager' order by modified desc
select `lead`, `order_type`, `customer` from `tabquotation` where `name` = 'QTN-00002' order by modified desc
select name from `tabtask` as parent where 'TASK00013' in (select task from `tabTask Depends On` as child where parent.name = child.parent )
select `name` from `tabdocshare` where `name` = 'a762693219' order by modified desc
select max(char_length(`location`)) from `tabuser`
select name, is_group, parent_warehouse from `tabwarehouse` wh where wh.lft > 47 and wh.rgt < 52
select distinct sr.name from `tabShipping Rule Country` src, `tabShipping Rule` sr where src.country = 'India' and sr.disabled !='1'and sr.name = src.parent
select r.recipient, q.message, q.message_id from `tabEmail Queue` as q, `tabEmail Queue Recipient` as r where q.name = r.parent
select name from `tabquotation` where `tabquotation`.customer = '_Test Customer' and ifnull(`tabquotation`.docstatus, 0) = 0.0 and `tabquotation`.order_type = 'Shopping Cart' order by modified desc limit 0, 1
select `name`, `department`, `designation`, `branch` from `tabemployee` where `name` = 'EMP-0001' order by modified desc
select name from `tabuserrole` where parent='test2@example.com' and role='Leave Approver'
select `name` from `tabtranslation` where `name` = 'ac684348bb' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabExpense Claim` where `amended_from` = 'EXP00002' order by modified desc
select name from `tabholiday` where parent='Salary Slip Test Holiday List' and parenttype='Holiday List' and parentfield='holidays' and name not in ('50c90a4f3f','6a9d98be8a','37c5899908','e6229da952','f70cc0fda6','ff49461a9d','fa7c2e0015','a7375f3866','c7b4ad0976','5ab722a765','4c0d729cae','b433fb2701','dbbfafeff9','8aad95b76d','6090c8c93e','1f7e0bbc22','bca140aeda','8197e61d0e','fe9c836f36','2a4a03797f','a4b05da848','de3c55a46c','d96579b2c3','be10fa5031','6d4c10480b','80f920431e','6a8ee938c2','bc3c018087','a98cae97da','e7ca451bd4','3732a62e83','22d6a6d068','b8498d39e7','f2d4099f13','c03250791d','50ce1f3597','e2ee11ac33','1fe7a8e296','762f2853ee','e8e1857d7f','de91ac4a81','262f9906f5','7bbc55c975','5866cd132b','cbbe8500cf','a5ab320637','24e7e56d55','85901ad42e','48b90283c7','0f91a5018a','e0b61324f5','f62398f370','b517fcdaa7')
select `name`, `parent`, `parenttype`, `docstatus` from `tabProduction Order` where `sales_order` = 'SO-00026' order by modified desc
select `name` from `tabSalary Slip` where `employee_name` = 'test_employee@salary.com' order by modified desc
select sum(stock_value_difference) from `tabStock Ledger Entry` where voucher_type='Delivery Note' and voucher_no='DN-00005' and warehouse='_Test Warehouse - _TC'
select `price_list_rate` from `tabItem Price` where `price_list` = '_Test Price List' and `item_code` = '_Test Serialized Item With Series' order by modified desc
select modified, docstatus from `tabExpense Claim` where name = 'EXP00002' for update
select sum(total_sanctioned_amount) as total_sanctioned_amount from `tabExpense Claim` where project = '_Test Project 1' and approval_status='Approved' and docstatus ='1'
select name from `tabuserrole` where parent='test@example.com' and parenttype='User' and parentfield='user_roles' and name not in ('a496d47242','329a1b58b9','b1b0e80e75','7d80cfb0a0','43ffd8b84e')
select distinct reference_type from `tabQuality Inspection`
select `has_serial_no` from `tabitem` where `item_code` = '_Test Item' order by modified desc
select `name` from `tabSales Person` where `name` = '_Test Sales Person 1' order by modified desc
select `full_name` from `tabuser` where `name` = 'Administrator' order by modified desc
select * from `tabItem Variant Attribute` where `parenttype` = 'Item' and `parent` = '_Test PPT Item SC B' and `parentfield` = 'attributes' order by idx asc
select `enabled` from `tabPrice List` where `name` = '_Test Price List 2' order by modified desc
select actual_qty, projected_qty from `tabbin` where item_code = '_Test Item' and warehouse = '_Test Warehouse - _TC'
select name, item_name, docstatus, description, image, is_sub_contracted_item, stock_uom, default_bom, last_purchase_rate from `tabitem` where name='_Test PPT Item SC B'
select max(char_length(`role`)) from `tabtodo`
select name, full_name as fullname, user_image as image, gender, email, username from tabUser where enabled='1'and user_type!='Website User'
SELECT item_code, stock_value, name, warehouse FROM `tabStock Ledger Entry` sle WHERE posting_date <= '2017-02-09' and exists ( select name from `tabwarehouse` wh where wh.name = sle.warehouse and wh.lft >='0'and wh.rgt <='0' ORDER BY timestamp(posting_date, posting_time) DESC, name DESC
select `item` from `tabbom` where `name` = 'BOM-_Test PPT Item Sub A-001' order by modified desc
select distinct `invoice_type`, parenttype from `tabPayment Reconciliation Invoice` where `invoice_type`='Role'
select distinct link_doctype from `tabcommunication`
select `name` from `tabPayment Gateway Account` where `is_default` ='1'and `name` != '_Test Gateway - INR' order by modified desc
select * from `tabnote` where `name` = 'test note' order by modified desc
select name from `tabPOS Customer Group` where parent='6125d62f89' and parenttype='POS Profile' and parentfield='customer_groups' and name not in ('dae1310fc9')
select name from `tabitem` item where is_stock_item='1'and has_variants='0'and disabled='0'and (end_of_life is null or end_of_life='0000-00-00' or end_of_life > '2017-02-09') and (exists (select name from `tabItem Reorder` ir where ir.parent=item.name) or (variant_of is not null and variant_of != '' and exists (select name from `tabItem Reorder` ir where ir.parent=item.variant_of)) )
select `stock_value_difference` from `tabStock Ledger Entry` where `voucher_no` = '_T-Purchase Receipt-00003' and `voucher_type` = 'Purchase Receipt' and `voucher_detail_no` = 'ff6bdc40b8' order by modified desc
select `name` from `tabEmail Digest` where `name` = 'Default Weekly Digest - Wind Power LLC' order by modified desc
select is_lwp from `tabLeave Type` where name = '_Test Leave Type'
select `parent` from `tabSalary Structure Employee` where `employee` = '_T-Employee-0001' order by modified desc
select `name` from `tabSerial No` where `name` = 'ABCD00002' order by modified desc
select `name` from `tablanguage` where `language_name` = 'english' order by modified desc
select * from `tabSales Person` where `name` = 'Sales Team' order by modified desc
select distinct prevdoc_doctype from `tabMaintenance Visit Purpose`
select `name` from `tabSales Person` where `employee` = '_T-Employee-0003' order by modified desc
select modified, docstatus from `tabPurchase Invoice` where name = 'PINV-00001' for update
select * from `tabTop Bar Item` where parent='Website Settings' and parentfield= 'top_bar_items' order by idx asc
select max(char_length(`ref_type`)) from `tabevent`
select sum(t1.debit) - sum(t1.credit) as balance from `tabGL Entry` t1, `tabaccount` t2 where t1.account = t2.name and t2.report_type = 'Profit and Loss' and t2.docstatus < 2 and t2.company = '_Test Company' and t1.posting_date between '2017-01-01' and '2017-02-09'
select 'Payment Entry' as reference_type, t1.name as reference_name, t1.remarks, t2.allocated_amount as amount, t2.name as reference_row, t2.reference_name as against_order, t1.posting_date from `tabPayment Entry` t1, `tabPayment Entry Reference` t2 where t1.name = t2.parent and t1.paid_to = 'Creditors - _TC' and t1.payment_type = 'Pay' and t1.party_type = 'Supplier' and t1.party = '_Test Supplier' and t1.docstatus ='1'and t2.reference_doctype = 'Purchase Order' and t2.reference_name in ('PO-00006')
select `name` from `tabcontact` where `email_id` = 'test_max_users@example.com' order by modified desc
select name from `tabItem Group` where lft <='1'and rgt >='10'
select `name` from `tabcommunication` where `name` = '9f45c70d23' order by modified desc
select * from `tabStock Ledger Entry` where `name` = 'SLE/00000048' order by modified desc
select *, timestamp(posting_date, posting_time) as "timestamp" from `tabStock Ledger Entry` where item_code = '_Test Item Home Desktop 100' and warehouse = 'Test Warehouse for Renaming 3 - _TC' and ifnull(is_cancelled, 'No')='No' and timestamp(posting_date, posting_time) > timestamp('1900-01-01', '00:00') order by timestamp(posting_date, posting_time) asc, name asc for update
select sum(ifnull(file_size,0)) from tabFile where folder='Home'
select `name` from `tabquotation` where `status` != 'Lost' and `docstatus` ='1'and `lead` = '_T-Lead-00001' order by modified desc
select name from `tabcustomer` where name='_Test Customer 1 Renamed' for update
select name from `tabuserrole` where parent='test1@example.com' and parenttype='User' and parentfield='user_roles' and name not in ('714c7cb0fa','428fc73a24')
select `name` from `tabCost Center` where `company` = 'Wind Power LLC' and `is_group` ='0'order by modified desc
select * from `tabAcademic Year` where `name` = '2014-2015' order by modified desc
select `freeze_account` from `tabaccount` where `name` = 'Capital Equipments - _TC' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabSales Invoice Timesheet` where `time_sheet` = 'TS-00001' order by modified desc
select max(char_length(`fb_username`)) from `tabuser`
select defkey, defvalue from `tabdefaultvalue` where parent = '__global' order by creation
select `name` from `tabPeriod Closing Voucher` where `name` = 'PCE/001' order by modified desc
select * from `tabItem Tax` where `parenttype` = 'Item' and `parent` = '_Test PPT Item Raw C' and `parentfield` = 'taxes' order by idx asc
select `quantity` from `tabbom` where `name` = 'BOM-_Test FG Item-001' order by modified desc
select `status` from `tabSales Order` where `name` = 'SO-00025' order by modified desc
select lft, rgt from `tabSales Person` where name='Sales Team'
select pr.name, pr.posting_date, pr.posting_time, pr.conversion_rate, pr_item.conversion_factor, pr_item.base_price_list_rate, pr_item.discount_percentage, pr_item.base_rate from `tabPurchase Receipt` pr, `tabPurchase Receipt Item` pr_item where pr.docstatus ='1'and pr_item.item_code = '_Test Item' and pr.name != 'PREC-00002' and pr.name = pr_item.parent order by pr.posting_date desc, pr.posting_time desc, pr.name desc limit 1
select * from `tabPurchase Order Item Supplied` where `parenttype` = 'Purchase Order' and `parent` = 'PO-00001' and `parentfield` = 'supplied_items' order by idx asc
select * from `tabuser` where `email` = 'test@example.com' order by modified desc
select count(*) from `tabtodo` where `tabtodo`.status = 'Open' and (`tabtodo`.owner = 'Administrator' or `tabtodo`.assigned_by = 'Administrator')
select name from `tabaccount` where lft <='325'and rgt >='330'
select name from `tabPurchase Taxes and Charges` where parent='_T-Purchase Receipt-00005' and parenttype='Purchase Receipt' and parentfield='taxes' and name not in ('9e749ad710','69bb25c5fa','5591096788')
select name, route from `tabBlog Post` where `tabBlog Post`.published = 0.0 order by `tabBlog Post`.`modified` desc limit 0, 1
select modified, docstatus from `tabtask` where name = 'TASK00011' for update
select name from `tabSales Invoice Item` where parent='SINV-00013' and parenttype='Sales Invoice' and parentfield='items' and name not in ('0e89fd8c03')
select * from `tabtask` where `name` = 'TASK00010' order by modified desc
select * from `tabTarget Detail` where `parenttype` = 'Territory' and `parent` = 'All Territories' and `parentfield` = 'targets' order by idx asc
select * from `tabWeb Page` where `name` = 'test-web-page-4' order by modified desc
select account_currency from `tabGL Entry` where docstatus='1'and company='_Test Company' and party_type='Supplier' and party='_Test Supplier 1' limit 1
select sum(debit_in_account_currency) - sum(credit_in_account_currency) from `tabGL Entry` where against_voucher_type='Asset' and against_voucher='Macbook Pro 1' and account = '_Test Accumulated Depreciations - _TC'
select `tabEmail Queue`.`name` from `tabEmail Queue` order by `tabEmail Queue`.`modified` desc
select `name` from `tabGL Entry` where `voucher_no` = 'JV-00016' and `voucher_type` = 'Journal Entry' order by modified desc
select modified, docstatus from `tabcommunication` where name = 'd5c37abf81' for update
select max(char_length(`fb_userid`)) from `tabuser`
select `name` from `tabworkflow` where `document_type` = 'Event' and `is_active` ='1'order by modified desc
select max(char_length(`test_ref_doc`)) from `tabevent`
select name from `tabaccount` order by RAND() limit 0,1
select *, timestamp(posting_date, posting_time) as "timestamp" from `tabStock Ledger Entry` where item_code = '_Test Serialized Item' and warehouse = '_Test Warehouse - _TC' and ifnull(is_cancelled, 'No')='No' and timestamp(posting_date, posting_time) <= timestamp('2017-02-09', '12:23:59.448687') order by timestamp(posting_date, posting_time) desc, name desc limit 1
select name from `tabDaily Work Summary Settings Company` where parent='Daily Work Summary Settings' and parenttype='Daily Work Summary Settings' and parentfield='companies' and name not in ('de97df60ee')
select name from tabDocType where istable='1'
select * from `tabSerial No` where `name` = 'ABCD' order by modified desc
select `report_type`, `root_type` from `tabaccount` where `name` = 'Tax Assets - WP' order by modified desc
select `status` from `tabMaterial Request` where `name` = '_T-Material Request-00005' order by modified desc
select * from `tabMode of Payment Account` where `parenttype` = 'Mode of Payment' and `parent` = 'Cash' and `parentfield` = 'accounts' order by idx asc
select field_name from `tabKanban Board` where `tabKanban Board`.reference_doctype = 'User' order by `tabKanban Board`.`modified` DESC
select distinct voucher_type from `tabStock Ledger Entry`
select name from `tabSalary Structure Employee` where parent='Monthly Salary Structure Test for Salary Slip' and parenttype='Salary Structure' and parentfield='employees' and name not in ('500b837327','9c7c22b312')
select projected_qty from `tabbin` where item_code = '_Test PPT Item SC A' and warehouse = '_Test Warehouse - _TC'
select `name` from `tabitem` where `item_code` = '_Test Variant Item-S' order by modified desc
select parent from `tabJournal Entry Account` where reference_type='Journal Entry' and reference_name='JV-00024' and docstatus < 2
select `name` from `tabworkstation` where `name` = '_Test Workstation 1' order by modified desc
select distinct `payment_document`, parenttype from `tabBank Reconciliation Detail` where `payment_document`='Role'
select `name` from `tabstudent` where `student_email_id` = 'test@erpnext.com' order by modified desc
select distinct user.name from tabUserRole user_role, tabUser user where user_role.role='System Manager' and user.docstatus<2 and user.enabled='1'and user_role.parent = user.name and user_role.parent not in ('Administrator', 'test_max_users@example.com') limit 1
select distinct `reference_type`, parenttype from `tabPayment Reconciliation Payment` where `reference_type`='Role'
select t1.account, sum(t1.debit) - sum(t1.credit) as balance, sum(t1.debit_in_account_currency) - sum(t1.credit_in_account_currency) as balance_in_account_currency from `tabGL Entry` t1, `tabaccount` t2 where t1.account = t2.name and t2.root_type = 'Expense' and t2.docstatus < 2 and t2.company = '_Test Company' and t1.posting_date between '2017-01-01' and '2017-02-09' group by t1.account having sum(t1.debit) > sum(t1.credit) limit 1
select name from `tabrole` where desk_access='1'and name in ('Administrator', 'System Manager', 'Accounts Manager', 'Accounts User', 'All', 'Blogger', 'Guest', 'Knowledge Base Contributor', 'Knowledge Base Editor', 'Maintenance Manager', 'Maintenance User', 'Newsletter Manager', 'Purchase Manager', 'Purchase Master Manager', 'Purchase User', 'Report Manager', 'Sales Manager', 'Sales Master Manager', 'Sales User', 'Website Manager', 'Stock User', 'Auditor', 'Stock Manager', 'Manufacturing Manager', 'Supplier', 'Projects User', 'Projects Manager', 'HR User', 'Manufacturing User', 'Item Manager', 'HR Manager', 'Fleet Manager', 'Leave Approver', 'Expense Approver', 'Quality Manager', 'Support Team', 'Instructor', 'Customer', 'Student', 'Analytics', '_Test Role 3', '_Test Role 2', '_Test Role', 'Stock User', '_Test Role 4') limit 1
select name, user_id from `tabemployee` where `tabemployee`.status = 'Active' and `tabemployee`.company = '_Test Company' order by `tabemployee`.`modified` DESC
select modified, docstatus from `tabBlog Category` where name = '_Test Blog Category 1' for update
select `name` from `tabEmail Queue` where `reference_name` = 'EV00006' order by modified desc
select distinct * from `tabevent` where `tabevent`.owner = 'Administrator' order by `tabevent`.`modified` desc limit 0, 20
select `owner` from `tabevent` where `name` = 'EV00006' order by modified desc
select `name` from `tabSupplier Quotation Item` where `name` = 'b2008c66cd' order by modified desc
select ifnull(max(rgt),0)+1 from `tabCost Center` where ifnull(`parent_cost_center`,'') =''
select `owner` from `tabtodo` where `name` = '2969f8e4ec' order by modified desc
select `lead_name`, `company_name` from `tablead` where `name` = '_T-Lead-00001' order by modified desc
select `tabquotation`.`name` from `tabquotation` where `tabquotation`.lead = '_T-Lead-00001' order by `tabquotation`.docstatus asc, `tabquotation`.`modified` DESC
select name, warehouse from tabAccount where account_type = 'Stock' and (warehouse is not null and warehouse != '') and is_group='0'and name in ('_Test Account Stock In Hand - _TC')
select * FROM `tabPrint Format` WHERE doc_type='Workflow' AND docstatus<2 and disabled='0'
select `name`, `module` from `tabdoctype` order by `tabdoctype`.`modified` DESC
select `name` from `tabaccount` where `company` = 'Wind Power LLC' and `is_group` ='1'and `account_name` = 'Duties and Taxes' order by modified desc
select `name` from `tabProduction Order` where `name` = 'PRO-00008' order by modified desc
select source_name, target_name from `tabtranslation` where `tabtranslation`.language = 'es-MX' order by `tabtranslation`.`modified` DESC
select `name`, `salary_component_abbr` from `tabSalary Component` where `name` = '_Test Allowance' order by modified desc
select * from `tabcompany` where `name` = 'Wind Power LLC' order by modified desc
select modified, docstatus from `tabLeave Allocation` where name = 'LAL/00007' for update
select `actual_qty` from `tabStock Ledger Entry` where `warehouse` = '_Test Rejected Warehouse - _TC' and `voucher_no` = 'PREC-00009' and `voucher_type` = 'Purchase Receipt' order by modified desc
select `account` from `tabParty Account` where `parenttype` = 'Customer' and `company` = 'Wind Power LLC' and `parent` = 'Party Status Test - 1' order by modified desc
select name, event, method from `tabEmail Alert` where `tabEmail Alert`.document_type = 'Opportunity Item' and `tabEmail Alert`.enabled = 1.0 order by `tabEmail Alert`.`modified` DESC
select parent from tabDocField where (fieldtype='Table' and options='Role')
select `name` from `tabsupplier` where `name` = '_Test Supplier 1' order by modified desc
select name from `tabBudget Account` where parent='_Test Project/_Test Fiscal Year 2013/003' and parenttype='Budget' and parentfield='accounts' and name not in ('401e36b4e1')
select name from `tabCost Center` where company='India - Chart of Accounts'
select `name` from `tabbom` where `is_default` ='1'and `item` = '_Test Variant Item' and `docstatus` ='1'order by modified desc
select `outstanding_amount` from `tabSales Invoice` where `name` = 'PINV-00006' order by modified desc
select `supplier_type` from `tabsupplier` where `name` = '_Test Supplier USD' order by modified desc
SELECT sum(debit_in_account_currency) - sum(credit_in_account_currency) FROM `tabGL Entry` gle WHERE posting_date <= '2017-02-09 12:27:02.311040' and posting_date >= '2017-01-01' and voucher_type != 'Period Closing Voucher' and gle.account = '_Test Account Cost for Goods Sold - _TC'
select name from `tabitem` item where variant_of='_Test Numeric Template Item' and exists ( select name from `tabItem Variant Attribute` iv_attribute where iv_attribute.parent=item.name and ((iv_attribute.attribute='Test Item Length' and iv_attribute.attribute_value='1.1') or (iv_attribute.attribute='Test Size' and iv_attribute.attribute_value='Large')) and parent != '_Test Numeric Variant-L-1.1' )
select name from `tabbom` where item='_Test PPT Item SC B'
select * from `tabSales Person` where lft='6'or rgt='7'
select `employee_name` from `tabemployee` where `name` = 'EMP-0003' order by modified desc
select * from `tabPurchase Taxes and Charges` where `parenttype` = 'Purchase Receipt' and `parent` = 'PREC-00007' and `parentfield` = 'taxes' order by idx asc
select `supplier` from `tabSerial No` where `name` = 'ABCD00011' order by modified desc
select modified, docstatus from `tabemployee` where name = '_T-Employee-0002' for update
select `status` from `tabasset` where `name` = 'Macbook Pro 1' order by modified desc
select `rate` from `tabPurchase Order Item` where `name` = 'cac0a55433' order by modified desc
select `account_currency` from `tabaccount` where `name` = 'Commission on Sales - WP' order by modified desc
select `symbol` from `tabcurrency` where `name` = 'INR' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabSalary Slip Timesheet` where `time_sheet` = 'TS-00001' order by modified desc
select name from `tabGL Entry` where voucher_type='Journal Entry' and voucher_no = 'JV-00002' and account='_Test Write Off - _TC' and cost_center='_Test Cost Center - _TC' and debit ='0'and credit = '.01'
select `default_income_account` from `tabItem Group` where `name` = '_Test Item Group' order by modified desc
select `company`, `currency` from `tabquotation` where `name` = 'QTN-00002' order by modified desc
select name from `tabPurchase Receipt` where `supplier` = '_Test Supplier' and `docstatus` = '1' and `company` = '_Test Company'
select * from `tabfile` where lft='9'or rgt='10'
select `name` from `tabbin` where `warehouse` = '_Test Warehouse - _TC' and `item_code` = '_Test PPT Item Sub B' order by modified desc
select name from `tabProduct Bundle` where new_item_code='_Test Mix Product Bundle' and docstatus !='2'
select name from `tabFiscal Year` where ( ('2021-01-01' between year_start_date and year_end_date) or ('2021-12-31' between year_start_date and year_end_date) or (year_start_date between '2021-01-01' and '2021-12-31') or (year_end_date between '2021-01-01' and '2021-12-31') ) and name!='_Test Fiscal Year 2021'
select `docstatus` from `tabPurchase Receipt` where `name` = 'PREC-00008' order by modified desc
select max(ifnull(last_active, '2000-01-01 00:00:00')) from `tabuser` where user_type = 'System User' and name not in ('Guest', 'Administrator')
select distinct `voucher_type`, parenttype from `tabGL Entry` where `voucher_type`='Role'
select * from `tabStock Ledger Entry` where voucher_type='Stock Reconciliation' and voucher_no='SR/00003'
select * from `tabCost Center` where `name` = '_Test Cost Center - _TC' order by modified desc
select `name` from `tabcurrency` where `name` = 'EUR' order by modified desc
select i.numeric_values, v.abbr from `tabItem Attribute` i left join `tabItem Attribute Value` v on (i.name=v.parent) where i.name='Test Item Length' and v.attribute_value='1.5'
select `name` from `tabuser` where `name` = 'test_import_userrole@example.com' order by modified desc
select name from `tabLeave Allocation` where employee='_T-Employee-0002' and leave_type='_Test Leave Type' and docstatus='1'and '2013-01-01' between from_date and to_date
select `date_of_joining` from `tabemployee` where `name` = 'EMP-0003' order by modified desc
select `incoming_rate`, `stock_value_difference` from `tabStock Ledger Entry` where `voucher_no` = 'DN-00018' and `voucher_type` = 'Delivery Note' order by modified desc
select issingle from tabDocType where name='User'
select ordered_qty, reserved_qty from `tabbin` where `tabbin`.warehouse = '_Test Warehouse - _TC' and `tabbin`.item_code = '_Test Item for Drop Shipping' order by `tabbin`.`modified` desc
select `project`, `item_code`, `uom` from `tabPurchase Receipt Item` where `name` = 'dca5ce203a' order by modified desc
select `tabAuto Email Report`.`name` from `tabAuto Email Report` where ifnull(`tabAuto Email Report`.frequency, '') in ('Daily', 'Weekly') and `tabAuto Email Report`.enabled = 1.0 order by `tabAuto Email Report`.`modified` DESC
select TIMEDIFF('2017-02-09 12:26:35.290843', '2017-02-09 12:26:35.290843')
select name from tabAccount where company='COA from Existing Company'
select max(char_length(`name`)) from `tabuser`
select * from `tabCustom Field` where `name` = 'User-test_custom_field' order by modified desc
select distinct `voucher_type`, parenttype from `tabStock Ledger Entry` where `voucher_type`='Role'
select i.numeric_values, v.abbr from `tabItem Attribute` i left join `tabItem Attribute Value` v on (i.name=v.parent) where i.name='Test Size' and v.attribute_value='Small'
select name from `tabStock Ledger Entry` where voucher_type='Stock Entry' and voucher_no='STE-00009'
select lft, rgt from `tabaccount` where name='Current Assets - _TC2'
select modified, docstatus from `tabActivity Type` where name = '_Test Activity Type' for update
select name from `tabPurchase Invoice Item` where parent='PINV-00001' and parenttype='Purchase Invoice' and parentfield='items' and name not in ('1295c79e1f')
select `modified` from `tabSales Order` where `name` = 'SO-00022' order by modified desc
select max(char_length(`parent`)) from `tabtodo`
select `name` from `tabCustom Field` where `name` = 'User-test_custom_field' order by modified desc
select name from `tabuserrole` where parent='test_import_userrole@example.com' and parenttype='User' and parentfield='user_roles' and name not in ('49ea7133f9')
select name from tabAccount where company='Wind Power LLC' and docstatus<2 limit 1
select * from `tabBOM Item` where `name` = 'a33c2aae0c' order by modified desc
select name from `tabrole` where desk_access='1'and name in ('_Test Role', 'System Manager', 'Employee', 'Blogger', '_Test Role 3', '_Test Role 2', 'Website Manager', 'Sales User', 'Sales Manager', 'Stock User') limit 1
select * from `tabTax Rule` where (from_date is null or from_date = '' or from_date <= 'None') and (to_date is null or to_date = '' or to_date >= 'None') and ifnull(customer, '') in ('', '_Test Customer') and ifnull(shipping_city, '') in ('', '_Test City') and ifnull(customer_group, '') in ('', '_Test Customer Group') and ifnull(tax_type, '') in ('', 'Sales') and ifnull(shipping_country, '') in ('', 'India') and ifnull(company, '') in ('', '') and ifnull(shipping_state, '') in ('', 'Test State') and ifnull(shipping_county, '') in ('', '') and ifnull(supplier_type, '') in ('', '') and ifnull(billing_county, '') in ('', '') and ifnull(billing_country, '') in ('', 'India') and ifnull(billing_state, '') in ('', 'Test State') and ifnull(billing_city, '') in ('', '_Test City')
select * from `tabAddress Template` where `name` = 'India' order by modified desc
select max(char_length(`github_userid`)) from `tabuser`
select `name` from `tabSalary Slip` where `employee` = 'EMP-0004' order by modified desc
SELECT * FROM `tabCustom Field` WHERE dt = 'Some DocType' AND docstatus < 2
select distinct `reference_type`, parenttype from `tabtodo` where `reference_type`='Role'
select `status` from `tabissue` where `name` = '_T-Issue-00001' order by modified desc
select * from `tabquotation` where `name` = 'QTN-00003' order by modified desc
select `name` from `tabuser` where `enabled` ='1'and `name` = 'sukh@yyy.com' and `user_type` = 'System User' order by modified desc
select `account_currency`, `company` from `tabaccount` where `name` = '_Test Account Cost for Goods Sold - _TC' order by modified desc
select name, from_range, to_range, increment from `tabItem Attribute` where `tabItem Attribute`.numeric_values = 1.0 order by `tabItem Attribute`.`modified` DESC
select * from `tabPurchase Order Item` where `parenttype` = 'Purchase Order' and `parent` = 'PO-00008' and `parentfield` = 'items' order by idx asc
select * from `tabfile` where `name` = 'ac145fc50e' order by modified desc
select distinct party_type from `tabPayment Entry`
select `tabWeb Form`.`doc_type`, `tabWeb Form`.`name`, `tabWeb Form`.`modified`, `tabWeb Form`.`docstatus` from `tabWeb Form` left join `tabPortal Menu Item` on (`tabPortal Menu Item`.parent = `tabWeb Form`.name) where `tabPortal Menu Item`.role = 'System Manager' order by `tabWeb Form`.`modified` DESC
select advance_paid from `tabSales Order` where name='SO-00033'
select `name` from `tabuser` where `name` like 'Admin%' order by modified desc
select `projected_qty` from `tabbin` where `warehouse` = '_Test Warehouse - _TC' and `item_code` = '_Test Variant Item-S' order by modified desc
select `default_payable_account` from `tabcompany` where `name` = '_Test Company 1' order by modified desc
select `issingle` from `tabdoctype` where `name` = 'Quality Inspection' order by modified desc
select indented_qty from `tabbin` where item_code= '_Test FG Item' and warehouse= '_Test Warehouse - _TC'
select lft, rgt from `tabwarehouse` where name='_Test Warehouse Group - _TC'
select distinct `customer_or_item`, parenttype from `tabAuthorization Rule` where `customer_or_item`='Role'
select salary_component_abbr from `tabSalary Component` where name!='_Test Basic Salary' and salary_component_abbr='_BS'
select name, subject, description, starts_on, ends_on, owner, all_day, event_type, repeat_this_event, repeat_on,repeat_till, monday, tuesday, wednesday, thursday, friday, saturday, sunday from tabEvent where (( (date(starts_on) between date('2017-02-09') and date('2017-02-09')) or (date(ends_on) between date('2017-02-09') and date('2017-02-09')) or (date(starts_on) <= date('2017-02-09') and date(ends_on) >= date('2017-02-09')) ) or ( date(starts_on) <= date('2017-02-09') and repeat_this_event='1'and ifnull(repeat_till, '3000-01-01') > date('2017-02-09') )) and ifnull(send_reminder,0)='1'and (event_type='Public' or owner='test@example.com' or exists(select name from `tabdocshare` where tabDocShare.share_doctype='Event' and `tabdocshare`.share_name=tabEvent.name and tabDocShare.user='test@example.com') or exists(select * from `tabEvent Role` where `tabEvent Role`.parent=tabEvent.name and `tabEvent Role`.role in ('System Manager', '_Test Role', 'Employee', 'All', 'Guest'))) order by starts_on
select distinct `timeline_doctype`, parenttype from `tabcommunication` where `timeline_doctype`='Role'
select `default_supplier` from `tabitem` where `name` = '_Test Item Home Desktop 100' order by modified desc
select name from `tabPurchase Receipt` where ifnull(`tabPurchase Receipt`.status, '') not in ('Completed', 'Closed') and ifnull(`tabPurchase Receipt`.docstatus, 0) < 2.0 and `tabPurchase Receipt`.supplier = '_Test Supplier' order by `tabPurchase Receipt`.docstatus asc, `tabPurchase Receipt`.`modified` DESC limit 0, 1
select `name` from `tabcustomer` where `lead_name` = '_T-Lead-00001' order by modified desc
select `hour_rate` from `tabworkstation` where `name` = '_Test Workstation 1' order by modified desc
select distinct share_doctype from `tabdocshare` where `user`='Administrator' and `read`='1'
select `password` from `__auth` where doctype='Email Account' and name='Test Email Account Password' and fieldname='password'
select name, reference_doctype, reference_name from `tabcommunication` where `tabcommunication`.sender = 'test_sender@example.com' order by `tabcommunication`.`modified` desc
select `name` from `tabSalary Slip` where `name` = 'Sal Slip/_T-Employee-0001/00001' order by modified desc
select `docstatus` from `tabSupplier Quotation` where `name` = '_T-Supplier Quotation-00002' order by modified desc
select email from `tabEmail Unsubscribe` where `tabEmail Unsubscribe`.global_unsubscribe = 1.0 order by `tabEmail Unsubscribe`.`modified` DESC
select max(char_length(`subject`)) from `tabevent`
select `name` from `tabAcademic Year` where `name` = '2014-2015' order by modified desc
select `purchase_rate` from `tabSerial No` where `name` = 'SN001' order by modified desc
select distinct voucher_type from `tabGL Entry`
select email from `tabEmail Group Member` where `tabEmail Group Member`.unsubscribed = 0.0 and `tabEmail Group Member`.email_group = '_Test Email Group' order by `tabEmail Group Member`.`modified` DESC
select name from `tabSalary Structure` where docstatus !='2'and is_active = 'Yes' and company = 'Wind Power LLC' and ifnull(salary_slip_based_on_timesheet,0) ='0'and payroll_frequency = 'Monthly'
select pr_detail, qty from `tabPurchase Invoice Item` where purchase_receipt=NULL and docstatus='1'
select `reserved_qty` from `tabbin` where `warehouse` = '_Test Warehouse - _TC' and `item_code` = '_Test Item' order by modified desc
select *, timestamp(posting_date, posting_time) as "timestamp" from `tabStock Ledger Entry` where item_code = '_Test Item Home Desktop 100' and warehouse = '_Test Warehouse 1 - _TC' and ifnull(is_cancelled, 'No')='No' and timestamp(posting_date, posting_time) <= timestamp('2013-03-01', '01:00') order by timestamp(posting_date, posting_time) desc, name desc limit 1
select `email_id`, `always_use_account_email_id_as_sender`, `name`, `send_unsubscribe_message` from `tabEmail Account` where `default_outgoing` ='1'and `enable_outgoing` ='1'order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabStock Entry` where `purchase_order` = 'PO-00002' order by modified desc
select content, sender_full_name, creation, sender from `tabcommunication` where communication_type='Comment' and reference_doctype='Blog Post' and reference_name='-test-blog-post-1' and (comment_type is null or comment_type in ('Comment', 'Communication')) and modified >= DATE_SUB(NOW(),INTERVAL 1 YEAR) order by creation
select modified, docstatus from `tabPeriod Closing Voucher` where name = 'PCE/001' for update
select modified, docstatus from `tabblogger` where name = '_Test Blogger 1' for update
select name, total_cost/quantity as unit_cost from `tabbom` where is_active ='1'and name = 'BOM-_Test PPT Item Sub C-001'
select b.project, ba.budget_amount, b.monthly_distribution, b.action_if_annual_budget_exceeded, b.action_if_accumulated_monthly_budget_exceeded from `tabbudget` b, `tabBudget Account` ba where b.name=ba.parent and b.fiscal_year='_Test Fiscal Year 2013' and ba.account='_Test Account Cost for Goods Sold - _TC' and b.docstatus='1'and b.project='_Test Project'
select `default_bom` from `tabitem` where `name` = '_Test FG Item 2' order by modified desc
select * from `tabJournal Entry Account` where `parenttype` = 'Journal Entry' and `parent` = 'JV-00014' and `parentfield` = 'accounts' order by idx asc
select name from `tabProduction Order Item` where parent='PRO-00009' and parenttype='Production Order' and parentfield='required_items' and name not in ('2ee8f266a0','26b3c66662')
select `name` from `tabActivity Type` where `name` = '_Test Activity Type 1' order by modified desc
select sum(simultaneous_sessions) from `tabuser` where enabled='1'and user_type='System User' and name not in ('Guest', 'Administrator')
select `tabpage`.`page_name`, `tabpage`.`title`, `tabpage`.`icon`, `tabpage`.`name`, `tabpage`.`modified`, `tabpage`.`docstatus` from `tabpage` left join `tabPage Role` on (`tabPage Role`.parent = `tabpage`.name) where `tabPage Role`.role = 'System Manager' order by `tabpage`.`modified` desc
select name from `tabaccount` where `company` = '_Test Company' and `name` = '_Test Account Cost for Goods Sold - _TC'
select `depreciation_method`, `total_number_of_depreciations`, `frequency_of_depreciation` from `tabAsset Category` where `name` = 'Computers' order by modified desc
select name from `tabrole` where desk_access='1'and name in ('_Test Role', 'System Manager', 'Employee', 'Blogger', '_Test Role 3', '_Test Role 2', 'Website Manager') limit 1
select `landed_cost_voucher_amount` from `tabPurchase Invoice Item` where `parent` = 'PINV-00001' order by modified desc
select name from `tabcompany` limit 1
select name from `tabJournal Entry Account` where account = '_Test Receivable - _TC' and docstatus ='1'and parent = '_T-Journal Entry-00004'
select `incoming_rate` from `tabStock Ledger Entry` where `voucher_no` = 'PREC-00006' and `voucher_type` = 'Purchase Receipt' and `item_code` = '_Test Item' order by modified desc
select `name` from `tabStock Reconciliation` where `name` = 'SR/00015' order by modified desc
select distinct delivery_document_type from `tabSerial No`
select max(char_length(`reference_type`)) from `tabtodo`
select modified, docstatus from `tabSupplier Quotation` where name = '_T-Supplier Quotation-00002' for update
select name from `tabsupplier` where `tabsupplier`.status = 'Open' order by `tabsupplier`.`modified` desc limit 0, 100
select `name` from `tabModule Def` where `name` = 'core' order by modified desc
select `name` from `tabemployee` where `employee_name` = 'test_employee@salary.com' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabStock Reconciliation` where `amended_from` = 'SR/00004' order by modified desc
select `tabcompany`.`name` from `tabcompany` order by `tabcompany`.`modified` desc
select `lft`, `rgt` from `tabItem Group` where `name` = '_Test Item Group C' order by modified desc
select valuation_rate from `tabStock Ledger Entry` where item_code = '_Test Item' and valuation_rate > 0 order by posting_date desc, posting_time desc, name desc limit 1
select name from `tabDelivery Note` where `customer` = '_Test Customer' and `docstatus` = '1' and `company` = '_Test Company'
select `name` from `tabdocshare` where `share_doctype` = 'Event' and `everyone` ='1'and `share_name` = 'EV00033' order by modified desc
select name from `tabopportunity` where `tabopportunity`.status = 'Open' and `tabopportunity`.customer = '_Test Lead' order by `tabopportunity`.`modified` DESC limit 0, 1
select `name` from `tabquotation` where `name` = 'QTN-00003' order by modified desc
select name, subject, description, starts_on, ends_on, owner, all_day, event_type, repeat_this_event, repeat_on,repeat_till, monday, tuesday, wednesday, thursday, friday, saturday, sunday from tabEvent where (( (date(starts_on) between date('2017-02-09') and date('2017-02-09')) or (date(ends_on) between date('2017-02-09') and date('2017-02-09')) or (date(starts_on) <= date('2017-02-09') and date(ends_on) >= date('2017-02-09')) ) or ( date(starts_on) <= date('2017-02-09') and repeat_this_event='1'and ifnull(repeat_till, '3000-01-01') > date('2017-02-09') )) and ifnull(send_reminder,0)='1'and (event_type='Public' or owner='test@erpnext.com' or exists(select name from `tabdocshare` where tabDocShare.share_doctype='Event' and `tabdocshare`.share_name=tabEvent.name and tabDocShare.user='test@erpnext.com') or exists(select * from `tabEvent Role` where `tabEvent Role`.parent=tabEvent.name and `tabEvent Role`.role in ('Expense Approver', 'Support Team', 'Manufacturing User', 'Website Manager', 'Purchase Manager', 'Sales User', 'Sales Manager', 'Quality Manager', 'Newsletter Manager', 'Maintenance User', 'System Manager', 'Fleet Manager', 'Maintenance Manager', 'Stock Manager', 'Purchase Master Manager', 'Knowledge Base Contributor', 'Report Manager', 'Student', 'Item Manager', 'Accounts Manager', 'Projects Manager', 'Projects User', 'Accounts User', 'Knowledge Base Editor', 'Sales Master Manager', 'Manufacturing Manager', 'Stock User', 'HR Manager', 'Leave Approver', 'HR User', 'Analytics', 'Auditor', 'Purchase User', 'Blogger', 'Instructor', 'All', 'Guest'))) order by starts_on
select max(char_length(`owner`)) from `tabtodo`
select `default_holiday_list` from `tabcompany` where `name` = '_Test Company' order by modified desc
select route, name, modified from `tabWeb Page` where published='1'and `route`='blog/-test-blog-category-1/-test-blog-post-1' limit 1
select `date_of_joining`, `relieving_date` from `tabemployee` where `name` = 'EMP-0003' order by modified desc
select `name` from `tabBlog Post` where `name` = '-test-blog-post-1' order by modified desc
select `bank_name`, `bank_ac_no` from `tabemployee` where `name` = 'EMP-0006' order by modified desc
select 'Payment Entry' as reference_type, name as reference_name, remarks, unallocated_amount as amount from `tabPayment Entry` where paid_to = 'Creditors - _TC' and party_type = 'Supplier' and party = '_Test Supplier' and payment_type = 'Pay' and docstatus ='1'and unallocated_amount > 0
select `docstatus` from `tabProduction Order` where `name` = 'PRO-00010' order by modified desc
select distinct reference_doctype from `tabPayment Request`
select name from `tabuser` where name >= 't' order by modified desc
select name from `tabPurchase Invoice` where `tabPurchase Invoice`.docstatus < 2.0 and `tabPurchase Invoice`.outstanding_amount > 0.0 order by `tabPurchase Invoice`.docstatus asc, `tabPurchase Invoice`.`modified` DESC limit 0, 100
select ifnull(max(rgt),0)+1 from `tabaccount` where ifnull(`parent_account`,'') =''
select count(*) from `tabDesktop Icon` where standard='1'
select `abbr` from `tabcompany` where `name` = 'Wind Power LLC' order by modified desc
select name from `tabEmail Digest` where enabled='1'and docstatus<2
select name from `tabPeriod Closing Voucher` where posting_date > '2017-02-09' and fiscal_year = '_Test Fiscal Year 2017' and docstatus ='1'
select * from `tabLanded Cost Taxes and Charges` where `parenttype` = 'Stock Entry' and `parent` = '_T-Stock Entry-00003' and `parentfield` = 'additional_costs' order by idx asc
select item_code, qty, serial_no, batch_no from `tabPacked Item` where parent = 'DN-00019'
select * from `tabSales Taxes and Charges Template` where `name` = '_Test Tax 1' order by modified desc
select count(*) from `tabItem Group` where ifnull(parent_item_group, '')=''
select * from `tabSales Order` where `name` = 'SO-00035' order by modified desc
select name from `tabFiscal Year` where year_end_date = date_add(current_date, interval 3 day)
select name from `tabBOM Explosion Item` where parent='BOM-_Test PPT Item Master-001' and parenttype='BOM' and parentfield='exploded_items' and name not in ('b8e043c427','a50344f3f6','cd7733d6d7','9999c04e23')
select max(char_length(`sender`)) from `tabtodo`
select name from `tabSupplier Quotation` where `tabSupplier Quotation`.supplier = '_Test Supplier' and ifnull(`tabSupplier Quotation`.docstatus, 0) = 0.0 order by `tabSupplier Quotation`.docstatus asc, `tabSupplier Quotation`.`modified` DESC limit 0, 1
select name from `tabattendance` where employee = '_T-Employee-0001' and attendance_date = '2014-02-01' and name != '_T-Attendance-00001' and docstatus ='1'
select * from `tabaccount` where `name` = 'Stock Received But Not Billed - _TC' order by modified desc
select distinct `receipt_document_type`, parenttype from `tabLanded Cost Purchase Receipt` where `receipt_document_type`='Role'
select options from `tabdocfield` where fieldtype='Table' and parent='DocType'
select name, parent, defkey, defvalue from tabDefaultValue where parent not in ('__default', '__global') and substr(defkey,1,1)!='_' and parenttype='User Permission' and `defkey`='Blog Post'and `defvalue`='-test-blog-post'and `parent`='test2@example.com' order by parent, defkey
select `is_fixed_asset`, `is_stock_item`, `disabled` from `tabitem` where `name` = 'Macbook Pro' order by modified desc
select * from `tabdocperm` where `tabdocperm`.parent = 'Sales Order' order by `tabdocperm`.`modified` desc
select name from `tabBOM Item` where parent='BOM-_Test PPT Item Sub C-001' and parenttype='BOM' and parentfield='items' and name not in ('905a63e0f2','87f5d21ce5')
select `prefered_email` from `tabemployee` where `name` = 'EMP-0002' order by modified desc
select fy.name, fy.year_start_date, fy.year_end_date from `tabFiscal Year` fy where disabled ='0'order by fy.year_start_date desc
select name from tabEmployee limit 1
select * from `tabtranslation` where `name` = 'ac684348bb' order by modified desc
select * from `tabItem Reorder` where `parenttype` = 'Item' and `parent` = 'Test Variant PRT' and `parentfield` = 'reorder_levels' order by idx asc
select `tabcommunication`.`name` from `tabcommunication` where `tabcommunication`.reference_doctype = 'Event' and `tabcommunication`.reference_name = 'EV00017' order by `tabcommunication`.`modified` desc
select `lft`, `rgt`, `parent_item_group` from `tabItem Group` where `name` = '_Test Item Group C - 2' order by modified desc
select * from `tabSupplier Quotation` where `name` = 'SQTN-00003' order by modified desc
select `owner` from `tabquotation` where `name` = 'QTN-00006' order by modified desc
select `tabKanban Board`.`name` from `tabKanban Board` where `tabKanban Board`.reference_doctype = 'DocType' order by `tabKanban Board`.`modified` DESC
select `currency` from `tabquotation` where `name` = 'QTN-00005' order by modified desc
select ts.name as name, tsd.from_time as from_time, tsd.to_time as to_time from `tabTimesheet Detail` tsd, `tabtimesheet` ts where tsd.`workstation`='_Test Workstation 1' and tsd.parent = ts.name and ( ('2017-02-09 12:25:52.554795' > tsd.from_time and '2017-02-09 12:25:52.554795' < tsd.to_time) or ('2017-02-09 13:25:52.554795' > tsd.from_time and '2017-02-09 13:25:52.554795' < tsd.to_time) or ('2017-02-09 12:25:52.554795' <= tsd.from_time and '2017-02-09 13:25:52.554795' >= tsd.to_time)) and tsd.name!='No Name' and ts.name!='No Name' and ts.docstatus < 2
select `name`, `parent`, `parenttype`, `docstatus` from `tabtimesheet` where `amended_from` = 'TS-00001' order by modified desc
select `name` from `tabDelivery Note` where `name` = 'DN-00012' order by modified desc
select name, subject, description, starts_on, ends_on, owner, all_day, event_type, repeat_this_event, repeat_on,repeat_till, monday, tuesday, wednesday, thursday, friday, saturday, sunday from tabEvent where (( (date(starts_on) between date('2017-02-09') and date('2017-02-09')) or (date(ends_on) between date('2017-02-09') and date('2017-02-09')) or (date(starts_on) <= date('2017-02-09') and date(ends_on) >= date('2017-02-09')) ) or ( date(starts_on) <= date('2017-02-09') and repeat_this_event='1'and ifnull(repeat_till, '3000-01-01') > date('2017-02-09') )) and ifnull(send_reminder,0)='1'and (event_type='Public' or owner='testdelete@example.com' or exists(select name from `tabdocshare` where tabDocShare.share_doctype='Event' and `tabdocshare`.share_name=tabEvent.name and tabDocShare.user='testdelete@example.com') or exists(select * from `tabEvent Role` where `tabEvent Role`.parent=tabEvent.name and `tabEvent Role`.role in ('_Test Role 2', 'System Manager', 'All', 'Guest'))) order by starts_on
select `lft`, `rgt` from `tabCustomer Group` where `name` = '_Test Customer Group' order by modified desc
select `name` from `tabPrice List` where `enabled` ='1'and `name` = 'Standard Buying' and `buying` ='1'order by modified desc
select item_code, `qty`, `ordered_qty`, parenttype, parent from `tabMaterial Request Item` where `qty` < `ordered_qty` and name='84bc15d769' and docstatus='1'
select `name` from `tabStock Ledger Entry` where `warehouse` = '_Test Warehouse Group-C1 - _TC' order by modified desc
select `owner` from `tabPurchase Invoice` where `name` = 'PINV-00005' order by modified desc
select lft, rgt from `tabfile` where name='Home/Attachments'
select name from `tabBOM Explosion Item` where parent='BOM-_Test PPT Item SC A-001' and parenttype='BOM' and parentfield='exploded_items' and name not in ('d827d5eca3')
select `stock_value_difference` from `tabStock Ledger Entry` where `warehouse` = '_Test Warehouse - _TC' and `voucher_no` = 'DN-00005' and `voucher_type` = 'Delivery Note' and `item_code` = '_Test Item' order by modified desc
select count(name) from tabTask where project='_Test Project' and status in ('Closed', 'Cancelled')
select `docstatus` from `tabDelivery Note` where `name` = 'DN-00006' order by modified desc
select * from `tabItem Quality Inspection Parameter` where `parenttype` = 'Item' and `parent` = '_Test PPT Item Raw A' and `parentfield` = 'quality_parameters' order by idx asc
select name from `tabItem Group` where name='_Test Item Group C' for update
select name from `tabtask` where `tabtask`.status = 'Overdue' order by `tabtask`.`modified` desc limit 0, 100
select distinct sle.voucher_type, sle.voucher_no from `tabStock Ledger Entry` sle where timestamp(sle.posting_date, sle.posting_time) >= timestamp('2017-02-09', '12:24:58.257046') and item_code in ('_Test Serialized Item', '_Test Item') and warehouse in ('_Test Warehouse - _TC', '_Test Warehouse 1 - _TC') order by timestamp(sle.posting_date, sle.posting_time) asc, name asc
select `title` from `tabBlog Category` where `name` = 'test-category' order by modified desc
select * from `tabProduct Bundle` where `name` = '_Test Service Product Bundle' order by modified desc
select name from `tabEmployee Leave Approver` where parent='_T-Employee-0001' and parenttype='Employee' and parentfield='leave_approvers' and name not in ('5e98e0dc43')
select 'Journal Entry' as reference_type, t1.name as reference_name, t1.remark as remarks, t2.debit_in_account_currency as amount, t2.name as reference_row, t2.reference_name as against_order from `tabJournal Entry` t1, `tabJournal Entry Account` t2 where t1.name = t2.parent and t2.account = 'Creditors - _TC' and t2.party_type = 'Supplier' and t2.party = '_Test Supplier' and t2.is_advance = 'Yes' and t1.docstatus ='1'and debit_in_account_currency > 0 and (ifnull(t2.reference_name, '')='' or (t2.reference_type = 'Purchase Order' and ifnull(t2.reference_name, '') in ('PO-00003'))) order by t1.posting_date
select name from tabRole
select user from `tabPOS Profile`
select b.cost_center, ba.budget_amount, b.monthly_distribution, b.action_if_annual_budget_exceeded, b.action_if_accumulated_monthly_budget_exceeded from `tabbudget` b, `tabBudget Account` ba where b.name=ba.parent and b.fiscal_year='_Test Fiscal Year 2017' and ba.account='Cost of Goods Sold - _TC' and b.docstatus='1'and exists(select name from `tabCost Center` where lft<='8'and rgt>='9'and name=b.cost_center)
select sum(costing_amount) as costing_amount, sum(billing_amount) as billing_amount, min(from_time) as start_date, max(to_time) as end_date, sum(hours) as time from `tabTimesheet Detail` where project = '_Test Project' and docstatus ='1'
select `first_name`, `last_name`, `user_image`, `name` from `tabuser` where `name` = 'Guest' order by modified desc
select dt as parent, fieldname, (select issingle from tabDocType dt where dt.name = df.dt) as issingle from `tabCustom Field` df where df.options='Asset' and df.fieldtype='Link'
select name from `tabPOS Item Group` where parent='6125d62f89' and parenttype='POS Profile' and parentfield='item_groups' and name not in ('954887165a')
select modified, docstatus from `tabSalary Structure` where name = 'Monthly Salary Structure Test for Salary Slip' for update
select `email_id` from `tabEmail Account` where `default_incoming` ='1'and `enable_incoming` ='1'order by modified desc
select dn_item.name, dn_item.amount, dn_item.si_detail, dn_item.parent from `tabDelivery Note Item` dn_item, `tabDelivery Note` dn where dn.name=dn_item.parent and dn_item.so_detail='4d7f31188e' and dn.docstatus='1'and dn.is_return ='0'order by dn.posting_date asc, dn.posting_time asc, dn.name asc
select * from `tabTax Rule` where (from_date is null or from_date = '' or from_date <= '2017-02-09') and (to_date is null or to_date = '' or to_date >= '2017-02-09') and ifnull(customer, '') in ('', 'test_cart_user') and use_for_shopping_cart ='1'and ifnull(supplier_type, '') in ('', '') and ifnull(company, '') in ('', '_Test Company') and ifnull(customer_group, '') in ('', '_Test Customer Group') and ifnull(tax_type, '') in ('', 'Sales')
select name from `tabSales Order Item` where parent='SO-00012' and parenttype='Sales Order' and parentfield='items' and name not in ('d6cc1c85b7')
select `name`, `parent`, `parenttype`, `docstatus` from `tabStock Entry` where `credit_note` = 'JV-00024' order by modified desc
select name, min_order_qty from tabItem where name in ('_Test FG Item')
select `include_holiday` from `tabLeave Type` where `name` = '_Test Leave Type' order by modified desc
select `name` from `tabSalary Structure` where `name` = 'Fortnightly Salary Structure Test for Salary Slip' order by modified desc
select distinct `reference_type`, parenttype from `tabSales Invoice Advance` where `reference_type`='Role'
select name from `tabLanded Cost Purchase Receipt` where parent='LCV00001' and parenttype='Landed Cost Voucher' and parentfield='purchase_receipts' and name not in ('9c23793825')
select `name` from `tabwarehouse` where `name` = 'Stores - CFEC' order by modified desc
select ifnull(max(rgt),0)+1 from `tabItem Group` where ifnull(`parent_item_group`,'') =''
select purpose, sum(fg_completed_qty) from `tabStock Entry` where production_order='PRO-00002' and docstatus='1'group by purpose
select `currency` from `tabPurchase Receipt` where `name` = '_T-Purchase Receipt-00006' order by modified desc
select max(char_length(`last_name`)) from `tabuser`
select `name`, `parent`, `parenttype`, `docstatus` from `tabJournal Entry` where `amended_from` = 'JV-00024' order by modified desc
select `customer`, `company`, `project`, `currency` from `tabSales Invoice` where `name` = 'SINV-00005' order by modified desc
select `report_type` from `tabaccount` where `name` = '_Test Warehouse - _TC' order by modified desc
select name from `tabNote Seen By` where parent='test note' and parenttype='Note' and parentfield='seen_by' and name not in ('fb96c0cfe9')
select * from `tabEmployee External Work History` where `parenttype` = 'Employee' and `parent` = 'EMP-0005' and `parentfield` = 'external_work_history' order by idx asc
select item_code, qty, serial_no, batch_no, parenttype,rejected_qty, received_qty from `tabPurchase Receipt Item` where parent = 'PREC-00006'
select distinct reference_type from `tabPayment Reconciliation Payment`
select `name` from `tabaccount` where `name` = '_Test Warehouse - _TC' and `root_type` = 'Expense' order by modified desc
select `script` from `tabCustom Script` where `dt` = 'Authorization Rule' and `script_type` = 'Client' order by modified desc
select `planned_qty` from `tabbin` where `warehouse` = '_Test Warehouse 1 - _TC' and `item_code` = '_Test FG Item' order by modified desc
select `owner` from `tabSales Order` where `name` = 'SO-00003' order by modified desc
select `abbr`, `name` from `tabcompany` where `name` = 'India - Chart of Accounts' order by modified desc
select `tabCustom DocPerm`.`role`, `tabCustom DocPerm`.`permlevel`, `tabCustom DocPerm`.`read`, `tabCustom DocPerm`.`write`, `tabCustom DocPerm`.`create`, `tabCustom DocPerm`.`delete`, `tabCustom DocPerm`.`submit`, `tabCustom DocPerm`.`cancel`, `tabCustom DocPerm`.`name`, `tabCustom DocPerm`.`modified`, `tabCustom DocPerm`.`docstatus` from `tabCustom DocPerm` where `tabCustom DocPerm`.role = 'System Manager' order by `tabCustom DocPerm`.`modified` ASC
select `holiday_list` from `tabworkstation` where `name` = '_Test Workstation 1' order by modified desc
select `name` from `tablanguage` where `name` = 'es' order by modified desc
select * from `tabEmployee Leave Approver` where `parenttype` = 'Employee' and `parent` = 'EMP-0003' and `parentfield` = 'leave_approvers' order by idx asc
select name from `tabrole` where desk_access='1'and name in ('_Test Role', 'System Manager', 'Employee') limit 1
select avg(purchase_rate) from `tabSerial No` where name in ('ABCD00011')
select distinct `prevdoc_doctype`, parenttype from `tabQuotation Item` where `prevdoc_doctype`='Role'
select `disabled` from `tabSales Taxes and Charges Template` where `name` = '_Test Sales Taxes and Charges Template 1' order by modified desc
select name from `tabrole` where desk_access='1'and name in ('_Test Role', 'System Manager', 'Employee', 'Blogger', '_Test Role 3', '_Test Role 2') limit 1
select * from `tabProduction Order` where `name` = 'PRO-00010' order by modified desc
select allow_user from `tabLeave Block List Allow` where parent='_Test Leave Block List'
select `owner` from `tabStock Entry` where `name` = 'STE-00031' order by modified desc
select name from `tabUOM Conversion Detail` where parent='_Test PPT Item SC B' and parenttype='Item' and parentfield='uoms' and name not in ('2638b50338')
select `course_abbreviation` from `tabcourse` where `name` = '_Test Course 2' order by modified desc
select `name` from `tabSupplier Quotation` where `name` = 'SQTN-00003' order by modified desc
select `name` from `tabtimesheet` where `name` = 'TS-00015' order by modified desc
select * from `tabItem Attribute Value` where `parenttype` = 'Item Attribute' and `parent` = 'Test Size' and `parentfield` = 'item_attribute_values' order by idx asc
select name, docstatus, parent, parenttype, idx from `tabJournal Entry Account` where reference_type='Asset' and reference_name='Macbook Pro 1'
select distinct parent from tabDocField where fieldname='barcode'
select name, docstatus from `tabStock Ledger Entry` where voucher_type='Sales Invoice' and voucher_no='SINV-00016'
select data from __ListSettings where user='Administrator' and doctype='DocType'
select distinct `reference_doctype`, parenttype from `tabPayment Request` where `reference_doctype`='Role'
select * from `tabPurchase Invoice Advance` where `parenttype` = 'Purchase Invoice' and `parent` = 'PINV-00006' and `parentfield` = 'advances' order by idx asc
select name from `tabSales Invoice` where `tabSales Invoice`.docstatus < 2.0 and `tabSales Invoice`.outstanding_amount > 0.0 order by `tabSales Invoice`.docstatus asc, `tabSales Invoice`.`modified` DESC limit 0, 100
select name from `tabSales Order Item` where parent='SO-00017' and parenttype='Sales Order' and parentfield='items' and name not in ('965bec8b58','e3125feed3')
select `name` from `tabfile` where `name` = '1bee6b5190' order by modified desc
select item_code, `amount`, `billed_amt`, parenttype, parent from `tabPurchase Order Item` where `amount` < `billed_amt` and name='20bb7cad4e' and docstatus='1'
select name from `tabevent` where DATE(`starts_on`) = ADDDATE(DATE('2017-02-09'), INTERVAL 2 DAY)
select `name` from `tabEmployment Type` where `name` = 'Intern' order by modified desc
select modified, docstatus from `tabPayment Request` where name = 'PR00002' for update
select `projected_qty`, `actual_qty` from `tabbin` where `warehouse` = '_Test Warehouse - _TC' and `item_code` = '_Test Item Home Desktop 200' order by modified desc
select `default_expense_account` from `tabItem Group` where `name` = '_Test Item Group Desktops' order by modified desc
select `email_id` from `tabEmail Account` where `email_id` = 'sukh@yyy.com' and `enable_incoming` ='1'order by modified desc
select `name` from `tabfile` where `name` = '44524e8707' and `is_folder` ='0'order by modified desc
select name from `tabbudget` where `tabbudget`.name like '_Test Cost Center - _TC/_Test Fiscal Year 2013%%' order by `tabbudget`.docstatus asc, `tabbudget`.`modified` DESC
select * from `tabProperty Setter` where doc_type='Landed Cost Item'
select * from `tabBOM Explosion Item` where `parenttype` = 'BOM' and `parent` = 'BOM-_Test FG Item 2-001' and `parentfield` = 'exploded_items' order by idx asc
select * from `tabPurchase Invoice` where `name` = 'PINV-00005' order by modified desc
select `fieldtype` from `tabdocfield` where `fieldname` = 'hidden' and `parent` = 'DocField' order by modified desc
select `current` from `tabseries` where name='_T-Production Order-' for update
select sum(qty) from `tabPurchase Order Item` poi, `tabPurchase Order` po where poi.sales_order_item = '965bec8b58' and poi.item_code = '_Test Item for Drop Shipping' and poi.parent = po.name and po.docstatus ='1'and po.status = 'Delivered'
select `content`, `footer` from `tabLetter Head` where `is_default` ='1'order by modified desc
select name from `tabSalary Detail` where parent='Monthly Salary Structure Test for Salary Slip' and parenttype='Salary Structure' and parentfield='deductions' and name not in ('36c7767330','a29839149c','e2034ef4b9')
select modified, docstatus from `tabtimesheet` where name = 'TS-00001' for update
select `holiday_list`, `company` from `tabemployee` where `name` = '_T-Employee-0001' order by modified desc
select * from `tabActivity Type` where `name` = '_Test Activity Type' order by modified desc
select name from `tabtimesheet` where `tabtimesheet`.production_order = 'PRO-00003' order by `tabtimesheet`.docstatus asc, `tabtimesheet`.`modified` desc
select name from `tabCost Center` where `company` = '_Test Company' and `name` = '_Test Cost Center - _TC'
select `_comments` from `tabtodo` where `name` = '2969f8e4ec' order by modified desc
select name, docstatus from `tabSerial No` where delivery_document_type='Delivery Note' and delivery_document_no='DN-00016'
select count(*) from `tabCustomer Group` where ifnull(parent_customer_group, '')=''
SELECT name FROM `tabItem Group` WHERE `parent_item_group`='' or `parent_item_group` IS NULL ORDER BY name ASC
select name, priority from `tabTax Rule` where ifnull(shipping_city, '') = '' and ifnull(company, '') = '_Test Company' and ifnull(shipping_state, '') = '' and ifnull(shipping_county, '') = '' and ifnull(supplier_type, '') = '' and ifnull(billing_country, '') = '' and ifnull(customer, '') = '_Test Customer' and ifnull(billing_city, '') = '' and ifnull(tax_type, '') = 'Sales' and ifnull(shipping_country, '') = '' and ifnull(supplier, '') = '' and ifnull(billing_county, '') = '' and ifnull(customer_group, '') = '' and ifnull(billing_state, '') = '' and to_date > '2015-01-01' and name != 'TR0005'
select * from `tabworkstation` where `name` = '_Test Workstation 1' order by modified desc
select `account_type`, `report_type`, `account_currency` from `tabaccount` where `name` = '_Test Receivable - _TC' order by modified desc
select `lft`, `rgt`, `is_group` from `tabwarehouse` where `name` = 'Stores - _TC1' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabTimesheet Detail` where `sales_invoice` = 'SINV-00013' order by modified desc
select * from `tabItem Customer Detail` where `parenttype` = 'Item' and `parent` = '_Test Item Warehouse Group Wise Reorder' and `parentfield` = 'customer_items' order by idx asc
select `name` from `tabRequest for Quotation` where `name` = 'RFQ-00002' order by modified desc
select t1.name from `tabemployee` t1, `tabSalary Structure Employee` t2 where t1.docstatus!='2'and t1.name = t2.employee and t1.company = 'Wind Power LLC' and ifnull(t1.date_of_joining, '0000-00-00') <= '2016-11-30' and ifnull(t1.relieving_date, '2199-12-31') >= '2016-11-01' and t2.parent IN (('Monthly Salary Structure Test for Salary Slip'))
select t1.item_code, sum(t1.qty) from `tabStock Entry Detail` t1, `tabStock Entry` t2 where t1.parent = t2.name and t2.production_order = 'PRO-00002' and t2.docstatus ='1'and t2.purpose = 'Material Transfer for Manufacture' group by t1.item_code
select `credit_days_based_on`, `credit_days` from `tabSupplier Type` where `name` = '_Test Supplier Type' order by modified desc
select `route` from `tabItem Group` where `name` = '_Test Item Group' order by modified desc
select name from `tabdepartment` order by `tabdepartment`.`modified` desc
select `name` from `tabItem Attribute` where `name` = 'Test Item Length' order by modified desc
select `asset_category` from `tabitem` where `name` = 'Macbook Pro' order by modified desc
select * from `tabdocperm` where `parenttype` = 'DocType' and `parent` = 'Shipping Rule Country' and `parentfield` = 'permissions' order by idx asc
select `description` from `tabevent` where `name` = 'EV00008' order by modified desc
select `docstatus` from `tabbom` where `name` = 'BOM-_Test PPT Item SC B-001' order by modified desc
select modified, docstatus from `tabBlog Post` where name = '-test-blog-post-1' for update
select name from `tabcommunication` where `tabcommunication`.status = 'Open' and `tabcommunication`.communication_type = 'Communication' order by `tabcommunication`.`modified` desc limit 0, 100
select `name`, `parent`, `parenttype`, `docstatus` from `tabStock Entry` where `amended_from` = 'STE-00049' order by modified desc
select distinct bom_item.parent from `tabBOM Item` bom_item where bom_item.bom_no = 'BOM-_Test FG Item 2-001' and bom_item.docstatus ='1'and exists (select * from `tabbom` where name = bom_item.parent and docstatus ='1'and is_active ='1'
select * from `tabCustom Script` order by `tabCustom Script`.`modified` desc
select name, customer_name, customer_group, territory from tabCustomer where disabled ='0'and customer_group in ('_Test Customer Group')
select `name` from `tabCustom DocPerm` where `parent` = 'Blog Post' order by modified desc
select modified, docstatus from `tabuser` where name = 'Weekly_test_employee@salary.com' for update
select modified, docstatus from `tabStock Entry` where name = 'STE-00023' for update
select name from tabUser where name not in ('Administrator', 'Guest', 'test@erpnext.com') and user_type = 'System User' and enabled='1'order by creation desc
select `currency` from `tabPurchase Invoice` where `name` = 'PINV-00001' order by modified desc
select lft, rgt from `tabItem Group` where name='_Test Item Group C'
select `root_type` from `tabaccount` where `name` = '_Test Receivable - _TC' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabStock Entry` where `production_order` = 'PRO-00003' order by modified desc
select * from `tabevent` where `name` = 'EV00022' order by modified desc
select sum(amount) from `tabSales Invoice Item` where dn_detail='f9b3131c89' and docstatus='1'and parent != 'SINV-00006'
select name from `tabPurchase Invoice Item` pi where docstatus ='1'and purchase_receipt='_T-Purchase Receipt-00004' and exists(select name from `tabGL Entry` where voucher_type='Purchase Invoice' and voucher_no=pi.parent and account='Expenses Included In Valuation - _TC')
select name from `tabfile` where content_hash='07a78a83e5d48037cad1e0fc0f1ef654' and is_private='1'
select * from `tabPacked Item` where `parenttype` = 'Sales Order' and `parent` = 'SO-00005' and `parentfield` = 'packed_items' order by idx asc
select `name` from `tabSales Order Item` where `docstatus` ='1'and `prevdoc_docname` = '_T-Quotation-00004' order by modified desc
select `total_expense_claim` from `tabtask` where `name` = 'TASK00014' order by modified desc
select `name` from `tabcampaign` where `name` = '_Test Campaign' order by modified desc
select `name` from `tabDesktop Icon` where `name` = '0e1e02aa56' order by modified desc
select `owner` from `tabLeave Application` where `name` = 'LAP/00003' order by modified desc
select count(*) from `tabAuto Email Report` where user='Administrator' and enabled='1'
select * from `tabbudget` where `name` = '_Test Cost Center - _TC/_Test Fiscal Year 2013/003' order by modified desc
select name from `tabrole` where desk_access='1'and name in ('Employee', 'Blogger', 'Sales User', 'Stock User') limit 1
select `customer_group` from `tabcustomer` where `name` = 'Party Status Test' order by modified desc
select count(*) from `tabcommunication` where communication_type='Comment' and modified >= DATE_SUB(NOW(),INTERVAL 1 YEAR) and comment_type='Like' and owner is not null and owner!='Administrator' and reference_owner='Administrator' and seen='0'
select * from `tabrole` where `name` = '_Test Role 3' order by modified desc
select * from `tabBudget Account` where `parenttype` = 'Budget' and `parent` = '_Test Company - _TC/_Test Fiscal Year 2013/001' and `parentfield` = 'accounts' order by idx asc
select name from `tabproject` where name = '_Test Project' and (customer = '_Test Customer' or customer is null or customer = '')
select name, route from `tabItem Group` where lft <='19'and rgt >='20'and show_in_website='1'order by lft asc
select * from `tabProject Task` where `parenttype` = 'Project' and `parent` = '_Test Project 1' and `parentfield` = 'tasks' order by idx asc
select `serial_no` from `tabStock Entry Detail` where `item_code` = '_Test Item' and `parent` = 'STE-00033' order by modified desc
select max(char_length(`parent`)) from `tabuser`
select * from `tabaccount` where lft='927'or rgt='928'
select `date_format` from `tabcountry` where `name` = 'United States' order by modified desc
select name, owner from `tabBlog Post` where ((((ifnull(`tabBlog Post`.`blogger`, '')='' or `tabBlog Post`.`blogger` in ('_Test Blogger 1'))))) order by `tabBlog Post`.`modified` desc
select `doc_type` from `tabPrint Format` where `name` = '_Test Print Format 1' order by modified desc
select `name` from `tabItem Price` where `currency` = 'INR' and `price_list` = '_Test Price List' and `item_code` = '_Test Item for Auto Price List' order by modified desc
select `owner` from `tabJournal Entry` where `name` = 'JV-00017' order by modified desc
select `name` from `tabroom` where `name` = 'RM0002' order by modified desc
select distinct timeline_doctype from `tabcommunication`
select route, name, modified from `tabWeb Form` where published='1'and `route`='manage-events' limit 1
select `name` from `tabPayment Gateway Account` where `currency` = 'USD' and `payment_gateway` = '_Test Gateway' order by modified desc
select * from `tabEmail Queue Recipient` where `parenttype` = 'Email Queue' and `parent` = '59b2fa6000' and `parentfield` = 'recipients' order by idx asc
select * from `tabUOM Conversion Detail` where `parenttype` = 'Item' and `parent` = '_Test PPT Item Raw D' and `parentfield` = 'uoms' order by idx asc
select `default_cost_center` from `tabItem Group` where `name` = 'All Item Groups' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabSales Invoice Item` where `sales_order` = 'SO-00013' order by modified desc
select * from `tabMaterial Request` where `name` = '_T-Material Request-00008' order by modified desc
select `name` from `tabuser` where `email` = 'test_lead@example.com' order by modified desc
select sum(qty - produced_qty) from `tabProduction Order` where production_item = '_Test FG Item' and fg_warehouse = '_Test Warehouse 1 - _TC' and status != 'Stopped' and docstatus='1'and qty > produced_qty
select `valuation_rate` from `tabitem` where `name` = '_Test Item Home Desktop 100' order by modified desc
select `production_item` from `tabProduction Order` where `name` = 'PRO-00010' order by modified desc
select name, `full_name` as title from `tabuser` order by `tabuser`.`modified` desc
select * from `tabCustomer Group` where lft='10'or rgt='11'
select t1.item_code, t1.qty, t1.uom, t1.description from `tabProduct Bundle Item` t1, `tabProduct Bundle` t2 where t2.new_item_code='_Test Service Product Bundle' and t1.parent = t2.name order by t1.idx
select max(char_length(`name`)) from `tabtodo`
select name from `tabBOM Explosion Item` where parent='BOM-_Test PPT Item Sub B-001' and parenttype='BOM' and parentfield='exploded_items' and name not in ('7fe4743b8b','2ec698dee9')
select 'Payment Entry' as reference_type, name as reference_name, remarks, unallocated_amount as amount from `tabPayment Entry` where paid_from = 'Debtors - _TC' and party_type = 'Customer' and party = '_Test Customer' and payment_type = 'Receive' and docstatus ='1'and unallocated_amount > 0
select `name` from `tabItem Group` where `name` = '_Test Item for Drop Shipping' order by modified desc
select pr_detail, qty from `tabPurchase Invoice Item` where purchase_receipt='PREC-00002' and docstatus='1'
select `owner` from `tabissue` where `name` = '_T-Issue-00001' order by modified desc
select `name` from `tabuser` where `name` < 'B' order by modified desc
select name from `tabStock Entry Detail` where parent='STE-00023' and parenttype='Stock Entry' and parentfield='items' and name not in ('54bb6b7b05')
select * from `tabStock Reconciliation` where `name` = 'SR/00002' order by modified desc
select name from `tabfile` where content_hash='b10a8db164e0754105b7a99be72e3fe5' and name!='1dbf08c29b' and attached_to_doctype='ToDo' and attached_to_name='dcfdc9b3b1'
select name from `tabemployee` where user_id='Monthly_test_employee@salary.com' and status='Active' and name!='EMP-0002'
select name, docstatus, parent, parenttype, idx from `tabLanded Cost Purchase Receipt` where receipt_document_type='Purchase Receipt' and receipt_document='_T-Purchase Receipt-00005'
select * from `tabPurchase Invoice Item` where `parenttype` = 'Purchase Invoice' and `parent` = 'PINV-00006' and `parentfield` = 'items' order by idx asc
select `credit_limit` from `tabcompany` where `name` = '_Test Company' order by modified desc
select name from `tabMode of Payment Account` where parent='Cash' and parenttype='Mode of Payment' and parentfield='accounts' and name not in ('c6ddfd123b','3a91ce4b16')
select actual_qty, projected_qty from `tabbin` where item_code = '_Test Service Product Bundle Item 1' and warehouse = NULL
select `name` from `tabaccount` where `company` = '_Test Company' and `account_name` = 'Sales' order by modified desc
select leave_type, half_day from `tabLeave Application` where employee = '_T-Employee-0001' and '2014-02-01' between from_date and to_date and status = 'Approved' and docstatus ='1'
select name from `tabLeave Block List` where applies_to_all_departments='1'and company='_Test Company'
select `warehouse`, `purchase_rate` from `tabSerial No` where `name` = 'SN001' order by modified desc
select name from `tabItem Group` where lft<23 and rgt>24 order by lft desc
select actual_qty from `tabbin` where item_code = '_Test Item' and warehouse = '_Test Warehouse - _TC'
select name from `tabProduction Order` where `tabProduction Order`.status in ('Draft', 'Not Started', 'In Process') order by `tabProduction Order`.docstatus asc, `tabProduction Order`.`modified` desc limit 0, 100
select parent, attribute_value from `tabItem Attribute Value` order by `tabItem Attribute Value`.`modified` DESC
select * from `tabCustom Field` order by `tabCustom Field`.`modified` desc
select * from `tabaddress` where `name` = '_Test Address for Customer-Office' order by modified desc
select reserved_qty from `tabbin` where `tabbin`.warehouse = '_Test Warehouse - _TC' and `tabbin`.item_code = '_Test Item' order by `tabbin`.`modified` desc
select * from `tabRequest for Quotation` where `name` = 'RFQ-00001' order by modified desc
select `name` from `tabtodo` where `owner` = 'test1@example.com' and `reference_name` = 'EV00010' and `reference_type` = 'Event' order by modified desc
select name from `tabLeave Allocation` where employee='_T-Employee-0002' and leave_type='_Test Leave Type' and docstatus='1'and to_date >= '2013-01-01' and from_date <= '2015-12-31'
select route, name, modified from `tabHelp Article` where published='1'and `route`='test-route-000' limit 1
select distinct link_doctype from `tabDynamic Link`
select name from `tabitem` where name in ('_Test Item', '_Test Item Home Desktop 100') and is_stock_item='1'
select `name`, `payment_gateway`, `payment_account`, `message` from `tabPayment Gateway Account` where `is_default` ='1'order by modified desc
select name from `tabMaterial Request` where `tabMaterial Request`.status not in ('Stopped') and `tabMaterial Request`.docstatus < 2.0 and `tabMaterial Request`.per_ordered < 100.0 order by `tabMaterial Request`.docstatus asc, `tabMaterial Request`.`modified` DESC limit 0, 100
select `account_type` from `tabaccount` where `name` = '_Test Write Off - _TC' order by modified desc
select item_code, qty from `tabBOM Scrap Item` where parent = 'BOM-_Test FG Item-001'
select modified, docstatus from `tabHoliday List` where name = 'Salary Slip Test Holiday List' for update
select ps.doc_type as parent, ps.field_name as fieldname, (select issingle from tabDocType dt where dt.name = ps.doc_type) as issingle from `tabProperty Setter` ps where ps.property_type='options' and ps.field_name is not null and ps.value='Item Group'
SELECT name FROM `tabPacking Slip` WHERE delivery_note = 'DN-00002' AND docstatus ='1'
select `supplier` from `tabPurchase Order` where `name` = 'PO-00014' order by modified desc
select modified, docstatus from `tabwarehouse` where name = 'All Warehouses - _TC1' for update
select * from `tabStock Ledger Entry` where `warehouse`='_Test Warehouse - _TC' and `item_code`='_Test Item 2' order by timestamp(posting_date, posting_time) desc, name desc limit 1
select * from `tabBOM Explosion Item` where `name` = '61c8b5fe94' order by modified desc
select max(char_length(`assigned_by_full_name`)) from `tabtodo`
select `create_account_under` from `tabwarehouse` where `name` = 'Finished Goods - _TC' order by modified desc
select name, issingle from `tabdoctype` order by `tabdoctype`.`modified` DESC
select account, debit, credit from `tabGL Entry` where voucher_type='Delivery Note' and voucher_no='DN-00005' order by account desc
select distinct `reference_doctype`, parenttype from `tabEmail Unsubscribe` where `reference_doctype`='Role'
select * from `tabdefaultvalue` where `parenttype` = 'User' and `parent` = 'Bimonthly_test_employee@salary.com' and `parentfield` = 'defaults' order by idx asc
select voucher_detail_no, serial_no, actual_qty, warehouse from `tabStock Ledger Entry` where voucher_type='Purchase Receipt' and voucher_no='PREC-00001'
select sum(gle.debit) - sum(gle.credit) from `tabGL Entry` gle where gle.account='_Test Account Cost for Goods Sold - _TC' and gle.posting_date <= '2013-02-28' and gle.fiscal_year='_Test Fiscal Year 2013' and gle.company='_Test Company' and gle.docstatus='1'and exists(select name from `tabCost Center` where lft>='10'and rgt<='11'and name=gle.cost_center)
select distinct reference_type from `tabPurchase Invoice Advance`
select `status` from `tabcustomer` where `name` = 'Party Status Test - 1' order by modified desc
select `docstatus` from `tabPurchase Invoice` where `name` = 'PINV-00001' order by modified desc
select `default_expense_account` from `tabcompany` where `name` = '_Test Company' order by modified desc
select name, from_time, to_time from `tabAssessment Plan` where `supervisor`='_T-Instructor-00001' and schedule_date = '2017-02-09' and ( (from_time > '3:00:00' and from_time < '4:00:00') or (to_time > '3:00:00' and to_time < '4:00:00') or ('3:00:00' > from_time and '3:00:00' < to_time) or ('3:00:00' = from_time and '4:00:00' = to_time)) and name!='SH00023'
select lft, rgt from `tabCustomer Group` where name='All Customer Groups'
select name, priority from `tabTax Rule` where ifnull(shipping_city, '') = '' and ifnull(company, '') = '_Test Company' and ifnull(shipping_state, '') = '' and ifnull(shipping_county, '') = '' and ifnull(supplier_type, '') = '' and ifnull(billing_country, '') = '' and ifnull(customer, '') = '_Test Customer' and ifnull(billing_city, '') = '' and ifnull(tax_type, '') = 'Sales' and ifnull(shipping_country, '') = '' and ifnull(supplier, '') = '' and ifnull(billing_county, '') = '' and ifnull(customer_group, '') = '' and ifnull(billing_state, '') = '' and from_date < '2013-01-01' and name != 'TR0006'
select name, docstatus from `tabGL Entry` where voucher_type='Payment Entry' and voucher_no='PE-00004'
select * from `tabDepreciation Schedule` where `parenttype` = 'Asset' and `parent` = 'Macbook Pro 1' and `parentfield` = 'schedules' order by idx asc
select is_stock_item, is_sub_contracted_item, end_of_life, disabled from `tabitem` where name='_Test FG Item'
select t1.name from `tabSales Invoice` t1,`tabSales Invoice Item` t2 where t1.name = t2.parent and t2.delivery_note = 'DN-00031' and t1.docstatus ='1'
select modified, docstatus from `tabGL Entry` where name = 'GL0000111' for update
select distinct `link_doctype`, parenttype from `tabDynamic Link` where `link_doctype`='Role'
select item_code, qty, serial_no, batch_no, parenttype from `tabDelivery Note Item` where parent = 'DN-00017'
select idx from `tabWorkstation Working Hour` where parent = '_Test Workstation 1' and name != '3bd7c886e1' and ( (start_time between '10:00:00' and '20:00:00') or (end_time between '10:00:00' and '20:00:00') or ('10:00:00' between start_time and end_time))
select * from `tabbin` where `name` = 'BIN/0000017' order by modified desc
select `name` from `taboperation` where `name` = '_Test Operation 1' order by modified desc
select * from `tabblogger` where `name` = '_Test Blogger 1' order by modified desc
select max(char_length(`owner`)) from `tabuser`
select `name`, `payment_gateway`, `payment_account`, `message` from `tabPayment Gateway Account` where `name` = '_Test Gateway - USD' order by modified desc
select * from `tabShipping Rule Condition` where `parenttype` = 'Shipping Rule' and `parent` = '_Test Shipping Rule - India' and `parentfield` = 'conditions' order by idx asc
select `operating_cost`, `quantity` from `tabbom` where `name` = 'BOM-_Test FG Item 2-001' order by modified desc
select modified, docstatus from `tabStock Reconciliation` where name = 'SR/00003' for update
select `name` from `tabGL Entry` where `account` = 'Direct Expenses - 7cQ' order by modified desc
select `warehouse` from `tabSerial No` where `name` = 'ABCD00006' order by modified desc
select name from `tabPayment Entry Reference` where parent='PE-00005' and parenttype='Payment Entry' and parentfield='references' and name not in ('8b27578551')
select `cost_center` from `tabcompany` where `name` = 'Wind Power LLC' order by modified desc
select * from `tabTax Rule` where (from_date is null or from_date = '' or from_date <= '2015-01-01') and (to_date is null or to_date = '' or to_date >= '2015-01-01') and ifnull(customer, '') in ('', '_Test Customer') and ifnull(billing_city, '') in ('', 'Test City 1')
select `credit_limit`, `customer_group` from `tabcustomer` where `name` = '_Test Customer USD' order by modified desc
select modified from `tabMaterial Request` where name = '_T-Material Request-00006'
select `country` from `tabaddress` where `name` = '_Test Address for Customer-Office' order by modified desc
select `email_id`, `always_use_account_email_id_as_sender`, `name` from `tabEmail Account` where `append_to` = 'Email Account' and `enable_outgoing` ='1'order by modified desc
select `name` from `tabasset` where `name` = 'Macbook Pro 1' order by modified desc
select `fieldtype` from `tabCustom Field` where `name` = 'User-test_custom_field' order by modified desc
select * from `tabJournal Entry` where `name` = '_T-Journal Entry-00002' order by modified desc
select modified, docstatus from `tabasset` where name = 'Macbook Pro 1' for update
select `debit` from `tabGL Entry` where `account` = '_Test Warehouse - _TC' and `voucher_no` = 'DN-00020' and `voucher_type` = 'Delivery Note' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabPacking Slip` where `delivery_note` = 'DN-00031' order by modified desc
select * from `tabSalary Structure Employee` where `parenttype` = 'Salary Structure' and `parent` = 'Fortnightly Salary Structure Test for Salary Slip' and `parentfield` = 'employees' order by idx asc
select `owner` from `tablead` where `name` = '_T-Lead-00004' order by modified desc
select name from `tabSales Order` where `tabSales Order`.status not in ('Completed', 'Closed') and `tabSales Order`.docstatus < 2.0 order by `tabSales Order`.docstatus asc, `tabSales Order`.`modified` DESC limit 0, 100
select name from `tabPurchase Invoice` where `tabPurchase Invoice`.supplier = '_Test Supplier 1' and ifnull(`tabPurchase Invoice`.docstatus, 0) < 2.0 and `tabPurchase Invoice`.outstanding_amount > 0.0 order by `tabPurchase Invoice`.docstatus asc, `tabPurchase Invoice`.`modified` DESC limit 0, 1
select name from `tabfile` where file_name='hello.txt'
select modified, docstatus from `tabMaterial Request` where name = '_T-Material Request-00008' for update
select distinct `delivery_document_type`, parenttype from `tabSerial No` where `delivery_document_type`='Role'
select `default_price_list` from `tabCustomer Group` where `name` = '_Test Customer Group' order by modified desc
select `currency` from `tabSales Invoice` where `name` = '_T-Sales Invoice-00002' order by modified desc
select name from `tabrole` where desk_access='1'and name in ('Administrator', 'System Manager', 'Accounts Manager', 'Accounts User', 'All', 'Blogger', 'Guest', 'Knowledge Base Contributor', 'Knowledge Base Editor', 'Maintenance Manager', 'Maintenance User', 'Newsletter Manager', 'Purchase Manager', 'Purchase Master Manager', 'Purchase User', 'Report Manager', 'Sales Manager', 'Sales Master Manager', 'Sales User', 'Website Manager', 'Stock User', 'Auditor', 'Stock Manager', 'Manufacturing Manager', 'Supplier', 'Projects User', 'Projects Manager', 'HR User', 'Manufacturing User', 'Item Manager', 'HR Manager', 'Fleet Manager', 'Leave Approver', 'Expense Approver', 'Quality Manager', 'Support Team', 'Instructor', 'Customer', 'Student', 'Analytics', 'Analytics', 'Fleet Manager', 'Item Manager', 'Maintenance Manager', '_Test Role', 'Newsletter Manager', 'Purchase Master Manager', 'Sales Manager', 'Stock User', 'Website Manager', '_Test Role 2') limit 1
select name from `tabitem` where name in ('_Test Item for Drop Shipping') and is_stock_item='1'
select modified, docstatus from `tabAddress Template` where name = 'Brazil' for update
select `buying`, `selling`, `currency` from `tabPrice List` where `enabled` ='1'and `name` = '_Test Price List Rest of the World' order by modified desc
select * from `tabTimesheet Detail` where `parenttype` = 'Timesheet' and `parent` = 'TS-00002' and `parentfield` = 'time_logs' order by idx asc
select name from `tabaccount` where name='Test Warehouse for Merging 2 - _TC' for update
select modified, docstatus from `tabitem` where name = '_Test PPT Item SC B' for update
select module_name, hidden, label, link, type, icon, color, _doctype, idx, force_show, reverse, custom, standard, blocked from `tabDesktop Icon` where `tabDesktop Icon`.owner = 'test@example.com' and `tabDesktop Icon`.standard = 0.0 order by `tabDesktop Icon`.`modified` DESC
select parent from `tabDynamic Link` where `tabDynamic Link`.parenttype = 'Address' and `tabDynamic Link`.link_name = '_Test Customer' and `tabDynamic Link`.link_doctype = 'Customer' order by `tabDynamic Link`.`modified` DESC
select docstatus, income_account from tabItem where name = '_Test Serialized Item With Series'
select name from `tabquotation` where name='QTN-00001' and order_type = 'Sales'
select `name`, `parent`, `parenttype`, `docstatus` from `tabDepreciation Schedule` where `journal_entry` = 'JV-00024' order by modified desc
select `name` from `tabEmail Unsubscribe` where `name` = '624d3b0343' order by modified desc
select `owner` from `tabPurchase Order` where `name` = 'PO-00008' order by modified desc
select modified, docstatus from `tabdocshare` where name = '96d68d85f1' for update
select distinct receipt_document_type from `tabLanded Cost Item`
select sum(debit) - sum(credit) from `tabGL Entry` where party_type = 'Customer' and party = '_Test Customer' and company='_Test Company 1'
select `name` from `tabissue` where `name` = '_T-Issue-00001' order by modified desc
select max(idx) from `tabDesktop Icon` where owner='test@example.com'
select `conversion_factor` from `tabUOM Conversion Detail` where `uom` = '_Test UOM' and `parent` = '_Test Serialized Item' order by modified desc
select name from `tabuser` where `tabuser`.thread_notify = 0.0 order by `tabuser`.`modified` desc
select `name` from `tabprogram` where `name` = '_Test Program' order by modified desc
select modified, docstatus from `tabItem Group` where name = '_Test Item Group B' for update
select * from `tabBank Reconciliation Detail` where `parenttype` = 'Bank Reconciliation' and `parent` = 'Bank Reconciliation' and `parentfield` = 'payment_entries' order by idx asc
select `default_expense_account`, `cost_center` from `tabcompany` where `name` = '_Test Company' order by modified desc
select field_name, property, value from `tabProperty Setter` where ifnull(`tabProperty Setter`.property, '') in ('precision', 'length', 'unique') and `tabProperty Setter`.doc_type = 'Some DocType' and `tabProperty Setter`.doctype_or_field = 'DocField' order by `tabProperty Setter`.`modified` desc
select `default_income_account` from `tabcompany` where `name` = '_Test Company' order by modified desc
select item.qty as qty from `tabMaterial Request` mat_req, `tabMaterial Request Item` item where item.item_code = '_Test PPT Item Sub B' and item.parent = mat_req.name
select name from `tabdocperm` where parent='ToDo' and parenttype='DocType' and parentfield='permissions' and name not in ('b4d5eb8bf3','88fa17305d')
select name, item_code, item_name, description, item_group, expense_account, has_batch_no, has_serial_no, expense_account, selling_cost_center, stock_uom, image, default_warehouse, is_stock_item, barcode from tabItem where disabled ='0'and has_variants ='0'and is_sales_item ='1'and item_group in ('_Test Item Group')
select avg(purchase_rate) from `tabSerial No` where name in ('ABCD00001', 'ABCD00002')
select child.item_code, sum(abs(child.qty)) as qty from `tabDelivery Note Item` child, `tabDelivery Note` par where child.parent = par.name and par.docstatus ='1'and par.is_return ='1'and par.return_against = 'DN-00015' group by child.item_code
select `name` from `tabSales Order` where `name` = 'SO-00034' order by modified desc
select * from `tabSupplier Quotation Item` where `parenttype` = 'Supplier Quotation' and `parent` = 'SQTN-00003' and `parentfield` = 'items' order by idx asc
select name, from_time, to_time from `tabAssessment Plan` where `room`='RM0001' and schedule_date = '2017-02-09' and ( (from_time > '1:00:00' and from_time < '2:00:00') or (to_time > '1:00:00' and to_time < '2:00:00') or ('1:00:00' > from_time and '1:00:00' < to_time) or ('1:00:00' = from_time and '2:00:00' = to_time)) and name!='SH00001'
select max(rgt) from `tabItem Group`
select `currency` from `tabbom` where `name` = 'BOM-_Test Item Home Desktop Manufactured-001' order by modified desc
select modified, docstatus from `tabevent` where name = 'EV00018' for update
select `name` from `tabrole` where `name` = 'Administrator' order by modified desc
select `owner` from `tabtask` where `name` = 'TASK00011' order by modified desc
select * from `tabbom` where `name` = 'BOM-_Test Variant Item-001' order by modified desc
select route, name, modified from `tabitem` where show_in_website='1'and `route`='test-route-000' limit 1
select modified from `tabPurchase Order` where name = 'PO-00007'
select * from `tabCost Center` where lft='14'or rgt='15'
select `is_group`, `company`, `report_type` from `tabaccount` where `name` = '_Test Account Cost for Goods Sold - _TC' order by modified desc
select name from `tabPurchase Order` where ifnull(`tabPurchase Order`.status, '') not in ('Completed', 'Closed') and ifnull(`tabPurchase Order`.docstatus, 0) < 2.0 and `tabPurchase Order`.supplier = '_Test Supplier with Country' order by `tabPurchase Order`.docstatus asc, `tabPurchase Order`.`modified` DESC limit 0, 1
select `name`, `parent`, `parenttype`, `docstatus` from `tabDelivery Note Item` where `against_sales_order` = 'SO-00027' order by modified desc
select * from `tabuser` order by `tabuser`.`modified` desc
select `name` from `tabSalary Component` where `name` = 'TDS' order by modified desc
select sum(transfer_qty) from `tabStock Entry Detail` where parent in ('STE-00024') and item_code = '_Test FG Item' and ifnull(s_warehouse,'')=''
select `produced_qty` from `tabProduction Order` where `name` = 'PRO-00002' order by modified desc
select sum(amount) from `tabSales Invoice Item` where dn_detail='d7515f6c54' and docstatus='1'
select `name` from `tabDesktop Icon` where `module_name` = 'Accounts' and `standard` ='1'order by modified desc
select max(char_length(`repeat_on`)) from `tabevent`
select distinct `reference_type`, parenttype from `tabJournal Entry Account` where `reference_type`='Role'
select `name`, `parent`, `parenttype`, `docstatus` from `tabasset` where `journal_entry_for_scrap` = '_T-Journal Entry-00004' order by modified desc
select `customer_group`, `territory` from `tabcustomer` where `name` = '_Test Customer 1' order by modified desc
select * from `tabSales Order Item` where `parenttype` = 'Sales Order' and `parent` = 'SO-00032' and `parentfield` = 'items' order by idx asc
select route, name, modified from `tabSales Partner` where show_in_website='1'and `route`='test-route-000' limit 1
select `docstatus` from `tabPurchase Order` where `name` = 'PO-00005' order by modified desc
select `tabdoctype`.`name` from `tabdoctype` where `tabdoctype`.name = 'DocField' order by `tabdoctype`.`modified` DESC
select `currency` from `tabSupplier Quotation` where `name` = '_T-Supplier Quotation-00001' order by modified desc
select distinct `party_type`, parenttype from `tabJournal Entry Account` where `party_type`='Role'
select `amount` from `tabDelivery Note Item` where `name` = '6a8666ef78' order by modified desc
select name from `tabJournal Entry Account` where reference_type = 'Purchase Order' and reference_name = 'PO-00014' and debit='400'
select `max_discount` from `tabitem` where `name` = '_Test Mix Product Bundle' order by modified desc
select * from `tabShipping Rule Country` where `parenttype` = 'Shipping Rule' and `parent` = '_Test Shipping Rule - India' and `parentfield` = 'countries' order by idx asc
select * from `tabsupplier` where `name` = '_Test Supplier 1' order by modified desc
select `docstatus` from `tabasset` where `name` = 'Macbook Pro 1' order by modified desc
select sum(transfer_qty) from `tabStock Entry Detail` where material_request = '_T-Material Request-00004' and material_request_item = '6ae9b62aee' and docstatus ='1'
select min(actual_start_time) as start_date, max(actual_end_time) as end_date from `tabProduction Order Operation` where parent = 'PRO-00001' and docstatus='1'
select name from `tabSalary Component` order by `tabSalary Component`.`modified` DESC
select * from `tabSales Order Item` where `name` = '2ca4c0603b' order by modified desc
select max(char_length(`new_password`)) from `tabuser`
select count(*) from `tabAuthorization Rule`
select `name` from `tabcontact` where `name` = '_Test Lead-_Test Lead' order by modified desc
select `student_batch` from `tabStudent Group` where `name` = 'TC-TP-2014-2015-2014-2015 (_Test Academic Term)' order by modified desc
select parent from `tabSalary Structure Employee` where employee='EMP-0002' and parent in (select name from `tabSalary Structure` where is_active = 'Yes' and (from_date <= '2016-11-01' or from_date <= '2013-01-01') and (to_date is null or to_date >= '2016-11-30' or to_date >= NULL) and payroll_frequency = 'Monthly')
select `number_format` from `tabcurrency` where `name` = 'USD' order by modified desc
select `name` from `tabLeave Application` where `name` = 'LAP/00008' order by modified desc
select count(name) from `tabItem Group` where `parent_item_group`='_Test Item Group B'
select `name` from `tabtask` where `name` = 'TASK00001' order by modified desc
select distinct `prevdoc_doctype`, parenttype from `tabMaintenance Visit Purpose` where `prevdoc_doctype`='Role'
select name from `tabEmail Account` where `tabEmail Account`.notify_if_unreplied = 1.0 and `tabEmail Account`.enable_incoming = 1.0 order by `tabEmail Account`.`modified` DESC
select `name` from `tabtodo` where `owner` = 'test@example.com' and `reference_name` = '9b6df46a09' and `status` = 'Open' and `reference_type` = 'ToDo' order by modified desc
select name from `tabDelivery Note` where ifnull(`tabDelivery Note`.status, '') not in ('Completed', 'Closed') and ifnull(`tabDelivery Note`.docstatus, 0) < 2.0 and `tabDelivery Note`.customer = '_Test Customer 3' order by `tabDelivery Note`.docstatus asc, `tabDelivery Note`.`modified` DESC limit 0, 1
select * from `tabStock Entry Detail` where `parenttype` = 'Stock Entry' and `parent` = '_T-Stock Entry-00003' and `parentfield` = 'items' order by idx asc
select `ordered_qty` from `tabbin` where `warehouse` = '_Test Warehouse - _TC' and `item_code` = '_Test Item' order by modified desc
select name, file_name from tabFile where is_home_folder ='0'and is_attachments_folder ='0'order by rgt-lft asc
select `amount` from `tabPurchase Receipt Item` where `name` = 'dca5ce203a' order by modified desc
select `name` from `tabinstructor` where `name` = '_T-Instructor-00001' order by modified desc
select `balance_must_be` from `tabaccount` where `name` = 'Stock Received But Not Billed - _TC' order by modified desc
select `stock_received_but_not_billed` from `tabcompany` where `name` = '_Test Company' order by modified desc
select max(char_length(`modified_by`)) from `tabevent`
select `name` from `tabSalary Component Account` where `company` = 'Wind Power LLC' and `parent` = 'Basic' order by modified desc
select CONCAT(from_currency,'-',to_currency) from `tabCurrency Exchange` where from_currency in ('USD') and to_currency = 'INR' and date <= curdate()
select `name` from `tabuser` where `username` = '_test' and `name` != 'test@example.com' order by modified desc
select `name` from `tabevent` where `subject` = '_Test Event 3' order by modified desc
select * from `tabDynamic Link` where `parenttype` = 'Contact' and `parent` = '_Test Contact for _Test Customer-_Test Customer' and `parentfield` = 'links' order by idx asc
select `is_frozen`, `disabled` from `tabsupplier` where `name` = '_Test Supplier 1' order by modified desc
select * from `tabPurchase Receipt Item` where `parenttype` = 'Purchase Receipt' and `parent` = 'PREC-00008' and `parentfield` = 'items' order by idx asc
select name from `tabMode of Payment Account` where parent='Cash' and parenttype='Mode of Payment' and parentfield='accounts' and name not in ('c6ddfd123b')
select max(char_length(`email`)) from `tabuser`
select `customer` from `tabSales Order` where `name` = 'SO-00033' order by modified desc
select modified, docstatus from `tabVehicle Log` where name = 'VLOG00001' for update
select name from `tabItem Price` where item_code='_Test Item' and price_list='_Test Price List' and name!='ITEM-PRICE-00005'
select `name` from `tabPrint Format` where `name` = 'Point of Sale' order by modified desc
select t1.name from `tabInstallation Note` t1, `tabInstallation Note Item` t2 where t1.name = t2.parent and t2.prevdoc_docname = 'DN-00016' and t1.docstatus ='1'
select `tabDaily Work Summary`.`name` from `tabDaily Work Summary` where `tabDaily Work Summary`.status = 'Open' order by `tabDaily Work Summary`.`modified` DESC
select max(char_length(`priority`)) from `tabtodo`
select `idx` from `tabuser` where `name` = 'test@example.com' order by modified desc
select `owner` from `tabEmail Account` where `name` = '_Test Email Account 1' order by modified desc
select t1.name from `tabDelivery Note` t1,`tabDelivery Note Item` t2 where t1.name = t2.parent and t2.against_sales_order = 'SO-00027' and t1.docstatus ='1'
select modified, docstatus from `tabbin` where name = 'BIN/0000001' for update
select * from `tabEmail Alert` where `name` = '_Test Email Alert 4' order by modified desc
select bom_item.item_code, sum(bom_item.qty/ifnull(bom.quantity, 1)) * 1 as qty, item.stock_uom from `tabBOM Explosion Item` bom_item, `tabbom` bom, `tabitem` item where bom_item.parent = bom.name and bom_item.docstatus < 2 and bom_item.parent = 'BOM-_Test FG Item 2-001' and item.name = bom_item.item_code and is_stock_item ='1'and item.is_sub_contracted_item ='0'group by bom_item.item_code, item.stock_uom
select name from `tabSales Invoice` where `customer` = '_Test Customer' and `docstatus` = '1' and `company` = '_Test Company'
select `name`, `parent`, `parenttype`, `docstatus` from `tabJournal Entry` where `stock_entry` = 'STE-00019' order by modified desc
select pr_item.item_code, pr_item.description, pr_item.qty, pr_item.base_rate, pr_item.base_amount, pr_item.name from `tabPurchase Invoice Item` pr_item where parent = 'PINV-00001' and exists(select name from tabItem where name = pr_item.item_code and is_stock_item ='1'
select name from `tabExpense Claim Detail` where parent='EXP00002' and parenttype='Expense Claim' and parentfield='expenses' and name not in ('15f84b48c1')
select `name`, `icon`, `color`, `reverse` from `tabDesktop Icon` where `module_name` = 'Core' and `standard` ='1'order by modified desc
select name, priority from `tabTax Rule` where ifnull(shipping_city, '') = '' and ifnull(company, '') = '_Test Company' and ifnull(shipping_state, '') = '' and ifnull(shipping_county, '') = '' and ifnull(supplier_type, '') = '' and ifnull(billing_country, '') = '' and ifnull(customer, '') = '_Test Customer' and ifnull(billing_city, '') = '' and ifnull(tax_type, '') = 'Sales' and ifnull(shipping_country, '') = '' and ifnull(supplier, '') = '' and ifnull(billing_county, '') = '' and ifnull(customer_group, '') = '' and ifnull(billing_state, '') = '' and name != 'TR0003'
select `name`, `parent`, `parenttype`, `docstatus` from `tabPurchase Receipt` where `return_against` = 'PREC-00016' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabtimesheet` where `production_order` = 'PRO-00007' order by modified desc
select route, name, modified from `tabItem Group` where show_in_website='1'and `route`='test-route-000' limit 1
select `name` from `tabEmail Queue` where `status` = 'Not Sent' and `reference_doctype` = 'Event' and `reference_name` = 'EV00009' order by modified desc
select sum(applicable_charges) from `tabLanded Cost Item` where docstatus ='1'and purchase_receipt_item = '539402fc7a'
select `module` from `tabdoctype` where `name` = 'Customize Form' order by modified desc
select `title` from `tabBlog Post` where `name` = '-test-blog-post-1' order by modified desc
select parent as doctype, fieldname, options as doctype_fieldname from `tabdocfield` where fieldtype='Dynamic Link'
select `name` from `tablead` where `email_id` = 'test@example.com' order by modified desc
select t1.name from `tabSales Invoice` t1,`tabSales Invoice Item` t2 where t1.name = t2.parent and t2.sales_order = 'SO-00027' and t1.docstatus ='1'
select `name` from `tabcourse` where `name` = '_Test Course 2' order by modified desc
select * from `tabQuotation Item` where `parenttype` = 'Quotation' and `parent` = 'QTN-00001' and `parentfield` = 'items' order by idx asc
select dt as parent, fieldname from `tabCustom Field` where (fieldtype='Link' and options='Role') or (fieldtype='Select' and options='link:Role')
select lft, rgt from `tabCost Center` where name='_Test Company - _TC'
select * from `tabtimesheet` where employee = '_T-Employee-0001' and start_date BETWEEN '2017-02-09' AND '2017-02-09' and (status = 'Submitted' or status = 'Billed')
select modified, docstatus from `tabPOS Profile` where name = '6125d62f89' for update
select sum(qty) from `tabProduction Order` where material_request = '_T-Material Request-00013' and material_request_item = '1a36242b82' and docstatus ='1'
select `item_group`, `selling_cost_center` from `tabitem` where `name` = '_Test Item' order by modified desc
select name from `tabDepreciation Schedule` where parent='Macbook Pro 1' and parenttype='Asset' and parentfield='schedules' and name not in ('df861eedbc','e2e3790e55','e9674ed419')
select `_comments` from `tabSales Invoice` where `name` = 'SINV-00021' order by modified desc
select * from `tabItem Group` where `name` = 'All Item Groups' order by modified desc
select * from `tabBOM Item` where `parenttype` = 'BOM' and `parent` = 'BOM-_Test FG Item-001' and `parentfield` = 'items' order by idx asc
select `email` from `tabuser` where `email` = 'test@example.com' order by modified desc
select `name` from `tabCost Center` where `name` = 'COA from Existing Company - CFEC' order by modified desc
select actual_qty, stock_value from `tabbin` where item_code='_Test Item Home Desktop 100'
select `name`, `parent`, `parenttype`, `docstatus` from `tabProduction Order` where `amended_from` = 'PRO-00003' order by modified desc
select name from `tabDelivery Note Item` where parent='DN-00030' and parenttype='Delivery Note' and parentfield='items' and name not in ('0823055fad')
SELECT sum(debit_in_account_currency) - sum(credit_in_account_currency) FROM `tabGL Entry` gle WHERE posting_date <= '2013-02-14' and gle.account = '_Test Receivable USD - _TC'
select name from `tabTimesheet Detail` where parent='TS-00002' and parenttype='Timesheet' and parentfield='time_logs' and name not in ('4a957935f1')
select `name` from `tabBlog Category` where `name` = 'test-category' order by modified desc
select name, communication_type, communication_medium, comment_type, content, sender, sender_full_name, creation, subject, delivery_status, _liked_by, timeline_doctype, timeline_name, reference_doctype, reference_name, link_doctype, link_name, 'Communication' as doctype from tabCommunication where communication_type in ('Communication', 'Comment') and ( (reference_doctype='Task' and reference_name='TASK00009') or ( (timeline_doctype='Task' and timeline_name='TASK00009') and ( communication_type='Communication' or ( communication_type='Comment' and comment_type in ('Created', 'Updated', 'Submitted', 'Cancelled', 'Deleted') ))) ) order by creation desc limit 0, 20
select `name`, `parent`, `parenttype`, `docstatus` from `tabStock Entry` where `sales_invoice_no` = 'SINV-00016' order by modified desc
select `name` from `tabEmail Account` where `name` = 'Test Email Account Password-new' order by modified desc
select `name` from `tabPrice List` where `selling` ='1'order by modified desc
select modified, docstatus from `tabbudget` where name = '_Test Project/_Test Fiscal Year 2013/002' for update
select mat_req.material_request_type as type from `tabMaterial Request` mat_req, `tabMaterial Request Item` item where item.item_code = '_Test PPT Item Raw B' and item.parent = mat_req.name
select `docstatus` from `tabquotation` where `name` = 'QTN-00002' order by modified desc
select `project` from `tabStock Entry` where `production_order` = 'PRO-00001' and `purpose` = 'Material Transfer for Manufacture' order by modified desc
select `name` from `tabStock Ledger Entry` where `company` = 'India - Chart of Accounts' order by modified desc
select *, timestamp(posting_date, posting_time) as "timestamp" from `tabStock Ledger Entry` where item_code = '_Test Item' and warehouse = '_Test Warehouse - _TC' and ifnull(is_cancelled, 'No')='No' and timestamp(posting_date, posting_time) < timestamp('2017-02-09', '12:25:12.166514') order by timestamp(posting_date, posting_time) desc, name desc limit 1
select name from `tabissue` where `tabissue`.status = 'Open' and `tabissue`.customer = '_Test Customer 3' order by `tabissue`.`modified` desc limit 0, 1
select name from `tabError Log` where `tabError Log`.seen = 0.0 order by `tabError Log`.`modified` desc limit 0, 100
select name from `tabuserrole` where parent='Administrator' and parenttype='User' and parentfield='user_roles' and name not in ('840a017172','a8aeb4dda8','fb92eac658','2f0b4f7942','295edbfb91','ea3354d8bd','ae196db87f','14607b04e4','ee65d39cdb','9a873503c7','63ddbbc65d','550f629631','f88424d645','93962fb409','2776be196f','767caf1a89','eef45bb10b','8606e302fa','0dc15b9feb','d07210c929','15e0ff6ecd','4dabbc20ab','bbd0220737','8fc9cf07fb','4e3bdaa967','ff26dd60d4','e6e009ef82','bb58f2d291','0ae1a69f66','27d84ccc37','1953579051','e709bd7103','5d9817f9d9','9e29a83a26','d79f19b8c9','dcdf15a4fe','1403958824','713d246c3f','daa263b410','b28ba6a464','ec9342c5c5','73e83c7986','6c0b5d5cef','5e989bb458','bd33659b90','7d2fb9484f')
select `name` from `tabDesktop Icon` where `owner` = 'Administrator' and `link` = 'List/Task' and `standard` ='1'order by modified desc
select name from `tabrole` where desk_access='1'and name in ('Administrator', 'System Manager', 'Accounts Manager', 'Accounts User', 'All', 'Blogger', 'Guest', 'Knowledge Base Contributor', 'Knowledge Base Editor', 'Maintenance Manager', 'Maintenance User', 'Newsletter Manager', 'Purchase Manager', 'Purchase Master Manager', 'Purchase User', 'Report Manager', 'Sales Manager', 'Sales Master Manager', 'Sales User', 'Website Manager', 'Stock User', 'Auditor', 'Stock Manager', 'Manufacturing Manager', 'Supplier', 'Projects User', 'Projects Manager', 'HR User', 'Manufacturing User', 'Item Manager', 'HR Manager', 'Fleet Manager', 'Leave Approver', 'Expense Approver', 'Quality Manager', 'Support Team', 'Instructor', 'Customer', 'Student', 'Analytics', 'Fleet Manager', '_Test Role 2', 'Maintenance Manager', '_Test Role', 'Purchase Master Manager', 'Stock User', '_Test Role 3') limit 1
select modified, docstatus from `tabPayment Entry` where name = 'PE-00004' for update
select max(char_length(`google_userid`)) from `tabuser`
select name from `tabLeave Application` where `tabLeave Application`.status = 'Open' order by `tabLeave Application`.docstatus asc, `tabLeave Application`.`modified` DESC limit 0, 100
select `must_be_whole_number` from `tabuom` where `name` = 'Nos' order by modified desc
select * from `tabItem Group` where lft='4'or rgt='5'
select `per_delivered` from `tabSales Order` where `name` = 'SO-00017' order by modified desc
select `is_group`, `root_type`, `company` from `tabaccount` where `name` = 'Test Warehouse for Merging 2 - _TC' order by modified desc
select name from `tabitem` where name in ('_Test FG Item') and is_sub_contracted_item='1'
select `stock_uom`, `is_stock_item`, `has_serial_no`, `has_batch_no` from `tabitem` where `name` = 'Test Item for Merging 2' order by modified desc
SELECT item_code, stock_value, name, warehouse FROM `tabStock Ledger Entry` sle WHERE posting_date <= '2017-02-09' AND warehouse = 'Test Warehouse for Renaming 1 - _TC' ORDER BY timestamp(posting_date, posting_time) DESC, name DESC
select `description` from `tabtodo` where `name` = '258546aad7' order by modified desc
select `company` from `tabCost Center` where `name` = 'Main - _TC' order by modified desc
select `tabevent`.`subject`, `tabevent`.`event_type`, `tabevent`.`name`, `tabevent`.`modified`, `tabevent`.`docstatus` from `tabevent` left join `tabEvent Role` on (`tabEvent Role`.parent = `tabevent`.name) where `tabEvent Role`.role = 'System Manager' and ((tabEvent.event_type='Public' or tabEvent.owner='Administrator' or exists(select * from `tabEvent Role` where `tabEvent Role`.parent=tabEvent.name and `tabEvent Role`.role in ('Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest'))) ) order by `tabevent`.`modified` desc
select `indented_qty` from `tabbin` where `warehouse` = '_Test Warehouse - _TC' and `item_code` = '_Test Item Home Desktop 100' order by modified desc
select max(char_length(`user_type`)) from `tabuser`
select `credit_days_based_on`, `credit_days` from `tabCustomer Group` where `name` = '_Test Customer Group' order by modified desc
select sum(mr_item.qty - mr_item.ordered_qty) from `tabMaterial Request Item` mr_item, `tabMaterial Request` mr where mr_item.item_code='_Test Item' and mr_item.warehouse='_Test Warehouse - _TC' and mr_item.qty > mr_item.ordered_qty and mr_item.parent=mr.name and mr.status!='Stopped' and mr.docstatus='1'
select `valuation_rate` from `tabbin` where `warehouse` = '_Test Warehouse - _TC' and `item_code` = '_Test Item for Drop Shipping' order by modified desc
select name, owner, description from `tabtodo` where reference_type='Event' and reference_name='EV00010' and status='Open' order by modified desc limit 5
select * from tabUser where user_type='System User' and enabled='1'and name not in ('Administrator', 'Guest')
select * from `tabPricing Rule` where (item_code='Macbook Pro' or ifnull(item_group, '') in ('All Item Groups') or brand=NULL) and docstatus < 2 and `tabPricing Rule`."disable" ='0'and selling ='1'and ifnull(company, '') in ('_Test Company', '') and ifnull(customer, '') = '' and ifnull(supplier, '') = '' and ifnull(supplier_type, '') = '' and ifnull(campaign, '') = '' and ifnull(sales_partner, '') = '' and ifnull(for_price_list, '') in ('Standard Selling', '') and '2017-02-09' between ifnull(valid_from, '2000-01-01') and ifnull(valid_upto, '2500-12-31') order by priority desc, name desc
select `name` from `tabproject` where `name` = '_Test Project 1' order by modified desc
select name from `tabPurchase Receipt Item` where parent='_T-Purchase Receipt-00005' and parenttype='Purchase Receipt' and parentfield='items' and name not in ('9baa450d6c','1397ec38ae')
select `tabaccount`.`name` from `tabaccount` where `tabaccount`.company = 'India - Chart of Accounts' and `tabaccount`.account_type = 'Cost of Goods Sold' order by `tabaccount`.`modified` desc
select `status` from `tabDelivery Note` where `name` = 'DN-00001' order by modified desc
select distinct prevdoc_doctype from `tabQuotation Item`
select * from `tabuser` where `name` = 'test@erpnext.com' order by modified desc
select * from `tabPurchase Invoice Item` where `name` = '1295c79e1f' order by modified desc
select distinct `reference_type`, parenttype from `tabQuality Inspection` where `reference_type`='Role'
select `lft`, `rgt` from `tabterritory` where `name` = '_Test Territory' order by modified desc
select modified, docstatus from `tabLeave Application` where name = 'LAP/00006' for update
SELECT sum(debit) - sum(credit) FROM `tabGL Entry` gle WHERE gle.account = '_Test Bank USD - _TC'
select `name` from `tabuser` where `name` <= 'Administrator' order by modified desc
select `name` from `tabaccount` where `is_group` ='0'and `company` = 'COA from Existing Company' and `account_type` = 'Depreciation' order by modified desc
select item_code, qty, serial_no, batch_no, parenttype from `tabSales Invoice Item` where parent = 'SINV-00017'
select bom_item.item_code, sum(bom_item.qty/ifnull(bom.quantity, 1)) * 1 as qty, item.stock_uom from `tabBOM Item` bom_item, `tabbom` bom, `tabitem` item where bom_item.parent = bom.name and bom_item.docstatus < 2 and bom_item.parent = 'BOM-_Test FG Item 2-001' and item.name = bom_item.item_code and is_stock_item ='1'group by bom_item.item_code, item.stock_uom
select name, file_name, file_url, is_private from `tabfile` where `tabfile`.attached_to_name = 'EV00013' and `tabfile`.attached_to_doctype = 'Event' order by `tabfile`.`modified` desc
select max(rgt) from `tabfile`
select name from `tabPayment Entry Deduction` where parent='PE-00009' and parenttype='Payment Entry' and parentfield='deductions' and name not in ('0d0e3f0204')
select `landed_cost_voucher_amount` from `tabPurchase Receipt Item` where `parent` = '_T-Purchase Receipt-00003' order by modified desc
select item_code, warehouse, projected_qty from tabBin where item_code in ('_Test Item', '_Test Item Warehouse Group Wise Reorder', '_Test Variant Item-S') and (warehouse != '' and warehouse is not null)
select name from `tabExpense Claim` where `tabExpense Claim`.approval_status = 'Draft' order by `tabExpense Claim`.docstatus asc, `tabExpense Claim`.`modified` DESC limit 0, 100
select `tabEmail Unsubscribe`.`name` from `tabEmail Unsubscribe` where `tabEmail Unsubscribe`.email = 'test@example.com' and ifnull(`tabEmail Unsubscribe`.name, '') != '624d3b0343' and `tabEmail Unsubscribe`.global_unsubscribe = 1.0 order by `tabEmail Unsubscribe`.`modified` DESC
select `year_start_date` from `tabFiscal Year` where `name` = '_Test Fiscal Year 2013' order by modified desc
select distinct reference_type from `tabtodo`
select abs(stock_value_difference / actual_qty) from `tabStock Ledger Entry` where voucher_type = 'Delivery Note' and voucher_no = 'DN-00017' and item_code = '_Test Item' limit 1
select name, leave_type, posting_date, from_date, to_date, total_leave_days from `tabLeave Application` where employee = '_T-Employee-0002' and docstatus < 2 and status in ('Open', 'Approved') and to_date >= '2013-01-01' and from_date <= '2013-01-05' and name != 'LAP/00003'
select max(char_length(`name`)) from `tabevent`
select * from `tabPricing Rule` where (item_code='_Test Item' or ifnull(item_group, '') in ('All Item Groups', '_Test Item Group') or brand=NULL) and docstatus < 2 and `tabPricing Rule`."disable" ='0'and buying ='1'and ifnull(company, '') in ('_Test Company', '') and ifnull(customer, '') = '' and ifnull(supplier, '') in ('_Test Supplier USD', '') and ifnull(supplier_type, '') in ('_Test Supplier Type', '') and ifnull(campaign, '') = '' and ifnull(sales_partner, '') = '' and ifnull(for_price_list, '') in ('Standard Buying', '') and '2017-02-09' between ifnull(valid_from, '2000-01-01') and ifnull(valid_upto, '2500-12-31') order by priority desc, name desc
select * from `tabuserrole` where parent='testdelete@example.com' and parentfield='user_roles' order by idx
select name from `tabSales Person` where lft <='1'and rgt >='2'
select name, docstatus from `tabSerial No` where purchase_document_type='Stock Entry' and purchase_document_no='STE-00019'
select dn_detail, qty from `tabSales Invoice Item` where delivery_note='DN-00009' and docstatus='1'
select * from `tabwarehouse` where `name` = 'All Warehouses - _TC1' order by modified desc
select ifnull(max(rgt),0)+1 from `tabterritory` where ifnull(`parent_territory`,'') =''
select ordered_qty from `tabbin` where `tabbin`.warehouse = '_Test Warehouse - _TC' and `tabbin`.item_code = '_Test Item' order by `tabbin`.`modified` desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabProduction Plan Sales Order` where `sales_order` = 'SO-00013' order by modified desc
select * from `tabWeb Form` where `name` = 'manage-events' order by modified desc
select `docstatus` from `tabtimesheet` where `name` = 'TS-00015' order by modified desc
select `tabdoctype`.`name` from `tabdoctype` order by `tabdoctype`.`modified` DESC
select distinct against_voucher_type from `tabGL Entry`
select `name` from `tabvehicle` where `name` = 'Z29BOJUG0R' order by modified desc
select `docstatus` from `tabSalary Slip` where `name` = 'Sal Slip/_T-Employee-0001/00001' order by modified desc
select `name` from `tabMonthly Distribution` where `name` = '_Test Distribution' order by modified desc
select name from `tabJournal Entry` where `tabJournal Entry`.docstatus = 0.0 order by `tabJournal Entry`.docstatus asc, `tabJournal Entry`.`modified` DESC limit 0, 100
select `name`, `parent`, `parenttype`, `docstatus` from `tabStock Entry` where `purchase_receipt_no` = '_T-Purchase Receipt-00005' order by modified desc
select `depreciation_cost_center` from `tabcompany` where `name` = '_Test Company' order by modified desc
select count(*) from `tabterritory` where ifnull(parent_territory, '')=''
select projected_qty from `tabbin` where item_code = '_Test Service Product Bundle' and warehouse = NULL
select name from `tabuserrole` where parent='test@example.com' and parenttype='User' and parentfield='user_roles' and name not in ('a496d47242','329a1b58b9','b1b0e80e75','7d80cfb0a0','3dcca4543d','3b7e2e6e19','a8777daf10','ef47be1c44','5d40438162','71b8b15646')
select `project`, `item_code`, `uom` from `tabPurchase Order Item` where `name` = '20bb7cad4e' order by modified desc
select name, company from `tabwarehouse` where disabled='0'
select count(name) from `tabfile` where `folder`='1bee6b5190'
select name from `tabrole` where desk_access='1'and name in ('Administrator', 'System Manager', 'Accounts Manager', 'Accounts User', 'All', 'Blogger', 'Guest', 'Knowledge Base Contributor', 'Knowledge Base Editor', 'Maintenance Manager', 'Maintenance User', 'Newsletter Manager', 'Purchase Manager', 'Purchase Master Manager', 'Purchase User', 'Report Manager', 'Sales Manager', 'Sales Master Manager', 'Sales User', 'Website Manager', 'Employee', 'Stock User', 'Auditor', 'Stock Manager', 'Manufacturing Manager', 'Supplier', 'Projects User', 'Projects Manager', 'HR User', 'Manufacturing User', 'Item Manager', 'HR Manager', 'Fleet Manager', 'Leave Approver', 'Expense Approver', 'Quality Manager', 'Support Team', 'Instructor', 'Customer', 'Student', 'Analytics', 'Accounts Manager', 'Analytics', 'Blogger', 'Fleet Manager', 'HR User', 'Item Manager', 'Knowledge Base Editor', 'Maintenance Manager', 'Manufacturing Manager', 'Newsletter Manager', 'Projects User', 'Purchase Master Manager', 'Quality Manager', 'Sales Manager', 'Sales User', 'Stock User', 'Support Team', 'Website Manager', '_Test Role') limit 1
select parent, fieldname, options from tabDocField where fieldtype='Dynamic Link'
select `owner` from `tabuser` where `name` = 'Administrator' order by modified desc
select `qty_after_transaction`, `stock_value` from `tabStock Ledger Entry` where `warehouse` = '_Test Warehouse - _TC' and `voucher_no` = '_T-Purchase Receipt-00003' and `voucher_type` = 'Purchase Receipt' and `item_code` = '_Test Item' order by modified desc
select * from `tabtodo` order by `tabtodo`.`modified` desc
select sum(required_qty - transferred_qty) from `tabProduction Order` pro, `tabProduction Order Item` item where item.item_code = '_Test Item Home Desktop 100' and item.parent = pro.name and pro.docstatus ='1'and pro.source_warehouse = '_Test Warehouse 2 - _TC'
select `name` from `tabaddress` where `name` = '_Test Address-Office' order by modified desc
select name from `tabitem` where `tabitem`.total_projected_qty < 0.0 order by `tabitem`.`idx` desc, `tabitem`.`modified` desc limit 0, 100
select name from `tabQuotation Item` where parent='_T-Quotation-00004' and parenttype='Quotation' and parentfield='items' and name not in ('QUOD/00007','QUOD/00008')
select * from `tabCustom DocPerm` where `tabCustom DocPerm`.parent = 'Industry Type' order by `tabCustom DocPerm`.`modified` ASC
select * from `tabPricing Rule` where (item_code='_Test Product Bundle Item' or ifnull(item_group, '') in ('_Test Item Group Desktops', 'All Item Groups') or brand=NULL) and docstatus < 2 and `tabPricing Rule`."disable" ='0'and selling ='1'and ifnull(company, '') in ('_Test Company', '') and ifnull(customer, '') in ('_Test Customer', '') and ifnull(supplier, '') = '' and ifnull(supplier_type, '') = '' and ifnull(campaign, '') = '' and ifnull(sales_partner, '') = '' and ifnull(customer_group, '') in ('_Test Customer Group', 'All Customer Groups', '') and ifnull(territory, '') in ('_Test Territory', 'All Territories', '') and ifnull(for_price_list, '') in ('Standard Selling', '') and '2017-02-09' between ifnull(valid_from, '2000-01-01') and ifnull(valid_upto, '2500-12-31') order by priority desc, name desc
select `name` from `tabCustomer Group` where `name` = 'Individual' order by modified desc
select name from `tabuserrole` where parent='Administrator' and parenttype='User' and parentfield='user_roles' and name not in ('840a017172','a8aeb4dda8','fb92eac658','2f0b4f7942','295edbfb91','ea3354d8bd','ae196db87f','14607b04e4','ee65d39cdb','9a873503c7','63ddbbc65d','550f629631','f88424d645','93962fb409','2776be196f','767caf1a89','eef45bb10b','8606e302fa','0dc15b9feb','d07210c929','15e0ff6ecd','4dabbc20ab','bbd0220737','8fc9cf07fb','4e3bdaa967','ff26dd60d4','e6e009ef82','bb58f2d291','0ae1a69f66','27d84ccc37','1953579051','e709bd7103','5d9817f9d9','9e29a83a26','d79f19b8c9','dcdf15a4fe','1403958824','713d246c3f','daa263b410','b28ba6a464','875ae75ef7','ec9342c5c5','9fe4d17ec6','73e83c7986','3ee9a82a34','5e989bb458','ea6432dcc4','bd33659b90','e9ebc25909','6c0b5d5cef')
select `name`, `parent`, `parenttype`, `docstatus` from `tabbudget` where `amended_from` = '_Test Cost Center - _TC/_Test Fiscal Year 2013/001' order by modified desc
select sum((dnpi_qty / so_item_qty) * (so_item_qty - so_item_delivered_qty)) from ( (select qty as dnpi_qty, ( select qty from `tabSales Order Item` where name = dnpi.parent_detail_docname and (delivered_by_supplier is null or delivered_by_supplier ='0' ) as so_item_qty, ( select delivered_qty from `tabSales Order Item` where name = dnpi.parent_detail_docname and delivered_by_supplier ='0') as so_item_delivered_qty, parent, name from ( select qty, parent_detail_docname, parent, name from `tabPacked Item` dnpi_in where item_code = '_Test Item' and warehouse = '_Test Warehouse - _TC' and parenttype='Sales Order' and item_code != parent_item and exists (select * from `tabSales Order` so where name = dnpi_in.parent and docstatus ='1'and status != 'Closed') ) dnpi) union (select qty as dnpi_qty, qty as so_item_qty, delivered_qty as so_item_delivered_qty, parent, name from `tabSales Order Item` so_item where item_code = '_Test Item' and warehouse = '_Test Warehouse - _TC' and (so_item.delivered_by_supplier is null or so_item.delivered_by_supplier ='0' and exists(select * from `tabSales Order` so where so.name = so_item.parent and so.docstatus ='1'and so.status != 'Closed')) ) tab where so_item_qty >= so_item_delivered_qty
select pr_item.item_code, pr_item.description, pr_item.qty, pr_item.base_rate, pr_item.base_amount, pr_item.name from `tabPurchase Receipt Item` pr_item where parent = '_T-Purchase Receipt-00003' and exists(select name from tabItem where name = pr_item.item_code and is_stock_item ='1'
select t1.name from `tabterritory` t1 where (select count(*) from `tabterritory` t2 where t2.lft < t1.lft and t2.rgt > t1.rgt) ='0'
select `costing_rate`, `billing_rate` from `tabActivity Cost` where `employee` = '_T-Employee-0001' and `activity_type` = '_Test Activity Type' order by modified desc
select `name` from `tabfile` where `is_attachments_folder` ='1'order by modified desc
select name, status, communication, message, sender, reference_doctype, reference_name, unsubscribe_param, unsubscribe_method, expose_recipients, show_as_cc from `tabEmail Queue` where name='72d13119ac' for update
select name, file_name from `tabfile` where `tabfile`.folder = '1bee6b5190' order by `tabfile`.`modified` desc
select `fixed_asset_account`, `accumulated_depreciation_account`, `depreciation_expense_account` from `tabAsset Category Account` where `company_name` = '_Test Company' and `parent` = 'Computers' order by modified desc
select `name` from `tabPayment Gateway Account` where `name` = '_Test Gateway - INR' order by modified desc
select * from `tabBlock Module` where `parenttype` = 'User' and `parent` = 'test_scheduler@example.com' and `parentfield` = 'block_modules' order by idx asc
select `name` from `tabopportunity` where `status` != 'Lost' and `lead` = '_T-Lead-00001' order by modified desc
select max(char_length(`parentfield`)) from `tabuser`
select `enabled` from `tabIntegration Service` where `name` = 'LDAP' order by modified desc
select `status` from `tabtask` where `name` = 'TASK00010' order by modified desc
select field, value from tabSingles where doctype='Notification Control'
select parent from `tabBOM Item` where bom_no = 'BOM-_Test PPT Item SC A-001'
select `tolerance` from `tabitem` where `name` = '_Test Product Bundle Item' order by modified desc
select distinct `reference_doctype`, parenttype from `tabIntegration Request` where `reference_doctype`='Role'
select * from `tabDesktop Icon` where `name` = 'a1d2a9f4b2' order by modified desc
select holiday_date from `tabholiday` where parent='Salary Slip Test Holiday List' and holiday_date >= '2017-02-09' and holiday_date <= '2017-02-15'
select employee, leave_type, from_date, to_date, total_leave_days from `tabLeave Application` where employee='_T-Employee-0002' and leave_type='_Test Leave Type' and status='Approved' and docstatus='1'and (from_date between '2013-01-01' and '2015-12-31' or to_date between '2013-01-01' and '2015-12-31' or (from_date < '2013-01-01' and to_date > '2015-12-31'))
select parent, (select is_primary_contact from tabContact c where c.name = dl.parent) as is_primary_contact from `tabDynamic Link` dl where dl.link_doctype='Customer' and dl.link_name='_Test Customer' and dl.parenttype = 'Contact'
select `delivered_by_supplier` from `tabSales Order Item` where `name` = '21b1167610' order by modified desc
select `lft`, `rgt` from `tabCost Center` where `name` = '_Test Cost Center - _TC' order by modified desc
select stock_uom, description from `tabitem` where disabled='0'and (end_of_life is null or end_of_life='0000-00-00' or end_of_life > '2017-02-09') and name='_Test FG Item'
select `tabaddress`.`name` from `tabaddress` order by `tabaddress`.`modified` DESC
select name from `tabuser`
select fb.item_code, ifnull(sum(fb.qty/ifnull(bom.quantity, 1)), 0) as qty, fb.description, fb.stock_uom, item.min_order_qty from `tabBOM Explosion Item` fb, `tabbom` bom, `tabitem` item where bom.name = fb.parent and item.name = fb.item_code and (item.is_sub_contracted_item ='0'or ifnull(item.default_bom, '')='') and item.is_stock_item ='1'and fb.docstatus<2 and bom.name='BOM-_Test PPT Item Master-001' group by fb.item_code, fb.stock_uom
select distinct party_type from `tabJournal Entry Account`
select `customer_name` from `tabcustomer` where `name` = '_Test Customer USD' order by modified desc
select `name` from `tabcommunication` where `communication_type` = 'Comment' and `reference_name` = '_Test Customer 1 Renamed' and `reference_doctype` = 'Customer' order by modified desc
select * from `tabPayment Reconciliation Invoice` where `parenttype` = 'Payment Reconciliation' and `parent` = 'Payment Reconciliation' and `parentfield` = 'invoices' order by idx asc
select parent FROM tabUserRole WHERE role='System Manager' AND parent!='Administrator' AND parent IN (SELECT email FROM tabUser WHERE enabled='1'
select * from `tabItem Attribute` where `name` = 'Test Size' order by modified desc
select max(char_length(`parent`)) from `tabevent`
select `customer`, `customer_name` from `tabDelivery Note` where `name` = 'DN-00015' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabProduction Plan Item` where `sales_order` = 'SO-00027' order by modified desc
select `docstatus` from `tabRequest for Quotation` where `name` = 'RFQ-00002' order by modified desc
select max(char_length(`first_name`)) from `tabuser`
select `name` from `tabEmail Unsubscribe` where `reference_doctype` = 'User' and `email` = 'test@example.com' and `reference_name` = 'Administrator' order by modified desc
select `password` from `__auth` where doctype='Email Account' and name='_Test Email Account 1' and fieldname='password' and encrypted='1'
select name from `tabItem Group` where ifnull(parent_item_group, '')='Services'
select name from `tabGL Entry` where voucher_type='Delivery Note' and voucher_no='DN-00030'
select `_comments` from `tabcustomer` where `name` = '_Test Customer 1' order by modified desc
select name from `tabproject` where `tabproject`.status = 'Open' and `tabproject`.customer = '_Test Customer USD' order by `tabproject`.`modified` desc limit 0, 1
select name from `tabPurchase Order Item` where parent='PO-00005' and parenttype='Purchase Order' and parentfield='items' and name not in ('cac0a55433')
select * from `tabProduct Bundle Item` where `parenttype` = 'Product Bundle' and `parent` = '_Test Product Bundle Item' and `parentfield` = 'items' order by idx asc
select max(char_length(`reference_name`)) from `tabtodo`
select `module`, `custom` from `tabdoctype` where `name` = 'Property Setter' order by modified desc
select `code` from `tabcountry` where `name` = 'India' order by modified desc
select task from `tabTask Depends On` where parent = 'TASK00010'
select * from `tabPOS Item Group` where `parenttype` = 'POS Profile' and `parent` = '6125d62f89' and `parentfield` = 'item_groups' order by idx asc
SELECT sum(debit) - sum(credit) FROM `tabGL Entry` gle WHERE posting_date <= '2013-02-14' and posting_date >= '2013-01-01' and voucher_type != 'Period Closing Voucher' and exists ( select name from `tabaccount` ac where ac.name = gle.account and ac.lft >='377'and ac.rgt <='386')
select `name`, `template` from `tabAddress Template` where `country` = 'India' order by modified desc
select activity_type, sum(hours) as total_hours from `tabTimesheet Detail` where project=NULL and docstatus < 2 group by activity_type order by total_hours desc
select name from `tabIntegration Service` where `tabIntegration Service`.enabled = 1.0 order by `tabIntegration Service`.`modified` DESC
select `production_item`, `qty` from `tabProduction Order` where `name` = 'PRO-00002' order by modified desc
select name from `tabPurchase Order Item Supplied` where parent='PO-00008' and parenttype='Purchase Order' and parentfield='supplied_items' and name not in ('e79888f684','bbfeee98df')
select pr_item.name, pr_item.amount, pr_item.parent from `tabPurchase Receipt Item` pr_item, `tabPurchase Receipt` pr where pr.name=pr_item.parent and pr_item.purchase_order_item='20bb7cad4e' and pr.docstatus='1'and pr.is_return ='0'order by pr.posting_date asc, pr.posting_time asc, pr.name asc
select `default_currency` from `tabcompany` where `name` = '_Test Company 1' order by modified desc
select max(char_length(`restrict_ip`)) from `tabuser`
select `advance_paid` from `tabSales Order` where `name` = 'SO-00032' order by modified desc
select * from `tabSalary Structure` where `name` = 'Daily Salary Structure Test for Salary Slip' order by modified desc
select `name` from `tabHoliday List` where `name` = '_Test Holiday List' order by modified desc
select name from `tabMode of Payment Account` where parent='Cash' and parenttype='Mode of Payment' and parentfield='accounts' and name not in ('c6ddfd123b','3a91ce4b16','bbb59610f6','2219838193','8865760296')
select options from `tabCustom Field` where fieldtype='Table' and parent='DocType'
select `name`, `parent`, `parenttype`, `docstatus` from `tabSales Order` where `amended_from` = 'SO-00026' order by modified desc
select `currency` from `tabDelivery Note` where `name` = 'DN-00021' order by modified desc
select name from `tabuser` where name > 's' order by modified desc
select `tabAuthorization Rule`.`transaction`, `tabAuthorization Rule`.`based_on`, `tabAuthorization Rule`.`master_name`, `tabAuthorization Rule`.`company`, `tabAuthorization Rule`.`system_role`, `tabAuthorization Rule`.`name`, `tabAuthorization Rule`.`modified`, `tabAuthorization Rule`.`docstatus` from `tabAuthorization Rule` where `tabAuthorization Rule`.approving_role = 'System Manager' order by `tabAuthorization Rule`.`modified` desc
select * from `tabtask` where `tabtask`.project = '_Test Project 1' order by exp_start_date asc
select `name` from `tabExpense Claim Type` where `name` = 'Food' order by modified desc
select `global_unsubscribe` from `tabEmail Unsubscribe` where `name` = '5b6fee6b2a' order by modified desc
select ifnull(max(rgt),0)+1 from `tabwarehouse` where ifnull(`parent_warehouse`,'') =''
select distinct purchase_document_type from `tabSerial No`
select `valuation_method` from `tabitem` where `name` = '_Test Regular Item' order by modified desc
select * from `tabcontact` where `name` = '_Test Contact for _Test Customer-_Test Customer' order by modified desc
select `disposal_account`, `depreciation_cost_center` from `tabcompany` where `name` = '_Test Company' order by modified desc
select name, min_order_qty from tabItem where name in ('_Test Item Home Desktop 200', '_Test Item Home Desktop 100')
select distinct sle.voucher_type, sle.voucher_no from `tabStock Ledger Entry` sle where timestamp(sle.posting_date, sle.posting_time) >= timestamp('2013-01-05', '07:00') and item_code in ('_Test Item') and warehouse in ('_Test Warehouse - _TC') order by timestamp(sle.posting_date, sle.posting_time) asc, name asc
select `name`, `parent`, `parenttype`, `docstatus` from `tabproject` where `sales_order` = 'SO-00026' order by modified desc
select * from `tabPortal Menu Item` where `parenttype` = 'Portal Settings' and `parent` = 'Portal Settings' and `parentfield` = 'custom_menu' order by idx asc
select `name`, `parent`, `parenttype`, `docstatus` from `tabPurchase Invoice` where `amended_from` = 'PINV-00005' order by modified desc
select * from `tabBOM Scrap Item` where `parenttype` = 'BOM' and `parent` = 'BOM-_Test PPT Item SC B-001' and `parentfield` = 'scrap_items' order by idx asc
select `name` from `tabtodo` where `name` = '7e8272a7a9' order by modified desc
select `name`, `email_server`, `smtp_port` from `tabEmail Domain` where `name` = 'example.com' order by modified desc
select * from `tabWeb Form Field` where `parenttype` = 'Web Form' and `parent` = 'manage-events' and `parentfield` = 'web_form_fields' order by idx asc
select modified, docstatus from `tabLanded Cost Voucher` where name = 'LCV00001' for update
select distinct `ref_type`, parenttype from `tabevent` where `ref_type`='Role'
select name from `tabMode of Payment Account` where parent='Cash' and parenttype='Mode of Payment' and parentfield='accounts' and name not in ('c6ddfd123b','3a91ce4b16','bbb59610f6')
select name from `tabDelivery Note` where `tabDelivery Note`.status not in ('Completed', 'Closed') and `tabDelivery Note`.docstatus < 2.0 order by `tabDelivery Note`.docstatus asc, `tabDelivery Note`.`modified` DESC limit 0, 100
select * from `tabGL Entry` where voucher_type='Stock Entry' and voucher_no='STE-00011'
select `name`, `parent`, `parenttype`, `docstatus` from `tabPurchase Receipt Item` where `purchase_order` = 'PO-00002' order by modified desc
select *, timestamp(posting_date, posting_time) as "timestamp" from `tabStock Ledger Entry` where item_code = '_Test Item Home Desktop 100' and warehouse = '_Test Warehouse 1 - _TC' and ifnull(is_cancelled, 'No')='No' and timestamp(posting_date, posting_time) > timestamp('2013-03-01', '00:00') and name!='SLE/00000083' order by timestamp(posting_date, posting_time) asc, name asc for update
select * from `tabEmployee Education` where `parenttype` = 'Employee' and `parent` = 'EMP-0005' and `parentfield` = 'education' order by idx asc
select sum(amount) from `tabPurchase Invoice Item` where po_detail='1534b0ea94' and (pr_detail is null or pr_detail = '') and docstatus='1'
select `owner` from `tabsupplier` where `name` = '_Test Supplier' order by modified desc
select name from `tabemployee` order by modified desc limit 1
select item_code, warehouse, actual_qty from `tabStock Ledger Entry` where voucher_type = 'Stock Entry' and voucher_no = 'STE-00010' order by item_code, warehouse, actual_qty
select modified, docstatus from `tabSales Invoice` where name = 'SINV-00010' for update
select name, rgt from `tabItem Group` where name in ('_Test Item Group B', 'All Item Groups')
select name from `tabSalary Slip` where docstatus!='2'and employee = 'EMP-0002' and start_date >= '2016-11-01' and end_date <= '2016-11-30' and company = 'Wind Power LLC'
select valuation_rate from `tabStock Ledger Entry` where item_code = '_Test Item' and warehouse = '_Test Warehouse - _TC' and valuation_rate > 0 order by posting_date desc, posting_time desc, name desc limit 1
select name from `tabuserrole` where parent='test@example.com' and parenttype='User' and parentfield='user_roles' and name not in ('a496d47242','329a1b58b9','b1b0e80e75','7d80cfb0a0','3dcca4543d','3b7e2e6e19','a8777daf10','d31a77e597','fbddc04fbe')
select name from `tabitem` item where variant_of='_Test Variant Item' and exists ( select name from `tabItem Variant Attribute` iv_attribute where iv_attribute.parent=item.name and ((iv_attribute.attribute='Test Size' and iv_attribute.attribute_value='Small')) and parent != '_Test Variant Item-S' )
select `inspection_required_before_delivery` from `tabitem` where `name` = '_Test Item' order by modified desc
select name from `tabStock Ledger Entry` limit 1
select `rate`, `project`, `item_code` from `tabSupplier Quotation Item` where `name` = 'b2008c66cd' order by modified desc
select account, debit, credit, against_voucher from `tabGL Entry` where voucher_type='Payment Entry' and voucher_no='PE-00006' order by account asc
select name, docstatus from `tabGL Entry` where against_voucher_type='Sales Invoice' and against_voucher='SINV-00013'
select `name` from `tabStock Entry` where `production_order` = 'PRO-00001' and `purpose` = 'Material Transfer for Manufacture' order by modified desc
select name, account_name, parent_account, account_type, is_group, root_type, tax_rate from `tabaccount` where `tabaccount`.company = '_Test Company' order by lft, rgt
select count(name) from `tabEmail Queue` where status='Sent' and MONTH(creation)=MONTH(CURDATE())
select route from `tabBlog Post` where ifnull(published,0)='1'
select sid from tabSessions where TIMEDIFF(NOW(), lastupdate) > TIME('720:00:00') and device = 'mobile'
select `name`, `parent`, `parenttype`, `docstatus` from `tabPurchase Invoice` where `return_against` = 'PINV-00005' order by modified desc
select `name` from `tablead` where `name` = '_T-Lead-00002' order by modified desc
select `name` from `tabitem` where `name` = '_Test Product Bundle Item' order by modified desc
select modified, docstatus from `tabProduction Order` where name = 'PRO-00010' for update
select name, blog_category from `tabBlog Post` where ((((ifnull(`tabBlog Post`.`blog_category`, '')='' or `tabBlog Post`.`blog_category` in ('_Test Blog Category 1'))))) order by `tabBlog Post`.`modified` desc
select * from `tabBlog Category` order by `tabBlog Category`.`modified` desc
select `currency` from `tabPrice List` where `name` = 'Standard Selling' order by modified desc
select `owner` from `tabMaterial Request` where `name` = '_T-Material Request-00010' order by modified desc
select distinct `party_type`, parenttype from `tabPayment Entry` where `party_type`='Role'
select parent, (select `is_shipping_address` from tabAddress a where a.name=dl.parent) as `is_shipping_address` from `tabDynamic Link` dl where link_doctype='Supplier' and link_name='_Test Supplier 1' and parenttype = 'Address'
select distinct test_ref_doc from `tabevent`
select name from `tabMaterial Request Item` where parent='MREQ-00003' and parenttype='Material Request' and parentfield='items' and name not in ('51f0693e95')
select max(char_length(`test_custom_field`)) from `tabuser`
select abbr from tabCompany where name!='India - Chart of Accounts' and abbr='7cQ'
select max(char_length(`modified_by`)) from `tabtodo`
select parent from `tabPayment Entry Reference` where reference_doctype='Journal Entry' and reference_name='JV-00015' and docstatus < 2
select `name` from `tabemployee` where `user_id` = 'Weekly_test_employee@salary.com' order by modified desc
select * from `tabProduction Order Item` where `parenttype` = 'Production Order' and `parent` = 'PRO-00008' and `parentfield` = 'required_items' order by idx asc
select po.name, po.transaction_date, po.conversion_rate, po_item.conversion_factor, po_item.base_price_list_rate, po_item.discount_percentage, po_item.base_rate from `tabPurchase Order` po, `tabPurchase Order Item` po_item where po.docstatus ='1'and po_item.item_code = '_Test Item for Drop Shipping' and po.name != 'PO-00013' and po.name = po_item.parent order by po.transaction_date desc, po.name desc limit 1
select `name` from `tabPrice List` where `selling` ='1'and `enabled` ='1'and `name` = '_Test Price List' order by modified desc
select `total_expense_claim` from `tabproject` where `name` = '_Test Project 1' order by modified desc
select `name` from `tabLeave Type` where `name` = '_Test Leave Type' order by modified desc
select `name` from `tabMaterial Request Item` where `name` = '409c143c61' order by modified desc
select * from `tabPurchase Taxes and Charges` where `name` = '6b9370559b' order by modified desc
select t1.account, t1.cost_center, t2.account_currency, sum(t1.debit_in_account_currency) - sum(t1.credit_in_account_currency) as balance_in_account_currency, sum(t1.debit) - sum(t1.credit) as balance_in_company_currency from `tabGL Entry` t1, `tabaccount` t2 where t1.account = t2.name and t2.report_type = 'Profit and Loss' and t2.docstatus < 2 and t2.company = '_Test Company' and t1.posting_date between '2017-01-01' and '2017-02-09' group by t1.account, t1.cost_center
select name from `tabSalary Detail` where parent='Sal Slip/EMP-0001/00003' and parenttype='Salary Slip' and parentfield='deductions' and name not in ('b9798ace74','5f8c7f25d7')
select `name` from `tabtask` where `project` = '_Test Project 1' order by modified desc
select `name` from `tabShipping Rule` where `name` = '_Test Shipping Rule - India' order by modified desc
select name from `tabEmail Alert` where event in ('Days Before', 'Days After') and enabled='1'
select distinct customer_or_item from `tabAuthorization Rule`
select name from `tabopportunity` where `tabopportunity`.status = 'Open' order by `tabopportunity`.`modified` DESC limit 0, 100
select `rgt` from `tabItem Group` where `name` = '_Test Item Group B' order by modified desc
select `expenses_included_in_valuation` from `tabcompany` where `name` = '_Test Company' order by modified desc
select `docstatus` from `tabLeave Application` where `name` = 'LAP/00007' order by modified desc
select sum(base_grand_total*(100 - per_billed)/100) from `tabSales Order` where customer='_Test Customer' and docstatus ='1'and company='_Test Company 1' and per_billed < 100 and status != 'Closed'
select `item_code`, `warehouse`, `idx` from `tabMaterial Request Item` where `name` = '409c143c61' and `parent` = '_T-Material Request-00003' order by modified desc
select name from `tabStock Reconciliation Item` where parent='SR/00003' and parenttype='Stock Reconciliation' and parentfield='items' and name not in ('7dc6966353')
select `username`, count(*) from `tabuser` group by `username` having count(*) > 1 limit 1
select sum(tsd.hours*60) as mins, sum(tsd.completed_qty) as completed_qty, min(tsd.from_time) as from_time, max(tsd.to_time) as to_time from `tabTimesheet Detail` as tsd, `tabtimesheet` as ts where ts.production_order = 'PRO-00001' and tsd.operation_id = 'd41f644502' and ts.docstatus='1'and ts.name = tsd.parent
select name from `tabMaterial Request Item` where parent='_T-Material Request-00011' and parenttype='Material Request' and parentfield='items' and name not in ('93cd71fd22','4928026fec')
select `cost_center` from `tabproject` where `name` = '_Test Project' order by modified desc
select modified, docstatus from `tabJournal Entry` where name = 'JV-00018' for update
select name from `tabItem Variant Attribute` where parent='_Test Variant Item' and parenttype='Item' and parentfield='attributes' and name not in ('66de29c1e4')
select name from `tabBOM Operation` where parent='BOM-_Test Variant Item-001' and parenttype='BOM' and parentfield='operations' and name not in ('99c05808b2')
select parent from `tabSalary Structure Employee` where employee='_T-Employee-0001' and parent in (select name from `tabSalary Structure` where is_active = 'Yes' and (from_date <= '2017-02-09' or from_date <= '2010-01-01') and (to_date is null or to_date >= '2017-02-09' or to_date >= NULL) )
select route, name, modified from `tabBlog Post` where published='1'and `route`='blog/-test-blog-category-1/-test-blog-post-1' limit 1
select * from `tabBlock Module` where parent='test@example.com' and parentfield='block_modules' order by idx
select name from `tabLanded Cost Taxes and Charges` where parent='STE-00017' and parenttype='Stock Entry' and parentfield='additional_costs' and name not in ('382ffe360f','0ed3aedda2')
select i.name from tabItem i, `tabProduct Bundle Item` pbi where pbi.parent = '_Test Mix Product Bundle' and pbi.item_code = i.name and i.is_stock_item ='1'
select name from `tabtodo` order by creation desc limit 0, 1
select operation, description, workstation, idx, base_hour_rate as hour_rate, time_in_mins, 'Pending' as status from `tabBOM Operation` where parent = 'BOM-_Test Variant Item-001' order by idx
select * from `tabproject` where `name` = '_Test Project 1' order by modified desc
select distinct party_type from `tabGL Entry`
select `owner` from `tabSupplier Quotation` where `name` = 'SQTN-00003' order by modified desc
select share_name from tabDocShare where (user='Administrator' or everyone='1' and share_doctype='Custom Field' and `read`='1'
select * from `tabTax Rule` where (from_date is null or from_date = '' or from_date <= 'None') and (to_date is null or to_date = '' or to_date >= 'None') and ifnull(customer, '') in ('', '_Test Customer') and ifnull(customer_group, '') in ('', '_Test Customer Group') and ifnull(supplier_type, '') in ('', '') and ifnull(company, '') in ('', '') and ifnull(tax_type, '') in ('', 'Sales')
select name from `tabquotation` where `tabquotation`.docstatus = 0.0 order by `tabquotation`.docstatus asc, `tabquotation`.`modified` DESC limit 0, 100
select * from `tabemployee` where `name` = 'EMP-0001' order by modified desc
select modified, docstatus from `tabrole` where name = 'Academics User' for update
select max(char_length(`owner`)) from `tabevent`
select name from `tabSalary Slip` where start_date = '2017-02-09' and end_date = '2017-02-09' and docstatus !='2'and employee = 'EMP-0006' and name != 'Sal Slip/EMP-0006/00001'
select * from `tabtask` where ifnull(`tabtask`.project, 0) ='0'order by exp_start_date asc
select * from `tabEmail Queue`
select name from `tabItem Reorder` where parent='_Test Item' and parenttype='Item' and parentfield='reorder_levels' and name not in ('876358622c')
select max(char_length(`last_ip`)) from `tabuser`
select max(char_length(`parenttype`)) from `tabtodo`
select sum(gle.debit) - sum(gle.credit) from `tabGL Entry` gle where gle.account='_Test Account Cost for Goods Sold - _TC' and gle.posting_date <= '2013-02-28' and gle.fiscal_year='_Test Fiscal Year 2013' and gle.company='_Test Company' and gle.docstatus='1'and exists(select name from `tabproject` where name=gle.project)
select owner, description from `tabtodo` where reference_type='ToDo' and reference_name='9b6df46a09' and status='Open' order by modified desc limit 5
select count(*) from `tabuser`
select `name`, `parent`, `parenttype`, `docstatus` from `tabPurchase Order` where `recurring_id` = 'PO-00002' order by modified desc
select name from `tabSales Order` where docstatus='1'and base_net_total ='0'
select `instructor_name` from `tabinstructor` where `name` = '_T-Instructor-00002' order by modified desc
select `actual_qty`, `projected_qty` from `tabbin` where `warehouse` = '_Test Warehouse - _TC' and `item_code` = '_Test Item' order by modified desc
select `description`, `stock_uom`, `item_name` from `tabitem` where `name` = '_Test PPT Item Sub C' order by modified desc
select distinct share_doctype from `tabdocshare`
select fieldname from `tabCustom Field` where `tabCustom Field`.dt = 'Project Task' order by `tabCustom Field`.`modified` desc
select name, company from tabWarehouse
select sum(purchase_rate) from `tabSerial No` where name in ('ABCD00005')
select count(*) from `tabfile` where `content_hash` = '012c41297324929dee9081dc18c9f0f3' and `name` != '1bee6b5190'
select * from `tabStock Entry` where `name` = 'STE-00009' order by modified desc
select name, year_start_date, year_end_date from `tabFiscal Year` where name!='_Test Fiscal Year 2017'
select name from `tabLanded Cost Item` where parent='LCV00002' and parenttype='Landed Cost Voucher' and parentfield='items' and name not in ('b8f5121122')
select `_comments` from `tabSales Order` where `name` = 'SO-00034' order by modified desc
select * from `tabItem Website Specification` where `parenttype` = 'Item' and `parent` = '_Test PPT Item Raw C' and `parentfield` = 'website_specifications' order by idx asc
select module_name, hidden, label, link, type, icon, color, _doctype, idx, force_show, reverse, custom, standard, blocked from `tabDesktop Icon` where `tabDesktop Icon`.standard = 1.0 order by `tabDesktop Icon`.`modified` DESC
select name from tabAccount where account_type='Stock' and company='_Test Company' and is_group='1'and (warehouse is null or warehouse = '')
select * from `tabVehicle Service` where `parenttype` = 'Vehicle Log' and `parent` = 'VLOG00001' and `parentfield` = 'service_detail' order by idx asc
select `status` from `tabPurchase Order` where `name` = 'PO-00006' order by modified desc
select 'Journal Entry' as reference_type, t1.name as reference_name, t1.remark as remarks, t2.credit_in_account_currency as amount, t2.name as reference_row, t2.reference_name as against_order from `tabJournal Entry` t1, `tabJournal Entry Account` t2 where t1.name = t2.parent and t2.account = 'Debtors - _TC' and t2.party_type = 'Customer' and t2.party = '_Test Customer' and t2.is_advance = 'Yes' and t1.docstatus ='1'and credit_in_account_currency > 0 and (ifnull(t2.reference_name, '')='') order by t1.posting_date
select max(char_length(`reset_password_key`)) from `tabuser`
select `name`, `parent`, `parenttype`, `docstatus` from `tabAsset Movement` where `asset` = 'Macbook Pro 1' order by modified desc
select * from `tabPricing Rule` where (item_code='_Test Item' or ifnull(item_group, '') in ('All Item Groups', '_Test Item Group') or brand=NULL) and docstatus < 2 and `tabPricing Rule`."disable" ='0'and selling ='1'and ifnull(company, '') in ('_Test Company', '') and ifnull(customer, '') in ('_Test Customer 1', '') and ifnull(supplier, '') = '' and ifnull(supplier_type, '') = '' and ifnull(campaign, '') in ('_Test Campaign', '') and ifnull(sales_partner, '') = '' and ifnull(customer_group, '') in ('_Test Customer Group', 'All Customer Groups', '') and ifnull(territory, '') in ('_Test Territory', 'All Territories', '') and ifnull(for_price_list, '') in ('_Test Price List', '') order by priority desc, name desc
select `name` from `tabEmail Account` where `enable_incoming` ='1'and `enable_outgoing` ='1'and `append_to` = 'Event' order by modified desc
select `docstatus` from `tabSales Order` where `name` = 'SO-00032' order by modified desc
select name from `tabholiday` where parent='Salary Structure Test Holiday List' and parenttype='Holiday List' and parentfield='holidays' and name not in ('727c08c6e0','56d431f452','306f233327','995c515360','9a7f4da953','e1389fce0e','b51d0f1250','2804ea82d7','f1fcf5aa19','8a3970b44d','000be7619c','231b246a76','53cfcdf1fc','63eb13f815','9404ba9e57','70e0e133e1','017f4082ef','31c668d43e','f4cbd8ad72','d0cefa83e0','7bc478748e','b16ccf47cd','280ad40bd1','88b456f237','3586b57cce','96b67aa426','444ffe39c7','c46ff02f29','e2182769be','31b6f243a8','bf6cd39b51','00880228cf','3897e9311a','8bb40fd78b','a21dd5c3f3','e237a1fc69','c297a6dba3','ff3981f0cc','754b3d2a66','1ee2bd80d1','e585a5024f','00ae1a2520','56651604d0','45733c03d4','1464aa135e','dc58d41e17','efc1a3c1b9','96527f9136','693a2f84fb','39f6571c4e','982820d718','73d8d6f4c0')
select sum(amount) from `tabPurchase Invoice Item` where pr_detail='dca5ce203a' and docstatus='1'and parent != 'PINV-00003'
select year_start_date, year_end_date from `tabFiscal Year` where name='2011'
select `name` from `tabIntegration Service` where `name` = 'Dropbox' order by modified desc
select `name` from `tabcountry` where `name` = 'India' order by modified desc
select `account_currency`, `account_type` from `tabaccount` where `name` = '_Test Cash - _TC' order by modified desc
select modified, docstatus from `tabcontact` where name = '_Test Contact for _Test Customer-_Test Customer' for update
select name from `tabPurchase Receipt` where `tabPurchase Receipt`.status not in ('Completed', 'Closed') and `tabPurchase Receipt`.docstatus < 2.0 order by `tabPurchase Receipt`.docstatus asc, `tabPurchase Receipt`.`modified` DESC limit 0, 100
select `name` from `tabPOS Profile` where `name` = '_Test POS Profile' order by modified desc
select stock_uom, description, image, item_name, expense_account, buying_cost_center, item_group from `tabitem` where name = '_Test Item 2' and disabled='0'and (end_of_life is null or end_of_life='0000-00-00' or end_of_life > '2017-02-09')
select name from `tabwarehouse` where name='Test Warehouse for Renaming 2 - _TC' for update
SELECT name FROM `tabItem Group` WHERE `parent_item_group`='_Test Item Group A'
select modified, docstatus from `tabEmail Account` where name = 'Test Email Account Password' for update
select * from `tabCustomer Group` where `name` = '_Test Customer Group 1' order by modified desc
select `project`, `uom`, `item_code` from `tabPurchase Order Item` where `name` = 'e82e694e0b' order by modified desc
select * from tabUser where name='test@example.com'
select `name`, `parent`, `parenttype`, `docstatus` from `tabStock Entry` where `delivery_note_no` = 'DN-00029' order by modified desc
select `has_variants` from `tabitem` where `name` = '_Test Variant Item-L' order by modified desc
select i.name, iva.attribute_value as value from `tabItem Variant Attribute` iva, `tabitem` i where iva.attribute = 'Test Colour' and iva.parent = i.name and i.has_variants ='0'
select t2.item_code, t2.qty / ifnull(t1.quantity, 1) as qty_consumed_per_unit, t2.rate, t2.stock_uom, t2.name, t2.description from `tabbom` t1, `tabBOM Item` t2, tabItem t3 where t2.parent = t1.name and t1.item = '_Test FG Item' and t1.docstatus ='1'and t1.is_active ='1'and t1.name = 'BOM-_Test FG Item-001' and t2.item_code = t3.name and t3.is_stock_item ='1'
select sum(gle.debit) - sum(gle.credit) from `tabGL Entry` gle where gle.account='_Test Account Cost for Goods Sold - _TC' and gle.fiscal_year='_Test Fiscal Year 2013' and gle.company='_Test Company' and gle.docstatus='1'and exists(select name from `tabproject` where name=gle.project)
select name, docstatus, parent, parenttype, idx from `tabLanded Cost Item` where receipt_document_type='Purchase Receipt' and receipt_document='PREC-00012'
select `default_price_list` from `tabsupplier` where `name` = '_Test Supplier' order by modified desc
select lft, rgt from `tabterritory` where name='All Territories'
select * from `tabUser Email` where `parenttype` = 'User' and `parent` = 'test@erpnext.com' and `parentfield` = 'user_emails' order by idx asc
select `owner` from `tabDelivery Note` where `name` = 'DN-00004' order by modified desc
select sum(total_sanctioned_amount) from `tabExpense Claim` where project = '_Test Project 1' and task = 'TASK00014' and approval_status = 'Approved' and docstatus='1'
select `leave_block_list` from `tabdepartment` where `name` = '_Test Department 1' order by modified desc
select name from `tabbom` where `tabbom`.docstatus = 0.0 order by `tabbom`.docstatus asc, `tabbom`.`modified` DESC limit 0, 100
select name from `tabLanded Cost Item` where parent='LCV00003' and parenttype='Landed Cost Voucher' and parentfield='items' and name not in ('628be0d3d8','7660d873e6')
select `company` from `tabaccount` where `name` = 'Sales - WP' order by modified desc
select item_code, warehouse, projected_qty from tabBin where item_code in ('_Test Item', '_Test Item Warehouse Group Wise Reorder') and (warehouse != '' and warehouse is not null)
select account, debit, credit from `tabGL Entry` where voucher_type='Stock Entry' and voucher_no='STE-00009' order by account asc, debit asc
select * from `tabnewsletter` where `name` = '_Test Newsletter' order by modified desc
select name, subject from `tabevent` where `tabevent`.subject like '_Test Event%%' and (((tabEvent.event_type='Public' or tabEvent.owner='test1@example.com' or exists(select * from `tabEvent Role` where `tabEvent Role`.parent=tabEvent.name and `tabEvent Role`.role in ('Employee', 'All', 'Guest'))) ) or (`tabevent`.name in ('EV00003'))) order by `tabevent`.`modified` desc
select name from `tabAcademic Term` where academic_year= '2014-2015' and term_name= '_Test Academic Term 1' and docstatus<2 and name != '2014-2015 (_Test Academic Term 1)'
select name from `tabitem` where name in ('_Test Item', '_Test Item Home Desktop 100', '_Test FG Item') and is_stock_item='1'
select dt from `tabCustom Field` where (fieldtype='Table' and options='Role')
select `owner` from `tabWeb Page` where `name` = 'test-web-page-3' order by modified desc
select `is_standard` from `tabreport` where `name` = 'User Activity Report' order by modified desc
select * from `tabcustomer` where `name` = 'test_cart_user' order by modified desc
select name, personal_email, company_email, user_id, employee_name from tabEmployee where day(date_of_birth) = day('2017-02-09') and month(date_of_birth) = month('2017-02-09') and status = 'Active'
select max(char_length(`full_name`)) from `tabuser`
select name from `tabproject` where `tabproject`.status = 'Open' order by `tabproject`.`modified` desc limit 0, 100
select `name` from `tabSalary Slip` where `start_date` = '2016-11-01' and `end_date` = '2016-11-30' order by modified desc
select name from `tabitem` where name='Test Item for Merging 2' for update
select owner from `tabtodo` where `tabtodo`.status = 'Open' and `tabtodo`.reference_name = 'TASK00009' and `tabtodo`.reference_type = 'Task' order by `tabtodo`.`modified` desc
select distinct `party_type`, parenttype from `tabGL Entry` where `party_type`='Role'
select name from `tabwarehouse` where `company` = '_Test Company' and `name` = '_Test Warehouse - _TC'
select `owner` from `tabPurchase Receipt` where `name` = 'PREC-00008' order by modified desc
select child.item_code, sum(abs(child.qty)) as qty from `tabSales Invoice Item` child, `tabSales Invoice` par where child.parent = par.name and par.docstatus ='1'and par.is_return ='1'and par.return_against = 'SINV-00017' group by child.item_code
select child.item_code, sum(abs(child.qty)) as qty, sum(abs(child.rejected_qty)) as rejected_qty, sum(abs(child.received_qty)) as received_qty from `tabPurchase Receipt Item` child, `tabPurchase Receipt` par where child.parent = par.name and par.docstatus ='1'and par.is_return ='1'and par.return_against = 'PREC-00006' group by child.item_code
select t1.name from `tabMaintenance Schedule` t1, `tabMaintenance Schedule Item` t2 where t2.parent=t1.name and t2.sales_order = 'SO-00027' and t1.docstatus ='1'
select name from `tabCustomer Group` where lft <='1'and rgt >='8'
select * from `tabJournal Entry Account` where account = '_Test Receivable - _TC' and docstatus ='1'and parent = '_T-Journal Entry-00004' and (reference_type is null or reference_type in ('', 'Sales Order', 'Purchase Order'))
select * from `tabCustom DocPerm` where docstatus='0'and ifnull(permlevel,0)='0'and role in ('Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest')
select * from `tabPurchase Order` where `name` = 'PO-00003' order by modified desc
select max(char_length(`middle_name`)) from `tabuser`
select `item_group`, `brand` from `tabitem` where `name` = '_Test Regular Item' order by modified desc
select `name` from `tabMode of Payment` where `type` = 'Cash' order by modified desc
select item_code from `tabitem` where `tabitem`.variant_of = '_Test Variant Item' order by `tabitem`.`idx` desc, `tabitem`.`modified` desc
select `actual_qty` from `tabbin` where `warehouse` = '_Test Warehouse - _TC' and `item_code` = '_Test Regular Item' order by modified desc
select `status` from `tabPurchase Receipt` where `name` = 'PREC-00001' order by modified desc
select distinct item_code, warehouse from `tabStock Ledger Entry` where voucher_type='Stock Reconciliation' and voucher_no='SR/00004'
select salary_component_abbr from `tabSalary Component` order by `tabSalary Component`.`modified` DESC
select distinct reference_type from `tabJournal Entry Account`
select `supplier_part_no` from `tabItem Supplier` where `supplier` = '_Test Supplier' and `parent` = '_Test Item' order by modified desc
select name from `tabPurchase Receipt Item Supplied` where parent='PREC-00013' and parenttype='Purchase Receipt' and parentfield='supplied_items' and name not in ('a9bb4be126','2c307ec3bb')
select `name` from `tabDynamic Link` where `parenttype` = 'Address' and `link_name` = '_Test Lead' and `link_doctype` = 'Lead' order by modified desc
select sum((po_item.qty - po_item.received_qty)*po_item.conversion_factor) from `tabPurchase Order Item` po_item, `tabPurchase Order` po where po_item.item_code='_Test Item Home Desktop 100' and po_item.warehouse='_Test Warehouse - _TC' and po_item.qty > po_item.received_qty and po_item.parent=po.name and po.status not in ('Closed', 'Delivered') and po.docstatus='1'and po_item.delivered_by_supplier ='0'
select `name` from `tabSupplier Type` where `name` = '_Test Supplier Type' order by modified desc
select name, subject, description, starts_on, ends_on, owner, all_day, event_type, repeat_this_event, repeat_on,repeat_till, monday, tuesday, wednesday, thursday, friday, saturday, sunday from tabEvent where (( (date(starts_on) between date('2017-02-09') and date('2017-02-09')) or (date(ends_on) between date('2017-02-09') and date('2017-02-09')) or (date(starts_on) <= date('2017-02-09') and date(ends_on) >= date('2017-02-09')) ) or ( date(starts_on) <= date('2017-02-09') and repeat_this_event='1'and ifnull(repeat_till, '3000-01-01') > date('2017-02-09') )) and (event_type='Public' or owner='Administrator' or exists(select name from `tabdocshare` where tabDocShare.share_doctype='Event' and `tabdocshare`.share_name=tabEvent.name and tabDocShare.user='Administrator') or exists(select * from `tabEvent Role` where `tabEvent Role`.parent=tabEvent.name and `tabEvent Role`.role in ('Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest'))) order by starts_on
select `enabled` from `tabuser` where `name` = 'test_deactivate_additional_users@example.com' order by modified desc
select `name` from `tabTax Rule` where `use_for_shopping_cart` ='1'and `name` != 'TR0003' order by modified desc
select * from `tabRequest for Quotation Item` where `parenttype` = 'Request for Quotation' and `parent` = 'RFQ-00001' and `parentfield` = 'items' order by idx asc
select `company` from `tabwarehouse` where `name` = 'Stores - _TC' order by modified desc
select name from `tabJournal Entry Account` where reference_type = 'Journal Entry' and reference_name = '_T-Journal Entry-00004'
select `name` from `tabevent` where `name` = 'EV00016' order by modified desc
select name from `tabJournal Entry Account` where parent='JV-00012' and parenttype='Journal Entry' and parentfield='accounts' and name not in ('0881ce0dd9','f7a303a61e')
select name from `tabCost Center` where lft <='5'and rgt >='8'
select share_name from tabDocShare where (user='Guest' ) and share_doctype='Event' and `read`='1'
select `inspection_required_before_purchase` from `tabitem` where `name` = '_Test Serialized Item With Series' order by modified desc
select `scrap_warehouse`, `qty`, `produced_qty`, `bom_no` from `tabProduction Order` where `name` = 'PRO-00010' order by modified desc
select item_code, `qty`, `received_qty`, parenttype, parent from `tabPurchase Order Item` where `qty` < `received_qty` and name='1534b0ea94' and docstatus='1'
select * from `tabProduction Plan Sales Order` where `parenttype` = 'Production Planning Tool' and `parent` = 'Production Planning Tool' and `parentfield` = 'sales_orders' order by idx asc
select * from `tabRequest for Quotation Supplier` where `parenttype` = 'Request for Quotation' and `parent` = 'RFQ-00001' and `parentfield` = 'suppliers' order by idx asc
select `name` from `tabMaterial Request` where `name` = '_T-Material Request-00009' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabPurchase Order` where `amended_from` = 'PO-00014' order by modified desc
select * from `tabSales Invoice Payment` where `parenttype` = 'Sales Invoice' and `parent` = 'SINV-00007' and `parentfield` = 'payments' order by idx asc
select `name` from `tabMode of Payment Account` where `company` = 'Wind Power LLC' order by modified desc
select name from `tabuserrole` where parent='test@erpnext.com' and parenttype='User' and parentfield='user_roles' and name not in ('7b30e900a1','59d95bd292','b444c1e880','cd89003e89','f03e2c7c05','f63793e6bc','f94ad98652','07b2ef596e','812e5ca9dd','e8059e4180','edff6111cc','ffd2cef4d4','b1af3e03ea','a9b7693679','d01b1293b3','ea2d1137d6','82ae1a39ae','71825e66b8','d37be6c148','21ab88db6a','5e10abc8b6','bae9c55e5a','c295a67d32','313eb36ee8','9f1e316d28','f7310205c3','5be3ecae94','aff3c6c432','5a857c3f13','d071c344a0','32ee429964','8c875a2d2f','d97ba93d5c','b0defe0a18','0b6815e387','2490097f42')
select * from `tabSalary Component` where `name` = 'HRA' order by modified desc
select name, `currency` from `tabPrice List` where name in ('Standard Selling')
select `name`, `parent`, `parenttype`, `docstatus` from `tabSales Order` where `recurring_id` = 'SO-00026' order by modified desc
select * from `tabDaily Work Summary Settings Company` where `parenttype` = 'Daily Work Summary Settings' and `parent` = 'Daily Work Summary Settings' and `parentfield` = 'companies' order by idx asc
select * from `tabcommunication` where `name` = 'fb8c4feea4' order by modified desc
select max(char_length(`parentfield`)) from `tabevent`
select distinct reference_doctype from `tabIntegration Request`
select `variant_of` from `tabitem` where `name` = '_Test Item Home Desktop 100' order by modified desc
select name, from_time, to_time from `tabCourse Schedule` where `instructor`='_T-Instructor-00001' and schedule_date = '2017-02-09' and ( (from_time > '4:00:00' and from_time < '5:00:00') or (to_time > '4:00:00' and to_time < '5:00:00') or ('4:00:00' > from_time and '4:00:00' < to_time) or ('4:00:00' = from_time and '5:00:00' = to_time)) and name!='SH00043'
select name from `tabitem` where has_serial_no='1'and name in ('_Test Item', '_Test Item Home Desktop 100')
select `tabopportunity`.`name` from `tabopportunity` where `tabopportunity`.lead = '_T-Lead-00001' order by `tabopportunity`.`modified` DESC
select `name` from `tabbudget` where `project` = '_Test Project' and `docstatus` !='2'and `company` = '_Test Company' and `fiscal_year` = '_Test Fiscal Year 2013' and `name` != '_Test Project/_Test Fiscal Year 2013/001' order by modified desc
select name from `tabPurchase Order Item` where parent='PO-00001' and parenttype='Purchase Order' and parentfield='items' and name not in ('c8c0b3ee72','ab62ad5a18')
select debit - credit from `tabGL Entry` where voucher_type='Period Closing Voucher' and voucher_no='PCE/001' and account = '_Test Account Reserves and Surplus - _TC'
select max(char_length(`language`)) from `tabuser`
select name, parent, billing_hours, billing_amount as billing_amt from `tabTimesheet Detail` where docstatus='1'and project = '_Test Project' and billable ='1'and sales_invoice is null
select * from `tablead` where `name` = '_T-Lead-00001' order by modified desc
select name, subject, description, starts_on, ends_on, owner, all_day, event_type, repeat_this_event, repeat_on,repeat_till, monday, tuesday, wednesday, thursday, friday, saturday, sunday from tabEvent where (( (date(starts_on) between date('2017-02-09') and date('2017-02-09')) or (date(ends_on) between date('2017-02-09') and date('2017-02-09')) or (date(starts_on) <= date('2017-02-09') and date(ends_on) >= date('2017-02-09')) ) or ( date(starts_on) <= date('2017-02-09') and repeat_this_event='1'and ifnull(repeat_till, '3000-01-01') > date('2017-02-09') )) and ifnull(send_reminder,0)='1'and (event_type='Public' or owner='test2@example.com' or exists(select name from `tabdocshare` where tabDocShare.share_doctype='Event' and `tabdocshare`.share_name=tabEvent.name and tabDocShare.user='test2@example.com') or exists(select * from `tabEvent Role` where `tabEvent Role`.parent=tabEvent.name and `tabEvent Role`.role in ('Employee', 'All', 'Guest'))) order by starts_on
select * from `tabversion` where `name` = '4b313b3a14' order by modified desc
select `name` from `tabSales Taxes and Charges Template` where `name` = '_Test Sales Taxes and Charges Template 1' order by modified desc
select modified, docstatus from `tabsupplier` where name = '_Test Supplier USD' for update
select * from `tabSalary Detail` where `parenttype` = 'Salary Slip' and `parent` = 'Sal Slip/EMP-0001/00005' and `parentfield` = 'deductions' order by idx asc
select `name` from `tabWeb Page` where `name` = 'test-web-page-3' order by modified desc
select `name` from `tabJournal Entry` where `name` = 'JV-00007' order by modified desc
select * from `tabWebsite Theme` where `name` = 'Standard' order by modified desc
select module_name from `tabDesktop Icon` where `tabDesktop Icon`.standard = 1.0 order by `tabDesktop Icon`.`modified` DESC
select name, recipient, status from `tabEmail Queue Recipient` where parent='72d13119ac'
select count(name) from tabTask where project='_Test Project 1'
select parent, fieldname from tabDocField where (fieldtype='Link' and options='Role') or (fieldtype='Select' and options='link:Role')
select `owner` from `tabBlog Post` where `name` = '-test-blog-post-2' order by modified desc
select `is_group` from `tabItem Group` where `name` = '_Test Item Group C' order by modified desc
select `lft`, `rgt` from `tabfile` where `name` = 'Home/Attachments' order by modified desc
select name from tabAccount where account_type = 'Stock' and (warehouse != '' and warehouse is not null) and is_group='0'
select `name` from `tabdepartment` where `name` = '_Test Department 1' order by modified desc
select b.cost_center, ba.budget_amount, b.monthly_distribution, b.action_if_annual_budget_exceeded, b.action_if_accumulated_monthly_budget_exceeded from `tabbudget` b, `tabBudget Account` ba where b.name=ba.parent and b.fiscal_year=NULL and ba.account='_Test Write Off - _TC' and b.docstatus='1'and exists(select name from `tabCost Center` where lft<='8'and rgt>='9'and name=b.cost_center)
select name from `tabSales Invoice` where `tabSales Invoice`.customer = 'Party Status Test' and ifnull(`tabSales Invoice`.docstatus, 0) < 2.0 and `tabSales Invoice`.outstanding_amount > 0.0 order by `tabSales Invoice`.docstatus asc, `tabSales Invoice`.`modified` DESC limit 0, 1
select 'Journal Entry' as reference_type, t1.name as reference_name, t1.remark as remarks, t2.credit_in_account_currency as amount, t2.name as reference_row, t2.reference_name as against_order from `tabJournal Entry` t1, `tabJournal Entry Account` t2 where t1.name = t2.parent and t2.account = 'Debtors - _TC' and t2.party_type = 'Customer' and t2.party = '_Test Customer' and t2.is_advance = 'Yes' and t1.docstatus ='1'and credit_in_account_currency > 0 and ( (t2.reference_type = 'Sales Order' and ifnull(t2.reference_name, '') in ('SO-00003'))) order by t1.posting_date
select `name`, `parent`, `parenttype`, `docstatus` from `tabquotation` where `amended_from` = 'QTN-00005' order by modified desc
select * from `tabGL Entry` where posting_date >= '2012-12-26' and voucher_no in ('STE-00007', 'STE-00010')
select fieldname, fieldtype from `tabdocfield` where `tabdocfield`.parent = 'DocType' and (`tabdocfield`.fieldtype = 'Table' or `tabdocfield`.fieldtype = 'Select') order by `tabdocfield`.`modified` desc
select `name` from `tabaccount` where `warehouse` = 'Test Warehouse for Renaming 3 - _TC' order by modified desc
select dt as parent, fieldname, options from `tabCustom Field` where fieldtype='Dynamic Link'
select modified, docstatus from `tabbatch` where name = '_test Batch' for update
select account_currency, sum(credit_in_account_currency) as amount from `tabGL Entry` where against_voucher_type = 'Sales Order' and against_voucher = 'SO-00034' and party='_Test Customer' and docstatus ='1'
select parent from `tabTask Depends On` where task = 'TASK00002'
select `fraction` from `tabcurrency` where `name` = 'INR' order by modified desc
select name from `tabSupplier Quotation Item` where parent='_T-Supplier Quotation-00002' and parenttype='Supplier Quotation' and parentfield='items' and name not in ('b2008c66cd')
select name from `tabMode of Payment Account` where parent='Cash' and parenttype='Mode of Payment' and parentfield='accounts' and name not in ('c6ddfd123b','3a91ce4b16','bbb59610f6','2219838193')
select `owner` from `tabproject` where `name` = '_Test Project' order by modified desc
select `owner`, `status` from `tabtodo` where `reference_name` = 'TASK00009' and `reference_type` = 'Task' and `description` = 'Close this task' order by modified desc
select `item_name`, `description`, `stock_uom`, `expense_account`, `buying_cost_center`, `name`, `default_warehouse` from `tabitem` where `name` = '_Test Variant Item-S' order by modified desc
select `currency` from `tabPurchase Order` where `name` = 'PO-00004' order by modified desc
select * from `tabPayment Request` where `name` = 'PR00002' order by modified desc
select max(char_length(`phone`)) from `tabuser`
select name from `tabrole` where desk_access='1'and name in ('_Test Role', 'System Manager', 'Employee', 'Blogger', '_Test Role 3', '_Test Role 2', 'Website Manager', 'Sales User', 'Stock User') limit 1
select * from `tabNote Seen By` where `parenttype` = 'Note' and `parent` = 'test note' and `parentfield` = 'seen_by' order by idx asc
SELECT sum(debit_in_account_currency) - sum(credit_in_account_currency) FROM `tabGL Entry` gle WHERE posting_date <= '2017-02-09' and gle.party_type = 'Customer' and gle.party = '_Test Customer' and gle.company = '_Test Company'
select name from tabLead where email_id='test_lead3@example.com' and name!='_T-Lead-00004'
select `tabEmail Alert`.`subject`, `tabEmail Alert`.`document_type`, `tabEmail Alert`.`event`, `tabEmail Alert`.`condition`, `tabEmail Alert`.`name`, `tabEmail Alert`.`modified`, `tabEmail Alert`.`docstatus` from `tabEmail Alert` left join `tabEmail Alert Recipient` on (`tabEmail Alert Recipient`.parent = `tabEmail Alert`.name) where `tabEmail Alert Recipient`.email_by_role = 'System Manager' order by `tabEmail Alert`.`modified` DESC
select distinct `receipt_document_type`, parenttype from `tabLanded Cost Item` where `receipt_document_type`='Role'
select modified, docstatus from `tabproject` where name = '_Test Project' for update
select `supplier`, `supplier_name` from `tabPurchase Receipt` where `name` = '_T-Purchase Receipt-00006' order by modified desc
select dn_item.name, dn_item.amount, dn.base_net_total, dn.base_grand_total from `tabDelivery Note` dn, `tabDelivery Note Item` dn_item where dn.name = dn_item.parent and dn.customer='_Test Customer' and dn.company='_Test Company' and dn.docstatus ='1'and dn.status not in ('Closed', 'Stopped') and ifnull(dn_item.against_sales_order, '') = '' and ifnull(dn_item.against_sales_invoice, '') = ''
select name from `tabSales Order` where ifnull(`tabSales Order`.status, '') not in ('Completed', 'Closed') and ifnull(`tabSales Order`.docstatus, 0) < 2.0 and `tabSales Order`.customer = '_Test Customer 1 - 1' order by `tabSales Order`.docstatus asc, `tabSales Order`.`modified` DESC limit 0, 1
select modified, docstatus from `tabDelivery Note` where name = 'DN-00003' for update
select * from `tabasset` where `name` = 'Macbook Pro 1' order by modified desc
select ifnull(max(rgt),0)+1 from `tabCustomer Group` where ifnull(`parent_customer_group`,'') =''
select name from `tabTask Depends On` where parent='TASK00012' and parenttype='Task' and parentfield='depends_on' and name not in ('ccbf8901af')
select * from `tabuserrole` where `parenttype` = 'User' and `parent` = 'test-for-type@example.com' and `parentfield` = 'user_roles' order by idx asc
select `default_receivable_account` from `tabcompany` where `name` = '_Test Company 1' order by modified desc
select `name` from `tabbom` where `name` = 'BOM-_Test Variant Item-001' order by modified desc
select * from `tabPayment Reconciliation Payment` where `parenttype` = 'Payment Reconciliation' and `parent` = 'Payment Reconciliation' and `parentfield` = 'payments' order by idx asc
SELECT bom_item.item_code, default_material_request_type, ifnull(1 * sum(bom_item.qty/ifnull(bom.quantity, 1)), 0) as qty, item.is_sub_contracted_item as is_sub_contracted, item.default_bom as default_bom, bom_item.description as description, bom_item.stock_uom as stock_uom, item.min_order_qty as min_order_qty FROM `tabBOM Item` bom_item, `tabbom` bom, tabItem item where bom.name = bom_item.parent and bom.name = 'BOM-_Test PPT Item Sub B-001' and bom_item.docstatus < 2 and bom_item.item_code = item.name and item.is_stock_item ='1'group by bom_item.item_code
select * from `tabUser Email` where parent='test2@example.com' and parentfield='user_emails' order by idx
select `name`, `smtp_port` from `tabEmail Domain` where `name` = 'example.com' order by modified desc
select `tabdoctype`.`module`, `tabdoctype`.`name`, `tabdoctype`.`modified`, `tabdoctype`.`docstatus` from `tabdoctype` left join `tabdocperm` on (`tabdocperm`.parent = `tabdoctype`.name) where `tabdocperm`.role = 'System Manager' order by `tabdoctype`.`modified` DESC
select sum(projected_qty) as projected_qty from tabBin where item_code = '_Test Item'
select name from `tabBOM Item` where parent='BOM-_Test Variant Item-001' and parenttype='BOM' and parentfield='items' and name not in ('9ee6218765')
select `name` from `tabBlog Post` where `title` = '_Test Blog Post' order by modified desc
select name from `tabBlock Module` where parent='test@example.com' and parenttype='User' and parentfield='block_modules' and name not in ('e005631ecf')
select `name` from `tabEmail Group` where `name` = '_Test Email Group' order by modified desc
SELECT count(*) FROM `tabcommunication` WHERE communication_type in ('Chat', 'Notification') AND reference_doctype = 'User' AND reference_name = 'Administrator' and modified >= DATE_SUB(NOW(),INTERVAL 1 YEAR) AND seen='0'
select name from `tabuserrole` where parent='test@example.com' and parenttype='User' and parentfield='user_roles' and name not in ('a496d47242','329a1b58b9','b1b0e80e75','7d80cfb0a0','3dcca4543d','3b7e2e6e19','a8777daf10')
select max(char_length(`ref_name`)) from `tabevent`
select field, value from tabSingles where field in ('parenttype', 'parent') and doctype='Buying Settings'
select name, `label` from `tabShipping Rule` where name in ('_Test Shipping Rule - India')
select `tabdoctype`.`name` from `tabdoctype` where `tabdoctype`.name like '%%yoyo%%' order by `tabdoctype`.`modified` DESC
select account_currency, sum(debit_in_account_currency) as amount from `tabGL Entry` where against_voucher_type = 'Purchase Order' and against_voucher = 'PO-00014' and party='_Test Supplier' and docstatus ='1'
select `exp_end_date` from `tabtask` where `name` = 'TASK00013' order by modified desc
select share_name from tabDocShare where (user='testperm@example.com' or everyone='1' and share_doctype='User' and `write`='1'
select `name` from `tabCustom DocPerm` where `role` = 'Website Manager' and `permlevel` ='0'and `parent` = 'Blog Post' order by modified desc
select 'Journal Entry' as reference_type, t1.name as reference_name, t1.remark as remarks, t2.debit_in_account_currency as amount, t2.name as reference_row, t2.reference_name as against_order from `tabJournal Entry` t1, `tabJournal Entry Account` t2 where t1.name = t2.parent and t2.account = 'Creditors - _TC' and t2.party_type = 'Supplier' and t2.party = '_Test Supplier' and t2.is_advance = 'Yes' and t1.docstatus ='1'and debit_in_account_currency > 0 and ( (t2.reference_type = 'Purchase Order' and ifnull(t2.reference_name, '') in ('PO-00006'))) order by t1.posting_date
select distinct tabUserRole.parent from tabUserRole, tabDocPerm where tabDocPerm.parent = 'Blogger' and tabDocPerm.role = tabUserRole.role
select name from `tabBOM Scrap Item` where parent='BOM-_Test FG Item-001' and parenttype='BOM' and parentfield='scrap_items' and name not in ('c2fdbc6680')
select `name` from `tabbom` where `is_default` ='1'and `item` = '_Test FG Item' order by modified desc
select `communication`, `reference_doctype`, `reference_name` from `tabEmail Queue` where `message_id` = '20170209172141.2312.21853.0vExP838a1@erpnext.vm' order by modified desc
select * from `tabPricing Rule` where (item_code='Macbook Pro' or ifnull(item_group, '') in ('All Item Groups') or brand=NULL) and docstatus < 2 and `tabPricing Rule`."disable" ='0'and selling ='1'and ifnull(company, '') in ('_Test Company', '') and ifnull(customer, '') in ('_Test Customer', '') and ifnull(supplier, '') = '' and ifnull(supplier_type, '') = '' and ifnull(campaign, '') = '' and ifnull(sales_partner, '') = '' and ifnull(customer_group, '') in ('_Test Customer Group', 'All Customer Groups', '') and ifnull(territory, '') in ('_Test Territory', 'All Territories', '') and ifnull(for_price_list, '') in ('Standard Selling', '') and '2017-02-09' between ifnull(valid_from, '2000-01-01') and ifnull(valid_upto, '2500-12-31') order by priority desc, name desc
select activity_type, sum(hours) as total_hours from `tabTimesheet Detail` where project='_Test Project 1' and docstatus < 2 group by activity_type order by total_hours desc
select * from `tabPOS Profile` where ifnull(user,'') = '' and company = '_Test Company'
select `conversion_factor` from `tabUOM Conversion Detail` where `uom` = '_Test UOM' and `parent` in ('_Test Variant Item-S', '_Test Variant Item') order by modified desc
select name from `tabaccount` where parent_account = 'Test Warehouse for Merging 1 - _TC' and docstatus !='2'
select `name`, `parent`, `parenttype`, `docstatus` from `tabSales Invoice` where `amended_from` = 'SINV-00013' order by modified desc
select `name` from `tabuser` where `name` != 'Guest' order by modified desc
select distinct `reference_doctype`, parenttype from `tabcommunication` where `reference_doctype`='Role'
select * from `tabPurchase Receipt Item Supplied` where `parenttype` = 'Purchase Receipt' and `parent` = 'PREC-00003' and `parentfield` = 'supplied_items' order by idx asc
select `write_off_account`, `exchange_gain_loss_account`, `cost_center` from `tabcompany` where `name` = '_Test Company' order by modified desc
select name from `tabEmployee Leave Approver` where parent='_T-Employee-0001' and parenttype='Employee' and parentfield='leave_approvers' and name not in ('5e98e0dc43','14114befc6')
select * from `tabWebsite Item Group` where `parenttype` = 'Item' and `parent` = '_Test Item for Auto Price List' and `parentfield` = 'website_item_groups' order by idx asc
select `tabStock Ledger Entry`.`name` from `tabStock Ledger Entry` order by `tabStock Ledger Entry`.`modified` DESC
select DISTINCT parent from `tabBOM Operation` where workstation = '_Test Workstation 1'
select name from `tabdocfield` where parent='ToDo' and parenttype='DocType' and parentfield='fields' and name not in ('42594f37c5','1d33322d80','42e8905f4a','e3817df1d0','d1d9230160','107ba1f7c6','268bda199d','c95955c71d','eaa2a54c48','5f8c00dace','4cc0780e32','be1e4a09ab','0081b75292','e9b9d7af8a','511c09171d','615c245c92')
select ifnull(max(rgt),0)+1 from `tabSales Person` where ifnull(`parent_sales_person`,'') =''
select account, debit, credit from `tabGL Entry` where voucher_type='Sales Invoice' and voucher_no = 'SINV-00016' order by account
select `name` from `tabAcademic Term` where `name` = '2014-2015 (_Test Academic Term)' order by modified desc
select name from `tabJob Applicant` where `tabJob Applicant`.status = 'Open' order by `tabJob Applicant`.`modified` desc limit 0, 100
select `name`, `parent`, `parenttype`, `docstatus` from `tabDelivery Note Item` where `against_sales_invoice` = 'SINV-00013' order by modified desc
select `item_group` from `tabitem` where `name` = '_Test FG Item' order by modified desc
select `outgoing_rate` from `tabStock Ledger Entry` where `voucher_no` = 'PREC-00007' and `voucher_type` = 'Purchase Receipt' order by modified desc
select * from `tabMaterial Request Item` where `parenttype` = 'Material Request' and `parent` = '_T-Material Request-00002' and `parentfield` = 'items' order by idx asc
select * from `tabShipping Rule` where `name` = '_Test Shipping Rule - India' order by modified desc
select name from `tabRequest for Quotation` where `tabRequest for Quotation`.docstatus = 0.0 order by `tabRequest for Quotation`.docstatus asc, `tabRequest for Quotation`.`modified` DESC limit 0, 100
select * from `tabwarehouse` where lft='43'or rgt='44'
select `name`, `parent`, `parenttype`, `docstatus` from `tabDelivery Note` where `amended_from` = 'DN-00015' order by modified desc
SELECT sum(debit_in_account_currency) - sum(credit_in_account_currency) FROM `tabGL Entry` gle WHERE posting_date <= '2013-02-14' and posting_date >= '2013-01-01' and voucher_type != 'Period Closing Voucher' and gle.account = '_Test Account Cost for Goods Sold - _TC'
select name from `tabSerial No` where item_code='_Test Serialized Item With Series' and warehouse='_Test Warehouse - _TC' order by timestamp(purchase_date, purchase_time) asc limit 1
select `_comments` from `tabevent` where `name` = 'EV00017' order by modified desc
select modified, docstatus from `tabSales Order` where name = 'SO-00017' for update
select `name`, `parent`, `parenttype`, `docstatus` from `tabPurchase Invoice Item` where `purchase_receipt` = 'PREC-00012' order by modified desc
select distinct ref_type from `tabevent`
select `name`, `parent`, `parenttype`, `docstatus` from `tabMaterial Request Item` where `sales_order` = 'SO-00013' order by modified desc
select `name` from `tabterritory` where `name` = 'United States' order by modified desc
select name from `tabfile` where lft<2 and rgt>9 order by lft desc
select max(char_length(`modified_by`)) from `tabuser`
select `tabworkflow`.`name`, `tabworkflow`.`modified`, `tabworkflow`.`docstatus` from `tabworkflow` left join `tabWorkflow Transition` on (`tabWorkflow Transition`.parent = `tabworkflow`.name) where `tabWorkflow Transition`.allowed = 'System Manager' order by `tabworkflow`.`modified` desc
SELECT sum(debit_in_account_currency) - sum(credit_in_account_currency) FROM `tabGL Entry` gle WHERE posting_date <= '2017-02-09 12:27:02.190850' and gle.account = '_Test Bank - _TC'
select distinct `purchase_document_type`, parenttype from `tabSerial No` where `purchase_document_type`='Role'
select `name`, `parent`, `parenttype`, `docstatus` from `tabSales Invoice Item` where `asset` = 'Macbook Pro 1' order by modified desc
select `is_frozen`, `disabled` from `tabcustomer` where `name` = '_Test Customer' order by modified desc
select * from `tabSales Invoice` where `name` = 'SINV-00008' order by modified desc
select name from `tabitem` where has_serial_no='1'and name in ('_Test Item', '_Test Item Home Desktop 100', '_Test FG Item')
select sum(total_leave_days) from `tabLeave Application` where employee = '_T-Employee-0001' and docstatus < 2 and status in ('Open', 'Approved') and from_date = '2013-01-01' and to_date = '2013-01-05' and name != 'LAP/00011'
select max(char_length(`github_username`)) from `tabuser`
select max(char_length(`gender`)) from `tabuser`
select name from `tabDynamic Link` where parent='_Test Contact for _Test Customer-_Test Customer' and parenttype='Contact' and parentfield='links' and name not in ('e67324e8dc')
select distinct sle.voucher_type, sle.voucher_no from `tabStock Ledger Entry` sle where timestamp(sle.posting_date, sle.posting_time) >= timestamp('2017-02-09', '12:23:43.536528') and item_code in ('_Test Item', '_Test Item Home Desktop 100') and warehouse in ('_Test Warehouse - _TC') order by timestamp(sle.posting_date, sle.posting_time) asc, name asc
select a.name from tabAsset a, `tabDepreciation Schedule` ds where a.name = ds.parent and a.docstatus='1'and ds.schedule_date<='2017-02-09' and a.status in ('Submitted', 'Partially Depreciated') and ifnull(ds.journal_entry, '')=''
select `name` from `tabFiscal Year` where `name` = '_Test Fiscal Year 2012' order by modified desc
select route, name, modified from `tabStudent Admission` where publish='1'and `route`='test-route-000' limit 1
select max(char_length(`parenttype`)) from `tabevent`
select name from `tabPurchase Order` where `tabPurchase Order`.status not in ('Completed', 'Closed') and `tabPurchase Order`.docstatus < 2.0 order by `tabPurchase Order`.docstatus asc, `tabPurchase Order`.`modified` DESC limit 0, 100
select `stock_value` from `tabbin` where `warehouse` = '_Test Warehouse - _TC' and `item_code` = '_Test Item' order by modified desc
select `name` from `tabaccount` where `warehouse` = '_Test Warehouse - _TC' and `account_type` = 'Stock' order by modified desc
select fy.name, fy.year_start_date, fy.year_end_date from `tabFiscal Year` fy where disabled ='0'and (not exists (select name from `tabFiscal Year Company` fyc where fyc.parent = fy.name) or exists(select company from `tabFiscal Year Company` fyc where fyc.parent = fy.name and fyc.company='Wind Power LLC') ) order by fy.year_start_date desc
select * from `tabTask Depends On` where `parenttype` = 'Task' and `parent` = 'TASK00010' and `parentfield` = 'depends_on' order by idx asc
select `name`, `target_name` from `tabtranslation` where `source_name` = 'Event' and `language` = 'en' order by modified desc
select ts.name as name, tsd.from_time as from_time, tsd.to_time as to_time from `tabTimesheet Detail` tsd, `tabtimesheet` ts where ts.`employee`='_T-Employee-0001' and tsd.parent = ts.name and ( ('2017-02-09 13:55:59.427627' > tsd.from_time and '2017-02-09 13:55:59.427627' < tsd.to_time) or ('2017-02-09 15:55:59.427627' > tsd.from_time and '2017-02-09 15:55:59.427627' < tsd.to_time) or ('2017-02-09 13:55:59.427627' <= tsd.from_time and '2017-02-09 15:55:59.427627' >= tsd.to_time)) and tsd.name!='df9353a452' and ts.name!='TS-00012' and ts.docstatus < 2
select max(char_length(`time_zone`)) from `tabuser`
select exchange_rate from `tabCurrency Exchange` where ifnull(`tabCurrency Exchange`.date, '0000-00-00') <= '2016-01-15' and `tabCurrency Exchange`.from_currency = 'USD' and `tabCurrency Exchange`.to_currency = 'INR' order by date desc limit 0, 1
select name from `tabProduction Order Operation` where parent='PRO-00001' and parenttype='Production Order' and parentfield='operations' and name not in ('d41f644502')
select bom_no from `tabBOM Item` where parent = 'BOM-_Test PPT Item SC B-001'
select `name`, `parent`, `parenttype`, `docstatus` from `tabasset` where `purchase_invoice` = 'PINV-00005' order by modified desc
select name from `tabPurchase Receipt Item` where parent='PREC-00012' and parenttype='Purchase Receipt' and parentfield='items' and name not in ('bd770fa806')
select name from `tabPurchase Receipt` where docstatus ='1'and name = 'PREC-00003'
select `name` from `tabcommunication` where `sender` = 'test_sender@example.com' order by modified desc
select * from `tabSales Invoice Timesheet` where `parenttype` = 'Sales Invoice' and `parent` = 'SINV-00013' and `parentfield` = 'timesheets' order by idx asc
select `is_lwp` from `tabLeave Type` where `name` = '_Test Leave Type' order by modified desc
select `owner` from `tabdoctype` where `name` = 'ToDo' order by modified desc
select distinct receipt_document_type from `tabLanded Cost Purchase Receipt`
select * from `tabStock Reconciliation Item` where `parenttype` = 'Stock Reconciliation' and `parent` = 'SR/00011' and `parentfield` = 'items' order by idx asc
select `credit_limit` from `tabcustomer` where `name` = 'Party Status Test - 1' order by modified desc
select `tabuser`.`name`, `tabuser`.`user_type`, `tabuser`.`first_name`, `tabuser`.`last_name`, `tabuser`.`last_active`, `tabuserrole`.`role` from `tabuser` left join `tabuserrole` on (`tabuserrole`.parent = `tabuser`.name) order by `tabuser`.`modified` desc
select `name` from `tabreport` where `name` = 'Permitted Documents For User' order by modified desc
select * from `tabCustomize Form Field` where `parenttype` = 'Customize Form' and `parent` = 'Customize Form' and `parentfield` = 'fields' order by idx asc
select `name` from `tabPayment Entry` where `name` = 'PE-00007' order by modified desc
select name from `tabFiscal Year` limit 1
select name, in_create, issingle, istable, read_only, module from tabDocType
select * from `tabPricing Rule` where (item_code='Test Variant PRT' or item_code='_Test Variant Item' or ifnull(item_group, '') in ('All Item Groups', '_Test Item Group') or brand=NULL) and docstatus < 2 and `tabPricing Rule`."disable" ='0'and selling ='1'and ifnull(company, '') in ('_Test Company', '') and ifnull(customer, '') in ('_Test Customer', '') and ifnull(supplier, '') = '' and ifnull(supplier_type, '') = '' and ifnull(campaign, '') = '' and ifnull(sales_partner, '') = '' and ifnull(customer_group, '') in ('_Test Customer Group', 'All Customer Groups', '') and ifnull(territory, '') in ('_Test Territory', 'All Territories', '') and ifnull(for_price_list, '') in ('_Test Price List', '') order by priority desc, name desc
select `stock_value_difference` from `tabStock Ledger Entry` where `voucher_no` = 'STE-00017' and `voucher_type` = 'Stock Entry' and `item_code` = '_Test Item Home Desktop 100' order by modified desc
select * from `tabtimesheet` where `name` = 'TS-00002' order by modified desc
select is_group, docstatus, company from tabAccount where name='Debtors - _TC'
select account, account_currency, debit, credit, debit_in_account_currency, credit_in_account_currency from `tabGL Entry` where voucher_type='Journal Entry' and voucher_no='JV-00024' order by account asc
select name from `tabcommunication` where `tabcommunication`.sent_or_received = 'Received' and `tabcommunication`.reference_doctype = 'ToDo' and `tabcommunication`.unread_notification_sent = 0.0 and ifnull(`tabcommunication`.creation, '0000-00-00 00:00:00') > '2017-02-09 08:21:41.524409' and `tabcommunication`.email_account = '_Test Email Account 1' order by `tabcommunication`.`modified` desc
select `tabaccount`.`name` from `tabaccount` where `tabaccount`.is_group = 1.0 and `tabaccount`.company = 'India - Chart of Accounts' and `tabaccount`.account_type = 'Cash' order by `tabaccount`.`modified` desc
select name from `tabuserrole` where parent='test@example.com' and parenttype='User' and parentfield='user_roles' and name not in ('a496d47242','329a1b58b9','b1b0e80e75')
select modified, docstatus from `tabItem Attribute` where name = 'Test Size' for update
select name from `tabPurchase Order` where docstatus='1'and base_net_total ='0'
select `name` from `tabStock Entry` where `docstatus` !='2'and `production_order` = 'PRO-00008' and `purpose` = 'Manufacture' and `name` != NULL order by modified desc
select name from `tabBlog Post` where owner='test2@example.com' and ifnull(blogger,'')=''
select item_name, description, stock_uom from `tabitem` where name = '_Test Item'
select `item_code`, `warehouse` from `tabSerial No` where `name` = 'ABCD00007' order by modified desc
select holiday_date from `tabholiday` where parent = '_Test Holiday List' and holiday_date between '2013-02-02' and '2013-02-02'
select `name` from `tabPrice List` where `name` = 'Standard Selling' order by modified desc
select name from `tabcontact` where `tabcontact`.status = 'Open' order by `tabcontact`.`modified` desc limit 0, 100
select `currency` from `tabSales Order` where `name` = '_T-Sales Order-00001' order by modified desc
select ifnull(sum(projected_qty),0) as qty from `tabbin` where item_code = '_Test PPT Item SC B' and warehouse='_Test Warehouse - _TC'
select `name` from `tabProduct Bundle` where `new_item_code` = '_Test Serialized Item With Series' order by modified desc
select parent, fieldname, (select issingle from tabDocType dt where dt.name = df.parent) as issingle from tabDocField df where df.options='Sales Order' and df.fieldtype='Link'
select max(char_length(`parenttype`)) from `tabuser`
select modified, docstatus from `tabPurchase Order` where name = 'PO-00004' for update
select `owner` from `tabcustomer` where `name` = '_Test Customer USD' order by modified desc
select `department` from `tabemployee` where `name` = '_T-Employee-0002' order by modified desc
select `name` from `tabversion` where `docname` = 'test note' order by modified desc
select distinct `reference_type`, parenttype from `tabPurchase Invoice Advance` where `reference_type`='Role'
select `supplier`, `company`, `currency` from `tabPurchase Receipt` where `name` = 'PREC-00003' order by modified desc
select name, from_date from `tabLeave Allocation` where employee='_T-Employee-0001' and leave_type='_Test Leave Type' and docstatus='1'and from_date > '2015-09-30' and carry_forward='1'
select `description` from `tabbom` where `name` = '_Test Numeric Template Item' order by modified desc
select owner from `tabtodo` where reference_type='Event' and reference_name='EV00010' and status='Open' and owner='test@example.com'
select max(char_length(`last_login`)) from `tabuser`
select `name`, `parent`, `parenttype`, `docstatus` from `tabSales Invoice` where `recurring_id` = 'SINV-00016' order by modified desc
select `credit_days_based_on`, `credit_days`, `customer_group` from `tabcustomer` where `name` = '_Test Customer' order by modified desc
select name from `tabrole` where desk_access='1'and name in ('_Test Role 2', 'System Manager') limit 1
select name from tabWarehouse where company='India - Chart of Accounts'
select name from `tabJournal Entry Account` where reference_type = 'Sales Order' and reference_name = 'SO-00033' and credit='400'
select * from `tabWorkstation Working Hour` where `parenttype` = 'Workstation' and `parent` = '_Test Workstation 1' and `parentfield` = 'working_hours' order by idx asc
select defkey, ifnull(defvalue, '') as defvalue from tabDefaultValue where parent='Administrator' and parenttype='User Permission'
select modified, docstatus from `tabSalary Slip` where name = 'Sal Slip/EMP-0001/00003' for update
select item_code, `qty`, `ordered_qty`, parenttype, parent from `tabSales Order Item` where `qty` < `ordered_qty` and name='965bec8b58' and docstatus='1'
select `name` from `tabcompany` where `name` = 'COA from Existing Company' order by modified desc
select `name` from `tabDesktop Icon` where `module_name` = 'ToDo' order by modified desc
select `docstatus` from `tabSales Invoice` where `name` = 'SINV-00021' order by modified desc
select item_code, `qty`, `delivered_qty`, parenttype, parent from `tabSales Order Item` where `qty` < `delivered_qty` and name='21b1167610' and docstatus='1'
select value from tabSingles where doctype='Manufacturing Settings' and field='disable_capacity_planning'
select * from `tabTop Bar Item` where `parenttype` = 'Website Settings' and `parent` = 'Website Settings' and `parentfield` = 'footer_items' order by idx asc
select `tabHoliday List`.`name` from `tabHoliday List` left join `tabholiday` on (`tabholiday`.parent = `tabHoliday List`.name) where `tabholiday`.holiday_date = '2017-02-09' and `tabHoliday List`.name = '_Test Holiday List' order by `tabHoliday List`.`modified` DESC
select name, from_time, to_time from `tabCourse Schedule` where `student_group`='TC-TP-2014-2015-2014-2015 (_Test Academic Term)' and schedule_date = '2017-02-09' and ( (from_time > '1:00:00' and from_time < '2:00:00') or (to_time > '1:00:00' and to_time < '2:00:00') or ('1:00:00' > from_time and '1:00:00' < to_time) or ('1:00:00' = from_time and '2:00:00' = to_time)) and name!='SH00025'
select distinct sle.voucher_type, sle.voucher_no from `tabStock Ledger Entry` sle where timestamp(sle.posting_date, sle.posting_time) >= timestamp('2017-02-09', '12:25:27.397847') and item_code in ('_Test Item') and warehouse in ('_Test Warehouse - _TC') order by timestamp(sle.posting_date, sle.posting_time) asc, name asc
select `name` from `tabPurchase Receipt` where `name` = 'PREC-00007' order by modified desc
select `name` from `tabtimesheet` where `production_order` = 'PRO-00001' order by modified desc
select role from tabUserRole where parent='Daily_test_employee@salary.com' and role not in ('All', 'Guest')
select `name` from `tabPayment Request` where `docstatus` !='2'and `reference_doctype` = 'Sales Invoice' and `reference_name` = 'SINV-00021' order by modified desc
select name, priority from `tabTax Rule` where ifnull(shipping_city, '') = '' and ifnull(company, '') = '_Test Company' and ifnull(shipping_state, '') = '' and ifnull(shipping_county, '') = '' and ifnull(supplier_type, '') = '' and ifnull(billing_country, '') = '' and ifnull(customer, '') = '_Test Customer' and ifnull(billing_city, '') = '' and ifnull(tax_type, '') = 'Sales' and ifnull(shipping_country, '') = '' and ifnull(supplier, '') = '' and ifnull(billing_county, '') = '' and ifnull(customer_group, '') = '' and ifnull(billing_state, '') = '' and ((from_date > '2015-01-03' and from_date < '2015-01-09') or (to_date > '2015-01-03' and to_date < '2015-01-09') or ('2015-01-03' > from_date and '2015-01-03' < to_date) or ('2015-01-03' = from_date and '2015-01-09' = to_date)) and name != 'TR0008'
select `read`, `write`, `share` from `tabdocshare` where `share_doctype` = 'Event' and `user` = 'test1@example.com' and `share_name` = 'EV00013' order by modified desc
select name from `tabPurchase Order` where docstatus ='1'and name = 'PO-00001'
select `name` from `tabdocshare` where `share_doctype` = 'User' and `user` = 'Bimonthly_test_employee@salary.com' and `share_name` = 'Bimonthly_test_employee@salary.com' order by modified desc
select name from `tabuserrole` where parent='test2@example.com' and parenttype='User' and parentfield='user_roles' and name not in ('fb6624c2ad','7dcdf83959','64e9ede9fc','601d0f0531','a497314342','3ec1f4b70d')
select `name` from `tabcustomer` where `name` = 'Government' order by modified desc
select name, owner, creation, data from `tabversion` where `tabversion`.docname = 'EV00013' and `tabversion`.ref_doctype = 'Event' order by creation desc limit 0, 10
select `exp_start_date` from `tabtask` where `name` = 'TASK00013' order by modified desc
select distinct reference_doctype from `tabCommunication`
select file_url from `tabfile` where name='7dd156ff10' or file_name='7dd156ff10'
select * from `tabBlog Post` where `name` = '-test-blog-post-2' order by modified desc
select count(name) from tabItem where item_group = '_Test Item Group'
select `name` from `tabwarehouse` where `warehouse_name` = 'Stores' order by modified desc
select * from `tabProduction Plan Item` where `parenttype` = 'Production Planning Tool' and `parent` = 'Production Planning Tool' and `parentfield` = 'items' order by idx asc
select advance_paid from `tabPurchase Order` where name='PO-00014'
select `name`, `parent`, `parenttype`, `docstatus` from `tabPurchase Invoice Item` where `purchase_order` = 'PO-00002' order by modified desc
select * from `tabItem Supplier` where `parenttype` = 'Item' and `parent` = 'Macbook Pro' and `parentfield` = 'supplier_items' order by idx asc
select `name`, `parent`, `parenttype`, `docstatus` from `tabtimesheet` where `sales_invoice` = 'SINV-00016' order by modified desc
select name, user from `tabPOS Profile` where ifnull(user, '') = NULL and name != '6125d62f89' and company = '_Test Company'
select max(char_length(`parentfield`)) from `tabtodo`
select sum(debit_in_account_currency) - sum(credit_in_account_currency) from `tabGL Entry` where voucher_type = 'Journal Entry' and voucher_no = '_T-Journal Entry-00004' and account = '_Test Receivable - _TC' and (against_voucher is null or against_voucher='') and party_type='Customer' and party='_Test Customer'
select count(*) from `tabSales Person` where ifnull(parent_sales_person, '')=''
select `customer`, `company`, `project`, `currency` from `tabDelivery Note` where `name` = 'DN-00009' order by modified desc
select `name` from `tabPayment Request` where `status` not in ('Initiated', 'Paid') and `reference_name` = 'SO-00034' and `name` != 'PR00001' and `docstatus` ='1'order by modified desc
select `status` from `tabtimesheet` where `name` = 'TS-00015' order by modified desc
select max(char_length(`username`)) from `tabuser`
SELECT name from `tabGL Entry` where company = 'India - Chart of Accounts'
select modified, docstatus from `tabquotation` where name = 'QTN-00001' for update
select bom_item.item_code, sum(bom_item.qty/ifnull(bom.quantity, 1)) * 2 as qty, item.stock_uom from `tabBOM Scrap Item` bom_item, `tabbom` bom, `tabitem` item where bom_item.parent = bom.name and bom_item.docstatus < 2 and bom_item.parent = 'BOM-_Test FG Item-001' and item.name = bom_item.item_code and is_stock_item ='1'group by bom_item.item_code, item.stock_uom
select * from `tabPricing Rule` where (item_code='_Test Item for Auto Price List' or ifnull(item_group, '') in ('All Item Groups', 'Products') or brand=NULL) and docstatus < 2 and `tabPricing Rule`."disable"='0'and selling ='1'and ifnull(company, '') in ('_Test Company', '') and ifnull(customer, '') in ('_Test Customer', '') and ifnull(supplier, '') = '' and ifnull(supplier_type, '') = '' and ifnull(campaign, '') = '' and ifnull(sales_partner, '') = '' and ifnull(customer_group, '') in ('_Test Customer Group', 'All Customer Groups', '') and ifnull(territory, '') in ('_Test Territory', 'All Territories', '') and ifnull(for_price_list, '') in ('_Test Price List', '') order by priority desc, name desc
select t1.name from `tabMaintenance Visit` t1, `tabMaintenance Visit Purpose` t2 where t2.parent=t1.name and t2.prevdoc_docname = 'SO-00033' and t1.docstatus ='1'
select `name` from `tabnewsletter` where `name` = '_Test Newsletter' order by modified desc
select block_date, reason from `tabLeave Block List Date` where parent='_Test Leave Block List' and block_date between '2013-01-01' and '2013-01-03'
select *, timestamp(posting_date, posting_time) as "timestamp" from `tabStock Ledger Entry` where item_code = '_Test Item Home Desktop 100' and warehouse = '_Test Warehouse - _TC' and ifnull(is_cancelled, 'No')='No' and timestamp(posting_date, posting_time) > timestamp('2017-02-09', '12:26:28.301535') and name!='SLE/00000161' order by timestamp(posting_date, posting_time) asc, name asc for update
select `name`, `parent`, `parenttype`, `docstatus` from `tabPayment Entry` where `amended_from` = 'PE-00003' order by modified desc
select `name`, `parent`, `parenttype`, `docstatus` from `tabSalary Slip` where `amended_from` = 'Sal Slip/_T-Employee-0001/00001' order by modified desc
select name from `tabSalary Slip` where journal_entry='JV-00001' and docstatus < 2
select name from `tabMaterial Request Item` where parent='MREQ-00001' and parenttype='Material Request' and parentfield='items' and name not in ('50ab2a5dac','89da2c613f','299df75383')
select sum(fg_completed_qty) from `tabStock Entry` where production_order='PRO-00002' and docstatus='1'and purpose='Material Transfer for Manufacture'
select parent, (select `is_primary_address` from tabAddress a where a.name=dl.parent) as `is_primary_address` from `tabDynamic Link` dl where link_doctype='Supplier' and link_name='_Test Supplier USD' and parenttype = 'Address'
select name from `tabActivity Cost` where employee_name= '_Test Employee' and activity_type= '_Test Activity Type 1' and name != 'AC-00001'
select * from `tabTax Rule` where (from_date is null or from_date = '' or from_date <= '2015-01-01') and (to_date is null or to_date = '' or to_date >= '2015-01-01') and ifnull(customer, '') in ('', '_Test Customer') and ifnull(billing_city, '') in ('', 'Test City') and ifnull(billing_state, '') in ('', 'Test State')
