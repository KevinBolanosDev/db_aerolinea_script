--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-11-28 19:50:45

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16414)
-- Name: aerolinea; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aerolinea (
    id bigint NOT NULL,
    nombre text NOT NULL,
    nombre_legal text NOT NULL,
    estado text NOT NULL,
    pais_origen text NOT NULL,
    numero_empleados integer,
    sede_principal text,
    telefono text,
    email text,
    CONSTRAINT aerolinea_estado_check CHECK ((estado = ANY (ARRAY['activa'::text, 'inactiva'::text, 'suspendida'::text])))
);


ALTER TABLE public.aerolinea OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16413)
-- Name: aerolinea_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.aerolinea ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.aerolinea_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16423)
-- Name: avion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avion (
    id bigint NOT NULL,
    id_aerolinea bigint,
    modelo text NOT NULL,
    capacidad_pasajeros integer NOT NULL,
    capacidad_carga_kg integer NOT NULL,
    fecha_fabricacion date NOT NULL,
    estado text NOT NULL,
    ultima_revision date,
    proxima_revision date,
    CONSTRAINT avion_estado_check CHECK ((estado = ANY (ARRAY['activo'::text, 'mantenimiento'::text, 'reserva'::text, 'retirado'::text])))
);


ALTER TABLE public.avion OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16422)
-- Name: avion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.avion ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.avion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 16471)
-- Name: empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleado (
    id bigint NOT NULL,
    id_aerolinea bigint,
    nombre text NOT NULL,
    apellido text NOT NULL,
    tipo_documento text NOT NULL,
    numero_documento text NOT NULL,
    fecha_nacimiento date NOT NULL,
    genero text NOT NULL,
    fecha_contratacion date NOT NULL,
    cargo text NOT NULL,
    pais text NOT NULL,
    ciudad text NOT NULL,
    salario numeric(10,2) NOT NULL,
    email text,
    corporativo text,
    CONSTRAINT empleado_cargo_check CHECK ((cargo = ANY (ARRAY['piloto'::text, 'copiloto'::text, 'ingeniero vuelo'::text, 'azafata'::text, 'supervisor'::text, 'tecnico'::text, 'gerente'::text, 'administrativo'::text]))),
    CONSTRAINT empleado_genero_check CHECK ((genero = ANY (ARRAY['masculino'::text, 'femenino'::text, 'otro'::text])))
);


ALTER TABLE public.empleado OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16470)
-- Name: empleado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.empleado ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.empleado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16486)
-- Name: mantenimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mantenimiento (
    id bigint NOT NULL,
    id_avion bigint,
    id_empleado bigint,
    tipo_mantenimiento text NOT NULL,
    fecha_inicio timestamp with time zone NOT NULL,
    fecha_fin timestamp with time zone,
    estado text NOT NULL,
    duracion_horas integer,
    ubicacion text NOT NULL,
    costo_mantenimiento numeric(10,2) NOT NULL,
    CONSTRAINT mantenimiento_estado_check CHECK ((estado = ANY (ARRAY['programado'::text, 'en proceso'::text, 'completado'::text, 'cancelado'::text, 'pospuesto'::text]))),
    CONSTRAINT mantenimiento_tipo_mantenimiento_check CHECK ((tipo_mantenimiento = ANY (ARRAY['preventivo'::text, 'correctivo'::text, 'overhaul'::text, 'inspeccion'::text, 'emergencia'::text])))
);


ALTER TABLE public.mantenimiento OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16485)
-- Name: mantenimiento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.mantenimiento ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.mantenimiento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16437)
-- Name: pasajero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pasajero (
    id bigint NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    tipo_documento text NOT NULL,
    numero_documento text NOT NULL,
    fecha_nacimiento date NOT NULL,
    nacionalidad text NOT NULL,
    genero text NOT NULL,
    pais text NOT NULL,
    ciudad text NOT NULL,
    telefono text,
    email text,
    CONSTRAINT pasajero_genero_check CHECK ((genero = ANY (ARRAY['masculino'::text, 'femenino'::text, 'otro'::text])))
);


