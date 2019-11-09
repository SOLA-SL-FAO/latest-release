--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = source, pg_catalog;

--
-- Data for Name: archive; Type: TABLE DATA; Schema: source; Owner: postgres
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE archive DISABLE TRIGGER ALL;

INSERT INTO archive (id, name, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('archive-id', 'Land Information New Zealand Landonline', '0e20efb6-99de-11e3-860a-437de73932f9', 1, 'i', 'test', '2014-02-20 16:21:15.006');


ALTER TABLE archive ENABLE TRIGGER ALL;

--
-- Data for Name: source; Type: TABLE DATA; Schema: source; Owner: postgres
--

ALTER TABLE source DISABLE TRIGGER ALL;

INSERT INTO source (id, maintype, la_nr, reference_nr, archive_id, acceptance, recordation, submission, expiration_date, ext_archive_id, availability_status_code, type_code, content, status_code, transaction_id, owner_name, version, description, signing_date, classification_code, redact_code, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('0e2339b0-99de-11e3-b14f-8f843c971634', 'mapDigital', 'Landonline', NULL, 'archive-id', NULL, NULL, '2011-06-29', NULL, NULL, 'available', 'cadastralMap', 'Land Information New Zealand Landonline', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0e2360c0-99de-11e3-aeb5-2f4cc95d3b6b', 1, 'i', 'test', '2014-02-20 16:21:15.014');
INSERT INTO source (id, maintype, la_nr, reference_nr, archive_id, acceptance, recordation, submission, expiration_date, ext_archive_id, availability_status_code, type_code, content, status_code, transaction_id, owner_name, version, description, signing_date, classification_code, redact_code, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('76b2f8ae-db3d-4033-8c9e-0961e4dd1574', NULL, '140220-000000001', NULL, NULL, NULL, '2014-02-20', '2014-02-20', NULL, 'd3ac733d-3679-4351-89ef-35151f2745a5', 'available', 'agreement', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '62fda8d0-48f4-40d8-8e28-8601d331da37', 1, 'i', 'test', '2014-02-20 16:38:56.443');
INSERT INTO source (id, maintype, la_nr, reference_nr, archive_id, acceptance, recordation, submission, expiration_date, ext_archive_id, availability_status_code, type_code, content, status_code, transaction_id, owner_name, version, description, signing_date, classification_code, redact_code, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('d29d94ec-6958-485c-9fd1-aa452b7f626b', NULL, '141110-000000001', NULL, NULL, '2014-11-10', '2014-11-09', '2014-11-10', NULL, NULL, 'available', 'agreement', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4b0484e8-cdc7-4950-98de-4e5efc150537', 1, 'i', 'test', '2014-11-10 10:31:44.372342');
INSERT INTO source (id, maintype, la_nr, reference_nr, archive_id, acceptance, recordation, submission, expiration_date, ext_archive_id, availability_status_code, type_code, content, status_code, transaction_id, owner_name, version, description, signing_date, classification_code, redact_code, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('9b21b4a2-a601-401c-997b-b28046b5606f', NULL, '141210-000000002', 'C/O 12345678', NULL, NULL, '2010-10-09', '2014-12-10', NULL, NULL, 'available', 'courtOrder', NULL, NULL, NULL, NULL, NULL, 'court order concerning protection of cultural site', NULL, NULL, NULL, '977ca2d4-d701-4776-8599-2abbd4211cbc', 1, 'i', 'test', '2014-12-10 01:58:25.743548');
INSERT INTO source (id, maintype, la_nr, reference_nr, archive_id, acceptance, recordation, submission, expiration_date, ext_archive_id, availability_status_code, type_code, content, status_code, transaction_id, owner_name, version, description, signing_date, classification_code, redact_code, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('a74c3f40-6712-42b2-8d20-8907c9b4fc05', NULL, '141214-000000003', 'Proc 234987', NULL, NULL, '2012-12-19', '2014-12-14', NULL, NULL, 'available', 'proclamation', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '831c1628-0615-4578-aa8f-d4f566a3ff47', 1, 'i', 'test', '2014-12-14 07:21:23.622446');


ALTER TABLE source ENABLE TRIGGER ALL;

SET search_path = administrative, pg_catalog;

--
-- Data for Name: source_describes_ba_unit; Type: TABLE DATA; Schema: administrative; Owner: postgres
--

ALTER TABLE source_describes_ba_unit DISABLE TRIGGER ALL;



ALTER TABLE source_describes_ba_unit ENABLE TRIGGER ALL;

--
-- Data for Name: source_describes_rrr; Type: TABLE DATA; Schema: administrative; Owner: postgres
--

ALTER TABLE source_describes_rrr DISABLE TRIGGER ALL;



ALTER TABLE source_describes_rrr ENABLE TRIGGER ALL;

--
-- Data for Name: source_describes_valuation; Type: TABLE DATA; Schema: administrative; Owner: postgres
--

ALTER TABLE source_describes_valuation DISABLE TRIGGER ALL;

INSERT INTO source_describes_valuation (valuation_id, source_id, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('b216c82c-9e22-4a63-b57d-a0156c36be80', '76b2f8ae-db3d-4033-8c9e-0961e4dd1574', 'f99272bb-942b-44f1-b91a-fad6ad17839e', 1, 'i', 'test', '2014-12-09 19:32:21.892356');


ALTER TABLE source_describes_valuation ENABLE TRIGGER ALL;

SET search_path = application, pg_catalog;

--
-- Data for Name: application_uses_source; Type: TABLE DATA; Schema: application; Owner: postgres
--

ALTER TABLE application_uses_source DISABLE TRIGGER ALL;

INSERT INTO application_uses_source (application_id, source_id, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('3040', '76b2f8ae-db3d-4033-8c9e-0961e4dd1574', '1585773e-c47a-4070-9744-563507de39e3', 1, 'i', 'test', '2014-02-20 16:38:56.443');


ALTER TABLE application_uses_source ENABLE TRIGGER ALL;

--
-- Data for Name: negotiate_uses_source; Type: TABLE DATA; Schema: application; Owner: postgres
--

ALTER TABLE negotiate_uses_source DISABLE TRIGGER ALL;



ALTER TABLE negotiate_uses_source ENABLE TRIGGER ALL;

--
-- Data for Name: notify_uses_source; Type: TABLE DATA; Schema: application; Owner: postgres
--

ALTER TABLE notify_uses_source DISABLE TRIGGER ALL;



ALTER TABLE notify_uses_source ENABLE TRIGGER ALL;

--
-- Data for Name: objection_uses_source; Type: TABLE DATA; Schema: application; Owner: postgres
--

ALTER TABLE objection_uses_source DISABLE TRIGGER ALL;



ALTER TABLE objection_uses_source ENABLE TRIGGER ALL;

--
-- Data for Name: public_display_item_uses_source; Type: TABLE DATA; Schema: application; Owner: postgres
--

ALTER TABLE public_display_item_uses_source DISABLE TRIGGER ALL;



ALTER TABLE public_display_item_uses_source ENABLE TRIGGER ALL;

SET search_path = source, pg_catalog;

--
-- Data for Name: power_of_attorney; Type: TABLE DATA; Schema: source; Owner: postgres
--

ALTER TABLE power_of_attorney DISABLE TRIGGER ALL;



ALTER TABLE power_of_attorney ENABLE TRIGGER ALL;

--
-- Data for Name: spatial_source; Type: TABLE DATA; Schema: source; Owner: postgres
--

ALTER TABLE spatial_source DISABLE TRIGGER ALL;



ALTER TABLE spatial_source ENABLE TRIGGER ALL;

--
-- Data for Name: spatial_source_measurement; Type: TABLE DATA; Schema: source; Owner: postgres
--

ALTER TABLE spatial_source_measurement DISABLE TRIGGER ALL;



ALTER TABLE spatial_source_measurement ENABLE TRIGGER ALL;

--
-- PostgreSQL database dump complete
--

