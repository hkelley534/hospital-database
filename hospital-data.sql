USE hospital;

INSERT INTO rooms VALUES (1001, 1, 3250);
INSERT INTO rooms VALUES (1002, 1, 2300);
INSERT INTO rooms VALUES (1003, 2, 1600);
INSERT INTO rooms VALUES (1004, 2, 2225);
INSERT INTO rooms VALUES (1005, 3, 1400);

INSERT INTO contacts VALUES (001, 'Clara Bishop', '165-159-1592', '160 Spring St');
INSERT INTO contacts VALUES (002, 'Walter Daniel', '610-109-6390', '');
INSERT INTO contacts VALUES (003, 'Ann Rhodes', '150-730-7302', '');
INSERT INTO contacts VALUES (004, 'Jeremiah Manning', '373-650-6820', '');
INSERT INTO contacts VALUES (005, 'Dawn Clarke', '739-970-1875', '');
INSERT INTO contacts VALUES (006, 'Randall Schultz', '150-262-6797', '');
INSERT INTO contacts VALUES (007, 'Linda Mcdonald', '763-529-6820', '');
INSERT INTO contacts VALUES (008, 'Yvette Wallace', '610-529-2691', '');
INSERT INTO contacts VALUES (009, 'Marjorie Sims', '159-529-6720', '');
INSERT INTO contacts VALUES (010, 'Dana Perkins', '906-269-1583', '');
INSERT INTO contacts VALUES (null, 'Carla Burgess', '160-152-6825', '');
INSERT INTO contacts VALUES (null, 'Neil Tran', '692-723-2930', '');
INSERT INTO contacts VALUES (null, 'Drew Olson', '156-526-1241', '');
INSERT INTO contacts VALUES (null, 'Javier Matthews', '602-142-6254', '');
INSERT INTO contacts VALUES (null, 'Velma Davidson', '925-255-1734', '');

INSERT INTO physicians VALUES (001, 519251, 'Neurology');
INSERT INTO physicians VALUES (002, 630143, 'Pathology');
INSERT INTO physicians VALUES (003, 105630, 'Dermatology');
INSERT INTO physicians VALUES (004, 690250, 'Surgery');
INSERT INTO physicians VALUES (005, 319502, 'Anesthesiology');

INSERT INTO nurses VALUES (006, 151692);
INSERT INTO nurses VALUES (007, 581905);
INSERT INTO nurses VALUES (008, 528950);
INSERT INTO nurses VALUES (009, 759210);
INSERT INTO nurses VALUES (010, 594302);

INSERT INTO patients VALUES (011, 1002, 003, 008, '2021-11-08', '2021-11-13', 'omeprazole', 2);
INSERT INTO patients VALUES (012, 1003, 002, 006, '2021-10-24', '2021-10-26', 'levothyroxine', 1);
INSERT INTO patients VALUES (013, 1004, 004, 010, '2021-10-28', '2021-10-29', 'albuterol', 2 );
INSERT INTO patients VALUES (014, 1001, 005, 007, '2021-11-06', '2021-11-09', 'metformin', 3);
INSERT INTO patients VALUES (015, 1005, 003, 009, '2021-11-14', '2021-11-16', 'rosuvastatin', 1); 

INSERT INTO patient_records VALUES (011, 01, '2018-06-05', '', '', '');
INSERT INTO patient_records VALUES (011, 02, '2020-12-14', '', '', '');
INSERT INTO patient_records VALUES (013, 03, '2017-04-23', '', '', '');
INSERT INTO patient_records VALUES (014, 04, '2019-07-20', '', '', '');
INSERT INTO patient_records VALUES (015, 05, '2020-02-29', '', '', '');

INSERT INTO physician_orders VALUES (01, '', 350.00, '2021-10-25', 002, 012);
INSERT INTO physician_orders VALUES (02, '', 550.00, '2021-10-29', 004, 013);
INSERT INTO physician_orders VALUES (03, '', 670.00, '2021-11-07', 005, 014);
INSERT INTO physician_orders VALUES (04, '', 400.00, '2021-11-12', 003, 011);
INSERT INTO physician_orders VALUES (05, '', 230.00, '2021-11-15', 003, 015);

INSERT INTO order_results VALUES (012, 007, 01, '2021-10-25', 'SUCCESS');
INSERT INTO order_results VALUES (013, 008, 02, '2021-10-29', 'SUCCESS');
INSERT INTO order_results VALUES (014, 006, 03, '2021-11-07', 'SUCCESS');
INSERT INTO order_results VALUES (011, 010, 04, '2021-11-12', 'COMPLICATIONS-DELAYED');
INSERT INTO order_results VALUES (015, 009, 05, '2021-11-15', 'SUCCESS');

INSERT INTO payments VALUES (01, 500.00, '2021-10-30');
INSERT INTO payments VALUES (02, 400.00, '2021-11-02');
INSERT INTO payments VALUES (03, 300.00, '2021-11-12');
INSERT INTO payments VALUES (04, 500.00, '2021-11-22');
INSERT INTO payments VALUES (05, 800.00, '2022-01-28');