ALTER TABLE public.pasajero OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16436)
-- Name: pasajero_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.pasajero ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pasajero_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16460)
-- Name: tickete; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickete (
    id bigint NOT NULL,
    numero_tickete text NOT NULL,
    numero_asiento text NOT NULL,
    clase text NOT NULL,
    estado text NOT NULL,
    fecha_emision date NOT NULL,
    fecha_limite date NOT NULL,
    precio numeric(10,2) NOT NULL,
    id_vuelo bigint,
    id_pasajero bigint,
    CONSTRAINT tickete_clase_check CHECK ((clase = ANY (ARRAY['economica'::text, 'primera clase'::text]))),
    CONSTRAINT tickete_estado_check CHECK ((estado = ANY (ARRAY['emitido'::text, 'usado'::text, 'cancelado'::text, 'expirado'::text])))
);


ALTER TABLE public.tickete OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16459)
-- Name: tickete_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tickete ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tickete_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 16506)
-- Name: tripulacion_vuelo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tripulacion_vuelo (
    id bigint NOT NULL,
    id_vuelo bigint,
    id_empleado bigint,
    rol text NOT NULL,
    horas_servicio integer NOT NULL,
    estado text NOT NULL,
    CONSTRAINT tripulacion_vuelo_estado_check CHECK ((estado = ANY (ARRAY['asignado'::text, 'confirmado'::text, 'cancelado'::text]))),
    CONSTRAINT tripulacion_vuelo_rol_check CHECK ((rol = ANY (ARRAY['capitan'::text, 'primer oficial'::text, 'ingeniero vuelo'::text, 'jefe cabina'::text, 'azafata'::text])))
);


ALTER TABLE public.tripulacion_vuelo OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16505)
-- Name: tripulacion_vuelo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tripulacion_vuelo ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tripulacion_vuelo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16446)
-- Name: vuelo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vuelo (
    id bigint NOT NULL,
    id_avion bigint,
    asientos_disponibles integer NOT NULL,
    asientos_ocupados integer NOT NULL,
    fecha_salida timestamp with time zone NOT NULL,
    fecha_llegada timestamp with time zone NOT NULL,
    numero_vuelo text NOT NULL,
    origen text NOT NULL,
    destino text NOT NULL,
    duracion_estimada interval NOT NULL,
    estado_vuelo text NOT NULL,
    CONSTRAINT vuelo_estado_vuelo_check CHECK ((estado_vuelo = ANY (ARRAY['programado'::text, 'embarcando'::text, 'demorado'::text, 'en vuelo'::text, 'aterrizado'::text, 'cancelado'::text])))
);


ALTER TABLE public.vuelo OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16445)
-- Name: vuelo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.vuelo ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.vuelo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4904 (class 0 OID 16414)
-- Dependencies: 216
-- Data for Name: aerolinea; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aerolinea (id, nombre, nombre_legal, estado, pais_origen, numero_empleados, sede_principal, telefono, email) FROM stdin;
1	Avianca	Avianca Holdings S.A.	activa	Colombia	12000	Bogot 	+57 1 5877700	contact@avianca.com
2	LATAM	LATAM Airlines Group S.A.	activa	Chile	28500	Santiago	+56 2 2565 2525	info@latam.com
4	Copa Airlines	Compa¤¡a Paname¤a de Aviaci¢n S.A.	activa	Panam 	9000	Ciudad de Panam 	+507 217 2672	contact@copaair.com
5	Aerom‚xico	Aerov¡as de M‚xico S.A. de C.V.	suspendida	M‚xico	15800	Ciudad de M‚xico	+52 55 5133 4000	servicio@aeromexico.com
6	GOL	GOL Linhas A‚reas S.A.	activa	Brasil	13500	SÆo Paulo	+55 11 5504 4410	atendimento@voegol.com.br
7	Sky Airline	Sky Airline S.A.	inactiva	Chile	2200	Santiago	+56 2 2352 5700	info@skyairline.com
8	Azul	Azul Linhas A‚reas Brasileiras S.A.	activa	Brasil	12000	Barueri	+55 11 4134 9700	contato@voeazul.com.br
3	Aerolineas Argentinas	Aerol¡neas Argentinas S.A.	activa	Argentina	11500	Buenos Aires	+54 11 4320 2400	info@aerolineas.com.ar
\.


