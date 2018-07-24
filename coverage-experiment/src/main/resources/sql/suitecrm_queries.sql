SELECT category, name, value FROM config WHERE category = 'notify'
SELECT oauth_consumer.* FROM oauth_consumer  WHERE c_key = '' AND deleted='0'LIMIT 0,1
SELECT * FROM acl_actions WHERE name='access' AND category = 'Test' AND acltype='module' and deleted='0'
SELECT meetings.* from meetings_users,meetings  WHERE  meetings_users.meeting_id=meetings.id AND meetings_users.user_id='1' AND meetings.deleted='0'AND meetings_users.deleted='0'
SELECT addr.email_address FROM email_addresses addr,email_addr_bean_rel eb WHERE eb.deleted='0'AND addr.id=eb.email_address_id AND bean_id ='' AND primary_address = '1'
SELECT  currencies.*  FROM currencies  where currencies.deleted='0'ORDER BY currencies.name
SELECT documents.document_name, revision FROM documents, document_revisions where documents.id = 'dummy_id' AND document_revisions.id = documents.document_revision_id
SELECT id FROM outbound_email WHERE type = 'system'
SELECT account_id FROM accounts_contacts WHERE contact_id='2' LIMIT 0,1
SELECT id ,aos_product_categories.name as parent_category_name , aos_product_categories.assigned_user_id owner FROM aos_product_categories WHERE deleted='0'AND id='1'
SELECT name, assigned_user_id FROM project_task WHERE id='b73ad8f7-7e94-2e67-2afc-589c85f52879'
SELECT securitygroup_id id FROM securitygroups_records  WHERE securitygroups_records.record_id = '1c378ecd-b7a5-090b-22f2-589c85e94f55' AND securitygroups_records.module = 'AOS_Product_Categories' AND securitygroups_records.deleted='0'
SELECT * FROM meetings_users WHERE deleted = '0'   AND user_id = ''  AND meeting_id = '259c2f1b-922d-ab63-b5d9-589c85cea2d8' 
SELECT first_name, last_name from contacts where id='1'
SELECT bean_id id FROM emails_beans  WHERE emails_beans.email_id = 'e3c8ca08-e16d-d18b-80c8-589c85b8ac4d' AND emails_beans.bean_module = 'ProjectTask' AND emails_beans.deleted='0'
SELECT contact_id id FROM contacts_bugs  WHERE contacts_bugs.bug_id = '58800532-0e9d-ccaf-e85e-589c85722403' AND contacts_bugs.deleted='0'
SELECT contact_id id FROM contacts_cases  WHERE contacts_cases.case_id = '610b3ee0-80df-4b8f-54d1-589c8545f8c6' AND contacts_cases.deleted='0'
SELECT name from emails where id='1'
SELECT tasks.* FROM tasks  WHERE tasks.id = '8e5f042a-01a2-b1ab-53df-589c856d05a2' AND tasks.deleted='0'LIMIT 0,1
SELECT * FROM emails_email_addr_rel WHERE email_id = '1ad4af31-e3d0-6719-5d2e-589c85551559' AND email_address_id = 'af6b9271-77f5-ef26-042d-589c810cf7e9' AND address_type = 'from' AND deleted ='0'
SELECT calls.* FROM calls  WHERE calls.id = 'c94a263b-747b-d4f1-f2f5-589c85af76fe' AND calls.deleted='0'LIMIT 0,1
SELECT eapm.* FROM eapm  WHERE eapm.id = 'adf4ad9c-6e3a-2ab1-a0fe-589c85e35558' AND eapm.deleted='0'LIMIT 0,1
SELECT r1.name from releases r1, bugs i1 where r1.id = i1.found_in_release and i1.id = '' and i1.deleted='0'and r1.deleted='0'
SELECT id FROM notes WHERE parent_id = 'b3cd04d9-5080-4707-0979-589c859a71d7'
SELECT user_id id FROM meetings_users  WHERE meetings_users.meeting_id = '259c2f1b-922d-ab63-b5d9-589c85cea2d8' AND meetings_users.deleted='0'
SELECT cases.*,cases_cstm.* FROM cases  LEFT JOIN cases_cstm ON cases.id = cases_cstm.id_c  WHERE cases.id = '610b3ee0-80df-4b8f-54d1-589c8545f8c6' AND cases.deleted='0'LIMIT 0,1
SELECT aos_contracts.* FROM aos_contracts  WHERE aos_contracts.id = 'b5053637-72bf-2991-1f1f-589c85d9d496' AND aos_contracts.deleted='0'LIMIT 0,1
SELECT id FROM securitygroups_records WHERE record_id = '1' AND module = 'Calls' AND securitygroup_id = '1' AND deleted='0'LIMIT 0,1
SELECT acl_actions.* ,acl_roles_actions.access_override  FROM acl_actions  LEFT JOIN acl_roles_actions ON acl_roles_actions.role_id = '1' AND  acl_roles_actions.action_id = acl_actions.id AND acl_roles_actions.deleted ='0'WHERE acl_actions.deleted='0'ORDER BY acl_actions.category, acl_actions.name
SELECT id FROM aor_charts WHERE aor_charts.aor_report_id = '22761e76-c3df-05f1-f67d-589c854aac22' AND aor_charts.deleted='0'
SELECT aop_case_updates.* FROM aop_case_updates  WHERE aop_case_updates.id = 'c48c392a-a6f9-8a1c-5e13-589c85e693dc' AND aop_case_updates.deleted='0'LIMIT 0,1
SELECT id FROM users WHERE deleted='0'AND is_group='0'AND portal_only='0'
SELECT documents.* FROM documents  WHERE documents.id = '' AND documents.deleted='0'LIMIT 0,1
SELECT id FROM aor_fields WHERE aor_fields.aor_report_id = '' AND aor_fields.deleted='0'
SELECT role_id id FROM securitygroups_acl_roles  WHERE securitygroups_acl_roles.securitygroup_id = 'ab4403a6-3576-eee1-ba12-589c85486314' AND securitygroups_acl_roles.deleted='0'
SELECT id FROM aos_products_quotes WHERE aos_products_quotes.parent_id = '1' AND aos_products_quotes.deleted='0'
SELECT meeting_id id FROM meetings_users  WHERE meetings_users.user_id = '' AND meetings_users.deleted='0'
SELECT aos_product_categories.* FROM aos_product_categories  WHERE aos_product_categories.id = '1' AND aos_product_categories.deleted='0'LIMIT 0,1
SELECT calls_users.required, calls_users.accept_status, calls_users.user_id from calls_users where calls_users.call_id='1' AND calls_users.deleted='0'
SELECT notes.* FROM notes  WHERE notes.id = '2ca107b1-7e57-2768-b563-589c8376f3f4' AND notes.deleted='0'LIMIT 0,1
SELECT contacts.first_name, contacts.last_name, contacts.phone_work, contacts.id, contacts.assigned_user_id contact_name_owner, 'Contacts' contact_name_mod FROM contacts, emails_beans WHERE emails_beans.email_id='b3cd04d9-5080-4707-0979-589c859a71d7' AND emails_beans.bean_id=contacts.id AND emails_beans.bean_module = 'Contacts' AND emails_beans.deleted='0'AND contacts.deleted='0'
SELECT leads.*,leads_cstm.* FROM leads  LEFT JOIN leads_cstm ON leads.id = leads_cstm.id_c  WHERE leads.id = 'ca56e9f8-ae3b-ab0d-5326-589c8518ddab' AND leads.deleted='0'LIMIT 0,1
select count(securitygroups.id) as results from securitygroups inner join securitygroups_users on securitygroups.id = securitygroups_users.securitygroup_id  and securitygroups_users.deleted ='0' where securitygroups.deleted ='0'and securitygroups_users.user_id = ''   and (securitygroups.noninheritable is null or securitygroups.noninheritable <> 1)   and (securitygroups_users.noninheritable is null or securitygroups_users.noninheritable <> 1) 
SELECT id ,cases.name as case_name , cases.assigned_user_id owner FROM cases WHERE deleted='0'AND id='610b3ee0-80df-4b8f-54d1-589c8545f8c6'
SELECT id FROM oauth_tokens WHERE oauth_tokens.assigned_user_id = '' AND oauth_tokens.deleted='0'
SELECT first_name, last_name, assigned_user_id contact_name_owner FROM contacts WHERE id='1' LIMIT 0,1
SELECT acl_actions.* FROM acl_actions  WHERE acl_actions.deleted='0'ORDER BY acl_actions.category, acl_actions.name
SELECT id FROM email_addresses WHERE email_address_caps = 'FROM_TEST@EMAIL.COM'
SELECT name from accounts where id='1'
SELECT id FROM favorites WHERE parent_id= '1' AND parent_type = 'Accounts' AND assigned_user_id = '' AND deleted ='0'ORDER BY date_entered DESC LIMIT 0,1
SELECT lead_id id FROM calls_leads  WHERE calls_leads.call_id = 'c94a263b-747b-d4f1-f2f5-589c85af76fe' AND calls_leads.deleted='0'
SELECT * FROM project_task WHERE project_id = '1' AND deleted ='0'ORDER BY project_task_id
SELECT related_id, related_type FROM prospect_lists_prospects WHERE id = ''
SELECT eapm.* FROM eapm  WHERE assigned_user_id = '' AND application = '' AND deleted = '0' AND validated = '1' AND deleted='0'LIMIT 0,1
SELECT id, email_address, invalid_email, opt_out FROM email_addresses WHERE id IN ('b706125e-bdb6-1939-22ff-58974811a509') AND deleted='0'
SELECT id FROM notes WHERE notes.parent_id = '8e5f042a-01a2-b1ab-53df-589c856d05a2' AND notes.deleted='0'
SELECT id, name FROM releases where name is not null and deleted='0' and status='Hidden'  order by list_order asc
select securitygroups_default.id, securitygroups.name, securitygroups_default.module, securitygroups_default.securitygroup_id from securitygroups_default inner join securitygroups on securitygroups_default.securitygroup_id = securitygroups.id where securitygroups_default.deleted ='0'and securitygroups.deleted ='0'
SELECT aor_reports.* FROM aor_reports  WHERE aor_reports.id = '22761e76-c3df-05f1-f67d-589c854aac22' AND aor_reports.deleted='0'LIMIT 0,1
SELECT first_name, last_name from leads where id='1'
SELECT aos_quotes77d9_quotes_ida id FROM aos_quotes_aos_invoices_c  WHERE aos_quotes_aos_invoices_c.aos_quotes6b83nvoices_idb = 'eaf912f5-3473-ccd0-a564-589c8573a960' AND aos_quotes_aos_invoices_c.deleted='0'
SELECT relationship_name, rhs_module, lhs_module FROM relationships WHERE deleted='0'AND relationship_name = 'test_test'
SELECT id from vcals where user_id='' AND type='vfb' AND deleted='0'
SELECT aod_index.* FROM aod_index  WHERE aod_index.id = '1' AND aod_index.deleted='0'LIMIT 0,1
SELECT id FROM meetings WHERE repeat_parent_id = '259c2f1b-922d-ab63-b5d9-589c85cea2d8' AND deleted ='0'ORDER BY date_start
SELECT id FROM calls_reschedule WHERE calls_reschedule.call_id = '1' AND calls_reschedule.deleted='0'
SELECT project_users_1project_ida id FROM project_users_1_c  WHERE project_users_1_c.project_users_1users_idb = '' AND project_users_1_c.deleted='0'
SELECT role_id FROM roles_users WHERE user_id='1'
SELECT id FROM project_task WHERE project_task.project_id = 'b73ad8f7-7e94-2e67-2afc-589c85f52879' AND project_task.deleted='0'
SELECT u1.first_name, u1.last_name from users  u1, users  u2 where u1.id = u2.reports_to_id AND u2.id = '42494856-4357-0ff9-d7a8-58974c4b55f8' and u1.deleted='0'
SELECT * from users where user_name='test' LIMIT 0,1
SELECT aor_conditions.* FROM aor_conditions  WHERE aor_conditions.id = '389d0165-5d89-69c3-cdee-589c85f0401c' AND aor_conditions.deleted='0'LIMIT 0,1
SELECT accounts.*,accounts_cstm.* FROM accounts  LEFT JOIN accounts_cstm ON accounts.id = accounts_cstm.id_c  WHERE accounts.id = '1' AND accounts.deleted='0'LIMIT 0,1
SELECT eapm.* FROM eapm  WHERE assigned_user_id = '' AND application = '' AND deleted = '0' AND deleted='0'LIMIT 0,1
SELECT id FROM aow_conditions WHERE aow_workflow_id = '' AND deleted ='0'ORDER BY condition_order ASC
SELECT meetings.*, meetings_cstm.* FROM meetings LEFT JOIN meetings_cstm ON meetings.id = meetings_cstm.id_c  WHERE meetings.deleted ='0'AND meetings.id = '1' LIMIT 0,1
SELECT * FROM meetings_contacts WHERE deleted = '0'   AND contact_id = ''  AND meeting_id = '259c2f1b-922d-ab63-b5d9-589c85cea2d8' 
SELECT role_id id FROM acl_roles_users  WHERE acl_roles_users.user_id = 'd9c07713-989b-ccdc-2cad-589c8529ef35' AND acl_roles_users.deleted='0'
SELECT aor_charts.* FROM aor_charts  WHERE aor_charts.id = '353ca905-49b5-ed0a-b6b6-589c85fc8d6e' AND aor_charts.deleted='0'LIMIT 0,1
select email_address_id from email_addr_bean_rel where bean_id = '' and email_addr_bean_rel.primary_address='1'and deleted='0'
SELECT aor_scheduled_reports.* FROM aor_scheduled_reports  WHERE aor_scheduled_reports.id = '9df9f4e0-9555-4dfd-a09c-589c8597d4ae' AND aor_scheduled_reports.deleted='0'LIMIT 0,1
SELECT lhs_module, rhs_module FROM relationships WHERE deleted='0'AND (lhs_module = 'SecurityGroups' OR rhs_module='SecurityGroups')
SELECT bugs.* FROM bugs  WHERE bugs.id = '58800532-0e9d-ccaf-e85e-589c85722403' AND bugs.deleted='0'LIMIT 0,1
SELECT name from campaigns where id = ''
SELECT id, name FROM releases where releases.name LIKE '%test%' and deleted='0' and status='Active'  order by list_order asc
SELECT name, assigned_user_id FROM project WHERE id='1'
SELECT * FROM acl_actions WHERE deleted='0' AND acltype='module' ORDER BY category
SELECT account_id id FROM accounts_bugs  WHERE accounts_bugs.bug_id = '58800532-0e9d-ccaf-e85e-589c85722403' AND accounts_bugs.deleted='0'
SELECT accounts.*, accounts_cstm.* FROM accounts LEFT JOIN accounts_cstm ON accounts.id = accounts_cstm.id_c  LEFT JOIN accounts_opportunities ON accounts.id = accounts_opportunities.account_id AND accounts_opportunities.deleted ='0' WHERE accounts.deleted ='0'AND accounts_opportunities.opportunity_id = '' LIMIT 0,1
SELECT aos_invoices.* FROM aos_invoices  WHERE aos_invoices.id = '1' AND aos_invoices.deleted='0'LIMIT 0,1
SELECT accounts_audit.*, users.user_name FROM accounts_audit, users WHERE accounts_audit.created_by = users.id AND accounts_audit.parent_id = '' order by accounts_audit.date_created desc
select users.id, users.user_name, users.first_name, users.last_name from securitygroups inner join securitygroups_users on securitygroups.id = securitygroups_users.securitygroup_id  and securitygroups_users.deleted ='0'inner join users on securitygroups_users.user_id = users.id and users.deleted ='0' where securitygroups.deleted ='0'and users.employee_status = 'Active'   and securitygroups.id = ''  order by users.user_name asc 
SELECT call_id id FROM calls_users  WHERE calls_users.user_id = '' AND calls_users.deleted='0'
SELECT user_id id FROM contacts_users  WHERE contacts_users.contact_id = '' AND contacts_users.deleted='0'
SELECT email_addresses.* FROM email_addresses  WHERE email_addresses.id = 'b10d3d59-ab27-3b26-13ee-589c84de0d8e' AND email_addresses.deleted='0'LIMIT 0,1
SELECT module_id FROM roles_modules WHERE role_id = '1' AND allow = '1' AND deleted='0'
SELECT email_address_id id FROM email_addr_bean_rel  WHERE email_addr_bean_rel.bean_id = '' AND email_addr_bean_rel.bean_module = 'Users' AND email_addr_bean_rel.deleted='0'
SELECT prospect_lists.* FROM prospect_lists  WHERE prospect_lists.id = '1a06a34d-9a05-c9dc-5a8b-589c85760304' AND prospect_lists.deleted='0'LIMIT 0,1
select id from email_marketing where template_id='' and deleted='0'
SELECT id FROM aow_actions WHERE aow_actions.aow_workflow_id = '1' AND aow_actions.deleted='0'
SELECT parent_id, parent_type FROM favorites WHERE assigned_user_id = '' AND deleted ='0'ORDER BY date_entered DESC
SELECT contacts.*,contacts_cstm.* FROM contacts  LEFT JOIN contacts_cstm ON contacts.id = contacts_cstm.id_c  WHERE contacts.id = 'test id' AND contacts.deleted='0'LIMIT 0,1
SELECT from_addr, reply_to_addr, to_addrs, cc_addrs, bcc_addrs, description, description_html, raw_source FROM emails_text WHERE email_id = 'b3cd04d9-5080-4707-0979-589c859a71d7'
SELECT id FROM aor_conditions WHERE aor_conditions.aor_report_id = '22761e76-c3df-05f1-f67d-589c854aac22' AND aor_conditions.deleted='0'
SELECT contents FROM user_preferences WHERE assigned_user_id='1' AND category = 'test_category' AND deleted ='0'
SELECT accounts.*, accounts_cstm.* FROM accounts LEFT JOIN accounts_cstm ON accounts.id = accounts_cstm.id_c  WHERE accounts.deleted ='0'AND id = '' LIMIT 0,1
SELECT count(*) as the_count FROM config WHERE category='info' AND name='sugar_version' AND value = ''
SELECT aos_products.* FROM aos_products  WHERE aos_products.id = '35088225-e323-0a98-4eaf-589c857e1471' AND aos_products.deleted='0'LIMIT 0,1
SELECT project_id id FROM projects_cases  WHERE projects_cases.case_id = '610b3ee0-80df-4b8f-54d1-589c8545f8c6' AND projects_cases.deleted='0'
SELECT currencies.* FROM currencies  WHERE currencies.id = '1edd9b52-818e-d5a4-78be-589c851d5d65' AND currencies.deleted='0'LIMIT 0,1
SELECT email_marketing.* FROM email_marketing  WHERE email_marketing.id = '' AND email_marketing.deleted='0'LIMIT 0,1
SELECT securitygroup_id id FROM securitygroups_acl_roles  WHERE securitygroups_acl_roles.role_id = '' AND securitygroups_acl_roles.deleted='0'
select * from currencies where id ='1'
SELECT prospect_lists_prospects.id id,prospects.first_name FROM prospects INNER JOIN prospect_lists_prospects ON prospect_lists_prospects.related_id = prospects.id INNER JOIN prospect_lists ON prospect_lists_prospects.prospect_list_id = prospect_lists.id INNER JOIN prospect_list_campaigns ON prospect_list_campaigns.prospect_list_id = prospect_lists.id INNER JOIN campaigns on campaigns.id = prospect_list_campaigns.campaign_id WHERE prospect_list_campaigns.deleted ='0'AND prospect_lists_prospects.deleted ='0'AND prospect_lists.deleted ='0'LIMIT 0,1
SELECT acc.id, acc.name FROM accounts  acc, cases  WHERE acc.id = cases.account_id AND cases.id = '1' AND cases.deleted='0'AND acc.deleted='0'
SELECT id FROM notes where parent_id='1' AND parent_type='Emails' AND file_mime_type is not null AND deleted='0'LIMIT 0,1
SELECT user_id id FROM securitygroups_users  WHERE securitygroups_users.securitygroup_id = 'ab4403a6-3576-eee1-ba12-589c85486314' AND securitygroups_users.deleted='0'
SELECT aos_products_quotes.* FROM aos_products_quotes  WHERE aos_products_quotes.id = '56f6e3a8-e6b3-eff2-7f47-589c855dd7a8' AND aos_products_quotes.deleted='0'LIMIT 0,1
select *  from email_addr_bean_rel eabr WHERE eabr.bean_id = 'ca56e9f8-ae3b-ab0d-5326-589c8518ddab' AND eabr.bean_module = 'Leads' and eabr.deleted='0'
SELECT config.value FROM config WHERE name='fromaddress'
SELECT meetings_users.required, meetings_users.accept_status, meetings_users.user_id from meetings_users where meetings_users.meeting_id='' AND meetings_users.deleted='0'
SELECT contact_id id FROM accounts_contacts  WHERE accounts_contacts.account_id = '' AND accounts_contacts.deleted='0'
SELECT campaign_trkrs.* FROM campaign_trkrs  WHERE campaign_trkrs.id = 'ecb15ceb-e4e0-f26f-fe9e-589c859f63b1' AND campaign_trkrs.deleted='0'LIMIT 0,1
SELECT id FROM meetings WHERE meetings.parent_id = '58800532-0e9d-ccaf-e85e-589c85722403' AND meetings.deleted='0'AND meetings.parent_type = 'Bugs'
SELECT id FROM aor_scheduled_reports WHERE aor_scheduled_reports.aor_report_id = '22761e76-c3df-05f1-f67d-589c854aac22' AND aor_scheduled_reports.deleted='0'
SELECT aow_workflow.* FROM aow_workflow  WHERE aow_workflow.id = '1' AND aow_workflow.deleted='0'LIMIT 0,1
SELECT id FROM aop_case_events WHERE aop_case_events.case_id = '610b3ee0-80df-4b8f-54d1-589c8545f8c6' AND aop_case_events.deleted='0'
SELECT id FROM notes WHERE notes.contact_id = '' AND notes.deleted='0'
select count(securitygroups.id) as results from securitygroups inner join securitygroups_users on securitygroups.id = securitygroups_users.securitygroup_id and securitygroups_users.deleted ='0'  and securitygroups_users.user_id = '' inner join securitygroups_records on securitygroups.id = securitygroups_records.securitygroup_id and securitygroups_records.deleted ='0'  and securitygroups_records.record_id = 'abcde-12345'   and securitygroups_records.module = 'Documents' where securitygroups.deleted ='0'
SELECT contacts.first_name, contacts.last_name, contacts.phone_work, contacts.id, contacts.assigned_user_id contact_name_owner, 'Contacts' contact_name_mod FROM contacts, emails_beans WHERE emails_beans.email_id='' AND emails_beans.bean_id=contacts.id AND emails_beans.bean_module = 'Contacts' AND emails_beans.deleted='0'AND contacts.deleted='0'AND contacts.id= '1' 
SELECT sugarfeed.* FROM sugarfeed  WHERE related_id = '1' AND related_module = 'SugarFeed' AND deleted='0'LIMIT 0,1
SELECT id FROM aos_line_item_groups WHERE aos_line_item_groups.parent_id = '1' AND aos_line_item_groups.deleted='0'
select revision from document_revisions where id='1' AND deleted='0'
SELECT id, name FROM releases where deleted='0' and status='Active'  order by list_order asc
SELECT aow_processed_id id FROM aow_processed_aow_actions  WHERE aow_processed_aow_actions.aow_action_id = '736c5271-6808-97cd-962b-589c85935bae' AND aow_processed_aow_actions.deleted='0'
SELECT document_name, revision, document_revision_id FROM documents, document_revisions where documents.id = '' AND document_revisions.id = documents.document_revision_id
SELECT id FROM aos_products WHERE aos_products.aos_product_category_id = '1c378ecd-b7a5-090b-22f2-589c85e94f55' AND aos_products.deleted='0'
SELECT id FROM aow_processed WHERE aow_processed.aow_workflow_id = '9650aa84-7b67-b648-e7a5-589c85589690' AND aow_processed.deleted='0'
SELECT id FROM document_revisions WHERE document_revisions.document_id = '6aa0d809-8f2d-fbef-bd77-589c858f860b' AND document_revisions.deleted='0'
SELECT * FROM relationships WHERE deleted='0'AND lhs_module = 'Roles' AND rhs_module = 'Users'
SELECT first_name, last_name FROM users WHERE id = ''
SELECT email_templates.* FROM email_templates  WHERE email_templates.id = '1' AND email_templates.deleted='0'LIMIT 0,1
SELECT id FROM aos_products_quotes WHERE aos_products_quotes.group_id = '1228c4a9-614c-31e7-7542-589c85451f14' AND aos_products_quotes.deleted='0'
SELECT users.* FROM users  WHERE user_name = '1' AND deleted='0'LIMIT 0,1
SELECT name , assigned_user_id account_name_owner FROM accounts WHERE id='1' LIMIT 0,1
SELECT id FROM aow_conditions WHERE aow_conditions.aow_workflow_id = '9650aa84-7b67-b648-e7a5-589c85589690' AND aow_conditions.deleted='0'
SELECT acl_roles.* FROM acl_roles INNER JOIN acl_roles_users ON acl_roles_users.user_id = '1' AND acl_roles_users.role_id = acl_roles.id AND acl_roles_users.deleted ='0'WHERE acl_roles.deleted='0'
SELECT aow_processed.* FROM aow_processed  WHERE aow_processed.id = 'd7abea92-7cf3-ca25-d70d-589c8552ead4' AND aow_processed.deleted='0'LIMIT 0,1
SELECT securitygroup_id id FROM securitygroups_users  WHERE securitygroups_users.user_id = '' AND securitygroups_users.deleted='0'
SELECT meetings_users.required, meetings_users.accept_status, meetings_users.meeting_id from meetings_users where meetings_users.user_id='' AND( meetings_users.accept_status IS NULL OR	meetings_users.accept_status='none') AND meetings_users.deleted='0'
SELECT case_id id FROM cases_bugs  WHERE cases_bugs.bug_id = '58800532-0e9d-ccaf-e85e-589c85722403' AND cases_bugs.deleted='0'
SELECT * FROM meetings_leads WHERE deleted = '0'   AND lead_id = ''  AND meeting_id = '259c2f1b-922d-ab63-b5d9-589c85cea2d8' 
SELECT user_name from users where user_name='admin' AND deleted='0'AND id<>'1'
SELECT calls.* from calls_users,calls  WHERE ((calls.date_start >= '2017-02-08 00:00:00' AND calls.date_start < '2017-02-10 00:00:00') OR (calls.date_start < '2017-02-08 00:00:00' AND calls.date_end > '2017-02-08 00:00:00') AND calls_users.accept_status != 'decline') AND  calls_users.call_id=calls.id AND calls_users.user_id='' AND calls.deleted='0'AND calls_users.deleted='0'
SELECT email_address_id id FROM email_addr_bean_rel  WHERE email_addr_bean_rel.bean_id = '' AND email_addr_bean_rel.primary_address = '1' AND bean_module = 'Users' AND email_addr_bean_rel.deleted='0'
SELECT contact_id id FROM meetings_contacts  WHERE meetings_contacts.meeting_id = '259c2f1b-922d-ab63-b5d9-589c85cea2d8' AND meetings_contacts.deleted='0'
SELECT inbound_email.* FROM inbound_email  WHERE group_id = '' AND deleted='0'LIMIT 0,1
SELECT project_task.* FROM project_task  WHERE project_task.id = 'b73ad8f7-7e94-2e67-2afc-589c85f52879' AND project_task.deleted='0'LIMIT 0,1
SELECT id FROM calls WHERE repeat_parent_id = 'c94a263b-747b-d4f1-f2f5-589c85af76fe' AND deleted ='0'ORDER BY date_start
SELECT aos_quotes.id AS id FROM aos_quotes  WHERE NOT EXISTS (SELECT * FROM aow_processed WHERE aow_processed.aow_workflow_id='' AND aow_processed.parent_id=aos_quotes.id AND aow_processed.status = 'Complete' AND aow_processed.deleted ='0' AND aos_quotes.deleted ='0'
SELECT * FROM prospect_lists_prospects WHERE deleted = '0'   AND related_id = '2'  AND prospect_list_id = '1a06a34d-9a05-c9dc-5a8b-589c85760304' 
SELECT contact_id id FROM contacts_users  WHERE contacts_users.user_id = '' AND contacts_users.deleted='0'
SELECT email_id id FROM emails_beans  WHERE emails_beans.bean_id = 'b5053637-72bf-2991-1f1f-589c85d9d496' AND emails_beans.bean_module = 'AOS_Contracts' AND emails_beans.deleted='0'
SELECT id FROM aor_fields WHERE aor_report_id = '' AND group_display ='1'AND deleted ='0'ORDER BY field_order ASC LIMIT 0,1
SELECT id FROM notes WHERE notes.created_by = '' AND notes.deleted='0'
SELECT job_queue.* FROM job_queue  WHERE job_queue.id = '66c88bff-987b-ad1c-5f53-589c8507856c' AND job_queue.deleted='0'LIMIT 0,1
SELECT * FROM roles_users WHERE deleted = '0'   AND user_id = '2'  AND role_id = '1' 
SELECT users.* FROM users  WHERE users.id = 'cec00d21-5ea1-f407-be72-589c7d71586a' AND users.deleted='0'LIMIT 0,1
SELECT calls_users.required, calls_users.accept_status, calls_users.call_id from calls_users where calls_users.user_id='' AND ( calls_users.accept_status IS NULL OR  calls_users.accept_status='none') AND calls_users.deleted='0'
SELECT id FROM notes WHERE notes.parent_id = '' AND notes.deleted='0'AND notes.parent_type = 'Accounts'
SELECT id FROM eapm WHERE eapm.assigned_user_id = '' AND eapm.deleted='0'
SELECT id FROM aow_actions WHERE aow_workflow_id = '1' AND deleted ='0'ORDER BY action_order ASC
SELECT users.id, users.user_name, users.first_name, users.last_name FROM users WHERE deleted='0'AND status = 'Active' AND is_group='0'ORDER BY users.last_name, users.first_name
SELECT meetings.*,meetings_cstm.* FROM meetings  LEFT JOIN meetings_cstm ON meetings.id = meetings_cstm.id_c  WHERE meetings.id = 'cce0654f-a2d9-da15-68a8-589c8458adac' AND meetings.deleted='0'LIMIT 0,1
SELECT first_name, last_name FROM contacts WHERE id='1' AND deleted='0'LIMIT 0,1
SELECT opportunities.*, opportunities_cstm.* FROM opportunities LEFT JOIN opportunities_cstm ON opportunities.id = opportunities_cstm.id_c  LEFT JOIN projects_opportunities ON opportunities.id = projects_opportunities.opportunity_id AND projects_opportunities.deleted ='0' WHERE opportunities.deleted ='0'AND projects_opportunities.project_id = '1' LIMIT 0,1
SELECT contact_id as id from calls_contacts where call_id='1' AND deleted='0'
SELECT documents_id id FROM aos_contracts_documents  WHERE aos_contracts_documents.aos_contracts_id = 'b5053637-72bf-2991-1f1f-589c85d9d496' AND aos_contracts_documents.deleted='0'
SELECT id FROM aos_product_categories WHERE aos_product_categories.parent_category_id = '1c378ecd-b7a5-090b-22f2-589c85e94f55' AND aos_product_categories.deleted='0'
SELECT count(*) AS the_count FROM config WHERE category = 'sugarfeed' AND name = 'module_Accounts'
SELECT count(*) c FROM emails   JOIN emails_text on emails.id = emails_text.email_id   WHERE (emails.type= 'inbound' OR emails.type='archived' OR emails.type='out') AND emails.deleted ='0'
SELECT tracker_url from campaign_trkrs where id='1'
SELECT accounts.id, accounts_cstm.id_c FROM accounts  LEFT JOIN accounts_cstm ON accounts.id = accounts_cstm.id_c  WHERE accounts.deleted ='0'AND accounts.id = '1'
SELECT users.* from users_signatures,users  WHERE  users_signatures.user_id=users.id AND users_signatures.user_id='1' AND users.deleted='0'AND users_signatures.deleted='0'
SELECT document_id id FROM documents_cases  WHERE documents_cases.case_id = '610b3ee0-80df-4b8f-54d1-589c8545f8c6' AND documents_cases.deleted='0'
SELECT category, name, value FROM config
SELECT aos_quotes6b83nvoices_idb id FROM aos_quotes_aos_invoices_c  WHERE aos_quotes_aos_invoices_c.aos_quotes77d9_quotes_ida = '621d577d-e027-d13e-f0fe-589c85da3bce' AND aos_quotes_aos_invoices_c.deleted='0'
SELECT COUNT(*) AS count FROM campaign_log WHERE campaign_id = '' AND target_id IS NULL AND activity_type = 'lead' LIMIT 0,1
SELECT aos_quotes7207project_idb id FROM aos_quotes_project_c  WHERE aos_quotes_project_c.aos_quotes1112_quotes_ida = '621d577d-e027-d13e-f0fe-589c85da3bce' AND aos_quotes_project_c.deleted='0'
SELECT distinct item_id AS item_id, id, item_summary, module_name, monitor_id, date_modified FROM tracker WHERE user_id = '1' AND deleted ='0'AND visible ='1' ORDER BY date_modified DESC LIMIT 0,50
SELECT u1.first_name, u1.last_name from users u1, users u2 where u1.id = u2.reports_to_id AND u2.id = '1' and u1.deleted='0'
SELECT * from relationships where deleted='0'
SELECT id FROM users WHERE id = '1' AND is_admin ='1'AND deleted ='0'AND status = 'Active' LIMIT 0,1
SELECT parent_id, parent_type FROM favorites WHERE assigned_user_id = '' AND parent_id = '1' AND deleted ='0'ORDER BY date_entered DESC
SELECT id FROM aor_fields WHERE aor_report_id = '' AND deleted ='0'ORDER BY field_order ASC
SELECT name  , assigned_user_id parent_name_owner  from accounts where id = '1'
SELECT user_id as id FROM roles_users WHERE role_id='1' AND deleted='0'
SELECT id, file_mime_type FROM notes WHERE parent_id = '' AND deleted ='0'
SELECT aos_quotes4dc0ntracts_idb id FROM aos_quotes_os_contracts_c  WHERE aos_quotes_os_contracts_c.aos_quotese81e_quotes_ida = '621d577d-e027-d13e-f0fe-589c85da3bce' AND aos_quotes_os_contracts_c.deleted='0'
SELECT aos_line_item_groups.* FROM aos_line_item_groups  WHERE aos_line_item_groups.id = '1228c4a9-614c-31e7-7542-589c85451f14' AND aos_line_item_groups.deleted='0'LIMIT 0,1
SELECT id ,LTRIM(RTRIM(CONCAT(IFNULL(contacts.first_name,''),' ',IFNULL(contacts.last_name,'')))) as parent_name ,contacts.first_name as parent_first_name ,contacts.last_name as parent_last_name , contacts.assigned_user_id owner FROM contacts WHERE deleted='0'AND id='1'
SELECT user_id id FROM calls_users  WHERE calls_users.call_id = '1' AND calls_users.deleted='0'
SELECT * FROM acl_roles_actions WHERE deleted = '0'   AND role_id = '1'  AND action_id = '1' 
SELECT document_revisions.* FROM document_revisions  WHERE document_revisions.id = '3c9f3299-3069-8feb-4a9c-589c85a22713' AND document_revisions.deleted='0'LIMIT 0,1
SELECT * FROM oauth_nonce WHERE conskey='' AND nonce='' AND nonce_ts ='123'
SELECT am_projecttemplates_ida id FROM am_projecttemplates_users_1_c  WHERE am_projecttemplates_users_1_c.users_idb = 'd9c07713-989b-ccdc-2cad-589c8529ef35' AND am_projecttemplates_users_1_c.deleted='0'
SELECT meetings.id, meetings_cstm.id_c FROM meetings  LEFT JOIN meetings_cstm ON meetings.id = meetings_cstm.id_c  WHERE meetings.deleted ='0'AND  meetings.parent_type = 'Accounts' AND  meetings.parent_id = '1'
SELECT role_id id FROM acl_roles_actions  WHERE acl_roles_actions.action_id = '' AND acl_roles_actions.deleted='0'
SELECT accounts.*, accounts_cstm.* FROM accounts LEFT JOIN accounts_cstm ON accounts.id = accounts_cstm.id_c  LEFT JOIN projects_accounts ON accounts.id = projects_accounts.account_id AND projects_accounts.deleted ='0' WHERE accounts.deleted ='0'AND projects_accounts.project_id = '1' LIMIT 0,1
SELECT id, first_name, last_name, user_name from users WHERE status='Inactive' AND portal_only='0' ORDER BY  user_name ASC 
SELECT name from prospect_lists  INNER JOIN email_marketing_prospect_lists empl ON empl.prospect_list_id = prospect_lists.id WHERE empl.email_marketing_id='' AND prospect_lists.deleted='0'AND empl.deleted='0'AND prospect_lists.list_type!='test'
SELECT id FROM tasks WHERE tasks.parent_id = 'b73ad8f7-7e94-2e67-2afc-589c85f52879' AND tasks.deleted='0'AND tasks.parent_type = 'ProjectTask'
select id from currencies where name='US Dollars' and deleted=0;
SELECT user_preferences.* FROM user_preferences  WHERE assigned_user_id = '1' AND category = 'home' AND deleted='0'LIMIT 0,1
SELECT prospect_list_id id FROM prospect_lists_prospects  WHERE prospect_lists_prospects.related_id = 'd9c07713-989b-ccdc-2cad-589c8529ef35' AND prospect_lists_prospects.related_type = 'Users' AND prospect_lists_prospects.deleted='0'
SELECT id FROM aow_workflow WHERE aow_workflow.flow_module = 'EAPM' AND aow_workflow.status = 'Active' AND (aow_workflow.run_when = 'Always' OR aow_workflow.run_when = 'On_Save' OR aow_workflow.run_when = 'Create') AND aow_workflow.deleted ='0'
SELECT accounts.*, accounts_cstm.* FROM accounts LEFT JOIN accounts_cstm ON accounts.id = accounts_cstm.id_c  LEFT JOIN accounts_cases ON accounts.id = accounts_cases.account_id AND accounts_cases.deleted ='0' WHERE accounts.deleted ='0'AND accounts_cases.case_id = '1' LIMIT 0,1
SELECT id ,emails.name as parent_name , emails.assigned_user_id owner FROM emails WHERE deleted='0'AND id='1'
SELECT meeting_id as id from meetings_users where user_id='' AND deleted='0'
SELECT * FROM meetings_cstm WHERE id_c='1'
SELECT count(*) AS num FROM roles_users WHERE user_id='2' AND deleted='0'
SELECT id FROM currencies WHERE symbol='\$' AND deleted=0;
SELECT * FROM email_addresses WHERE email_address_caps = 'ONE@EMAIL.COM' and deleted='0'
SELECT id ,calls.name as parent_name , calls.assigned_user_id owner FROM calls WHERE deleted='0'AND id='1'
SELECT users.* FROM users  WHERE users.id = '42494856-4357-0ff9-d7a8-58974c4b55f8' AND users.deleted='0'LIMIT 0,1
SELECT * FROM fields_meta_data WHERE  custom_module='Reminders_Invitees' AND  deleted ='0'
SELECT * FROM users_signatures WHERE user_id = '1' AND deleted ='0'ORDER BY name ASC
select 1 from notes where notes.parent_id = '' and notes.deleted ='0'
SELECT accounts.*, accounts_cstm.* FROM accounts LEFT JOIN accounts_cstm  ON accounts.id = accounts_cstm.id_c  WHERE accounts.deleted ='0'AND ((accounts_cstm.jjwg_maps_lat_c ='0'AND accounts_cstm.jjwg_maps_lng_c ='0' OR (accounts_cstm.jjwg_maps_lat_c IS NULL AND accounts_cstm.jjwg_maps_lng_c IS NULL)) AND (accounts_cstm.jjwg_maps_geocode_status_c = '' OR accounts_cstm.jjwg_maps_geocode_status_c IS NULL) LIMIT 0,250
SELECT emails.* FROM emails  WHERE emails.id = 'b3cd04d9-5080-4707-0979-589c859a71d7' AND emails.deleted='0'LIMIT 0,1
SELECT aos_quotese81e_quotes_ida id FROM aos_quotes_os_contracts_c  WHERE aos_quotes_os_contracts_c.aos_quotes4dc0ntracts_idb = 'b5053637-72bf-2991-1f1f-589c85d9d496' AND aos_quotes_os_contracts_c.deleted='0'
SELECT count(*) AS num FROM prospect_lists_prospects WHERE prospect_list_id='1a06a34d-9a05-c9dc-5a8b-589c85760304' AND deleted = '0'
select id, revision from document_revisions where document_id='1' and deleted='0'
SELECT * FROM roles_modules WHERE deleted = '0'   AND module_id = 'Leads'  AND role_id = '1'  AND allow = '1' 
SELECT aor_fields.* FROM aor_fields  WHERE aor_fields.id = '2ef079b5-3a34-0c5b-f390-589c855efae6' AND aor_fields.deleted='0'LIMIT 0,1
SELECT lead_id id FROM meetings_leads  WHERE meetings_leads.meeting_id = '259c2f1b-922d-ab63-b5d9-589c85cea2d8' AND meetings_leads.deleted='0'
SELECT document_id id FROM documents_bugs  WHERE documents_bugs.bug_id = '58800532-0e9d-ccaf-e85e-589c85722403' AND documents_bugs.deleted='0'
SELECT name, assigned_user_id opportunity_name_owner FROM opportunities WHERE id='1' LIMIT 0,1
SELECT email_templates.id, name as display from email_templates where  email_templates.deleted='0'
SELECT aop_case_events.* FROM aop_case_events  WHERE aop_case_events.id = '671d1ad2-0d3d-f611-27df-589c8502ff44' AND aop_case_events.deleted='0'LIMIT 0,1
SELECT aow_action_id id FROM aow_processed_aow_actions  WHERE aow_processed_aow_actions.aow_processed_id = 'd7abea92-7cf3-ca25-d70d-589c8552ead4' AND aow_processed_aow_actions.deleted='0'
SELECT id FROM outbound_email WHERE user_id = '' 
SELECT * FROM acl_actions WHERE deleted='0' AND acltype='module'AND name='list' ORDER BY category
SELECT id FROM notes WHERE notes.modified_user_id = '' AND notes.deleted='0'
SELECT id FROM meetings WHERE meetings.parent_id = 'e3c8ca08-e16d-d18b-80c8-589c85b8ac4d' AND meetings.deleted='0'
SELECT jjwg_address_cache.* FROM jjwg_address_cache WHERE jjwg_address_cache.deleted ='0'AND jjwg_address_cache.name='test' LIMIT 0,1
SELECT emails.* FROM emails  WHERE emails.id = '0' LIMIT 0,1
SELECT id FROM cron_remove_documents WHERE module='' AND bean_id='' LIMIT 0,1
SELECT id ,LTRIM(RTRIM(CONCAT(IFNULL(contacts.first_name,''),' ',IFNULL(contacts.last_name,'')))) as contact_name , contacts.assigned_user_id owner FROM contacts WHERE deleted='0'AND id='test id'
SELECT * FROM oauth_nonce WHERE conskey='' AND nonce_ts > 123
SELECT oauth_tokens.* FROM oauth_tokens  WHERE oauth_tokens.id = '15e4eabf13e5' AND oauth_tokens.deleted='0'LIMIT 0,1
SELECT id, first_name, last_name, user_name FROM users WHERE 1='1'ORDER BY  user_name ASC 
SELECT aos_quotes.* FROM aos_quotes  WHERE aos_quotes.id = '1' AND aos_quotes.deleted='0'LIMIT 0,1
select email_address_id from email_addr_bean_rel eabr WHERE eabr.bean_id = 'd9c07713-989b-ccdc-2cad-589c8529ef35' AND eabr.bean_module = 'Users' and eabr.deleted='0'
SELECT vcals.* FROM vcals  WHERE user_id = '1' AND type = 'vfb' AND source = 'sugar' AND deleted='0'LIMIT 0,1
SELECT * FROM calls_users WHERE deleted = '0'   AND user_id = '1'  AND call_id = '1' 
SELECT contact_id id FROM calls_contacts  WHERE calls_contacts.call_id = 'c94a263b-747b-d4f1-f2f5-589c85af76fe' AND calls_contacts.deleted='0'
SELECT id FROM users WHERE users.reports_to_id = 'd9c07713-989b-ccdc-2cad-589c8529ef35' AND users.deleted='0'
SELECT vcals.* FROM vcals  WHERE vcals.id = '46e004b7-ac49-a870-1a0f-589c81f8df4a' AND vcals.deleted='0'LIMIT 0,1
SELECT first_name, last_name from prospects where id='1'
SELECT acc.id, acc.name, acc.assigned_user_id FROM accounts acc, accounts_opportunities a_o WHERE acc.id=a_o.account_id AND a_o.opportunity_id='1' AND a_o.deleted='0'AND acc.deleted='0'
SELECT id FROM notes WHERE notes.assigned_user_id = '' AND notes.deleted='0'
SELECT id FROM calls WHERE calls.parent_id = '58800532-0e9d-ccaf-e85e-589c85722403' AND calls.deleted='0'AND calls.parent_type = 'Bugs'
SELECT id FROM users WHERE users.is_group ='1'AND deleted ='0'
SELECT id, name, list_type FROM prospect_lists WHERE deleted ='0'ORDER BY name ASC
SELECT bug_id id FROM cases_bugs  WHERE cases_bugs.case_id = '610b3ee0-80df-4b8f-54d1-589c8545f8c6' AND cases_bugs.deleted='0'
select document_name from documents where id='1'  and deleted='0'
SELECT id FROM securitygroups_users WHERE user_id = '1' AND securitygroup_id = '1' AND deleted='0'LIMIT 0,1
SELECT id, email_address, invalid_email, opt_out FROM email_addresses WHERE id IN ('b0800029-cc5f-8c5d-a47c-589c844a69d8', 'b10d3d59-ab27-3b26-13ee-589c84de0d8e') AND deleted='0'
select amount, id from opportunities where (currency_id='GBP' or currency_id='EUR') and deleted='0'and opportunities.sales_stage <> 'Closed Won' AND opportunities.sales_stage <> 'Closed Lost';
SELECT project_id id FROM projects_bugs  WHERE projects_bugs.bug_id = '58800532-0e9d-ccaf-e85e-589c85722403' AND projects_bugs.deleted='0'
SELECT id, name, symbol, conversion_rate FROM currencies WHERE status = 'Active' and deleted ='0'
SELECT aow_processed.* FROM aow_processed  WHERE aow_workflow_id = '' AND parent_id = '' AND deleted='0'LIMIT 0,1
SELECT relationship_name FROM relationships WHERE deleted='0'AND relationship_name = 'test_test'
SELECT meetings.* from meetings_users,meetings  WHERE ((meetings.date_start >= '2016-08-09 15:06:04' AND meetings.date_start < '2017-08-09 15:06:04') OR (meetings.date_start < '2016-08-09 15:06:04' AND meetings.date_end > '2016-08-09 15:06:04') AND meetings_users.accept_status != 'decline') AND  meetings_users.meeting_id=meetings.id AND meetings_users.user_id='' AND meetings.deleted='0'AND meetings_users.deleted='0'
SELECT id FROM aop_case_updates WHERE aop_case_updates.case_id = '610b3ee0-80df-4b8f-54d1-589c8545f8c6' AND aop_case_updates.deleted='0'
SELECT id FROM aor_conditions WHERE aor_report_id = '1' AND deleted ='0'ORDER BY condition_order ASC
SELECT id, name FROM securitygroups WHERE securitygroups.deleted ='0'ORDER BY name
SELECT acl_roles.* FROM acl_roles  WHERE acl_roles.id = '1' AND acl_roles.deleted='0'LIMIT 0,1
SELECT * FROM outbound_email WHERE id = 'def51767-c847-792d-ee8f-589748efcb71'
