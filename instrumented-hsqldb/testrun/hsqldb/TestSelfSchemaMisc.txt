drop schema schemafk1 if exists
drop schema schemafk2 if exists
create schema schemafk1 authorization dba;
create table schemafk1.table1 ( table1_id integer primary key);
create schema schemafk2 authorization dba;
create table schemafk2.table2 (table2_id integer primary key, table1_id
 integer, foreign key (table1_id) references schemafk1.table1);
create table schemafk2.table3 (table3_id integer primary key, table1_id integer);
alter table schemafk2.table3 add constraint fktbl3 foreign key (table1_id)
 references schemafk1.table1;
create table schemafk2.table4 (table4_id integer primary key, table1_id integer);
alter table schemafk2.table4 add constraint fktbl4 foreign key (table1_id)
 references schemafk1.table1 (table1_id);

comment on table schemafk1.table1 is 'a short table comment';
comment on column schemafk1.table1.table1_id is 'a short column comment';

/*c2*/select * from information_schema.system_comments where object_schema='SCHEMAFK1'