--
-- TOC entry 4906 (class 0 OID 16423)
-- Dependencies: 218
-- Data for Name: avion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.avion (id, id_aerolinea, modelo, capacidad_pasajeros, capacidad_carga_kg, fecha_fabricacion, estado, ultima_revision, proxima_revision) FROM stdin;
1	1	Boeing 787-8 Dreamliner	250	28000	2019-06-15	activo	2024-10-15	2025-04-15
2	2	Airbus A320neo	174	16600	2020-03-20	mantenimiento	2024-09-20	2025-03-20
3	3	Boeing 737-800	186	20000	2018-08-10	activo	2024-10-10	2025-04-10
4	4	Boeing 737 MAX 9	178	19000	2021-02-25	activo	2024-11-01	2025-05-01
5	5	Boeing 787-9 Dreamliner	274	32000	2017-11-30	reserva	2024-08-15	2025-02-15
6	6	Boeing 737-800	186	20000	2016-07-22	mantenimiento	2024-07-22	2025-01-22
7	7	Airbus A320-200	168	16600	2015-04-18	retirado	2024-04-18	\N
8	8	Embraer E195-E2	136	13900	2022-01-15	activo	2024-11-15	2025-05-15
9	1	Boeing 777-300ER	396	45000	2018-09-15	activo	2024-09-15	2025-03-15
\.


--
-- TOC entry 4914 (class 0 OID 16471)
-- Dependencies: 226
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empleado (id, id_aerolinea, nombre, apellido, tipo_documento, numero_documento, fecha_nacimiento, genero, fecha_contratacion, cargo, pais, ciudad, salario, email, corporativo) FROM stdin;
1	1	Andr‚s	Ram¡rez	CC	79123456	1980-05-15	masculino	2010-03-01	piloto	Colombia	Bogot 	85000.00	andres.ramirez@gmail.com	aramirez@avianca.com
2	2	Carolina	Mendoza	DNI	15678901	1988-08-22	femenino	2015-06-15	azafata	Chile	Santiago	45000.00	carolina.mendoza@gmail.com	cmendoza@latam.com
3	3	Gabriel	Fern ndez	DNI	28456789	1985-11-30	masculino	2012-09-01	copiloto	Argentina	Buenos Aires	65000.00	gabriel.fernandez@hotmail.com	gfernandez@aerolineas.com.ar
4	4	Patricia	Torres	CIP	8-456-789	1990-04-12	femenino	2018-01-15	supervisor	Panam 	Ciudad de Panam 	52000.00	patricia.torres@gmail.com	ptorres@copaair.com
5	5	Miguel	Hern ndez	INE	HERM900515	1990-05-15	masculino	2016-11-01	tecnico	M‚xico	Ciudad de M‚xico	48000.00	miguel.hernandez@outlook.com	mhernandez@aeromexico.com
6	6	Luciana	Santos	RG	32.456.789-0	1987-07-25	femenino	2014-08-01	gerente	Brasil	SÆo Paulo	78000.00	luciana.santos@gmail.com	lsantos@voegol.com.br
7	7	Jorge	Valenzuela	DNI	15789456	1982-03-18	masculino	2017-05-01	ingeniero vuelo	Chile	Santiago	58000.00	jorge.valenzuela@gmail.com	jvalenzuela@skyairline.com
8	8	Marina	Costa	RG	45.789.123-X	1992-12-05	femenino	2019-03-15	administrativo	Brasil	Barueri	42000.00	marina.costa@hotmail.com	mcosta@voeazul.com.br
\.


