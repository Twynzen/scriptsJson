--Muchas validaciones
update errors_users set (id_v1, id_v3, name_v1, username_v1, email_v1, email_v4, phone_v1, website_v1, website_v4) = 
        (
        
        select 
        length(t2.id) = 0 as id_v1, 
        t1.count_id as id_v3, 
        length(t2.name) < 4 as name_v1, 
        length(t2.username) < 6 as username_v1, 
        length(t2.email) < 15 as email_v1, 
        instr(t2.email, "@") < 6 as email_v4, 
        length(t2.phone) < 8 as phone_v1,
        length(t2.website) < 6 as website_v1,
        (instr(t2.website, '.com') + 
        instr(t2.website, '.co') + 
        instr(t2.website, '.org') + 
        instr(t2.website, '.info') +
        instr(t2.website, '.net') +
        instr(t2.website, '.io') +
        instr(t2.website, '.biz')) < 3 as website_v4
        from etl_users AS t2 left join
        (select id,count(id)>1 as count_id
        from etl_users        
        group by id ) AS t1 ON t1.id = t2.id
        where errors_users.ident = t2.ident
        )



insert into errors_posts (ident)
select ident from etl_posts


update errors_posts set (
userId_v1, userId_v2, id_v1, id_v3, title_v1, body_v1
) =
(select
length(t2.userId) < 1 as userId_v1, 
etl_users.id is NULL as userId_v2, 
length(t2.id) < 1 as id_v1,
t1.count_id as id_v3,
length(t2.title) < 3 as title_v1,
length(t2.body) < 8 as body_v1 
from etl_posts AS t2
LEFT JOIN etl_users ON etl_users.id = t2.userId
LEFT JOIN (
select id,count(id)>1 as count_id
        from etl_posts        
        group by id ) AS t1 ON t1.id = t2.id
                where errors_posts.ident = t2.ident
                )
                



insert into users (id)
select id from etl_users AS t1
inner join (
SELECT errors_users.ident from errors_users
        where (
                id_v1 = 0 AND 
                id_v3 = 0 AND 
                name_v1 = 0 AND 
                username_v1 = 0 AND
                email_v1 = 0 AND
                email_v4 = 0 AND
                phone_v1 = 0 AND
                website_v1 = 0 AND
                website_v4 = 0) ) AS t2 ON t1.ident = t2.ident
                WHERE t1.inserto != 1
;
UPDATE etl_users set inserto = 1
where EXISTS (
SELECT users.id
FROM users
WHERE users.id = etl_users.id) AND etl_users.inserto != 1

versión 2:20am
insert into users (id, name,username, email, phone, website)
select id, name,username, email, phone, website from etl_users AS t1
inner join (
SELECT errors_users.ident from errors_users
        where (
                id_v1 = 0 AND 
                id_v3 = 0 AND 
                name_v1 = 0 AND 
                username_v1 = 0 AND
                email_v1 = 0 AND
                email_v4 = 0 AND
                phone_v1 = 0 AND
                website_v1 = 0 AND
                website_v4 = 0) ) AS t2 ON t1.ident = t2.ident
                WHERE t1.inserto != 1
;
UPDATE etl_users set inserto = 1
where EXISTS (
SELECT users.id
FROM users
WHERE users.id = etl_users.id) AND etl_users.inserto != 1




insert into users (id, name,username, email, phone, website)
select id, name,username, email, phone, website from etl_users AS t1
inner join (
SELECT errors_users.ident from errors_users
        where (
                id_v1 = 0 AND 
                id_v3 = 0 AND 
                name_v1 = 0 AND 
                username_v1 = 0 AND
                email_v1 = 0 AND
                email_v4 = 0 AND
                phone_v1 = 0 AND
                website_v1 = 0 AND
                website_v4 = 0) ) AS t2 ON t1.ident = t2.ident
                WHERE t1.inserto != 1
;
UPDATE etl_users set inserto = 1
where EXISTS (
SELECT users.id
FROM users
WHERE users.id = etl_users.id) AND etl_users.inserto != 1;

