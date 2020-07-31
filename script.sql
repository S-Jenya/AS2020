--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.2

-- Started on 2020-07-31 10:32:38

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

--
-- TOC entry 235 (class 1255 OID 16571)
-- Name: add_user(character varying, character varying, character varying, character varying, character varying, date, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_user(p_email character varying, p_pass character varying, p_name1 character varying, p_name2 character varying, p_name3 character varying, p_date date, p_gender character varying, p_phone character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO 
  public."user"
(
  email,
  password,
  "Name1",
  "Name2",
  "Name3",
  "Date",
  "Gender",
  phone
)
VALUES (
  p_email,
  p_pass,
  p_name1,
  p_name2,
  p_name3,
  p_date,
  p_gender,
  p_phone
);
END;
$$;


ALTER FUNCTION public.add_user(p_email character varying, p_pass character varying, p_name1 character varying, p_name2 character varying, p_name3 character varying, p_date date, p_gender character varying, p_phone character varying) OWNER TO postgres;

--
-- TOC entry 239 (class 1255 OID 16569)
-- Name: add_user_role(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_user_role(p_id_user integer, p_id_role integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN

  INSERT INTO 
    public."UserRoles"
  (
    id_role,
    id_user
  )
  VALUES (
    p_id_role,
    p_id_user
  );
END;
$$;


ALTER FUNCTION public.add_user_role(p_id_user integer, p_id_role integer) OWNER TO postgres;

--
-- TOC entry 213 (class 1255 OID 16543)
-- Name: cur_func_role(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cur_func_role(pidrole integer) RETURNS TABLE(idfunc integer, name character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
RETURN QUERY
select fd.id, fd."Name" from cur_functions fd, "FunctionsRole" fr
	 where  fr.id_role = pidrole and fr.id_finction = fd.id;
END;
$$;


ALTER FUNCTION public.cur_func_role(pidrole integer) OWNER TO postgres;

--
-- TOC entry 215 (class 1255 OID 16546)
-- Name: cur_func_role_del(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cur_func_role_del(p_id_func integer, p_id_role integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
  DELETE FROM 
  public."FunctionsRole" 
WHERE p_id_func = id_finction and p_id_role = id_role
;
  
END;
$$;


ALTER FUNCTION public.cur_func_role_del(p_id_func integer, p_id_role integer) OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 16573)
-- Name: del_user(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.del_user(p_id_user integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM 
    public."UserRoles" 
  WHERE id_user = p_id_user
;

  DELETE FROM 
    public."user" 
  WHERE 
    id = p_id_user
  ;
END;
$$;


ALTER FUNCTION public.del_user(p_id_user integer) OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 16570)
-- Name: del_user_role(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.del_user_role(p_id_user integer, p_id_role integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  DELETE FROM 
  public."UserRoles" 
WHERE id_role = p_id_role and id_user = p_id_user
;
END;
$$;


ALTER FUNCTION public.del_user_role(p_id_user integer, p_id_role integer) OWNER TO postgres;

--
-- TOC entry 211 (class 1255 OID 16533)
-- Name: functions_get(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.functions_get() RETURNS TABLE(id integer, name character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
	RETURN QUERY
    select ff.id, ff."Name" from cur_functions ff;
END;
$$;


ALTER FUNCTION public.functions_get() OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 16544)
-- Name: functions_role_set(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.functions_role_set(p_id_role integer, p_id_func integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN

  INSERT INTO 
    public."FunctionsRole"
  (
    id_role,
    id_finction
  )
  VALUES (
    p_id_role,
    p_id_func
  );

END;
$$;


ALTER FUNCTION public.functions_role_set(p_id_role integer, p_id_func integer) OWNER TO postgres;

--
-- TOC entry 210 (class 1255 OID 16532)
-- Name: login_get(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.login_get(plog character varying, ppass character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
	con NUMERIC;
BEGIN

  SELECT Count(pp.id) into con from "user" pp where pp.email = plog and pp.password = ppass;
  
  if(con > 0) THEN 
  	RETURN TRUE;
  else 
  	RETURN FALSE;
  END IF;
END;
$$;


ALTER FUNCTION public.login_get(plog character varying, ppass character varying) OWNER TO postgres;

--
-- TOC entry 218 (class 1255 OID 16550)
-- Name: rol_del(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rol_del(p_id_role integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  DELETE FROM 
    public."FunctionsRole" 
  WHERE id_role = p_id_role
  ;

  DELETE FROM 
    public.role 
  WHERE 
    id = p_id_role
  ;
END;
$$;


ALTER FUNCTION public.rol_del(p_id_role integer) OWNER TO postgres;

--
-- TOC entry 212 (class 1255 OID 16541)
-- Name: role_add(character varying, character varying, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.role_add(psysname character varying, pname character varying, pdatestart date, pdatefinish date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	maxid INTEGER;
BEGIN
INSERT INTO public.role
(
  "Name",
  "SystemName",
  "Date_start",
  "Date_finish"
)
VALUES (
  pname,
  psysname,
  pdatestart,
  pdatefinish
);

select max(rr.id) into maxid from role rr;
RETURN maxid;

END;
$$;


ALTER FUNCTION public.role_add(psysname character varying, pname character varying, pdatestart date, pdatefinish date) OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 16565)
-- Name: role_add_get(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.role_add_get() RETURNS TABLE(id integer, sysname character varying, name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
	SELECT rr.id, rr."SystemName", rr."Name" from role rr;
END;
$$;


ALTER FUNCTION public.role_add_get() OWNER TO postgres;

--
-- TOC entry 216 (class 1255 OID 16549)
-- Name: role_func_get(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.role_func_get(p_id integer) RETURNS TABLE(id integer, name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
    select fd.id, fd."Name" from cur_functions fd, "FunctionsRole" fr
	 where  fr.id_role = p_id and fr.id_finction = fd.id;
END;
$$;


ALTER FUNCTION public.role_func_get(p_id integer) OWNER TO postgres;

--
-- TOC entry 217 (class 1255 OID 16548)
-- Name: role_get(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.role_get(p_sys_name character varying) RETURNS TABLE(id integer, sysname character varying, name character varying, datestart date, datefinish date)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
    
	SELECT rr.id, rr."SystemName", rr."Name", rr."Date_start", rr."Date_finish" from role rr
    where ((lower(rr."SystemName") like '%' || lower(p_sys_name) || '%') or (p_sys_name = ''));
END;
$$;


ALTER FUNCTION public.role_get(p_sys_name character varying) OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 16572)
-- Name: upd_user(character varying, character varying, character varying, character varying, character varying, date, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.upd_user(p_email character varying, p_password character varying, p_name1 character varying, p_name2 character varying, p_name3 character varying, p_date date, p_gender character varying, p_phone character varying, p_id_user integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  
  UPDATE 
  public."user" 
SET 
  email = p_email,
  password = p_password,
  "Name1" = p_name1,
  "Name2" = p_name2,
  "Name3" = p_name3,
  "Date" = p_date,
  "Gender" = p_gender,
  phone = p_phone
WHERE 
  id = p_id_user
;
END;
$$;


ALTER FUNCTION public.upd_user(p_email character varying, p_password character varying, p_name1 character varying, p_name2 character varying, p_name3 character varying, p_date date, p_gender character varying, p_phone character varying, p_id_user integer) OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 16578)
-- Name: user_profil(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.user_profil(p_log character varying, p_pass character varying) RETURNS TABLE(id integer, email character varying, passw character varying, name1 character varying, name2 character varying, name3 character varying, date date, gender character varying, phone character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  --select uu."Name1", uu."Name2", uu."Name3", uu.email, uu.phone, uu.password, uu."Date", uu."Gender",  uu.id
   -- from user uu where uu.email = p_log and uu.password = p_pass;
SELECT 
  nn.id,
  nn.email,
  nn.password,
  nn."Name1",
  nn."Name2",
  nn."Name3",
  nn."Date",
  nn."Gender",
  nn.phone
FROM 
  public."user" nn where nn.email = p_log;
END;
$$;


ALTER FUNCTION public.user_profil(p_log character varying, p_pass character varying) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 16567)
-- Name: user_role_get(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.user_role_get(p_id integer) RETURNS TABLE(id integer, namesys character varying, name character varying, data_s date, date_f date)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
    
	SELECT rr.id, rr."SystemName", rr."Name", rr."Date_start", rr."Date_finish" from role rr, "UserRoles" ur
    where ur.id_user = p_id and rr.id = ur.id_role;
END;
$$;


ALTER FUNCTION public.user_role_get(p_id integer) OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 16564)
-- Name: users_get(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.users_get(p_name character varying) RETURNS TABLE(id integer, name1 character varying, name2 character varying, name3 character varying, date date, email character varying, gender character varying, pass character varying, phone character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
	select uu.id, uu."Name1", uu."Name2", uu."Name3", uu."Date", uu.email, uu."Gender", uu.password, uu.phone from "user" uu
    where ((lower(uu."Name1") like '%' || lower(p_name) || '%') or (p_name = ''));
END;
$$;


ALTER FUNCTION public.users_get(p_name character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 16519)
-- Name: FunctionsRole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FunctionsRole" (
    id_role integer NOT NULL,
    id_finction integer NOT NULL
);


ALTER TABLE public."FunctionsRole" OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16458)
-- Name: UserRoles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserRoles" (
    id_role integer NOT NULL,
    id_user integer NOT NULL
);


ALTER TABLE public."UserRoles" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16505)
-- Name: cur_functions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cur_functions (
    id integer NOT NULL,
    "Name" character varying NOT NULL
);
ALTER TABLE ONLY public.cur_functions ALTER COLUMN id SET STATISTICS 0;


ALTER TABLE public.cur_functions OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16503)
-- Name: functions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.functions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.functions_id_seq OWNER TO postgres;

--
-- TOC entry 2884 (class 0 OID 0)
-- Dependencies: 207
-- Name: functions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.functions_id_seq OWNED BY public.cur_functions.id;


--
-- TOC entry 202 (class 1259 OID 16428)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id integer NOT NULL,
    "Name" character varying NOT NULL,
    "SystemName" character varying NOT NULL,
    "Date_start" date NOT NULL,
    "Date_finish" date NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16433)
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_id_seq OWNER TO postgres;

--
-- TOC entry 2885 (class 0 OID 0)
-- Dependencies: 203
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- TOC entry 205 (class 1259 OID 16447)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    "Name1" character varying NOT NULL,
    "Name2" character varying NOT NULL,
    "Name3" character varying NOT NULL,
    "Date" date NOT NULL,
    "Gender" character varying NOT NULL,
    phone character varying
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16445)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- TOC entry 2886 (class 0 OID 0)
-- Dependencies: 204
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 2730 (class 2604 OID 16508)
-- Name: cur_functions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cur_functions ALTER COLUMN id SET DEFAULT nextval('public.functions_id_seq'::regclass);


--
-- TOC entry 2728 (class 2604 OID 16435)
-- Name: role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- TOC entry 2729 (class 2604 OID 16450)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 2878 (class 0 OID 16519)
-- Dependencies: 209
-- Data for Name: FunctionsRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FunctionsRole" (id_role, id_finction) FROM stdin;
17	3
18	2
17	2
35	7
35	2
\.


--
-- TOC entry 2875 (class 0 OID 16458)
-- Dependencies: 206
-- Data for Name: UserRoles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserRoles" (id_role, id_user) FROM stdin;
17	1
\.


--
-- TOC entry 2877 (class 0 OID 16505)
-- Dependencies: 208
-- Data for Name: cur_functions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cur_functions (id, "Name") FROM stdin;
3	Управление пользователями
4	Управление ролями
7	Пользователь\r\nПользователь
2	Профиль
\.


--
-- TOC entry 2871 (class 0 OID 16428)
-- Dependencies: 202
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, "Name", "SystemName", "Date_start", "Date_finish") FROM stdin;
17	администратор	admin	2020-07-30	2020-08-01
18	Пользователь	user	2020-07-30	2021-07-30
35	Кот	qqq	2019-10-01	2023-02-10
\.


--
-- TOC entry 2874 (class 0 OID 16447)
-- Dependencies: 205
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, password, "Name1", "Name2", "Name3", "Date", "Gender", phone) FROM stdin;
3	sdd@mail.ru	sssD63	Иванов	Николай	Иванович	2020-03-20	Мужской	9 999-999-9985
1	admin@mail.ru	Admin3	Сёмин	Евгений	Николаевич	1998-11-03	Мужской	9 596-777-5522
\.


--
-- TOC entry 2887 (class 0 OID 0)
-- Dependencies: 207
-- Name: functions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.functions_id_seq', 7, true);


--
-- TOC entry 2888 (class 0 OID 0)
-- Dependencies: 203
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_seq', 35, true);


--
-- TOC entry 2889 (class 0 OID 0)
-- Dependencies: 204
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 4, true);


--
-- TOC entry 2740 (class 2606 OID 16510)
-- Name: cur_functions functions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cur_functions
    ADD CONSTRAINT functions_pkey PRIMARY KEY (id);


--
-- TOC entry 2732 (class 2606 OID 16437)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 2734 (class 2606 OID 16457)
-- Name: user user_log_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_log_key UNIQUE (email);


--
-- TOC entry 2736 (class 2606 OID 16563)
-- Name: user user_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_phone_key UNIQUE (phone);


--
-- TOC entry 2738 (class 2606 OID 16455)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 2743 (class 2606 OID 16522)
-- Name: FunctionsRole FunctionsRole_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FunctionsRole"
    ADD CONSTRAINT "FunctionsRole_fk" FOREIGN KEY (id_finction) REFERENCES public.cur_functions(id);


--
-- TOC entry 2744 (class 2606 OID 16527)
-- Name: FunctionsRole FunctionsRole_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FunctionsRole"
    ADD CONSTRAINT "FunctionsRole_fk1" FOREIGN KEY (id_role) REFERENCES public.role(id);


--
-- TOC entry 2741 (class 2606 OID 16488)
-- Name: UserRoles UserRoles_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRoles"
    ADD CONSTRAINT "UserRoles_fk" FOREIGN KEY (id_role) REFERENCES public.role(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2742 (class 2606 OID 16493)
-- Name: UserRoles UserRoles_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRoles"
    ADD CONSTRAINT "UserRoles_fk1" FOREIGN KEY (id_user) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2020-07-31 10:32:38

--
-- PostgreSQL database dump complete
--