--
-- TOC entry 4916 (class 0 OID 16486)
-- Dependencies: 228
-- Data for Name: mantenimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mantenimiento (id, id_avion, id_empleado, tipo_mantenimiento, fecha_inicio, fecha_fin, estado, duracion_horas, ubicacion, costo_mantenimiento) FROM stdin;
9	1	5	preventivo	2024-11-20 09:00:00-05	2024-11-20 17:00:00-05	completado	8	Hangar 3 - AICM M‚xico	12500.00
10	2	5	overhaul	2024-11-25 07:00:00-05	\N	programado	72	Centro MRO Avianca - Bogot 	85000.00
11	3	5	correctivo	2024-11-22 07:00:00-05	\N	en proceso	24	Hangar LATAM - Santiago	28000.00
12	4	5	emergencia	2024-11-21 14:00:00-05	2024-11-21 18:00:00-05	completado	4	Terminal Internacional - Tocumen	15000.00
13	5	5	inspeccion	2024-11-23 08:00:00-05	\N	pospuesto	6	Hangar GOL - Guarulhos	8500.00
14	6	5	preventivo	2024-11-24 06:00:00-05	\N	cancelado	5	Hangar T‚cnico - Aeroparque	7500.00
15	7	5	correctivo	2024-11-26 07:00:00-05	\N	programado	12	Terminal Mantenimiento - SCL	18000.00
16	8	5	preventivo	2024-11-19 05:00:00-05	2024-11-19 13:00:00-05	completado	8	Centro MRO Azul - Campinas	13500.00
\.


--
-- TOC entry 4908 (class 0 OID 16437)
-- Dependencies: 220
-- Data for Name: pasajero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pasajero (id, nombre, apellido, tipo_documento, numero_documento, fecha_nacimiento, nacionalidad, genero, pais, ciudad, telefono, email) FROM stdin;
1	Juan Carlos	Rodr¡guez	DNI	45678912	1985-03-15	Argentina	masculino	Argentina	Buenos Aires	+54 911 2345 6789	jcrodriguez@gmail.com
2	Mar¡a	Gonz lez	Pasaporte	PAB123456	1990-07-22	Colombiana	femenino	Colombia	Medell¡n	+57 314 567 8901	mgonzalez90@hotmail.com
3	Ana Paula	Silva	RG	32.456.789-X	1988-11-30	Brasile¤a	femenino	Brasil	SÆo Paulo	+55 11 98765 4321	anapaula.silva@outlook.com
4	Roberto	Mart¡nez	C‚dula	1234567890	1976-09-05	Mexicana	masculino	M‚xico	Guadalajara	+52 333 123 4567	rmartinez@yahoo.com
5	Carmen	S nchez	DNI	09876543	1995-12-18	Peruana	femenino	Per£	Lima	+51 999 888 777	carmensanchez@gmail.com
6	Diego	Vargas	CI	4567890-1	1982-04-25	Uruguaya	masculino	Uruguay	Montevideo	+598 99 123 456	dvargas82@gmail.com
7	Valentina	L¢pez	Pasaporte	CHI98765	1993-02-14	Chilena	otro	Chile	Santiago	+56 9 8765 4321	vlopez93@outlook.cl
8	Carlos	P‚rez	C‚dula	V-12345678	1980-08-10	Venezolana	masculino	Venezuela	Caracas	+58 414 123 4567	cperez@gmail.com
\.