insert into posts (id, userId,title, body)
select id, userId,title, body from etl_posts AS t1
inner join (
SELECT errors_posts.ident from errors_posts
        where (
                userId_v1 = 0 AND
                                userId_v2 = 0 AND
                                id_v1 = 0 AND
                                id_v3 = 0 AND
                                title_v1 = 0 AND
                                body_v1 = 0) AND EXISTS (select users.id from users left JOIN etl_posts on etl_posts.userId = users.id  where etl_posts.ident = errors_posts.ident) ) AS t2 ON t1.ident = t2.ident
                WHERE t1.inserto != 1
;
UPDATE etl_posts set inserto = 1
where EXISTS (
SELECT posts.id
FROM posts
WHERE posts.id = etl_posts.id) AND etl_posts.inserto != 1






update errors_posts set (
userId_v1, userId_v2, id_v1, id_v3, title_v1, body_v1, userId_v3
) =
(select
length(t2.userId) < 1 as userId_v1, 
etl_users.id is NULL as userId_v2, 
length(t2.id) < 1 as id_v1,
t1.count_id as id_v3,
length(t2.title) < 3 as title_v1,
length(t2.body) < 8 as body_v1,
t3.id is not null as userId_v3
from etl_posts AS t2
LEFT JOIN etl_users ON etl_users.id = t2.userId
LEFT JOIN (
select id,count(id)>1 as count_id
        from etl_posts        
        group by id ) AS t1 ON t1.id = t2.id
LEFT JOIN (
select id
        from etl_users
where ifnull(inserto, 0) = 0        
) AS t3 ON t3.id = t2.userId
                where errors_posts.ident = t2.ident
                )

--------------------------------------------------------------------------------------------------------------------------------
insert into users (id, name,username, email, phone, website)
select id, name,username, email, phone, website from etl_users AS t1
inner join (
SELECT errors_users.ident from errors_users
        where (
                id_v1 = 0 AND 
                id_v3 = 0 AND 
                name_v1 = 0 AND 
                username_v1 = 0 AND
                email_v1 = 0 AND
                email_v4 = 0 AND
                phone_v1 = 0 AND
                website_v1 = 0 AND
                website_v4 = 0
                                ) ) AS t2 ON t1.ident = t2.ident
                WHERE t1.inserto is null
;

UPDATE etl_users set (inserto)=
( 
select Date('now') from errors_users
where 
                id_v1 = 0 AND 
                id_v3 = 0 AND 
                name_v1 = 0 AND 
                username_v1 = 0 AND
                email_v1 = 0 AND
                email_v4 = 0 AND
                phone_v1 = 0 AND
                website_v1 = 0 AND
                website_v4 = 0 AND 
                                etl_users.ident = errors_users.ident
                                ) 
                                where inserto is NULL
;
insert into posts (id, userId,title, body)
select id, userId,title, body from etl_posts AS t1
inner join (
SELECT errors_posts.ident from errors_posts
        where (
                userId_v1 = 0 AND
                                userId_v2 = 0 AND
                                id_v1 = 0 AND
                                id_v3 = 0 AND
                                title_v1 = 0 AND
                                body_v1 = 0 AND 
                                ifnull(userId_v3,0) = 0)) AS t2 ON t1.ident = t2.ident
                WHERE t1.inserto is NULL
;
UPDATE etl_posts set inserto = 
(
select Date('now') from errors_posts
 where 
                userId_v1 = 0 AND
                                userId_v2 = 0 AND
                                id_v1 = 0 AND
                                id_v3 = 0 AND
                                title_v1 = 0 AND
                                body_v1 = 0 AND 
                                ifnull(userId_v3,0) = 0 AND
                                etl_posts.ident = errors_posts.ident
) where inserto is null



ERRORS_POSTS

update errors_posts set (
userId_v1, userId_v2, id_v1, id_v3, title_v1, body_v1, userId_v3
) =
(select
length(t2.userId) < 1 as userId_v1, 
etl_users.id is NULL as userId_v2, 
length(t2.id) < 1 as id_v1,
t1.count_id as id_v3,
length(t2.title) < 3 as title_v1,
length(t2.body) < 8 as body_v1,
t3.id is not null as userId_v3
from etl_posts AS t2
LEFT JOIN etl_users ON etl_users.id = t2.userId
LEFT JOIN (
select id,count(id)>1 as count_id
        from etl_posts        
        group by id ) AS t1 ON t1.id = t2.id
LEFT JOIN (
select id
        from etl_users
where inserto is NULL       
) AS t3 ON t3.id = t2.userId
                where errors_posts.ident = t2.ident
                )

