use jdbc;

create table tbl_reply(
   id bigint unsigned auto_increment primary key,
   reply_content varchar(255) not null,
   reply_status enum('disable', 'enable') default 'enable',
   created_date datetime default current_timestamp(),
   updated_date datetime default current_timestamp(),
   post_id bigint unsigned not null,
   member_id bigint unsigned not null,
   constraint fk_reply_post foreign key(post_id)
   references tbl_post(id),
   constraint fk_reply_member foreign key(member_id)
   references tbl_member(id)
);

select * from tbl_reply;