--
-- TOC entry 4912 (class 0 OID 16460)
-- Dependencies: 224
-- Data for Name: tickete; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickete (id, numero_tickete, numero_asiento, clase, estado, fecha_emision, fecha_limite, precio, id_vuelo, id_pasajero) FROM stdin;
1	AV120-PC15	2A	primera clase	emitido	2024-11-20	2025-11-20	1250.00	\N	\N
2	LA843-EC78	15F	economica	usado	2024-11-15	2025-11-15	385.50	\N	\N
3	AR1132-PC03	1C	primera clase	cancelado	2024-11-18	2025-11-18	890.00	\N	\N
4	CM758-EC145	23D	economica	emitido	2024-11-22	2025-11-22	445.75	\N	\N
5	AM058-PC08	3A	primera clase	expirado	2024-01-15	2024-11-15	2800.00	\N	\N
6	G31575-EC201	18C	economica	usado	2024-11-10	2025-11-10	275.50	\N	\N
7	AD4512-EC167	12B	economica	cancelado	2024-11-19	2025-11-19	325.25	\N	\N
8	AV046-PC22	4D	primera clase	emitido	2024-11-21	2025-11-21	3200.00	\N	\N
\.


--
-- TOC entry 4918 (class 0 OID 16506)
-- Dependencies: 230
-- Data for Name: tripulacion_vuelo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tripulacion_vuelo (id, id_vuelo, id_empleado, rol, horas_servicio, estado) FROM stdin;
1	1	1	capitan	8	confirmado
2	2	2	azafata	6	confirmado
3	2	3	primer oficial	6	confirmado
4	3	3	primer oficial	4	confirmado
5	4	7	ingeniero vuelo	8	asignado
6	5	2	jefe cabina	12	confirmado
7	6	1	capitan	4	cancelado
8	8	2	azafata	10	confirmado
\.


--
-- TOC entry 4910 (class 0 OID 16446)
-- Dependencies: 222
-- Data for Name: vuelo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vuelo (id, id_avion, asientos_disponibles, asientos_ocupados, fecha_salida, fecha_llegada, numero_vuelo, origen, destino, duracion_estimada, estado_vuelo) FROM stdin;
1	1	45	205	2024-11-25 08:30:00-05	2024-11-25 12:45:00-05	AV120	Bogot 	SÆo Paulo	04:15:00	programado
2	2	24	150	2024-11-25 08:15:00-05	2024-11-25 10:00:00-05	LA843	Santiago	Lima	01:45:00	embarcando
3	3	36	150	2024-11-25 11:20:00-05	2024-11-25 13:50:00-05	AR1132	Buenos Aires	Santiago	02:30:00	en vuelo
4	4	28	150	2024-11-25 09:45:00-05	2024-11-25 14:15:00-05	CM758	Ciudad de Panam 	Los µngeles	04:30:00	demorado
5	5	74	200	2024-11-26 00:30:00-05	2024-11-26 05:30:00-05	AM058	Ciudad de M‚xico	Tokio	20:00:00	programado
6	6	46	140	2024-11-25 13:20:00-05	2024-11-25 15:05:00-05	G31575	SÆo Paulo	Rio de Janeiro	01:45:00	aterrizado
7	8	26	110	2024-11-25 14:30:00-05	2024-11-25 16:15:00-05	AD4512	Campinas	Salvador	01:45:00	cancelado
8	1	65	185	2024-11-25 20:15:00-05	2024-11-25 23:45:00-05	AV046	Bogot 	Madrid	09:30:00	programado
\.


--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 215
-- Name: aerolinea_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aerolinea_id_seq', 8, true);


--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 217
-- Name: avion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.avion_id_seq', 9, true);


--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 225
-- Name: empleado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empleado_id_seq', 8, true);


--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 227
-- Name: mantenimiento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mantenimiento_id_seq', 16, true);


--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 219
-- Name: pasajero_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pasajero_id_seq', 8, true);


--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 223
-- Name: tickete_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tickete_id_seq', 8, true);


--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 229
-- Name: tripulacion_vuelo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tripulacion_vuelo_id_seq', 8, true);


--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 221
-- Name: vuelo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vuelo_id_seq', 8, true);


--
-- TOC entry 4736 (class 2606 OID 16421)
-- Name: aerolinea aerolinea_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aerolinea
    ADD CONSTRAINT aerolinea_pkey PRIMARY KEY (id);


