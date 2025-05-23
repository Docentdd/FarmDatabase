INSERT INTO role (id, name)
VALUES (1, 'ROLE_1'),
       (2, 'ROLE_2'),
       (3, 'ROLE_3'),
       (4, 'ROLE_4'),
       (5, 'ROLE_5'),
       (6, 'ROLE_6'),
       (7, 'ROLE_7'),
       (8, 'ROLE_8'),
       (9, 'ROLE_9'),
       (10, 'ROLE_10'),
       (11, 'ROLE_11'),
       (12, 'ROLE_12'),
       (13, 'ROLE_13'),
       (14, 'ROLE_14'),
       (15, 'ROLE_15'),
       (16, 'ROLE_16'),
       (17, 'ROLE_17'),
       (18, 'ROLE_18'),
       (19, 'ROLE_19'),
       (20, 'ROLE_20');

INSERT INTO "user" (id, email)
VALUES (1, 'user1@example.com'),
       (2, 'user2@example.com'),
       (3, 'user3@example.com'),
       (4, 'user4@example.com'),
       (5, 'user5@example.com'),
       (6, 'user6@example.com'),
       (7, 'user7@example.com'),
       (8, 'user8@example.com'),
       (9, 'user9@example.com'),
       (10, 'user10@example.com'),
       (11, 'user11@example.com'),
       (12, 'user12@example.com'),
       (13, 'user13@example.com'),
       (14, 'user14@example.com'),
       (15, 'user15@example.com'),
       (16, 'user16@example.com'),
       (17, 'user17@example.com'),
       (18, 'user18@example.com'),
       (19, 'user19@example.com'),
       (20, 'user20@example.com');

INSERT INTO user_roles (user_id, role_id)
VALUES (1, 1),
       (1, 2),
       (2, 2),
       (2, 3),
       (3, 3),
       (3, 4),
       (4, 4),
       (4, 5),
       (5, 5),
       (5, 6),
       (6, 6),
       (6, 7),
       (7, 7),
       (7, 8),
       (8, 8),
       (8, 9),
       (9, 9),
       (9, 10),
       (10, 10),
       (10, 1),
       (11, 11),
       (11, 12),
       (12, 12),
       (12, 13),
       (13, 13),
       (13, 14),
       (14, 14),
       (14, 15),
       (15, 15),
       (15, 16),
       (16, 16),
       (16, 17),
       (17, 17),
       (17, 18),
       (18, 18),
       (18, 19),
       (19, 19),
       (19, 20),
       (20, 20),
       (20, 1);

INSERT INTO blog (id, name, manager_id)
VALUES (1, 'Blog 1', 1),
       (2, 'Blog 2', 2),
       (3, 'Blog 3', 3),
       (4, 'Blog 4', 4),
       (5, 'Blog 5', 5),
       (6, 'Blog 6', 6),
       (7, 'Blog 7', 7),
       (8, 'Blog 8', 8),
       (9, 'Blog 9', 9),
       (10, 'Blog 10', 10),
       (11, 'Blog 11', 11),
       (12, 'Blog 12', 12),
       (13, 'Blog 13', 13),
       (14, 'Blog 14', 14),
       (15, 'Blog 15', 15),
       (16, 'Blog 16', 16),
       (17, 'Blog 17', 17),
       (18, 'Blog 18', 18),
       (19, 'Blog 19', 19),
       (20, 'Blog 20', 20);

INSERT INTO article (id, title, author_id, blog_id)
VALUES (1, 'Article 1', 1, 1),
       (2, 'Article 2', 2, 2),
       (3, 'Article 3', 3, 3),
       (4, 'Article 4', 4, 4),
       (5, 'Article 5', 5, 5),
       (6, 'Article 6', 6, 6),
       (7, 'Article 7', 7, 7),
       (8, 'Article 8', 8, 8),
       (9, 'Article 9', 9, 9),
       (10, 'Article 10', 10, 10),
       (11, 'Article 11', 11, 11),
       (12, 'Article 12', 12, 12),
       (13, 'Article 13', 13, 13),
       (14, 'Article 14', 14, 14),
       (15, 'Article 15', 15, 15),
       (16, 'Article 16', 16, 16),
       (17, 'Article 17', 17, 17),
       (18, 'Article 18', 18, 18),
       (19, 'Article 19', 19, 19),
       (20, 'Article 20', 20, 20);

ALTER TABLE "user" ALTER COLUMN id RESTART WITH 21;
ALTER TABLE blog ALTER COLUMN id RESTART WITH 21;
ALTER TABLE article ALTER COLUMN id RESTART WITH 21;
ALTER TABLE role ALTER COLUMN id RESTART WITH 21;