--
-- TOC entry 4738 (class 2606 OID 16430)
-- Name: avion avion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avion
    ADD CONSTRAINT avion_pkey PRIMARY KEY (id);


--
-- TOC entry 4746 (class 2606 OID 16479)
-- Name: empleado empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (id);


--
-- TOC entry 4748 (class 2606 OID 16494)
-- Name: mantenimiento mantenimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mantenimiento
    ADD CONSTRAINT mantenimiento_pkey PRIMARY KEY (id);


--
-- TOC entry 4740 (class 2606 OID 16444)
-- Name: pasajero pasajero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasajero
    ADD CONSTRAINT pasajero_pkey PRIMARY KEY (id);


--
-- TOC entry 4744 (class 2606 OID 16468)
-- Name: tickete tickete_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickete
    ADD CONSTRAINT tickete_pkey PRIMARY KEY (id);


--
-- TOC entry 4750 (class 2606 OID 16514)
-- Name: tripulacion_vuelo tripulacion_vuelo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tripulacion_vuelo
    ADD CONSTRAINT tripulacion_vuelo_pkey PRIMARY KEY (id);


--
-- TOC entry 4742 (class 2606 OID 16453)
-- Name: vuelo vuelo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT vuelo_pkey PRIMARY KEY (id);


--
-- TOC entry 4751 (class 2606 OID 16431)
-- Name: avion avion_id_aerolinea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avion
    ADD CONSTRAINT avion_id_aerolinea_fkey FOREIGN KEY (id_aerolinea) REFERENCES public.aerolinea(id);


--
-- TOC entry 4755 (class 2606 OID 16480)
-- Name: empleado empleado_id_aerolinea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_id_aerolinea_fkey FOREIGN KEY (id_aerolinea) REFERENCES public.aerolinea(id);


--
-- TOC entry 4756 (class 2606 OID 16495)
-- Name: mantenimiento mantenimiento_id_avion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mantenimiento
    ADD CONSTRAINT mantenimiento_id_avion_fkey FOREIGN KEY (id_avion) REFERENCES public.avion(id);


--
-- TOC entry 4757 (class 2606 OID 16500)
-- Name: mantenimiento mantenimiento_id_empleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mantenimiento
    ADD CONSTRAINT mantenimiento_id_empleado_fkey FOREIGN KEY (id_empleado) REFERENCES public.empleado(id);


--
-- TOC entry 4753 (class 2606 OID 16530)
-- Name: tickete tickete_id_pasajero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickete
    ADD CONSTRAINT tickete_id_pasajero_fkey FOREIGN KEY (id_pasajero) REFERENCES public.pasajero(id);


--
-- TOC entry 4754 (class 2606 OID 16525)
-- Name: tickete tickete_id_vuelo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickete
    ADD CONSTRAINT tickete_id_vuelo_fkey FOREIGN KEY (id_vuelo) REFERENCES public.vuelo(id);


--
-- TOC entry 4758 (class 2606 OID 16520)
-- Name: tripulacion_vuelo tripulacion_vuelo_id_empleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tripulacion_vuelo
    ADD CONSTRAINT tripulacion_vuelo_id_empleado_fkey FOREIGN KEY (id_empleado) REFERENCES public.empleado(id);


--
-- TOC entry 4759 (class 2606 OID 16515)
-- Name: tripulacion_vuelo tripulacion_vuelo_id_vuelo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tripulacion_vuelo
    ADD CONSTRAINT tripulacion_vuelo_id_vuelo_fkey FOREIGN KEY (id_vuelo) REFERENCES public.vuelo(id);


--
-- TOC entry 4752 (class 2606 OID 16454)
-- Name: vuelo vuelo_id_avion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT vuelo_id_avion_fkey FOREIGN KEY (id_avion) REFERENCES public.avion(id);


-- Completed on 2024-11-28 19:50:46

--
-- PostgreSQL database dump complete
--

