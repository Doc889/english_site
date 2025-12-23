--
-- PostgreSQL database dump
--

\restrict y9Ab7PPSdpRX6KIPHLfHGQt8tzsRgRgldeCkjK0jqFN8hIqFgcB3IaT1OepKHJF

-- Dumped from database version 16.10 (Homebrew)
-- Dumped by pg_dump version 16.10 (Homebrew)

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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: doc
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO doc;

--
-- Name: question_options; Type: TABLE; Schema: public; Owner: doc
--

CREATE TABLE public.question_options (
    id integer NOT NULL,
    question_id integer NOT NULL,
    option_text character varying(500) NOT NULL,
    option_index integer NOT NULL,
    CONSTRAINT check_option_index CHECK (((option_index >= 0) AND (option_index <= 3)))
);


ALTER TABLE public.question_options OWNER TO doc;

--
-- Name: question_options_id_seq; Type: SEQUENCE; Schema: public; Owner: doc
--

CREATE SEQUENCE public.question_options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.question_options_id_seq OWNER TO doc;

--
-- Name: question_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doc
--

ALTER SEQUENCE public.question_options_id_seq OWNED BY public.question_options.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: doc
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    topic_id character varying(100) NOT NULL,
    question_text text NOT NULL,
    correct_index integer NOT NULL,
    explanation text NOT NULL,
    display_order integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    quiz_set integer NOT NULL,
    CONSTRAINT check_correct_index CHECK (((correct_index >= 0) AND (correct_index <= 3))),
    CONSTRAINT check_question_order CHECK ((display_order >= 0))
);


ALTER TABLE public.questions OWNER TO doc;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: doc
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_id_seq OWNER TO doc;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doc
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: rule_examples; Type: TABLE; Schema: public; Owner: doc
--

CREATE TABLE public.rule_examples (
    id integer NOT NULL,
    rule_section_id integer NOT NULL,
    example_text text NOT NULL,
    display_order integer NOT NULL,
    CONSTRAINT check_example_order CHECK ((display_order >= 0))
);


ALTER TABLE public.rule_examples OWNER TO doc;

--
-- Name: rule_examples_id_seq; Type: SEQUENCE; Schema: public; Owner: doc
--

CREATE SEQUENCE public.rule_examples_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rule_examples_id_seq OWNER TO doc;

--
-- Name: rule_examples_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doc
--

ALTER SEQUENCE public.rule_examples_id_seq OWNED BY public.rule_examples.id;


--
-- Name: rule_sections; Type: TABLE; Schema: public; Owner: doc
--

CREATE TABLE public.rule_sections (
    id integer NOT NULL,
    topic_id character varying(100) NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    display_order integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT check_rule_order CHECK ((display_order >= 0))
);


ALTER TABLE public.rule_sections OWNER TO doc;

--
-- Name: rule_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: doc
--

CREATE SEQUENCE public.rule_sections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rule_sections_id_seq OWNER TO doc;

--
-- Name: rule_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doc
--

ALTER SEQUENCE public.rule_sections_id_seq OWNED BY public.rule_sections.id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: doc
--

CREATE TABLE public.topics (
    id character varying(100) NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    difficulty character varying(50) NOT NULL,
    total_questions integer NOT NULL,
    display_order integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT check_difficulty CHECK (((difficulty)::text = ANY ((ARRAY['beginner'::character varying, 'intermediate'::character varying, 'advanced'::character varying])::text[])))
);


ALTER TABLE public.topics OWNER TO doc;

--
-- Name: question_options id; Type: DEFAULT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.question_options ALTER COLUMN id SET DEFAULT nextval('public.question_options_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: rule_examples id; Type: DEFAULT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.rule_examples ALTER COLUMN id SET DEFAULT nextval('public.rule_examples_id_seq'::regclass);


--
-- Name: rule_sections id; Type: DEFAULT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.rule_sections ALTER COLUMN id SET DEFAULT nextval('public.rule_sections_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: doc
--

COPY public.alembic_version (version_num) FROM stdin;
4b86b53d9170
\.


--
-- Data for Name: question_options; Type: TABLE DATA; Schema: public; Owner: doc
--

COPY public.question_options (id, question_id, option_text, option_index) FROM stdin;
1	1	Окончания слов	0
2	1	Интонация	1
3	1	Порядок слов	2
4	1	Длина предложения	3
5	2	Что делает → кто → остальное	0
6	2	Кто → что делает → остальное	1
7	2	Остальное → кто → что делает	2
8	2	Любой порядок допустим	3
9	3	Одно слово	0
10	3	Подлежащее и глагол	1
11	3	Подлежащее, глагол и дополнение	2
12	3	Глагол и прилагательное	3
13	4	Потому что нужно добавить артикль	0
14	4	Потому что слово слишком короткое	1
15	4	Потому что в предложении нет глагола	2
16	4	Потому что это разговорная форма	3
17	5	I student	0
18	5	I be student	1
19	5	I am student	2
20	5	I am a student	3
21	6	To do	0
22	6	To have	1
23	6	To be	2
24	6	To make	3
25	7	She tired	0
26	7	She is tired	1
27	7	Is tired she	2
28	7	She tired is	3
29	8	Потому что так красивее	0
30	8	Потому что это разговорный стиль	1
31	8	Потому что без глагола предложение не существует	2
32	8	Потому что так делают только носители	3
33	9	Cold	0
34	9	Is cold	1
35	9	It cold	2
36	9	It is cold	3
37	10	Артикль	0
38	10	Предлог	1
39	10	Глагол	2
40	10	Наречие	3
41	11	I working	0
42	11	I am work	1
43	11	I work	2
44	11	Work I	3
45	12	В нём много сложных правил	0
46	12	Нужно угадывать формы слов	1
47	12	Предложения собираются из чётких блоков	2
48	12	Он подходит только для технических тем	3
49	13	You work?	0
50	13	Do you work?	1
51	13	Work you?	2
52	13	Are you work?	3
53	14	I not work	0
54	14	I no work	1
55	14	I do not work	2
56	14	I work not	3
17453	4364	beautiful red	0
17454	4364	red beautiful	1
17455	4364	beautifuls red	2
17456	4364	reds beautiful	3
17457	4365	a big	0
17458	4365	big	1
17459	4365	bigs	2
17460	4365	the bigs	3
17461	4366	interesting	0
17462	4366	interestinger	1
17463	4366	more interesting	2
17464	4366	most interesting	3
17465	4367	best	0
17466	4367	better	1
17467	4367	more best	2
17468	4367	the best	3
17469	4368	fast	0
17470	4368	faster	1
17471	4368	fastest	2
17472	4368	fasts	3
17473	4369	much	0
17474	4369	very	1
17475	4369	more	2
17476	4369	the most	3
17477	4370	olds	0
17478	4370	house old	1
17479	4370	an old	2
17480	4370	an house old	3
17481	4371	am	0
17482	4371	are	1
17483	4371	be	2
17484	4371	is	3
17485	4372	beautiful	0
17486	4372	beautifuls	1
17487	4372	beauties	2
17488	4372	beautifuler	3
17489	4373	tall	0
17490	4373	taller	1
17491	4373	more tall	2
17492	4373	tallest	3
17493	4374	older	0
17494	4374	the oldest	1
17495	4374	oldest	2
17496	4374	more old	3
17497	4375	fastest	0
17498	4375	fast	1
17499	4375	faster	2
17500	4375	more fast	3
17501	4376	news beautiful	0
17502	4376	beautiful new	1
17503	4376	new beautiful	2
17504	4376	beautifuls new	3
17505	4377	are	0
17506	4377	am	1
17507	4377	is	2
17508	4377	be	3
17509	4378	bigs	0
17510	4378	bigger	1
17511	4378	biggest	2
17512	4378	big	3
17513	4379	the most interesting	0
17514	4379	interestinger	1
17515	4379	most interesting	2
17516	4379	the interestingest	3
17517	4380	smalls	0
17518	4380	a small	1
17519	4380	small a	2
17520	4380	a table small	3
17521	4381	are	0
17522	4381	am	1
17523	4381	is	2
17524	4381	be	3
17525	4382	fasts	0
17526	4382	faster	1
17527	4382	fastest	2
17528	4382	fast	3
17529	4383	the kindest	0
17530	4383	kindest	1
17531	4383	kinder	2
17532	4383	more kind	3
17533	4384	big	0
17534	4384	bigger	1
17535	4384	biggest	2
17536	4384	more big	3
17537	4385	youngest	0
17538	4385	younger	1
17539	4385	more young	2
17540	4385	the youngest	3
17541	4386	cleaner	0
17542	4386	more clean	1
17543	4386	cleanest	2
17544	4386	clean	3
17545	4387	hotest	0
17546	4387	the hottest	1
17547	4387	hotter	2
17548	4387	more hot	3
17549	4388	carefuler	0
17550	4388	more careful	1
17551	4388	most careful	2
17552	4388	carefullest	3
17553	4389	difficulter	0
17554	4389	more difficult	1
17555	4389	most difficult	2
17556	4389	the most difficult	3
17557	4390	cheap	0
17558	4390	more cheap	1
17559	4390	cheaper	2
17560	4390	cheapest	3
17561	4391	the amazingest	0
17562	4391	most amazing	1
17563	4391	more amazing	2
17564	4391	the most amazing	3
17565	4392	colder	0
17566	4392	cold	1
17567	4392	coldest	2
17568	4392	more cold	3
17569	4393	cheaper	0
17570	4393	cheapest	1
17571	4393	the cheapest	2
17572	4393	most cheap	3
17573	4394	faster	0
17574	4394	fastest	1
17575	4394	more fast	2
17576	4394	the fastest	3
17577	4395	interestinger	0
17578	4395	more interesting	1
17579	4395	most interesting	2
17580	4395	interesting	3
17581	4396	the kindest	0
17582	4396	more kind	1
17583	4396	kinder	2
17584	4396	kindest	3
17585	4397	hardest	0
17586	4397	harder	1
17587	4397	more hard	2
17588	4397	hard	3
17589	4398	popularst	0
17590	4398	more popular	1
17591	4398	the most popular	2
17592	4398	most popular	3
17593	4399	the hottest	0
17594	4399	hot	1
17595	4399	more hot	2
17596	4399	hotter	3
17597	4400	the most comfortable	0
17598	4400	most comfortable	1
17599	4400	more comfortable	2
17600	4400	the comfortablest	3
17601	4401	confident	0
17602	4401	more confident	1
17603	4401	most confident	2
17604	4401	confidenter	3
17605	4402	longest	0
17606	4402	more long	1
17607	4402	long	2
17608	4402	longer	3
17609	4403	taller	0
17610	4403	tallest	1
17611	4403	the tallest	2
17612	4403	more tall	3
17613	4404	good	0
17614	4404	better	1
17615	4404	best	2
17616	4404	more good	3
17617	4405	better	0
17618	4405	good	1
17619	4405	the best	2
17620	4405	more good	3
17621	4406	badder	0
17622	4406	bad	1
17623	4406	worst	2
17624	4406	worse	3
17625	4407	the worst	0
17626	4407	worse	1
17627	4407	bad	2
17628	4407	more bad	3
17629	4408	much	0
17630	4408	very	1
17631	4408	many	2
17632	4408	more	3
17633	4409	much	0
17634	4409	more	1
17635	4409	very	2
17636	4409	many	3
17637	4410	more	0
17638	4410	much	1
17639	4410	many	2
17640	4410	really	3
17641	4411	good	0
17642	4411	better	1
17643	4411	best	2
17644	4411	more good	3
17645	4412	many	0
17646	4412	quite	1
17647	4412	much	2
17648	4412	more	3
17649	4413	more good	0
17650	4413	good	1
17651	4413	better	2
17652	4413	best	3
17653	4414	worse	0
17654	4414	bad	1
17655	4414	more bad	2
17656	4414	the worst	3
17657	4415	really	0
17658	4415	many	1
17659	4415	much	2
17660	4415	more	3
17661	4416	good	0
17662	4416	better	1
17663	4416	best	2
17664	4416	more good	3
17665	4417	much	0
17666	4417	many	1
17667	4417	very	2
17668	4417	more	3
17669	4418	worse	0
17670	4418	the worst	1
17671	4418	bad	2
17672	4418	more bad	3
17673	4419	much	0
17674	4419	many	1
17675	4419	really	2
17676	4419	more	3
17677	4420	the worst	0
17678	4420	worse	1
17679	4420	bad	2
17680	4420	more bad	3
17681	4421	many	0
17682	4421	much	1
17683	4421	more	2
17684	4421	quite	3
17685	4422	really	0
17686	4422	many	1
17687	4422	much	2
17688	4422	more	3
17689	4423	much	0
17690	4423	more	1
17691	4423	very	2
17692	4423	many	3
17693	4424	beautifuls	0
17694	4424	beauties	1
17695	4424	beautiful	2
17696	4424	beautifuler	3
17697	4425	bigs	0
17698	4425	biggs	1
17699	4425	bigger	2
17700	4425	big	3
17701	4426	black	0
17702	4426	blacks	1
17703	4426	cat black	2
17704	4426	a black	3
17705	4427	longs	0
17706	4427	long	1
17707	4427	hair long	2
17708	4427	a long	3
17709	4428	fasts	0
17710	4428	faster	1
17711	4428	fast	2
17712	4428	fastest	3
17713	4429	reds	0
17714	4429	car red	1
17715	4429	a red	2
17716	4429	red	3
17717	4430	interesting	0
17718	4430	interestings	1
17719	4430	interested	2
17720	4430	interests	3
17721	4431	moderns	0
17722	4431	modern	1
17723	4431	apartment modern	2
17724	4431	a modern	3
17725	4432	olds	0
17726	4432	older	1
17727	4432	old	2
17728	4432	oldest	3
17729	4433	news	0
17730	4433	shoes new	1
17731	4433	a new	2
17732	4433	new	3
17733	4434	smart	0
17734	4434	smarts	1
17735	4434	smarter	2
17736	4434	smartest	3
17737	4435	blues	0
17738	4435	blue	1
17739	4435	dress blue	2
17740	4435	a blue	3
17741	4436	beautifuls	0
17742	4436	beauties	1
17743	4436	beautiful	2
17744	4436	beautifuler	3
17745	4437	news	0
17746	4437	phone new	1
17747	4437	new	2
17748	4437	a new	3
17749	4438	smalls	0
17750	4438	smaller	1
17751	4438	smallest	2
17752	4438	small	3
17753	4439	tall	0
17754	4439	talls	1
17755	4439	building tall	2
17756	4439	a tall	3
17757	4440	happys	0
17758	4440	happy	1
17759	4440	happies	2
17760	4440	happier	3
17761	4441	blacks	0
17762	4441	pen black	1
17763	4441	black	2
17764	4441	a black	3
17765	4442	goods	0
17766	4442	better	1
17767	4442	best	2
17768	4442	good	3
17769	4443	small	0
17770	4443	smalls	1
17771	4443	bag small	2
17772	4443	a small	3
17773	4444	beautiful red	0
17774	4444	red beautiful	1
17775	4444	beautifuls red	2
17776	4444	reds beautiful	3
17777	4445	are	0
17778	4445	is	1
17779	4445	am	2
17780	4445	be	3
17781	4446	black big	0
17782	4446	bigs black	1
17783	4446	big black	2
17784	4446	blacks big	3
17785	4447	are	0
17786	4447	am	1
17787	4447	be	2
17788	4447	is	3
17789	4448	nice old	0
17790	4448	old nice	1
17791	4448	nices old	2
17792	4448	olds nice	3
17793	4449	are	0
17794	4449	is	1
17795	4449	am	2
17796	4449	be	3
17797	4450	blue long	0
17798	4450	longs blue	1
17799	4450	long blue	2
17800	4450	blues long	3
17801	4451	is	0
17802	4451	am	1
17803	4451	be	2
17804	4451	are	3
17805	4452	small round	0
17806	4452	round small	1
17807	4452	smalls round	2
17808	4452	rounds small	3
17809	4453	is	0
17810	4453	are	1
17811	4453	be	2
17812	4453	am	3
17813	4454	blacks large	0
17814	4454	large black	1
17815	4454	larges black	2
17816	4454	black large	3
17817	4455	are	0
17818	4455	am	1
17819	4455	is	2
17820	4455	be	3
17821	4456	old thin	0
17822	4456	thin old	1
17823	4456	thins old	2
17824	4456	olds thin	3
17825	4457	is	0
17826	4457	am	1
17827	4457	be	2
17828	4457	are	3
17829	4458	fast red	0
17830	4458	red fast	1
17831	4458	fasts red	2
17832	4458	reds fast	3
17833	4459	is	0
17834	4459	are	1
17835	4459	am	2
17836	4459	be	3
17837	4460	yellow small	0
17838	4460	smalls yellow	1
17839	4460	small yellow	2
17840	4460	yellows small	3
17841	4461	are	0
17842	4461	am	1
17843	4461	be	2
17844	4461	is	3
17845	4462	new expensive	0
17846	4462	expensive new	1
17847	4462	news expensive	2
17848	4462	expensives new	3
17849	4463	is	0
17850	4463	are	1
17851	4463	am	2
17852	4463	be	3
17853	4464	than	0
17854	4464	then	1
17855	4464	that	2
17856	4464	the	3
17857	4465	then	0
17858	4465	than	1
17859	4465	that	2
17860	4465	the	3
17861	4466	the	0
17862	4466	that	1
17863	4466	than	2
17864	4466	then	3
17865	4467	that	0
17866	4467	then	1
17867	4467	the	2
17868	4467	than	3
17869	4468	than	0
17870	4468	then	1
17871	4468	that	2
17872	4468	the	3
17873	4469	then	0
17874	4469	than	1
17875	4469	that	2
17876	4469	the	3
17877	4470	the	0
17878	4470	that	1
17879	4470	than	2
17880	4470	then	3
17881	4471	that	0
17882	4471	then	1
17883	4471	the	2
17884	4471	than	3
17885	4472	than	0
17886	4472	then	1
17887	4472	that	2
17888	4472	the	3
17889	4473	then	0
17890	4473	than	1
17891	4473	that	2
17892	4473	the	3
17893	4474	the	0
17894	4474	that	1
17895	4474	than	2
17896	4474	then	3
17897	4475	that	0
17898	4475	then	1
17899	4475	the	2
17900	4475	than	3
17901	4476	than	0
17902	4476	then	1
17903	4476	that	2
17904	4476	the	3
17905	4477	then	0
17906	4477	than	1
17907	4477	that	2
17908	4477	the	3
17909	4478	the	0
17910	4478	that	1
17911	4478	than	2
17912	4478	then	3
17913	4479	that	0
17914	4479	then	1
17915	4479	the	2
17916	4479	than	3
17917	4480	than	0
17918	4480	then	1
17919	4480	that	2
17920	4480	the	3
17921	4481	then	0
17922	4481	than	1
17923	4481	that	2
17924	4481	the	3
17925	4482	the	0
17926	4482	that	1
17927	4482	than	2
17928	4482	then	3
17929	4483	that	0
17930	4483	then	1
17931	4483	the	2
17932	4483	than	3
17933	4484	the	0
17934	4484	a	1
17935	4484	an	2
17936	4484	–	3
17937	4485	a	0
17938	4485	the	1
17939	4485	an	2
17940	4485	–	3
17941	4486	an	0
17942	4486	–	1
17943	4486	the	2
17944	4486	a	3
17945	4487	–	0
17946	4487	a	1
17947	4487	an	2
17948	4487	the	3
17949	4488	the	0
17950	4488	a	1
17951	4488	an	2
17952	4488	–	3
17953	4489	a	0
17954	4489	the	1
17955	4489	an	2
17956	4489	–	3
17957	4490	an	0
17958	4490	–	1
17959	4490	the	2
17960	4490	a	3
17961	4491	–	0
17962	4491	a	1
17963	4491	an	2
17964	4491	the	3
17965	4492	the	0
17966	4492	a	1
17967	4492	an	2
17968	4492	–	3
17969	4493	a	0
17970	4493	the	1
17971	4493	an	2
17972	4493	–	3
17973	4494	an	0
17974	4494	–	1
17975	4494	the	2
17976	4494	a	3
17977	4495	–	0
17978	4495	a	1
17979	4495	an	2
17980	4495	the	3
17981	4496	the	0
17982	4496	a	1
17983	4496	an	2
17984	4496	–	3
17985	4497	a	0
17986	4497	the	1
17987	4497	an	2
17988	4497	–	3
17989	4498	an	0
17990	4498	–	1
17991	4498	the	2
17992	4498	a	3
17993	4499	–	0
17994	4499	a	1
17995	4499	an	2
17996	4499	the	3
17997	4500	the	0
17998	4500	a	1
17999	4500	an	2
18000	4500	–	3
18001	4501	a	0
18002	4501	the	1
18003	4501	an	2
18004	4501	–	3
18005	4502	an	0
18006	4502	–	1
18007	4502	the	2
18008	4502	a	3
18009	4503	–	0
18010	4503	a	1
18011	4503	an	2
18012	4503	the	3
18013	4504	delicious	0
18014	4504	a delicious	1
18015	4504	deliciously	2
18016	4504	deliciouses	3
18017	4505	a tired	0
18018	4505	tired	1
18019	4505	tiredly	2
18020	4505	tireds	3
18021	4506	nices	0
18022	4506	nicely	1
18023	4506	nice	2
18024	4506	a nice	3
18025	4507	happily	0
18026	4507	a happy	1
18027	4507	happys	2
18028	4507	happy	3
18029	4508	beautiful	0
18030	4508	a beautiful	1
18031	4508	beautifully	2
18032	4508	beautifuls	3
18033	4509	sickly	0
18034	4509	sick	1
18035	4509	sicks	2
18036	4509	a sick	3
18037	4510	a sweet	0
18038	4510	sweetly	1
18039	4510	sweet	2
18040	4510	sweets	3
18041	4511	confidently	0
18042	4511	confidents	1
18043	4511	a confident	2
18044	4511	confident	3
18045	4512	cold	0
18046	4512	coldly	1
18047	4512	colds	2
18048	4512	a cold	3
18049	4513	a beautiful	0
18050	4513	beautiful	1
18051	4513	beautifully	2
18052	4513	beautifuls	3
18053	4514	deliciously	0
18054	4514	a delicious	1
18055	4514	delicious	2
18056	4514	deliciouses	3
18057	4515	happily	0
18058	4515	a happy	1
18059	4515	happys	2
18060	4515	happy	3
18061	4516	wonderful	0
18062	4516	wonderfully	1
18063	4516	wonders	2
18064	4516	a wonderful	3
18065	4517	nervously	0
18066	4517	nervous	1
18067	4517	a nervous	2
18068	4517	nervouses	3
18069	4518	cleanly	0
18070	4518	cleans	1
18071	4518	clean	2
18072	4518	a clean	3
18073	4519	angrily	0
18074	4519	angries	1
18075	4519	a angry	2
18076	4519	angry	3
18077	4520	sweet	0
18078	4520	sweetly	1
18079	4520	sweets	2
18080	4520	a sweet	3
18081	4521	comfortably	0
18082	4521	comfortable	1
18083	4521	comfortables	2
18084	4521	a comfortable	3
18085	4522	loudly	0
18086	4522	louds	1
18087	4522	loud	2
18088	4522	a loud	3
18089	4523	seriously	0
18090	4523	serious	1
18091	4523	seriouses	2
18092	4523	a serious	3
18093	4524	houses beautiful	0
18094	4524	beautifuls houses	1
18095	4524	houses beautifuls	2
18096	4524	beautiful houses	3
18097	4525	she is a beautiful	0
18098	4525	she beautiful	1
18099	4525	she are beautiful	2
18100	4525	she is beautiful	3
18101	4526	a house big	0
18102	4526	big a house	1
18103	4526	a bigs house	2
18104	4526	a big house	3
18105	4527	more better	0
18106	4527	more good	1
18107	4527	gooder	2
18108	4527	better	3
18109	4528	the interestingest	0
18110	4528	most interesting	1
18111	4528	more interesting	2
18112	4528	the most interesting	3
18113	4529	much smart	0
18114	4529	many smart	1
18115	4529	very smart	2
18116	4529	more smart	3
18117	4530	fasts cars	0
18118	4530	fast cars	1
18119	4530	cars fast	2
18120	4530	faster cars	3
18121	4531	an old book	0
18122	4531	old an book	1
18123	4531	a book old	2
18124	4531	an olds book	3
18125	4532	more bad	0
18126	4532	worse	1
18127	4532	badder	2
18128	4532	more worse	3
18129	4533	small a child	0
18130	4533	a child small	1
18131	4533	a small child	2
18132	4533	a smalls child	3
18133	4534	they is happy	0
18134	4534	they are happy	1
18135	4534	they happy	2
18136	4534	they are a happy	3
18137	4535	phone new	0
18138	4535	a news phone	1
18139	4535	new a phone	2
18140	4535	a new phone	3
18141	4536	the best	0
18142	4536	best	1
18143	4536	better	2
18144	4536	more best	3
18145	4537	expensiver	0
18146	4537	more expensive	1
18147	4537	most expensive	2
18148	4537	the most expensive	3
18149	4538	water cold	0
18150	4538	a colds water	1
18151	4538	cold water	2
18152	4538	cold a water	3
18153	4539	smarts students	0
18154	4539	students smart	1
18155	4539	smarter students	2
18156	4539	smart students	3
18157	4540	the worst	0
18158	4540	worst	1
18159	4540	worser	2
18160	4540	more worst	3
18161	4541	much cold	0
18162	4541	very cold	1
18163	4541	many cold	2
18164	4541	more cold	3
18165	4542	man tall	0
18166	4542	a talls man	1
18167	4542	a tall man	2
18168	4542	tall a man	3
18169	4543	interestinger	0
18170	4543	most interesting	1
18171	4543	the most interesting	2
18172	4543	more interesting	3
18173	4544	beautiful	0
18174	4544	beautifuls	1
18175	4544	a beautiful	2
18176	4544	beautifully	3
18177	4545	more good	0
18178	4545	better	1
18179	4545	gooder	2
18180	4545	best	3
18181	4546	nicest	0
18182	4546	nicer	1
18183	4546	the nicest	2
18184	4546	more nice	3
18185	4547	news	0
18186	4547	a new	1
18187	4547	the new	2
18188	4547	new	3
18189	4548	very	0
18190	4548	much	1
18191	4548	more	2
18192	4548	the most	3
18193	4549	taller then	0
18194	4549	taller than	1
18195	4549	more tall than	2
18196	4549	tallest than	3
18197	4550	most	0
18198	4550	more	1
18199	4550	the most	2
18200	4550	much	3
18201	4551	a happy	0
18202	4551	happily	1
18203	4551	happys	2
18204	4551	happy	3
18205	4552	bigger	0
18206	4552	more big	1
18207	4552	biger	2
18208	4552	biggest	3
18209	4553	much	0
18210	4553	really	1
18211	4553	more	2
18212	4553	the most	3
18213	4554	more fast	0
18214	4554	fastest	1
18215	4554	faster	2
18216	4554	the fastest	3
18217	4555	are	0
18218	4555	am	1
18219	4555	be	2
18220	4555	is	3
18221	4556	hot	0
18222	4556	a hot	1
18223	4556	hots	2
18224	4556	the hot	3
18225	4557	more important	0
18226	4557	the most important	1
18227	4557	importanter	2
18228	4557	most important	3
18229	4558	olds	0
18230	4558	older	1
18231	4558	old	2
18232	4558	oldest	3
18233	4559	more young	0
18234	4559	youngest	1
18235	4559	the youngest	2
18236	4559	younger	3
18237	4560	fast	0
18238	4560	fasts	1
18239	4560	faster	2
18240	4560	the fastest	3
18241	4561	worse	0
18242	4561	the worst	1
18243	4561	bad	2
18244	4561	more bad	3
18245	4562	more clean	0
18246	4562	cleanest	1
18247	4562	cleaner	2
18248	4562	clean	3
18249	4563	red beautiful	0
18250	4563	beautifuls red	1
18251	4563	reds beautiful	2
18252	4563	beautiful red	3
18253	4564	is	0
18254	4564	are	1
18255	4564	am	2
18256	4564	be	3
18257	4565	am	0
18258	4565	are	1
18259	4565	be	2
18260	4565	is	3
18261	4566	is	0
18262	4566	am	1
18263	4566	be	2
18264	4566	are	3
18265	4567	be	0
18266	4567	are	1
18267	4567	is	2
18268	4567	am	3
18269	4568	are	0
18270	4568	be	1
18271	4568	am	2
18272	4568	is	3
18273	4569	is	0
18274	4569	be	1
18275	4569	are	2
18276	4569	am	3
18277	4570	are	0
18278	4570	am	1
18279	4570	be	2
18280	4570	is	3
18281	4571	are	0
18282	4571	be	1
18283	4571	am	2
18284	4571	is	3
18285	4572	am	0
18286	4572	are	1
18287	4572	is	2
18288	4572	be	3
18289	4573	is	0
18290	4573	be	1
18291	4573	are	2
18292	4573	am	3
18293	4574	be	0
18294	4574	is	1
18295	4574	am	2
18296	4574	are	3
18297	4575	are	0
18298	4575	am	1
18299	4575	is	2
18300	4575	be	3
18301	4576	be	0
18302	4576	are	1
18303	4576	is	2
18304	4576	am	3
18305	4577	am	0
18306	4577	are	1
18307	4577	be	2
18308	4577	is	3
18309	4578	is	0
18310	4578	be	1
18311	4578	am	2
18312	4578	are	3
18313	4579	are	0
18314	4579	be	1
18315	4579	is	2
18316	4579	am	3
18317	4580	be	0
18318	4580	are	1
18319	4580	is	2
18320	4580	am	3
18321	4581	is	0
18322	4581	am	1
18323	4581	be	2
18324	4581	are	3
18325	4582	am	0
18326	4582	are	1
18327	4582	be	2
18328	4582	is	3
18329	4583	is	0
18330	4583	be	1
18331	4583	are	2
18332	4583	am	3
18333	4584	am	0
18334	4584	are	1
18335	4584	is	2
18336	4584	be	3
18337	4585	is	0
18338	4585	be	1
18339	4585	am	2
18340	4585	are	3
18341	4586	is	0
18342	4586	am	1
18343	4586	be	2
18344	4586	are	3
18345	4587	be	0
18346	4587	are	1
18347	4587	is	2
18348	4587	am	3
18349	4588	are	0
18350	4588	be	1
18351	4588	am	2
18352	4588	is	3
18353	4589	is	0
18354	4589	be	1
18355	4589	are	2
18356	4589	am	3
18357	4590	are	0
18358	4590	am	1
18359	4590	be	2
18360	4590	is	3
18361	4591	are	0
18362	4591	be	1
18363	4591	am	2
18364	4591	is	3
18365	4592	am	0
18366	4592	are	1
18367	4592	is	2
18368	4592	be	3
18369	4593	is	0
18370	4593	be	1
18371	4593	are	2
18372	4593	am	3
18373	4594	be	0
18374	4594	is	1
18375	4594	am	2
18376	4594	are	3
18377	4595	are	0
18378	4595	am	1
18379	4595	is	2
18380	4595	be	3
18381	4596	be	0
18382	4596	are	1
18383	4596	is	2
18384	4596	am	3
18385	4597	am	0
18386	4597	are	1
18387	4597	be	2
18388	4597	is	3
18389	4598	is	0
18390	4598	be	1
18391	4598	am	2
18392	4598	are	3
18393	4599	are	0
18394	4599	be	1
18395	4599	is	2
18396	4599	am	3
18397	4600	be	0
18398	4600	are	1
18399	4600	is	2
18400	4600	am	3
18401	4601	is	0
18402	4601	am	1
18403	4601	be	2
18404	4601	are	3
18405	4602	am	0
18406	4602	are	1
18407	4602	be	2
18408	4602	is	3
18409	4603	is	0
18410	4603	be	1
18411	4603	are	2
18412	4603	am	3
18413	4604	is	0
18414	4604	are	1
18415	4604	am	2
18416	4604	be	3
18417	4605	am	0
18418	4605	are	1
18419	4605	is	2
18420	4605	be	3
18421	4606	is	0
18422	4606	am	1
18423	4606	be	2
18424	4606	are	3
18425	4607	be	0
18426	4607	are	1
18427	4607	is	2
18428	4607	am	3
18429	4608	are	0
18430	4608	be	1
18431	4608	am	2
18432	4608	is	3
18433	4609	is	0
18434	4609	be	1
18435	4609	are	2
18436	4609	am	3
18437	4610	are	0
18438	4610	am	1
18439	4610	be	2
18440	4610	is	3
18441	4611	are	0
18442	4611	be	1
18443	4611	am	2
18444	4611	is	3
18445	4612	am	0
18446	4612	are	1
18447	4612	is	2
18448	4612	be	3
18449	4613	is	0
18450	4613	be	1
18451	4613	are	2
18452	4613	am	3
18453	4614	be	0
18454	4614	is	1
18455	4614	am	2
18456	4614	are	3
18457	4615	are	0
18458	4615	am	1
18459	4615	is	2
18460	4615	be	3
18461	4616	be	0
18462	4616	are	1
18463	4616	is	2
18464	4616	am	3
18465	4617	am	0
18466	4617	are	1
18467	4617	be	2
18468	4617	is	3
18469	4618	is	0
18470	4618	be	1
18471	4618	am	2
18472	4618	are	3
18473	4619	are	0
18474	4619	be	1
18475	4619	is	2
18476	4619	am	3
18477	4620	be	0
18478	4620	are	1
18479	4620	is	2
18480	4620	am	3
18481	4621	is	0
18482	4621	am	1
18483	4621	be	2
18484	4621	are	3
18485	4622	am	0
18486	4622	are	1
18487	4622	be	2
18488	4622	is	3
18489	4623	is	0
18490	4623	be	1
18491	4623	are	2
18492	4623	am	3
18493	4624	Is	0
18494	4624	Am	1
18495	4624	Are	2
18496	4624	Be	3
18497	4625	Am	0
18498	4625	Are	1
18499	4625	Is	2
18500	4625	Be	3
18501	4626	Is	0
18502	4626	Be	1
18503	4626	Am	2
18504	4626	Are	3
18505	4627	Are	0
18506	4627	Be	1
18507	4627	Is	2
18508	4627	Am	3
18509	4628	Are	0
18510	4628	Am	1
18511	4628	Be	2
18512	4628	Is	3
18513	4629	Are	0
18514	4629	Be	1
18515	4629	Am	2
18516	4629	Is	3
18517	4630	Am	0
18518	4630	Are	1
18519	4630	Is	2
18520	4630	Be	3
18521	4631	Is	0
18522	4631	Be	1
18523	4631	Am	2
18524	4631	Are	3
18525	4632	Is	0
18526	4632	Be	1
18527	4632	Are	2
18528	4632	Am	3
18529	4633	Are	0
18530	4633	Be	1
18531	4633	Is	2
18532	4633	Am	3
18533	4634	Am	0
18534	4634	Are	1
18535	4634	Be	2
18536	4634	Is	3
18537	4635	Are	0
18538	4635	Be	1
18539	4635	Am	2
18540	4635	Is	3
18541	4636	Am	0
18542	4636	Are	1
18543	4636	Is	2
18544	4636	Be	3
18545	4637	Is	0
18546	4637	Be	1
18547	4637	Am	2
18548	4637	Are	3
18549	4638	Are	0
18550	4638	Be	1
18551	4638	Is	2
18552	4638	Am	3
18553	4639	Am	0
18554	4639	Are	1
18555	4639	Be	2
18556	4639	Is	3
18557	4640	Is	0
18558	4640	Be	1
18559	4640	Are	2
18560	4640	Am	3
18561	4641	is	0
18562	4641	are	1
18563	4641	am	2
18564	4641	be	3
18565	4642	am	0
18566	4642	are	1
18567	4642	is	2
18568	4642	be	3
18569	4643	Is	0
18570	4643	Be	1
18571	4643	Am	2
18572	4643	Are	3
18573	4644	be	0
18574	4644	are	1
18575	4644	is	2
18576	4644	am	3
18577	4645	are	0
18578	4645	be	1
18579	4645	am	2
18580	4645	is	3
18581	4646	Is	0
18582	4646	Be	1
18583	4646	Are	2
18584	4646	Am	3
18585	4647	are	0
18586	4647	am	1
18587	4647	be	2
18588	4647	is	3
18589	4648	are	0
18590	4648	be	1
18591	4648	am	2
18592	4648	is	3
18593	4649	am	0
18594	4649	are	1
18595	4649	is	2
18596	4649	be	3
18597	4650	is	0
18598	4650	be	1
18599	4650	are	2
18600	4650	am	3
18601	4651	are	0
18602	4651	am	1
18603	4651	is	2
18604	4651	be	3
18605	4652	be	0
18606	4652	are	1
18607	4652	is	2
18608	4652	am	3
18609	4653	am	0
18610	4653	are	1
18611	4653	be	2
18612	4653	is	3
18613	4654	Are	0
18614	4654	Be	1
18615	4654	Am	2
18616	4654	Is	3
18617	4655	are	0
18618	4655	be	1
18619	4655	is	2
18620	4655	am	3
18621	4656	be	0
18622	4656	are	1
18623	4656	is	2
18624	4656	am	3
18625	4657	is	0
18626	4657	am	1
18627	4657	be	2
18628	4657	are	3
18629	4658	am	0
18630	4658	are	1
18631	4658	be	2
18632	4658	is	3
18633	4659	Is	0
18634	4659	Be	1
18635	4659	Are	2
18636	4659	Am	3
18637	4660	is	0
18638	4660	are	1
18639	4660	am	2
18640	4660	be	3
18641	4661	am	0
18642	4661	are	1
18643	4661	is	2
18644	4661	be	3
18645	4662	is	0
18646	4662	am	1
18647	4662	be	2
18648	4662	are	3
18649	4663	be	0
18650	4663	are	1
18651	4663	is	2
18652	4663	am	3
18653	4664	are	0
18654	4664	be	1
18655	4664	am	2
18656	4664	is	3
18657	4665	is	0
18658	4665	be	1
18659	4665	are	2
18660	4665	am	3
18661	4666	are	0
18662	4666	am	1
18663	4666	be	2
18664	4666	is	3
18665	4667	are	0
18666	4667	be	1
18667	4667	am	2
18668	4667	is	3
18669	4668	am	0
18670	4668	are	1
18671	4668	is	2
18672	4668	be	3
18673	4669	is	0
18674	4669	be	1
18675	4669	are	2
18676	4669	am	3
18677	4670	be	0
18678	4670	is	1
18679	4670	am	2
18680	4670	are	3
18681	4671	are	0
18682	4671	am	1
18683	4671	is	2
18684	4671	be	3
18685	4672	be	0
18686	4672	are	1
18687	4672	is	2
18688	4672	am	3
18689	4673	am	0
18690	4673	are	1
18691	4673	be	2
18692	4673	is	3
18693	4674	is	0
18694	4674	be	1
18695	4674	am	2
18696	4674	are	3
18697	4675	are	0
18698	4675	be	1
18699	4675	is	2
18700	4675	am	3
18701	4676	be	0
18702	4676	are	1
18703	4676	is	2
18704	4676	am	3
18705	4677	is	0
18706	4677	am	1
18707	4677	be	2
18708	4677	are	3
18709	4678	am	0
18710	4678	are	1
18711	4678	be	2
18712	4678	is	3
18713	4679	is	0
18714	4679	be	1
18715	4679	are	2
18716	4679	am	3
18717	4680	Are	0
18718	4680	Be	1
18719	4680	Am	2
18720	4680	Is	3
18721	4681	Am	0
18722	4681	Are	1
18723	4681	Is	2
18724	4681	Be	3
18725	4682	Is	0
18726	4682	Be	1
18727	4682	Am	2
18728	4682	Are	3
18729	4683	Are	0
18730	4683	Be	1
18731	4683	Is	2
18732	4683	Am	3
18733	4684	Is	0
18734	4684	Be	1
18735	4684	Are	2
18736	4684	Am	3
18737	4685	Am	0
18738	4685	Are	1
18739	4685	Be	2
18740	4685	Is	3
18741	4686	Are	0
18742	4686	Be	1
18743	4686	Am	2
18744	4686	Is	3
18745	4687	Am	0
18746	4687	Are	1
18747	4687	Is	2
18748	4687	Be	3
18749	4688	Is	0
18750	4688	Be	1
18751	4688	Am	2
18752	4688	Are	3
18753	4689	Are	0
18754	4689	Be	1
18755	4689	Is	2
18756	4689	Am	3
18757	4690	Is	0
18758	4690	Be	1
18759	4690	Are	2
18760	4690	Am	3
18761	4691	Am	0
18762	4691	Are	1
18763	4691	Be	2
18764	4691	Is	3
18765	4692	Are	0
18766	4692	Be	1
18767	4692	Am	2
18768	4692	Is	3
18769	4693	Am	0
18770	4693	Are	1
18771	4693	Is	2
18772	4693	Be	3
18773	4694	Is	0
18774	4694	Be	1
18775	4694	Am	2
18776	4694	Are	3
18777	4695	Are	0
18778	4695	Be	1
18779	4695	Is	2
18780	4695	Am	3
18781	4696	Is	0
18782	4696	Be	1
18783	4696	Are	2
18784	4696	Am	3
18785	4697	is	0
18786	4697	are	1
18787	4697	am	2
18788	4697	be	3
18789	4698	am	0
18790	4698	are	1
18791	4698	is	2
18792	4698	be	3
18793	4699	is	0
18794	4699	am	1
18795	4699	be	2
18796	4699	are	3
18797	4700	be	0
18798	4700	are	1
18799	4700	is	2
18800	4700	am	3
18801	4701	are	0
18802	4701	be	1
18803	4701	am	2
18804	4701	is	3
18805	4702	is	0
18806	4702	be	1
18807	4702	are	2
18808	4702	am	3
18809	4703	are	0
18810	4703	am	1
18811	4703	be	2
18812	4703	is	3
18813	4704	are	0
18814	4704	be	1
18815	4704	am	2
18816	4704	is	3
18817	4705	am	0
18818	4705	are	1
18819	4705	is	2
18820	4705	be	3
18821	4706	is	0
18822	4706	be	1
18823	4706	are	2
18824	4706	am	3
18825	4707	be	0
18826	4707	is	1
18827	4707	am	2
18828	4707	are	3
18829	4708	are	0
18830	4708	am	1
18831	4708	is	2
18832	4708	be	3
18833	4709	be	0
18834	4709	are	1
18835	4709	is	2
18836	4709	am	3
18837	4710	am	0
18838	4710	are	1
18839	4710	be	2
18840	4710	is	3
18841	4711	is	0
18842	4711	be	1
18843	4711	am	2
18844	4711	are	3
18845	4712	are	0
18846	4712	be	1
18847	4712	is	2
18848	4712	am	3
18849	4713	be	0
18850	4713	are	1
18851	4713	is	2
18852	4713	am	3
18853	4714	is	0
18854	4714	am	1
18855	4714	be	2
18856	4714	are	3
18857	4715	am	0
18858	4715	are	1
18859	4715	be	2
18860	4715	is	3
18861	4716	is	0
18862	4716	be	1
18863	4716	are	2
18864	4716	am	3
18865	4717	is	0
18866	4717	are	1
18867	4717	am	2
18868	4717	be	3
18869	4718	am	0
18870	4718	are	1
18871	4718	is	2
18872	4718	be	3
18873	4719	is	0
18874	4719	am	1
18875	4719	be	2
18876	4719	are	3
18877	4720	be	0
18878	4720	are	1
18879	4720	is	2
18880	4720	am	3
18881	4721	are	0
18882	4721	be	1
18883	4721	am	2
18884	4721	is	3
18885	4722	is	0
18886	4722	be	1
18887	4722	are	2
18888	4722	am	3
18889	4723	are	0
18890	4723	am	1
18891	4723	be	2
18892	4723	is	3
18893	4724	are	0
18894	4724	be	1
18895	4724	am	2
18896	4724	is	3
18897	4725	am	0
18898	4725	are	1
18899	4725	is	2
18900	4725	be	3
18901	4726	is	0
18902	4726	be	1
18903	4726	are	2
18904	4726	am	3
18905	4727	be	0
18906	4727	is	1
18907	4727	am	2
18908	4727	are	3
18909	4728	are	0
18910	4728	am	1
18911	4728	is	2
18912	4728	be	3
18913	4729	be	0
18914	4729	are	1
18915	4729	is	2
18916	4729	am	3
18917	4730	am	0
18918	4730	are	1
18919	4730	be	2
18920	4730	is	3
18921	4731	is	0
18922	4731	be	1
18923	4731	am	2
18924	4731	are	3
18925	4732	are	0
18926	4732	be	1
18927	4732	is	2
18928	4732	am	3
18929	4733	be	0
18930	4733	are	1
18931	4733	is	2
18932	4733	am	3
18933	4734	is	0
18934	4734	am	1
18935	4734	be	2
18936	4734	are	3
18937	4735	am	0
18938	4735	are	1
18939	4735	be	2
18940	4735	is	3
18941	4736	is	0
18942	4736	be	1
18943	4736	are	2
18944	4736	am	3
21421	5356	in	0
21422	5356	on	1
21423	5356	under	2
21424	5356	at	3
21425	5357	in	0
21426	5357	on	1
21427	5357	under	2
21428	5357	at	3
21429	5358	in	0
21430	5358	on	1
21431	5358	under	2
21432	5358	at	3
21433	5359	in	0
21434	5359	on	1
21435	5359	under	2
21436	5359	at	3
21437	5360	in	0
21438	5360	on	1
21439	5360	under	2
21440	5360	at	3
21441	5361	in	0
21442	5361	on	1
21443	5361	under	2
21444	5361	at	3
21445	5362	in	0
21446	5362	on	1
21447	5362	under	2
21448	5362	at	3
21449	5363	in	0
21450	5363	on	1
21451	5363	under	2
21452	5363	at	3
21453	5364	in	0
21454	5364	on	1
21455	5364	under	2
21456	5364	at	3
21457	5365	in	0
21458	5365	on	1
21459	5365	under	2
21460	5365	at	3
21461	5366	in	0
21462	5366	on	1
21463	5366	under	2
21464	5366	at	3
21465	5367	in	0
21466	5367	on	1
21467	5367	under	2
21468	5367	at	3
21469	5368	in	0
21470	5368	on	1
21471	5368	under	2
21472	5368	at	3
21473	5369	in	0
21474	5369	on	1
21475	5369	under	2
21476	5369	at	3
21477	5370	in	0
21478	5370	on	1
21479	5370	under	2
21480	5370	at	3
21481	5371	in	0
21482	5371	on	1
21483	5371	under	2
21484	5371	at	3
21485	5372	in	0
21486	5372	on	1
21487	5372	under	2
21488	5372	at	3
21489	5373	in	0
21490	5373	on	1
21491	5373	under	2
21492	5373	at	3
21493	5374	in	0
21494	5374	on	1
21495	5374	under	2
21496	5374	at	3
21497	5375	in	0
21498	5375	on	1
21499	5375	under	2
21500	5375	at	3
21501	5376	in	0
21502	5376	on	1
21503	5376	under	2
21504	5376	at	3
21505	5377	in	0
21506	5377	on	1
21507	5377	under	2
21508	5377	at	3
21509	5378	in	0
21510	5378	on	1
21511	5378	under	2
21512	5378	at	3
21513	5379	in	0
21514	5379	on	1
21515	5379	under	2
21516	5379	at	3
21517	5380	in	0
21518	5380	on	1
21519	5380	under	2
21520	5380	at	3
21521	5381	in	0
21522	5381	on	1
21523	5381	under	2
21524	5381	at	3
21525	5382	in	0
21526	5382	on	1
21527	5382	under	2
21528	5382	at	3
21529	5383	in	0
21530	5383	on	1
21531	5383	under	2
21532	5383	at	3
21533	5384	in	0
21534	5384	on	1
21535	5384	under	2
21536	5384	at	3
21537	5385	in	0
21538	5385	on	1
21539	5385	under	2
21540	5385	at	3
21541	5386	in	0
21542	5386	on	1
21543	5386	under	2
21544	5386	at	3
21545	5387	in	0
21546	5387	on	1
18945	4737	plays	0
18946	4737	play	1
18947	4737	played	2
18948	4737	playing	3
18949	4738	drink	0
18950	4738	drinks	1
18951	4738	drank	2
18952	4738	drinking	3
18953	4739	go	0
18954	4739	goes	1
18955	4739	went	2
18956	4739	going	3
18957	4740	do	0
18958	4740	does	1
18959	4740	did	2
18960	4740	doing	3
18961	4741	speaks	0
18962	4741	speak	1
18963	4741	spoke	2
18964	4741	speaking	3
18965	4742	drink	0
18966	4742	drinks	1
18967	4742	drank	2
18968	4742	drinking	3
18969	4743	snows	0
18970	4743	snow	1
18971	4743	snowed	2
18972	4743	snowing	3
18973	4744	do	0
18974	4744	does	1
18975	4744	did	2
18976	4744	doing	3
18977	4745	do	0
18978	4745	does	1
18979	4745	did	2
18980	4745	doing	3
18981	4746	do	0
18982	4746	does	1
18983	4746	did	2
18984	4746	doing	3
18985	4747	do	0
18986	4747	does	1
18987	4747	did	2
18988	4747	doing	3
18989	4748	do	0
18990	4748	does	1
18991	4748	did	2
18992	4748	doing	3
18993	4749	do	0
18994	4749	does	1
18995	4749	did	2
18996	4749	doing	3
18997	4750	do	0
18998	4750	does	1
18999	4750	did	2
19000	4750	doing	3
19001	4751	do	0
19002	4751	does	1
19003	4751	am	2
19004	4751	wake	3
19005	4752	drink	0
19006	4752	drinks	1
19007	4752	drank	2
19008	4752	drinking	3
19009	4753	play	0
19010	4753	plays	1
19011	4753	played	2
19012	4753	playing	3
19013	4754	eat	0
19014	4754	eats	1
19015	4754	ate	2
19016	4754	eating	3
19017	4755	eat	0
19018	4755	eats	1
19019	4755	ate	2
19020	4755	eating	3
19021	4756	read	0
19022	4756	reads	1
19023	4756	reading	2
19024	4756	readed	3
19025	4757	plays	0
19026	4757	play	1
19027	4757	played	2
19028	4757	playing	3
19029	4758	drink	0
19030	4758	drinks	1
19031	4758	drank	2
19032	4758	drinking	3
19033	4759	go	0
19034	4759	goes	1
19035	4759	went	2
19036	4759	going	3
19037	4760	do	0
19038	4760	does	1
19039	4760	did	2
19040	4760	doing	3
19041	4761	speaks	0
19042	4761	speak	1
19043	4761	spoke	2
19044	4761	speaking	3
19045	4762	drink	0
19046	4762	drinks	1
19047	4762	drank	2
19048	4762	drinking	3
19049	4763	snows	0
19050	4763	snow	1
19051	4763	snowed	2
19052	4763	snowing	3
19053	4764	do	0
19054	4764	does	1
19055	4764	did	2
19056	4764	doing	3
19057	4765	do	0
19058	4765	does	1
19059	4765	did	2
19060	4765	doing	3
19061	4766	do	0
19062	4766	does	1
19063	4766	did	2
19064	4766	doing	3
19065	4767	do	0
19066	4767	does	1
19067	4767	did	2
19068	4767	doing	3
19069	4768	do	0
19070	4768	does	1
19071	4768	did	2
19072	4768	doing	3
19073	4769	do	0
19074	4769	does	1
19075	4769	did	2
19076	4769	doing	3
19077	4770	do	0
19078	4770	does	1
19079	4770	did	2
19080	4770	doing	3
19081	4771	do	0
19082	4771	does	1
19083	4771	am	2
19084	4771	wake	3
19085	4772	drink	0
19086	4772	drinks	1
19087	4772	drank	2
19088	4772	drinking	3
19089	4773	play	0
19090	4773	plays	1
19091	4773	played	2
19092	4773	playing	3
19093	4774	eat	0
19094	4774	eats	1
19095	4774	ate	2
19096	4774	eating	3
19097	4775	eat	0
19098	4775	eats	1
19099	4775	ate	2
19100	4775	eating	3
19101	4776	read	0
19102	4776	reads	1
19103	4776	reading	2
19104	4776	readed	3
19105	4777	do not	0
19106	4777	does not	1
19107	4777	am not	2
19108	4777	is not	3
19109	4778	do not	0
19110	4778	does not	1
19111	4778	am not	2
19112	4778	is not	3
19113	4779	do not	0
19114	4779	does not	1
19115	4779	am not	2
19116	4779	is not	3
19117	4780	do not	0
19118	4780	does not	1
19119	4780	am not	2
19120	4780	is not	3
19121	4781	do not	0
19122	4781	does not	1
19123	4781	am not	2
19124	4781	is not	3
19125	4782	do not	0
19126	4782	does not	1
19127	4782	am not	2
19128	4782	is not	3
19129	4783	do not	0
19130	4783	does not	1
19131	4783	am not	2
19132	4783	is not	3
19133	4784	do not	0
19134	4784	does not	1
19135	4784	am not	2
19136	4784	is not	3
19137	4785	do not	0
19138	4785	does not	1
19139	4785	am not	2
19140	4785	is not	3
19141	4786	do not	0
19142	4786	does not	1
19143	4786	am not	2
19144	4786	is not	3
19145	4787	do not	0
19146	4787	does not	1
19147	4787	am not	2
19148	4787	is not	3
19149	4788	do not	0
19150	4788	does not	1
19151	4788	am not	2
19152	4788	is not	3
19153	4789	do not	0
19154	4789	does not	1
19155	4789	am not	2
19156	4789	is not	3
19157	4790	do not	0
19158	4790	does not	1
19159	4790	am not	2
19160	4790	is not	3
19161	4791	do not	0
19162	4791	does not	1
19163	4791	am not	2
19164	4791	is not	3
19165	4792	do not	0
19166	4792	does not	1
19167	4792	am not	2
19168	4792	is not	3
19169	4793	do not	0
19170	4793	does not	1
19171	4793	am not	2
19172	4793	is not	3
19173	4794	do not	0
19174	4794	does not	1
19175	4794	am not	2
19176	4794	is not	3
19177	4795	do not	0
19178	4795	does not	1
19179	4795	am not	2
19180	4795	is not	3
19181	4796	do not	0
19182	4796	does not	1
19183	4796	am not	2
19184	4796	is not	3
19185	4797	plays	0
19186	4797	play	1
19187	4797	played	2
19188	4797	playing	3
19189	4798	drink	0
19190	4798	drinks	1
19191	4798	drank	2
19192	4798	drinking	3
19193	4799	go	0
19194	4799	goes	1
19195	4799	went	2
19196	4799	going	3
19197	4800	do	0
19198	4800	does	1
19199	4800	did	2
19200	4800	doing	3
19201	4801	speaks	0
19202	4801	speak	1
19203	4801	spoke	2
19204	4801	speaking	3
19205	4802	drink	0
19206	4802	drinks	1
19207	4802	drank	2
19208	4802	drinking	3
19209	4803	snows	0
19210	4803	snow	1
19211	4803	snowed	2
19212	4803	snowing	3
19213	4804	do	0
19214	4804	does	1
19215	4804	did	2
19216	4804	doing	3
19217	4805	do	0
19218	4805	does	1
19219	4805	did	2
19220	4805	doing	3
19221	4806	do	0
19222	4806	does	1
19223	4806	did	2
19224	4806	doing	3
19225	4807	do	0
19226	4807	does	1
19227	4807	did	2
19228	4807	doing	3
19229	4808	do	0
19230	4808	does	1
19231	4808	did	2
19232	4808	doing	3
19233	4809	do	0
19234	4809	does	1
19235	4809	did	2
19236	4809	doing	3
19237	4810	do	0
19238	4810	does	1
19239	4810	did	2
19240	4810	doing	3
19241	4811	do	0
19242	4811	does	1
19243	4811	am	2
19244	4811	wake	3
19245	4812	drink	0
19246	4812	drinks	1
19247	4812	drank	2
19248	4812	drinking	3
19249	4813	play	0
19250	4813	plays	1
19251	4813	played	2
19252	4813	playing	3
19253	4814	eat	0
19254	4814	eats	1
19255	4814	ate	2
19256	4814	eating	3
19257	4815	eat	0
19258	4815	eats	1
19259	4815	ate	2
19260	4815	eating	3
19261	4816	read	0
19262	4816	reads	1
19263	4816	reading	2
19264	4816	readed	3
19265	4817	am	0
19266	4817	do	1
19267	4817	wake	2
19268	4817	wakes	3
19269	4818	drink	0
19270	4818	drinks	1
19271	4818	drank	2
19272	4818	drinking	3
19273	4819	play	0
19274	4819	plays	1
19275	4819	played	2
19276	4819	playing	3
19277	4820	eat	0
19278	4820	eats	1
19279	4820	ate	2
19280	4820	eating	3
19281	4821	eat	0
19282	4821	eats	1
19283	4821	ate	2
19284	4821	eating	3
19285	4822	read	0
19286	4822	reads	1
19287	4822	reading	2
19288	4822	readed	3
19289	4823	rain	0
19290	4823	rains	1
19291	4823	rained	2
19292	4823	raining	3
19293	4824	go	0
19294	4824	goes	1
19295	4824	went	2
19296	4824	going	3
19297	4825	watch	0
19298	4825	watches	1
19299	4825	watched	2
19300	4825	watching	3
19301	4826	take	0
19302	4826	takes	1
19303	4826	took	2
19304	4826	taking	3
19305	4827	do	0
19306	4827	does	1
19307	4827	did	2
19308	4827	doing	3
19309	4828	drink	0
19310	4828	drinks	1
19311	4828	drank	2
19312	4828	drinking	3
19313	4829	eat	0
19314	4829	eats	1
19315	4829	ate	2
19316	4829	eating	3
19317	4830	snow	0
19318	4830	snows	1
19319	4830	snowed	2
19320	4830	snowing	3
19321	4831	eat	0
19322	4831	eats	1
19323	4831	ate	2
19324	4831	eating	3
19325	4832	go	0
19326	4832	goes	1
19327	4832	went	2
19328	4832	going	3
19329	4833	help	0
19330	4833	helps	1
19331	4833	helped	2
19332	4833	helping	3
19333	4834	visit	0
19334	4834	visits	1
19335	4834	visited	2
19336	4834	visiting	3
19337	4835	play	0
19338	4835	plays	1
19339	4835	played	2
19340	4835	playing	3
19341	4836	study	0
19342	4836	studies	1
19343	4836	studied	2
19344	4836	studying	3
19345	4837	do	0
19346	4837	does	1
19347	4837	am	2
19348	4837	is	3
19349	4838	do	0
19350	4838	does	1
19351	4838	am	2
19352	4838	is	3
19353	4839	do	0
19354	4839	does	1
19355	4839	am	2
19356	4839	is	3
19357	4840	do	0
19358	4840	does	1
19359	4840	am	2
19360	4840	is	3
19361	4841	do	0
19362	4841	does	1
19363	4841	am	2
19364	4841	is	3
19365	4842	do	0
19366	4842	does	1
19367	4842	am	2
19368	4842	is	3
19369	4843	do	0
19370	4843	does	1
19371	4843	am	2
19372	4843	is	3
19373	4844	do	0
19374	4844	does	1
19375	4844	am	2
19376	4844	is	3
19377	4845	do	0
19378	4845	does	1
19379	4845	am	2
19380	4845	is	3
19381	4846	do	0
19382	4846	does	1
19383	4846	am	2
19384	4846	is	3
19385	4847	do	0
19386	4847	does	1
19387	4847	am	2
19388	4847	is	3
19389	4848	do	0
19390	4848	does	1
19391	4848	am	2
19392	4848	is	3
19393	4849	do	0
19394	4849	does	1
19395	4849	am	2
19396	4849	is	3
19397	4850	do	0
19398	4850	does	1
19399	4850	am	2
19400	4850	is	3
19401	4851	do	0
19402	4851	does	1
19403	4851	am	2
19404	4851	is	3
19405	4852	do	0
19406	4852	does	1
19407	4852	am	2
19408	4852	is	3
19409	4853	do	0
19410	4853	does	1
19411	4853	am	2
19412	4853	is	3
19413	4854	do	0
19414	4854	does	1
19415	4854	am	2
19416	4854	is	3
19417	4855	do	0
19418	4855	does	1
19419	4855	am	2
19420	4855	is	3
19421	4856	do	0
19422	4856	does	1
19423	4856	am	2
19424	4856	is	3
19425	4857	wake	0
19426	4857	wakes	1
19427	4857	woke	2
19428	4857	waking	3
19429	4858	drink	0
19430	4858	drinks	1
19431	4858	drank	2
19432	4858	drinking	3
19433	4859	play	0
19434	4859	plays	1
19435	4859	played	2
19436	4859	playing	3
19437	4860	eat	0
19438	4860	eats	1
19439	4860	ate	2
19440	4860	eating	3
19441	4861	eat	0
19442	4861	eats	1
19443	4861	ate	2
19444	4861	eating	3
19445	4862	read	0
19446	4862	reads	1
19447	4862	reading	2
19448	4862	readed	3
19449	4863	rain	0
19450	4863	rains	1
19451	4863	rained	2
19452	4863	raining	3
19453	4864	go	0
19454	4864	goes	1
19455	4864	went	2
19456	4864	going	3
19457	4865	watch	0
19458	4865	watches	1
19459	4865	watched	2
19460	4865	watching	3
19461	4866	take	0
19462	4866	takes	1
19463	4866	took	2
19464	4866	taking	3
19465	4867	do	0
19466	4867	does	1
19467	4867	did	2
19468	4867	doing	3
19469	4868	drink	0
19470	4868	drinks	1
19471	4868	drank	2
19472	4868	drinking	3
19473	4869	eat	0
19474	4869	eats	1
19475	4869	ate	2
19476	4869	eating	3
19477	4870	snow	0
19478	4870	snows	1
19479	4870	snowed	2
19480	4870	snowing	3
19481	4871	eat	0
19482	4871	eats	1
19483	4871	ate	2
19484	4871	eating	3
19485	4872	go	0
19486	4872	goes	1
19487	4872	went	2
19488	4872	going	3
19489	4873	help	0
19490	4873	helps	1
19491	4873	helped	2
19492	4873	helping	3
19493	4874	visit	0
19494	4874	visits	1
19495	4874	visited	2
19496	4874	visiting	3
19497	4875	play	0
19498	4875	plays	1
19499	4875	played	2
19500	4875	playing	3
19501	4876	study	0
19502	4876	studies	1
19503	4876	studied	2
19504	4876	studying	3
19505	4877	play	0
19506	4877	plays	1
19507	4877	played	2
19508	4877	playing	3
19509	4878	drink	0
19510	4878	drinks	1
19511	4878	drank	2
19512	4878	drinking	3
19513	4879	go	0
19514	4879	goes	1
19515	4879	went	2
19516	4879	going	3
19517	4880	do	0
19518	4880	does	1
19519	4880	did	2
19520	4880	doing	3
19521	4881	speak	0
19522	4881	speaks	1
19523	4881	spoke	2
19524	4881	speaking	3
19525	4882	drink	0
19526	4882	drinks	1
19527	4882	drank	2
19528	4882	drinking	3
19529	4883	snow	0
19530	4883	snows	1
19531	4883	snowed	2
19532	4883	snowing	3
19533	4884	do	0
19534	4884	does	1
19535	4884	did	2
19536	4884	doing	3
19537	4885	do	0
19538	4885	does	1
19539	4885	did	2
19540	4885	doing	3
19541	4886	do	0
19542	4886	does	1
19543	4886	did	2
19544	4886	doing	3
19545	4887	eat	0
19546	4887	eats	1
19547	4887	ate	2
19548	4887	eating	3
19549	4888	eat	0
19550	4888	eats	1
19551	4888	ate	2
19552	4888	eating	3
19553	4889	read	0
19554	4889	reads	1
19555	4889	reading	2
19556	4889	readed	3
19557	4890	rain	0
19558	4890	rains	1
19559	4890	rained	2
19560	4890	raining	3
19561	4891	go	0
19562	4891	goes	1
19563	4891	went	2
19564	4891	going	3
19565	4892	watch	0
19566	4892	watches	1
19567	4892	watched	2
19568	4892	watching	3
19569	4893	take	0
19570	4893	takes	1
19571	4893	took	2
19572	4893	taking	3
19573	4894	do	0
19574	4894	does	1
19575	4894	did	2
19576	4894	doing	3
19577	4895	drink	0
19578	4895	drinks	1
19579	4895	drank	2
19580	4895	drinking	3
19581	4896	eat	0
19582	4896	eats	1
19583	4896	ate	2
19584	4896	eating	3
19585	4897	drink	0
19586	4897	drinks	1
19587	4897	drank	2
19588	4897	drinking	3
19589	4898	snows	0
19590	4898	snow	1
19591	4898	snowed	2
19592	4898	snowing	3
19593	4899	do	0
19594	4899	does	1
19595	4899	did	2
19596	4899	doing	3
19597	4900	do	0
19598	4900	does	1
19599	4900	did	2
19600	4900	doing	3
19601	4901	do	0
19602	4901	does	1
19603	4901	did	2
19604	4901	doing	3
19605	4902	do	0
19606	4902	does	1
19607	4902	did	2
19608	4902	doing	3
19609	4903	do	0
19610	4903	does	1
19611	4903	did	2
19612	4903	doing	3
19613	4904	do	0
19614	4904	does	1
19615	4904	did	2
19616	4904	doing	3
19617	4905	do	0
19618	4905	does	1
19619	4905	did	2
19620	4905	doing	3
19621	4906	do	0
19622	4906	does	1
19623	4906	am	2
19624	4906	wake	3
19625	4907	drink	0
19626	4907	drinks	1
19627	4907	drank	2
19628	4907	drinking	3
19629	4908	play	0
19630	4908	plays	1
19631	4908	played	2
19632	4908	playing	3
19633	4909	eat	0
19634	4909	eats	1
19635	4909	ate	2
19636	4909	eating	3
19637	4910	eat	0
19638	4910	eats	1
19639	4910	ate	2
19640	4910	eating	3
19641	4911	read	0
19642	4911	reads	1
19643	4911	reading	2
19644	4911	readed	3
19645	4912	go	0
19646	4912	goes	1
19647	4912	went	2
19648	4912	going	3
19649	4913	help	0
19650	4913	helps	1
19651	4913	helped	2
19652	4913	helping	3
19653	4914	visit	0
19654	4914	visits	1
19655	4914	visited	2
19656	4914	visiting	3
19657	4915	play	0
19658	4915	plays	1
19659	4915	played	2
19660	4915	playing	3
19661	4916	study	0
19662	4916	studies	1
19663	4916	studied	2
19664	4916	studying	3
19665	4917	plays	0
19666	4917	play	1
19667	4917	played	2
19668	4917	playing	3
19669	4918	drink	0
19670	4918	drinks	1
19671	4918	drank	2
19672	4918	drinking	3
19673	4919	go	0
19674	4919	goes	1
19675	4919	went	2
19676	4919	going	3
19677	4920	do	0
19678	4920	does	1
19679	4920	did	2
19680	4920	doing	3
19681	4921	speaks	0
19682	4921	speak	1
19683	4921	spoke	2
19684	4921	speaking	3
19685	4922	drink	0
19686	4922	drinks	1
19687	4922	drank	2
19688	4922	drinking	3
19689	4923	snows	0
19690	4923	snow	1
19691	4923	snowed	2
19692	4923	snowing	3
19693	4924	do	0
19694	4924	does	1
19695	4924	did	2
19696	4924	doing	3
19697	4925	do	0
19698	4925	does	1
19699	4925	did	2
19700	4925	doing	3
19701	4926	do	0
19702	4926	does	1
19703	4926	did	2
19704	4926	doing	3
19705	4927	eat	0
19706	4927	eats	1
19707	4927	ate	2
19708	4927	eating	3
19709	4928	eat	0
19710	4928	eats	1
19711	4928	ate	2
19712	4928	eating	3
19713	4929	read	0
19714	4929	reads	1
19715	4929	reading	2
19716	4929	readed	3
19717	4930	rain	0
19718	4930	rains	1
19719	4930	rained	2
19720	4930	raining	3
19721	4931	go	0
19722	4931	goes	1
19723	4931	went	2
19724	4931	going	3
19725	4932	watch	0
19726	4932	watches	1
19727	4932	watched	2
19728	4932	watching	3
19729	4933	take	0
19730	4933	takes	1
19731	4933	took	2
19732	4933	taking	3
19733	4934	do	0
19734	4934	does	1
19735	4934	did	2
19736	4934	doing	3
19737	4935	drink	0
19738	4935	drinks	1
19739	4935	drank	2
19740	4935	drinking	3
19741	4936	eat	0
19742	4936	eats	1
19743	4936	ate	2
19744	4936	eating	3
21547	5387	under	2
21548	5387	at	3
21549	5388	in	0
21550	5388	on	1
21551	5388	under	2
21552	5388	at	3
21553	5389	in	0
21554	5389	on	1
21555	5389	under	2
21556	5389	at	3
21557	5390	in	0
21558	5390	on	1
21559	5390	under	2
21560	5390	at	3
21561	5391	in	0
21562	5391	on	1
21563	5391	under	2
21564	5391	at	3
19745	4937	can	0
19746	4937	cans	1
19747	4937	can to	2
19748	4937	am can	3
19749	4938	can	0
19750	4938	cans	1
19751	4938	can to	2
19752	4938	is can	3
19753	4939	can	0
19754	4939	cans	1
19755	4939	can to	2
19756	4939	are can	3
19757	4940	can	0
19758	4940	cans	1
19759	4940	can to	2
19760	4940	are can	3
19761	4941	can	0
19762	4941	cans	1
19763	4941	can to	2
19764	4941	is can	3
19765	4942	can	0
19766	4942	cans	1
19767	4942	can to	2
19768	4942	are can	3
19769	4943	can	0
19770	4943	cans	1
19771	4943	can to	2
19772	4943	is can	3
19773	4944	can	0
19774	4944	cans	1
19775	4944	can to	2
19776	4944	am can	3
19777	4945	can	0
19778	4945	cans	1
19779	4945	can to	2
19780	4945	is can	3
19781	4946	can	0
19782	4946	cans	1
19783	4946	can to	2
19784	4946	are can	3
19785	4947	can	0
19786	4947	cans	1
19787	4947	can to	2
19788	4947	are can	3
19789	4948	can	0
19790	4948	cans	1
19791	4948	can to	2
19792	4948	is can	3
19793	4949	can	0
19794	4949	cans	1
19795	4949	can to	2
19796	4949	are can	3
19797	4950	can	0
19798	4950	cans	1
19799	4950	can to	2
19800	4950	is can	3
19801	4951	can	0
19802	4951	cans	1
19803	4951	can to	2
19804	4951	am can	3
19805	4952	can	0
19806	4952	cans	1
19807	4952	can to	2
19808	4952	is can	3
19809	4953	can	0
19810	4953	cans	1
19811	4953	can to	2
19812	4953	are can	3
19813	4954	can	0
19814	4954	cans	1
19815	4954	can to	2
19816	4954	are can	3
19817	4955	can	0
19818	4955	cans	1
19819	4955	can to	2
19820	4955	is can	3
19821	4956	can	0
19822	4956	cans	1
19823	4956	can to	2
19824	4956	are can	3
19825	4957	can't	0
19826	4957	can not to	1
19827	4957	don't can	2
19828	4957	am not can	3
19829	4958	can't	0
19830	4958	can not to	1
19831	4958	doesn't can	2
19832	4958	isn't can	3
19833	4959	can't	0
19834	4959	can not to	1
19835	4959	don't can	2
19836	4959	aren't can	3
19837	4960	can't	0
19838	4960	can not to	1
19839	4960	don't can	2
19840	4960	aren't can	3
19841	4961	can't	0
19842	4961	can not to	1
19843	4961	doesn't can	2
19844	4961	isn't can	3
19845	4962	can't	0
19846	4962	can not to	1
19847	4962	don't can	2
19848	4962	aren't can	3
19849	4963	can't	0
19850	4963	can not to	1
19851	4963	doesn't can	2
19852	4963	isn't can	3
19853	4964	can't	0
19854	4964	can not to	1
19855	4964	don't can	2
19856	4964	am not can	3
19857	4965	can't	0
19858	4965	can not to	1
19859	4965	doesn't can	2
19860	4965	isn't can	3
19861	4966	can't	0
19862	4966	can not to	1
19863	4966	don't can	2
19864	4966	aren't can	3
19865	4967	can't	0
19866	4967	can not to	1
19867	4967	don't can	2
19868	4967	aren't can	3
19869	4968	can't	0
19870	4968	can not to	1
19871	4968	doesn't can	2
19872	4968	isn't can	3
19873	4969	can't	0
19874	4969	can not to	1
19875	4969	don't can	2
19876	4969	aren't can	3
19877	4970	can't	0
19878	4970	can not to	1
19879	4970	doesn't can	2
19880	4970	isn't can	3
19881	4971	can't	0
19882	4971	can not to	1
19883	4971	don't can	2
19884	4971	am not can	3
19885	4972	can't	0
19886	4972	can not to	1
19887	4972	doesn't can	2
19888	4972	isn't can	3
19889	4973	can't	0
19890	4973	can not to	1
19891	4973	don't can	2
19892	4973	aren't can	3
19893	4974	can't	0
19894	4974	can not to	1
19895	4974	don't can	2
19896	4974	aren't can	3
19897	4975	can't	0
19898	4975	can not to	1
19899	4975	doesn't can	2
19900	4975	isn't can	3
19901	4976	can't	0
19902	4976	can not to	1
19903	4976	don't can	2
19904	4976	aren't can	3
19905	4977	Can	0
19906	4977	Do can	1
19907	4977	Are can	2
19908	4977	Cans	3
19909	4978	Can	0
19910	4978	Does can	1
19911	4978	Is can	2
19912	4978	Cans	3
19913	4979	Can	0
19914	4979	Do can	1
19915	4979	Are can	2
19916	4979	Cans	3
19917	4980	Can	0
19918	4980	Do can	1
19919	4980	Are can	2
19920	4980	Cans	3
19921	4981	Can	0
19922	4981	Does can	1
19923	4981	Is can	2
19924	4981	Cans	3
19925	4982	Can	0
19926	4982	Do can	1
19927	4982	Are can	2
19928	4982	Cans	3
19929	4983	Can	0
19930	4983	Does can	1
19931	4983	Is can	2
19932	4983	Cans	3
19933	4984	Can	0
19934	4984	Do can	1
19935	4984	Am can	2
19936	4984	Cans	3
19937	4985	Can	0
19938	4985	Does can	1
19939	4985	Is can	2
19940	4985	Cans	3
19941	4986	Can	0
19942	4986	Do can	1
19943	4986	Are can	2
19944	4986	Cans	3
19945	4987	Can	0
19946	4987	Do can	1
19947	4987	Are can	2
19948	4987	Cans	3
19949	4988	Can	0
19950	4988	Does can	1
19951	4988	Is can	2
19952	4988	Cans	3
19953	4989	Can	0
19954	4989	Do can	1
19955	4989	Are can	2
19956	4989	Cans	3
19957	4990	Can	0
19958	4990	Does can	1
19959	4990	Is can	2
19960	4990	Cans	3
19961	4991	Can	0
19962	4991	Do can	1
19963	4991	Am can	2
19964	4991	Cans	3
19965	4992	Can	0
19966	4992	Does can	1
19967	4992	Is can	2
19968	4992	Cans	3
19969	4993	Can	0
19970	4993	Do can	1
19971	4993	Are can	2
19972	4993	Cans	3
19973	4994	Can	0
19974	4994	Do can	1
19975	4994	Are can	2
19976	4994	Cans	3
19977	4995	Can	0
19978	4995	Does can	1
19979	4995	Is can	2
19980	4995	Cans	3
19981	4996	Can	0
19982	4996	Do can	1
19983	4996	Are can	2
19984	4996	Cans	3
19985	4997	must	0
19986	4997	musts	1
19987	4997	must to	2
19988	4997	am must	3
19989	4998	must	0
19990	4998	musts	1
19991	4998	must to	2
19992	4998	is must	3
19993	4999	must	0
19994	4999	musts	1
19995	4999	must to	2
19996	4999	are must	3
19997	5000	must	0
19998	5000	musts	1
19999	5000	must to	2
20000	5000	are must	3
20001	5001	must	0
20002	5001	musts	1
20003	5001	must to	2
20004	5001	is must	3
20005	5002	must	0
20006	5002	musts	1
20007	5002	must to	2
20008	5002	are must	3
20009	5003	must	0
20010	5003	musts	1
20011	5003	must to	2
20012	5003	is must	3
20013	5004	must	0
20014	5004	musts	1
20015	5004	must to	2
20016	5004	am must	3
20017	5005	must	0
20018	5005	musts	1
20019	5005	must to	2
20020	5005	is must	3
20021	5006	must	0
20022	5006	musts	1
20023	5006	must to	2
20024	5006	are must	3
20025	5007	must	0
20026	5007	musts	1
20027	5007	must to	2
20028	5007	are must	3
20029	5008	must	0
20030	5008	musts	1
20031	5008	must to	2
20032	5008	is must	3
20033	5009	must	0
20034	5009	musts	1
20035	5009	must to	2
20036	5009	are must	3
20037	5010	must	0
20038	5010	musts	1
20039	5010	must to	2
20040	5010	is must	3
20041	5011	must	0
20042	5011	musts	1
20043	5011	must to	2
20044	5011	am must	3
20045	5012	must	0
20046	5012	musts	1
20047	5012	must to	2
20048	5012	is must	3
20049	5013	must	0
20050	5013	musts	1
20051	5013	must to	2
20052	5013	are must	3
20053	5014	must	0
20054	5014	musts	1
20055	5014	must to	2
20056	5014	are must	3
20057	5015	must	0
20058	5015	musts	1
20059	5015	must to	2
20060	5015	is must	3
20061	5016	must	0
20062	5016	musts	1
20063	5016	must to	2
20064	5016	are must	3
20065	5017	mustn't	0
20066	5017	must not to	1
20067	5017	don't must	2
20068	5017	aren't must	3
20069	5018	mustn't	0
20070	5018	must not to	1
20071	5018	doesn't must	2
20072	5018	isn't must	3
20073	5019	mustn't	0
20074	5019	must not to	1
20075	5019	don't must	2
20076	5019	aren't must	3
20077	5020	mustn't	0
20078	5020	must not to	1
20079	5020	don't must	2
20080	5020	aren't must	3
20081	5021	mustn't	0
20082	5021	must not to	1
20083	5021	doesn't must	2
20084	5021	isn't must	3
20085	5022	mustn't	0
20086	5022	must not to	1
20087	5022	don't must	2
20088	5022	aren't must	3
20089	5023	mustn't	0
20090	5023	must not to	1
20091	5023	don't must	2
20092	5023	am not must	3
20093	5024	mustn't	0
20094	5024	must not to	1
20095	5024	doesn't must	2
20096	5024	isn't must	3
20097	5025	mustn't	0
20098	5025	must not to	1
20099	5025	doesn't must	2
20100	5025	isn't must	3
20101	5026	mustn't	0
20102	5026	must not to	1
20103	5026	don't must	2
20104	5026	aren't must	3
20105	5027	mustn't	0
20106	5027	must not to	1
20107	5027	don't must	2
20108	5027	aren't must	3
20109	5028	mustn't	0
20110	5028	must not to	1
20111	5028	doesn't must	2
20112	5028	isn't must	3
20113	5029	mustn't	0
20114	5029	must not to	1
20115	5029	don't must	2
20116	5029	aren't must	3
20117	5030	mustn't	0
20118	5030	must not to	1
20119	5030	don't must	2
20120	5030	am not must	3
20121	5031	mustn't	0
20122	5031	must not to	1
20123	5031	doesn't must	2
20124	5031	isn't must	3
20125	5032	mustn't	0
20126	5032	must not to	1
20127	5032	doesn't must	2
20128	5032	isn't must	3
20129	5033	mustn't	0
20130	5033	must not to	1
20131	5033	don't must	2
20132	5033	aren't must	3
20133	5034	mustn't	0
20134	5034	must not to	1
20135	5034	don't must	2
20136	5034	aren't must	3
20137	5035	mustn't	0
20138	5035	must not to	1
20139	5035	doesn't must	2
20140	5035	isn't must	3
20141	5036	mustn't	0
20142	5036	must not to	1
20143	5036	don't must	2
20144	5036	aren't must	3
20145	5037	should	0
20146	5037	shoulds	1
20147	5037	should to	2
20148	5037	are should	3
20149	5038	should	0
20150	5038	shoulds	1
20151	5038	should to	2
20152	5038	is should	3
20153	5039	should	0
20154	5039	shoulds	1
20155	5039	should to	2
20156	5039	are should	3
20157	5040	should	0
20158	5040	shoulds	1
20159	5040	should to	2
20160	5040	are should	3
20161	5041	should	0
20162	5041	shoulds	1
20163	5041	should to	2
20164	5041	is should	3
20165	5042	should	0
20166	5042	shoulds	1
20167	5042	should to	2
20168	5042	are should	3
20169	5043	should	0
20170	5043	shoulds	1
20171	5043	should to	2
20172	5043	am should	3
20173	5044	should	0
20174	5044	shoulds	1
20175	5044	should to	2
20176	5044	is should	3
20177	5045	should	0
20178	5045	shoulds	1
20179	5045	should to	2
20180	5045	is should	3
20181	5046	should	0
20182	5046	shoulds	1
20183	5046	should to	2
20184	5046	are should	3
20185	5047	should	0
20186	5047	shoulds	1
20187	5047	should to	2
20188	5047	are should	3
20189	5048	should	0
20190	5048	shoulds	1
20191	5048	should to	2
20192	5048	is should	3
20193	5049	should	0
20194	5049	shoulds	1
20195	5049	should to	2
20196	5049	are should	3
20197	5050	should	0
20198	5050	shoulds	1
20199	5050	should to	2
20200	5050	am should	3
20201	5051	should	0
20202	5051	shoulds	1
20203	5051	should to	2
20204	5051	is should	3
20205	5052	should	0
20206	5052	shoulds	1
20207	5052	should to	2
20208	5052	is should	3
20209	5053	should	0
20210	5053	shoulds	1
20211	5053	should to	2
20212	5053	are should	3
20213	5054	should	0
20214	5054	shoulds	1
20215	5054	should to	2
20216	5054	are should	3
20217	5055	should	0
20218	5055	shoulds	1
20219	5055	should to	2
20220	5055	is should	3
20221	5056	should	0
20222	5056	shoulds	1
20223	5056	should to	2
20224	5056	are should	3
20225	5057	shouldn't	0
20226	5057	should not to	1
20227	5057	don't should	2
20228	5057	aren't should	3
20229	5058	shouldn't	0
20230	5058	should not to	1
20231	5058	doesn't should	2
20232	5058	isn't should	3
20233	5059	shouldn't	0
20234	5059	should not to	1
20235	5059	don't should	2
20236	5059	aren't should	3
20237	5060	shouldn't	0
20238	5060	should not to	1
20239	5060	don't should	2
20240	5060	aren't should	3
20241	5061	shouldn't	0
20242	5061	should not to	1
20243	5061	doesn't should	2
20244	5061	isn't should	3
20245	5062	shouldn't	0
20246	5062	should not to	1
20247	5062	don't should	2
20248	5062	aren't should	3
20249	5063	shouldn't	0
20250	5063	should not to	1
20251	5063	don't should	2
20252	5063	am not should	3
20253	5064	shouldn't	0
20254	5064	should not to	1
20255	5064	doesn't should	2
20256	5064	isn't should	3
20257	5065	shouldn't	0
20258	5065	should not to	1
20259	5065	doesn't should	2
20260	5065	isn't should	3
20261	5066	shouldn't	0
20262	5066	should not to	1
20263	5066	don't should	2
20264	5066	aren't should	3
20265	5067	shouldn't	0
20266	5067	should not to	1
20267	5067	don't should	2
20268	5067	aren't should	3
20269	5068	shouldn't	0
20270	5068	should not to	1
20271	5068	doesn't should	2
20272	5068	isn't should	3
20273	5069	shouldn't	0
20274	5069	should not to	1
20275	5069	don't should	2
20276	5069	aren't should	3
20277	5070	shouldn't	0
20278	5070	should not to	1
20279	5070	don't should	2
20280	5070	am not should	3
20281	5071	shouldn't	0
20282	5071	should not to	1
20283	5071	doesn't should	2
20284	5071	isn't should	3
20285	5072	shouldn't	0
20286	5072	should not to	1
20287	5072	doesn't should	2
20288	5072	isn't should	3
20289	5073	shouldn't	0
20290	5073	should not to	1
20291	5073	don't should	2
20292	5073	aren't should	3
20293	5074	shouldn't	0
20294	5074	should not to	1
20295	5074	don't should	2
20296	5074	aren't should	3
20297	5075	shouldn't	0
20298	5075	should not to	1
20299	5075	doesn't should	2
20300	5075	isn't should	3
20301	5076	shouldn't	0
20302	5076	should not to	1
20303	5076	don't should	2
20304	5076	aren't should	3
20305	5077	can	0
20306	5077	must	1
20307	5077	should	2
20308	5077	cans	3
20309	5078	can	0
20310	5078	must	1
20311	5078	should	2
20312	5078	musts	3
20313	5079	can	0
20314	5079	must	1
20315	5079	should	2
20316	5079	shoulds	3
20317	5080	can	0
20318	5080	must	1
20319	5080	should	2
20320	5080	cans	3
20321	5081	can	0
20322	5081	must	1
20323	5081	should	2
20324	5081	musts	3
20325	5082	can	0
20326	5082	must	1
20327	5082	should	2
20328	5082	shoulds	3
20329	5083	can	0
20330	5083	must	1
20331	5083	should	2
20332	5083	cans	3
20333	5084	can	0
20334	5084	must	1
20335	5084	should	2
20336	5084	musts	3
20337	5085	can	0
20338	5085	must	1
20339	5085	should	2
20340	5085	shoulds	3
20341	5086	can	0
20342	5086	must	1
20343	5086	should	2
20344	5086	cans	3
20345	5087	can	0
20346	5087	must	1
20347	5087	should	2
20348	5087	musts	3
20349	5088	can	0
20350	5088	must	1
20351	5088	should	2
20352	5088	shoulds	3
20353	5089	can	0
20354	5089	must	1
20355	5089	should	2
20356	5089	cans	3
20357	5090	can	0
20358	5090	must	1
20359	5090	should	2
20360	5090	musts	3
20361	5091	can	0
20362	5091	must	1
20363	5091	should	2
20364	5091	shoulds	3
20365	5092	can	0
20366	5092	must	1
20367	5092	should	2
20368	5092	cans	3
20369	5093	can	0
20370	5093	must	1
20371	5093	should	2
20372	5093	musts	3
20373	5094	can	0
20374	5094	must	1
20375	5094	should	2
20376	5094	shoulds	3
20377	5095	can	0
20378	5095	must	1
20379	5095	should	2
20380	5095	cans	3
20381	5096	can	0
20382	5096	must	1
20383	5096	should	2
20384	5096	musts	3
20385	5097	Can	0
20386	5097	Must	1
20387	5097	Should	2
20388	5097	Do can	3
20389	5098	Can	0
20390	5098	Must	1
20391	5098	Should	2
20392	5098	Do must	3
20393	5099	Can	0
20394	5099	Must	1
20395	5099	Should	2
20396	5099	Do should	3
20397	5100	Can	0
20398	5100	Must	1
20399	5100	Should	2
20400	5100	Does can	3
20401	5101	Can	0
20402	5101	Must	1
20403	5101	Should	2
20404	5101	Do must	3
20405	5102	Can	0
20406	5102	Must	1
20407	5102	Should	2
20408	5102	Does should	3
20409	5103	Can	0
20410	5103	Must	1
20411	5103	Should	2
20412	5103	Do can	3
20413	5104	Can	0
20414	5104	Must	1
20415	5104	Should	2
20416	5104	Do must	3
20417	5105	Can	0
20418	5105	Must	1
20419	5105	Should	2
20420	5105	Do should	3
20421	5106	Can	0
20422	5106	Must	1
20423	5106	Should	2
20424	5106	Does can	3
20425	5107	Can	0
20426	5107	Must	1
20427	5107	Should	2
20428	5107	Does must	3
20429	5108	Can	0
20430	5108	Must	1
20431	5108	Should	2
20432	5108	Do should	3
20433	5109	Can	0
20434	5109	Must	1
20435	5109	Should	2
20436	5109	Do can	3
20437	5110	Can	0
20438	5110	Must	1
20439	5110	Should	2
20440	5110	Do must	3
20441	5111	Can	0
20442	5111	Must	1
20443	5111	Should	2
20444	5111	Do should	3
20445	5112	Can	0
20446	5112	Must	1
20447	5112	Should	2
20448	5112	Does can	3
20449	5113	Can	0
20450	5113	Must	1
20451	5113	Should	2
20452	5113	Do must	3
20453	5114	Can	0
20454	5114	Must	1
20455	5114	Should	2
20456	5114	Does should	3
20457	5115	Can	0
20458	5115	Must	1
20459	5115	Should	2
20460	5115	Do can	3
20461	5116	Can	0
20462	5116	Must	1
20463	5116	Should	2
20464	5116	Do must	3
20465	5117	can't	0
20466	5117	mustn't	1
20467	5117	shouldn't	2
20468	5117	don't can	3
20469	5118	can't	0
20470	5118	mustn't	1
20471	5118	shouldn't	2
20472	5118	don't must	3
20473	5119	can't	0
20474	5119	mustn't	1
20475	5119	shouldn't	2
20476	5119	doesn't should	3
20477	5120	can't	0
20478	5120	mustn't	1
20479	5120	shouldn't	2
20480	5120	don't can	3
20481	5121	can't	0
20482	5121	mustn't	1
20483	5121	shouldn't	2
20484	5121	don't must	3
20485	5122	can't	0
20486	5122	mustn't	1
20487	5122	shouldn't	2
20488	5122	doesn't should	3
20489	5123	can't	0
20490	5123	mustn't	1
20491	5123	shouldn't	2
20492	5123	don't can	3
20493	5124	can't	0
20494	5124	mustn't	1
20495	5124	shouldn't	2
20496	5124	don't must	3
20497	5125	can't	0
20498	5125	mustn't	1
20499	5125	shouldn't	2
20500	5125	doesn't should	3
20501	5126	can't	0
20502	5126	mustn't	1
20503	5126	shouldn't	2
20504	5126	don't can	3
20505	5127	can't	0
20506	5127	mustn't	1
20507	5127	shouldn't	2
20508	5127	don't must	3
20509	5128	can't	0
20510	5128	mustn't	1
20511	5128	shouldn't	2
20512	5128	doesn't should	3
20513	5129	can't	0
20514	5129	mustn't	1
20515	5129	shouldn't	2
20516	5129	don't can	3
20517	5130	can't	0
20518	5130	mustn't	1
20519	5130	shouldn't	2
20520	5130	don't must	3
20521	5131	can't	0
20522	5131	mustn't	1
20523	5131	shouldn't	2
20524	5131	doesn't should	3
20525	5132	can't	0
20526	5132	mustn't	1
20527	5132	shouldn't	2
20528	5132	don't can	3
20529	5133	can't	0
20530	5133	mustn't	1
20531	5133	shouldn't	2
20532	5133	don't must	3
20533	5134	can't	0
20534	5134	mustn't	1
20535	5134	shouldn't	2
20536	5134	doesn't should	3
20537	5135	can't	0
20538	5135	mustn't	1
20539	5135	shouldn't	2
20540	5135	don't can	3
20541	5136	can't	0
20542	5136	mustn't	1
20543	5136	shouldn't	2
20544	5136	don't must	3
20545	5137	There is	0
20546	5137	There are	1
20547	5137	It is	2
20548	5137	Is there	3
20549	5138	There is	0
20550	5138	There are	1
20551	5138	It is	2
20552	5138	Is there	3
20553	5139	There is	0
20554	5139	There are	1
20555	5139	It is	2
20556	5139	Is there	3
20557	5140	There is	0
20558	5140	There are	1
20559	5140	It is	2
20560	5140	Is there	3
20561	5141	There is	0
20562	5141	There are	1
20563	5141	It is	2
20564	5141	Is there	3
20565	5142	There is	0
20566	5142	There are	1
20567	5142	It is	2
20568	5142	Is there	3
20569	5143	There is	0
20570	5143	There are	1
20571	5143	It is	2
20572	5143	Is there	3
20573	5144	There is	0
20574	5144	There are	1
20575	5144	It is	2
20576	5144	Is there	3
20577	5145	There is	0
20578	5145	There are	1
20579	5145	It is	2
20580	5145	Is there	3
20581	5146	There is	0
20582	5146	There are	1
20583	5146	It is	2
20584	5146	Is there	3
20585	5147	There is	0
20586	5147	There are	1
20587	5147	It is	2
20588	5147	Is there	3
20589	5148	There is	0
20590	5148	There are	1
20591	5148	It is	2
20592	5148	Is there	3
20593	5149	There is	0
20594	5149	There are	1
20595	5149	It is	2
20596	5149	Is there	3
20597	5150	There is	0
20598	5150	There are	1
20599	5150	It is	2
20600	5150	Is there	3
20601	5151	There is	0
20602	5151	There are	1
20603	5151	It is	2
20604	5151	Is there	3
20605	5152	There is	0
20606	5152	There are	1
20607	5152	It is	2
20608	5152	Is there	3
20609	5153	There is	0
20610	5153	There are	1
20611	5153	It is	2
20612	5153	Is there	3
20613	5154	There is	0
20614	5154	There are	1
20615	5154	It is	2
20616	5154	Is there	3
20617	5155	There is	0
20618	5155	There are	1
20619	5155	It is	2
20620	5155	Is there	3
20621	5156	There is	0
20622	5156	There are	1
20623	5156	It is	2
20624	5156	Is there	3
20625	5157	There is	0
20626	5157	There are	1
20627	5157	They are	2
20628	5157	Are there	3
20629	5158	There is	0
20630	5158	There are	1
20631	5158	They are	2
20632	5158	Are there	3
20633	5159	There is	0
20634	5159	There are	1
20635	5159	They are	2
20636	5159	Are there	3
20637	5160	There is	0
20638	5160	There are	1
20639	5160	They are	2
20640	5160	Are there	3
20641	5161	There is	0
20642	5161	There are	1
20643	5161	They are	2
20644	5161	Are there	3
20645	5162	There is	0
20646	5162	There are	1
20647	5162	They are	2
20648	5162	Are there	3
20649	5163	There is	0
20650	5163	There are	1
20651	5163	They are	2
20652	5163	Are there	3
20653	5164	There is	0
20654	5164	There are	1
20655	5164	They are	2
20656	5164	Are there	3
20657	5165	There is	0
20658	5165	There are	1
20659	5165	They are	2
20660	5165	Are there	3
20661	5166	There is	0
20662	5166	There are	1
20663	5166	They are	2
20664	5166	Are there	3
20665	5167	There is	0
20666	5167	There are	1
20667	5167	They are	2
20668	5167	Are there	3
20669	5168	There is	0
20670	5168	There are	1
20671	5168	They are	2
20672	5168	Are there	3
20673	5169	There is	0
20674	5169	There are	1
20675	5169	They are	2
20676	5169	Are there	3
20677	5170	There is	0
20678	5170	There are	1
20679	5170	They are	2
20680	5170	Are there	3
20681	5171	There is	0
20682	5171	There are	1
20683	5171	They are	2
20684	5171	Are there	3
20685	5172	There is	0
20686	5172	There are	1
20687	5172	They are	2
20688	5172	Are there	3
20689	5173	There is	0
20690	5173	There are	1
20691	5173	They are	2
20692	5173	Are there	3
20693	5174	There is	0
20694	5174	There are	1
20695	5174	They are	2
20696	5174	Are there	3
20697	5175	There is	0
20698	5175	There are	1
20699	5175	They are	2
20700	5175	Are there	3
20701	5176	There is	0
20702	5176	There are	1
20703	5176	They are	2
20704	5176	Are there	3
20705	5177	There is	0
20706	5177	There are	1
20707	5177	It is	2
20708	5177	They are	3
20709	5178	There is	0
20710	5178	There are	1
20711	5178	It is	2
20712	5178	They are	3
20713	5179	There is	0
20714	5179	There are	1
20715	5179	It is	2
20716	5179	They are	3
20717	5180	There is	0
20718	5180	There are	1
20719	5180	It is	2
20720	5180	They are	3
20721	5181	There is	0
20722	5181	There are	1
20723	5181	It is	2
20724	5181	They are	3
20725	5182	There is	0
20726	5182	There are	1
20727	5182	It is	2
20728	5182	They are	3
20729	5183	There is	0
20730	5183	There are	1
20731	5183	It is	2
20732	5183	They are	3
20733	5184	There is	0
20734	5184	There are	1
20735	5184	It is	2
20736	5184	They are	3
20737	5185	There is	0
20738	5185	There are	1
20739	5185	It is	2
20740	5185	They are	3
20741	5186	There is	0
20742	5186	There are	1
20743	5186	It is	2
20744	5186	They are	3
20745	5187	There is	0
20746	5187	There are	1
20747	5187	It is	2
20748	5187	They are	3
20749	5188	There is	0
20750	5188	There are	1
20751	5188	It is	2
20752	5188	They are	3
20753	5189	There is	0
20754	5189	There are	1
20755	5189	It is	2
20756	5189	They are	3
20757	5190	There is	0
20758	5190	There are	1
20759	5190	It is	2
20760	5190	They are	3
20761	5191	There is	0
20762	5191	There are	1
20763	5191	It is	2
20764	5191	They are	3
20765	5192	There is	0
20766	5192	There are	1
20767	5192	It is	2
20768	5192	They are	3
20769	5193	There is	0
20770	5193	There are	1
20771	5193	It is	2
20772	5193	They are	3
20773	5194	There is	0
20774	5194	There are	1
20775	5194	It is	2
20776	5194	They are	3
20777	5195	There is	0
20778	5195	There are	1
20779	5195	It is	2
20780	5195	They are	3
20781	5196	There is	0
20782	5196	There are	1
20783	5196	It is	2
20784	5196	They are	3
20785	5197	There isn't	0
20786	5197	There aren't	1
20787	5197	It isn't	2
20788	5197	They aren't	3
20789	5198	There isn't	0
20790	5198	There aren't	1
20791	5198	It isn't	2
20792	5198	They aren't	3
20793	5199	There isn't	0
20794	5199	There aren't	1
20795	5199	It isn't	2
20796	5199	They aren't	3
20797	5200	There isn't	0
20798	5200	There aren't	1
20799	5200	It isn't	2
20800	5200	They aren't	3
20801	5201	There isn't	0
20802	5201	There aren't	1
20803	5201	It isn't	2
20804	5201	They aren't	3
20805	5202	There isn't	0
20806	5202	There aren't	1
20807	5202	It isn't	2
20808	5202	They aren't	3
20809	5203	There isn't	0
20810	5203	There aren't	1
20811	5203	It isn't	2
20812	5203	They aren't	3
20813	5204	There isn't	0
20814	5204	There aren't	1
20815	5204	It isn't	2
20816	5204	They aren't	3
20817	5205	There isn't	0
20818	5205	There aren't	1
20819	5205	It isn't	2
20820	5205	They aren't	3
20821	5206	There isn't	0
20822	5206	There aren't	1
20823	5206	It isn't	2
20824	5206	They aren't	3
20825	5207	There isn't	0
20826	5207	There aren't	1
20827	5207	It isn't	2
20828	5207	They aren't	3
20829	5208	There isn't	0
20830	5208	There aren't	1
20831	5208	It isn't	2
20832	5208	They aren't	3
20833	5209	There isn't	0
20834	5209	There aren't	1
20835	5209	It isn't	2
20836	5209	They aren't	3
20837	5210	There isn't	0
20838	5210	There aren't	1
20839	5210	It isn't	2
20840	5210	They aren't	3
20841	5211	There isn't	0
20842	5211	There aren't	1
20843	5211	It isn't	2
20844	5211	They aren't	3
20845	5212	There isn't	0
20846	5212	There aren't	1
20847	5212	It isn't	2
20848	5212	They aren't	3
20849	5213	There isn't	0
20850	5213	There aren't	1
20851	5213	It isn't	2
20852	5213	They aren't	3
20853	5214	There isn't	0
20854	5214	There aren't	1
20855	5214	It isn't	2
20856	5214	They aren't	3
20857	5215	There isn't	0
20858	5215	There aren't	1
20859	5215	It isn't	2
20860	5215	They aren't	3
20861	5216	There isn't	0
20862	5216	There aren't	1
20863	5216	It isn't	2
20864	5216	They aren't	3
20865	5217	There is	0
20866	5217	There are	1
20867	5217	It is	2
20868	5217	They are	3
20869	5218	There is	0
20870	5218	There are	1
20871	5218	It is	2
20872	5218	They are	3
20873	5219	There is	0
20874	5219	There are	1
20875	5219	It is	2
20876	5219	They are	3
20877	5220	There is	0
20878	5220	There are	1
20879	5220	It is	2
20880	5220	They are	3
20881	5221	There is	0
20882	5221	There are	1
20883	5221	It is	2
20884	5221	They are	3
20885	5222	There is	0
20886	5222	There are	1
20887	5222	It is	2
20888	5222	They are	3
20889	5223	There is	0
20890	5223	There are	1
20891	5223	It is	2
20892	5223	They are	3
20893	5224	There is	0
20894	5224	There are	1
20895	5224	It is	2
20896	5224	They are	3
20897	5225	There is	0
20898	5225	There are	1
20899	5225	It is	2
20900	5225	They are	3
20901	5226	There is	0
20902	5226	There are	1
20903	5226	It is	2
20904	5226	They are	3
20905	5227	There is	0
20906	5227	There are	1
20907	5227	It is	2
20908	5227	They are	3
20909	5228	There is	0
20910	5228	There are	1
20911	5228	It is	2
20912	5228	They are	3
20913	5229	There is	0
20914	5229	There are	1
20915	5229	It is	2
20916	5229	They are	3
20917	5230	There is	0
20918	5230	There are	1
20919	5230	It is	2
20920	5230	They are	3
20921	5231	There is	0
20922	5231	There are	1
20923	5231	It is	2
20924	5231	They are	3
20925	5232	There is	0
20926	5232	There are	1
20927	5232	It is	2
20928	5232	They are	3
20929	5233	There is	0
20930	5233	There are	1
20931	5233	It is	2
20932	5233	They are	3
20933	5234	There is	0
20934	5234	There are	1
20935	5234	It is	2
20936	5234	They are	3
20937	5235	There is	0
20938	5235	There are	1
20939	5235	It is	2
20940	5235	They are	3
20941	5236	There is	0
20942	5236	There are	1
20943	5236	It is	2
20944	5236	They are	3
20945	5237	Is there	0
20946	5237	Are there	1
20947	5237	Is it	2
20948	5237	Are they	3
20949	5238	Is there	0
20950	5238	Are there	1
20951	5238	Is it	2
20952	5238	Are they	3
20953	5239	Is there	0
20954	5239	Are there	1
20955	5239	Is it	2
20956	5239	Are they	3
20957	5240	Is there	0
20958	5240	Are there	1
20959	5240	Is it	2
20960	5240	Are they	3
20961	5241	Is there	0
20962	5241	Are there	1
20963	5241	Is it	2
20964	5241	Are they	3
20965	5242	Is there	0
20966	5242	Are there	1
20967	5242	Is it	2
20968	5242	Are they	3
20969	5243	Is there	0
20970	5243	Are there	1
20971	5243	Is it	2
20972	5243	Are they	3
20973	5244	Is there	0
20974	5244	Are there	1
20975	5244	Is it	2
20976	5244	Are they	3
20977	5245	Is there	0
20978	5245	Are there	1
20979	5245	Is it	2
20980	5245	Are they	3
20981	5246	Is there	0
20982	5246	Are there	1
20983	5246	Is it	2
20984	5246	Are they	3
20985	5247	Is there	0
20986	5247	Are there	1
20987	5247	Is it	2
20988	5247	Are they	3
20989	5248	Is there	0
20990	5248	Are there	1
20991	5248	Is it	2
20992	5248	Are they	3
20993	5249	Is there	0
20994	5249	Are there	1
20995	5249	Is it	2
20996	5249	Are they	3
20997	5250	Is there	0
20998	5250	Are there	1
20999	5250	Is it	2
21000	5250	Are they	3
21001	5251	Is there	0
21002	5251	Are there	1
21003	5251	Is it	2
21004	5251	Are they	3
21005	5252	Is there	0
21006	5252	Are there	1
21007	5252	Is it	2
21008	5252	Are they	3
21009	5253	Is there	0
21010	5253	Are there	1
21011	5253	Is it	2
21012	5253	Are they	3
21013	5254	Is there	0
21014	5254	Are there	1
21015	5254	Is it	2
21016	5254	Are they	3
21017	5255	Is there	0
21018	5255	Are there	1
21019	5255	Is it	2
21020	5255	Are they	3
21021	5256	Is there	0
21022	5256	Are there	1
21023	5256	Is it	2
21024	5256	Are they	3
21025	5257	Is there	0
21026	5257	Are there	1
21027	5257	Is it	2
21028	5257	Are they	3
21029	5258	Is there	0
21030	5258	Are there	1
21031	5258	Is it	2
21032	5258	Are they	3
21033	5259	Is there	0
21034	5259	Are there	1
21035	5259	Is it	2
21036	5259	Are they	3
21037	5260	Is there	0
21038	5260	Are there	1
21039	5260	Is it	2
21040	5260	Are they	3
21041	5261	Is there	0
21042	5261	Are there	1
21043	5261	Is it	2
21044	5261	Are they	3
21045	5262	Is there	0
21046	5262	Are there	1
21047	5262	Is it	2
21048	5262	Are they	3
21049	5263	Is there	0
21050	5263	Are there	1
21051	5263	Is it	2
21052	5263	Are they	3
21053	5264	Is there	0
21054	5264	Are there	1
21055	5264	Is it	2
21056	5264	Are they	3
21057	5265	Is there	0
21058	5265	Are there	1
21059	5265	Is it	2
21060	5265	Are they	3
21061	5266	Is there	0
21062	5266	Are there	1
21063	5266	Is it	2
21064	5266	Are they	3
21065	5267	Is there	0
21066	5267	Are there	1
21067	5267	Is it	2
21068	5267	Are they	3
21069	5268	Is there	0
21070	5268	Are there	1
21071	5268	Is it	2
21072	5268	Are they	3
21073	5269	Is there	0
21074	5269	Are there	1
21075	5269	Is it	2
21076	5269	Are they	3
21077	5270	Is there	0
21078	5270	Are there	1
21079	5270	Is it	2
21080	5270	Are they	3
21081	5271	Is there	0
21082	5271	Are there	1
21083	5271	Is it	2
21084	5271	Are they	3
21085	5272	Is there	0
21086	5272	Are there	1
21087	5272	Is it	2
21088	5272	Are they	3
21089	5273	Is there	0
21090	5273	Are there	1
21091	5273	Is it	2
21092	5273	Are they	3
21093	5274	Is there	0
21094	5274	Are there	1
21095	5274	Is it	2
21096	5274	Are they	3
21097	5275	Is there	0
21098	5275	Are there	1
21099	5275	Is it	2
21100	5275	Are they	3
21101	5276	Is there	0
21102	5276	Are there	1
21103	5276	Is it	2
21104	5276	Are they	3
21105	5277	in	0
21106	5277	on	1
21107	5277	at	2
21108	5277	to	3
21109	5278	in	0
21110	5278	on	1
21111	5278	at	2
21112	5278	to	3
21113	5279	in	0
21114	5279	under	1
21115	5279	at	2
21116	5279	to	3
21117	5280	in	0
21118	5280	on	1
21119	5280	at	2
21120	5280	to	3
21121	5281	in	0
21122	5281	on	1
21123	5281	next to	2
21124	5281	to	3
21125	5282	in	0
21126	5282	under	1
21127	5282	at	2
21128	5282	to	3
21129	5283	in	0
21130	5283	between	1
21131	5283	at	2
21132	5283	to	3
21133	5284	in	0
21134	5284	on	1
21135	5284	at	2
21136	5284	to	3
21137	5285	in	0
21138	5285	on	1
21139	5285	at	2
21140	5285	to	3
21141	5286	in	0
21142	5286	on	1
21143	5286	at	2
21144	5286	to	3
21145	5287	in	0
21146	5287	on	1
21147	5287	at	2
21148	5287	to	3
21149	5288	in	0
21150	5288	on	1
21151	5288	at	2
21152	5288	to	3
21153	5289	in	0
21154	5289	on	1
21155	5289	at	2
21156	5289	to	3
21157	5290	in	0
21158	5290	on	1
21159	5290	at	2
21160	5290	to	3
21161	5291	in	0
21162	5291	next to	1
21163	5291	at	2
21164	5291	to	3
21165	5292	in	0
21166	5292	on	1
21167	5292	at	2
21168	5292	to	3
21169	5293	in	0
21170	5293	on	1
21171	5293	at	2
21172	5293	to	3
21173	5294	in	0
21174	5294	on	1
21175	5294	at	2
21176	5294	to	3
21177	5295	in	0
21178	5295	under	1
21179	5295	at	2
21180	5295	to	3
21181	5296	in	0
21182	5296	next to	1
21183	5296	at	2
21184	5296	to	3
21185	5297	There is	0
21186	5297	There are	1
21187	5297	Is there	2
21188	5297	Are there	3
21189	5298	There is	0
21190	5298	There are	1
21191	5298	Is there	2
21192	5298	Are there	3
21193	5299	There is	0
21194	5299	There are	1
21195	5299	Is there	2
21196	5299	Are there	3
21197	5300	There is	0
21198	5300	There are	1
21199	5300	Is there	2
21200	5300	Are there	3
21201	5301	There is	0
21202	5301	There are	1
21203	5301	Is there	2
21204	5301	Are there	3
21205	5302	There is	0
21206	5302	There are	1
21207	5302	Is there	2
21208	5302	Are there	3
21209	5303	There is	0
21210	5303	There are	1
21211	5303	Is there	2
21212	5303	Are there	3
21213	5304	There is	0
21214	5304	There are	1
21215	5304	Is there	2
21216	5304	Are there	3
21217	5305	is	0
21218	5305	are	1
21219	5305	isn't	2
21220	5305	aren't	3
21221	5306	is	0
21222	5306	are	1
21223	5306	isn't	2
21224	5306	aren't	3
21225	5307	is	0
21226	5307	are	1
21227	5307	isn't	2
21228	5307	aren't	3
21229	5308	is	0
21230	5308	are	1
21231	5308	isn't	2
21232	5308	aren't	3
21233	5309	There is	0
21234	5309	There are	1
21235	5309	Is there	2
21236	5309	Are there	3
21237	5310	There is	0
21238	5310	There are	1
21239	5310	Is there	2
21240	5310	Are there	3
21241	5311	There is	0
21242	5311	There are	1
21243	5311	Is there	2
21244	5311	Are there	3
21245	5312	There is	0
21246	5312	There are	1
21247	5312	Is there	2
21248	5312	Are there	3
21249	5313	There is	0
21250	5313	There are	1
21251	5313	Is there	2
21252	5313	Are there	3
21253	5314	is	0
21254	5314	are	1
21255	5314	isn't	2
21256	5314	aren't	3
21257	5315	There is	0
21258	5315	There are	1
21259	5315	Is there	2
21260	5315	Are there	3
21261	5316	There is	0
21262	5316	There are	1
21263	5316	Is there	2
21264	5316	Are there	3
21265	5317	there is	0
21266	5317	there are	1
21267	5317	it is	2
21268	5317	they are	3
21269	5318	there is	0
21270	5318	there are	1
21271	5318	it is	2
21272	5318	they are	3
21273	5319	there is	0
21274	5319	there isn't	1
21275	5319	it isn't	2
21276	5319	they aren't	3
21277	5320	there is	0
21278	5320	there isn't	1
21279	5320	it isn't	2
21280	5320	there aren't	3
21281	5321	there is	0
21282	5321	there are	1
21283	5321	it is	2
21284	5321	they are	3
21285	5322	there is	0
13661	3416	Глагол	0
13662	3416	Наречие	1
13663	3416	Существительное	2
13664	3416	Союз	3
13665	3417	chair	0
13666	3417	student	1
13667	3417	information	2
13668	3417	idea	3
13669	3418	two book	0
13670	3418	two books	1
13671	3418	two bookes	2
13672	3418	two booking	3
13673	3419	citys	0
13674	3419	cityes	1
13675	3419	cities	2
13676	3419	citis	3
13677	3420	car of John	0
13678	3420	Johns car	1
13679	3420	John car	2
13680	3420	John’s car	3
13681	3421	Нет артикля	0
13682	3421	Нет глагола	1
13683	3421	Неправильное слово	2
13684	3421	Слишком короткое	3
13685	3422	Informations are useful	0
13686	3422	Information are useful	1
13687	3422	Information is useful	2
13688	3422	An information is useful	3
13689	3423	В конце	0
13690	3423	Перед глаголом	1
13691	3423	Только после глагола	2
13692	3423	Где угодно	3
13693	3424	a	0
13694	3424	an	1
13695	3424	the	2
13696	3424	–	3
13697	3425	a	0
13698	3425	an	1
13699	3425	the	2
13700	3425	–	3
13701	3426	A	0
13702	3426	An	1
13703	3426	The	2
13704	3426	–	3
13705	3427	a	0
13706	3427	an	1
13707	3427	the	2
13708	3427	–	3
13709	3428	a	0
13710	3428	an	1
13711	3428	the	2
13712	3428	–	3
13713	3429	a	0
13714	3429	an	1
13715	3429	the	2
13716	3429	–	3
13717	3430	a	0
13718	3430	an	1
13719	3430	the	2
13720	3430	–	3
13721	3431	a	0
13722	3431	an	1
13723	3431	the	2
13724	3431	–	3
13725	3432	a	0
13726	3432	an	1
13727	3432	the	2
13728	3432	–	3
13729	3433	A	0
13730	3433	An	1
13731	3433	The	2
13732	3433	–	3
13733	3434	a	0
13734	3434	an	1
13735	3434	the	2
13736	3434	–	3
13737	3435	A	0
13738	3435	An	1
13739	3435	The	2
13740	3435	–	3
13741	3436	a / a	0
13742	3436	an / a	1
13743	3436	the / the	2
13744	3436	a / an	3
13745	3437	a	0
13746	3437	an	1
13747	3437	the	2
13748	3437	–	3
13749	3438	A	0
13750	3438	An	1
13751	3438	The	2
13752	3438	–	3
13753	3439	a / a	0
13754	3439	an / a	1
13755	3439	the / the	2
13756	3439	a / the	3
13757	3440	a	0
13758	3440	an	1
13759	3440	the	2
13760	3440	–	3
13761	3441	a	0
13762	3441	an	1
13763	3441	the	2
13764	3441	–	3
13765	3442	A	0
13766	3442	An	1
13767	3442	The	2
13768	3442	–	3
13769	3443	a	0
13770	3443	an	1
13771	3443	the	2
13772	3443	–	3
13773	3444	a	0
13774	3444	an	1
13775	3444	the	2
13776	3444	–	3
13777	3445	a	0
13778	3445	an	1
13779	3445	the	2
13780	3445	–	3
13781	3446	A	0
13782	3446	An	1
13783	3446	The	2
13784	3446	–	3
13785	3447	a	0
13786	3447	an	1
13787	3447	the	2
13788	3447	–	3
13789	3448	a	0
13790	3448	an	1
13791	3448	the	2
13792	3448	–	3
13793	3449	a	0
13794	3449	an	1
13795	3449	the	2
13796	3449	–	3
13797	3450	a	0
13798	3450	an	1
13799	3450	the	2
13800	3450	–	3
13801	3451	a	0
13802	3451	an	1
13803	3451	the	2
13804	3451	–	3
13805	3452	a	0
13806	3452	an	1
13807	3452	the	2
13808	3452	–	3
13809	3453	A	0
13810	3453	An	1
13811	3453	The	2
13812	3453	–	3
13813	3454	a	0
13814	3454	an	1
13815	3454	the	2
13816	3454	–	3
13817	3455	A	0
13818	3455	An	1
13819	3455	The	2
13820	3455	–	3
13821	3456	a / a	0
13822	3456	an / a	1
13823	3456	the / the	2
13824	3456	a / an	3
13825	3457	a	0
13826	3457	an	1
13827	3457	the	2
13828	3457	–	3
13829	3458	A	0
13830	3458	An	1
13831	3458	The	2
13832	3458	–	3
13833	3459	a / a	0
13834	3459	an / a	1
13835	3459	the / the	2
13836	3459	a / the	3
13837	3460	a	0
13838	3460	an	1
13839	3460	the	2
13840	3460	–	3
13841	3461	a	0
13842	3461	an	1
13843	3461	the	2
13844	3461	–	3
13845	3462	A	0
13846	3462	An	1
13847	3462	The	2
13848	3462	–	3
13849	3463	a	0
13850	3463	an	1
13851	3463	the	2
13852	3463	–	3
13853	3464	a	0
13854	3464	an	1
13855	3464	the	2
13856	3464	–	3
13857	3465	a	0
13858	3465	an	1
13859	3465	the	2
13860	3465	–	3
13861	3466	A	0
13862	3466	An	1
13863	3466	The	2
13864	3466	–	3
13865	3467	a	0
13866	3467	an	1
13867	3467	the	2
13868	3467	–	3
13869	3468	a	0
13870	3468	an	1
13871	3468	the	2
13872	3468	–	3
13873	3469	a	0
13874	3469	an	1
13875	3469	the	2
13876	3469	–	3
13877	3470	a	0
13878	3470	an	1
13879	3470	the	2
13880	3470	–	3
13881	3471	a	0
13882	3471	an	1
13883	3471	the	2
13884	3471	–	3
13885	3472	a	0
13886	3472	an	1
13887	3472	the	2
13888	3472	–	3
13889	3473	A	0
13890	3473	An	1
13891	3473	The	2
13892	3473	–	3
13893	3474	a / a	0
13894	3474	an / a	1
13895	3474	the / the	2
13896	3474	a / an	3
13897	3475	A	0
13898	3475	An	1
13899	3475	The	2
13900	3475	–	3
13901	3476	a / a	0
13902	3476	an / a	1
13903	3476	the / the	2
13904	3476	a / an	3
13905	3477	a	0
13906	3477	an	1
13907	3477	the	2
13908	3477	–	3
13909	3478	A	0
13910	3478	An	1
13911	3478	The	2
13912	3478	–	3
13913	3479	a / a	0
13914	3479	an / a	1
13915	3479	the / the	2
13916	3479	a / the	3
13917	3480	a	0
13918	3480	an	1
13919	3480	the	2
13920	3480	–	3
13921	3481	a	0
13922	3481	an	1
13923	3481	the	2
13924	3481	–	3
13925	3482	A	0
13926	3482	An	1
13927	3482	The	2
13928	3482	–	3
13929	3483	a	0
13930	3483	an	1
13931	3483	the	2
13932	3483	–	3
13933	3484	a	0
13934	3484	an	1
13935	3484	the	2
13936	3484	–	3
13937	3485	a	0
13938	3485	an	1
13939	3485	the	2
13940	3485	–	3
13941	3486	A	0
13942	3486	An	1
13943	3486	The	2
13944	3486	–	3
13945	3487	a	0
13946	3487	an	1
13947	3487	the	2
13948	3487	–	3
13949	3488	a	0
13950	3488	an	1
13951	3488	the	2
13952	3488	–	3
13953	3489	a	0
13954	3489	an	1
13955	3489	the	2
13956	3489	–	3
13957	3490	a	0
13958	3490	an	1
13959	3490	the	2
13960	3490	–	3
13961	3491	a	0
13962	3491	an	1
13963	3491	the	2
13964	3491	–	3
13965	3492	a	0
13966	3492	an	1
13967	3492	the	2
13968	3492	–	3
13969	3493	A	0
13970	3493	An	1
13971	3493	The	2
13972	3493	–	3
13973	3494	a / a	0
13974	3494	an / a	1
13975	3494	the / the	2
13976	3494	a / an	3
13977	3495	A	0
13978	3495	An	1
13979	3495	The	2
13980	3495	–	3
13981	3496	a / a	0
13982	3496	an / a	1
13983	3496	the / the	2
13984	3496	a / an	3
13985	3497	a	0
13986	3497	an	1
13987	3497	the	2
13988	3497	–	3
13989	3498	A	0
13990	3498	An	1
13991	3498	The	2
13992	3498	–	3
13993	3499	a / a	0
13994	3499	an / a	1
13995	3499	the / the	2
13996	3499	a / the	3
13997	3500	a	0
13998	3500	an	1
13999	3500	the	2
14000	3500	–	3
14001	3501	a	0
14002	3501	an	1
14003	3501	the	2
14004	3501	–	3
14005	3502	A	0
14006	3502	An	1
14007	3502	The	2
14008	3502	–	3
14009	3503	a	0
14010	3503	an	1
14011	3503	the	2
14012	3503	–	3
14013	3504	a	0
14014	3504	an	1
14015	3504	the	2
14016	3504	–	3
14017	3505	a	0
14018	3505	an	1
14019	3505	the	2
14020	3505	–	3
14021	3506	A	0
14022	3506	An	1
14023	3506	The	2
14024	3506	–	3
14025	3507	a	0
14026	3507	an	1
14027	3507	the	2
14028	3507	–	3
14029	3508	a	0
14030	3508	an	1
14031	3508	the	2
14032	3508	–	3
14033	3509	a	0
14034	3509	an	1
14035	3509	the	2
14036	3509	–	3
14037	3510	a	0
14038	3510	an	1
14039	3510	the	2
14040	3510	–	3
14041	3511	a	0
14042	3511	an	1
14043	3511	the	2
14044	3511	–	3
14045	3512	a	0
14046	3512	an	1
14047	3512	the	2
14048	3512	–	3
14049	3513	A	0
14050	3513	An	1
14051	3513	The	2
14052	3513	–	3
14053	3514	a / a	0
14054	3514	an / a	1
14055	3514	the / the	2
14056	3514	a / an	3
14057	3515	A	0
14058	3515	An	1
14059	3515	The	2
14060	3515	–	3
14061	3516	a / a	0
14062	3516	an / a	1
14063	3516	the / the	2
14064	3516	a / an	3
14065	3517	a	0
14066	3517	an	1
14067	3517	the	2
14068	3517	–	3
14069	3518	A	0
14070	3518	An	1
14071	3518	The	2
14072	3518	–	3
14073	3519	a / a	0
14074	3519	an / a	1
14075	3519	the / the	2
14076	3519	a / the	3
14077	3520	a	0
14078	3520	an	1
14079	3520	the	2
14080	3520	–	3
14081	3521	a	0
14082	3521	an	1
14083	3521	the	2
14084	3521	–	3
14085	3522	A	0
14086	3522	An	1
14087	3522	The	2
14088	3522	–	3
14089	3523	a	0
14090	3523	an	1
14091	3523	the	2
14092	3523	–	3
14093	3524	a	0
14094	3524	an	1
14095	3524	the	2
14096	3524	–	3
14097	3525	a	0
14098	3525	an	1
14099	3525	the	2
14100	3525	–	3
14101	3526	A	0
14102	3526	An	1
14103	3526	The	2
14104	3526	–	3
14105	3527	a	0
14106	3527	an	1
14107	3527	the	2
14108	3527	–	3
14109	3528	a	0
14110	3528	an	1
14111	3528	the	2
14112	3528	–	3
14113	3529	a	0
14114	3529	an	1
14115	3529	the	2
14116	3529	–	3
14117	3530	a	0
14118	3530	an	1
14119	3530	the	2
14120	3530	–	3
14121	3531	a	0
14122	3531	an	1
14123	3531	the	2
14124	3531	–	3
14125	3532	a	0
14126	3532	an	1
14127	3532	the	2
14128	3532	–	3
14129	3533	A	0
14130	3533	An	1
14131	3533	The	2
14132	3533	–	3
14133	3534	a / a	0
14134	3534	an / a	1
14135	3534	the / the	2
14136	3534	a / an	3
14137	3535	A	0
14138	3535	An	1
14139	3535	The	2
14140	3535	–	3
14141	3536	a / a	0
14142	3536	an / a	1
14143	3536	the / the	2
14144	3536	a / an	3
14145	3537	a	0
14146	3537	an	1
14147	3537	the	2
14148	3537	–	3
14149	3538	A	0
14150	3538	An	1
14151	3538	The	2
14152	3538	–	3
14153	3539	a / a	0
14154	3539	an / a	1
14155	3539	the / the	2
14156	3539	a / the	3
14157	3540	a	0
14158	3540	an	1
14159	3540	the	2
14160	3540	–	3
14161	3541	a	0
14162	3541	an	1
14163	3541	the	2
14164	3541	–	3
14165	3542	A	0
14166	3542	An	1
14167	3542	The	2
14168	3542	–	3
14169	3543	a	0
14170	3543	an	1
14171	3543	the	2
14172	3543	–	3
14173	3544	a	0
14174	3544	an	1
14175	3544	the	2
14176	3544	–	3
14177	3545	a	0
14178	3545	an	1
14179	3545	the	2
14180	3545	–	3
14181	3546	A	0
14182	3546	An	1
14183	3546	The	2
14184	3546	–	3
14185	3547	a	0
14186	3547	an	1
14187	3547	the	2
14188	3547	–	3
14189	3548	a	0
14190	3548	an	1
14191	3548	the	2
14192	3548	–	3
14193	3549	a	0
14194	3549	an	1
14195	3549	the	2
14196	3549	–	3
14197	3550	a	0
14198	3550	an	1
14199	3550	the	2
14200	3550	–	3
14201	3551	a	0
14202	3551	an	1
14203	3551	the	2
14204	3551	–	3
14205	3552	a	0
14206	3552	an	1
14207	3552	the	2
14208	3552	–	3
14209	3553	A	0
14210	3553	An	1
14211	3553	The	2
14212	3553	–	3
14213	3554	a / a	0
14214	3554	an / a	1
14215	3554	the / the	2
14216	3554	a / an	3
14217	3555	A	0
14218	3555	An	1
14219	3555	The	2
14220	3555	–	3
14221	3556	a / a	0
14222	3556	an / a	1
14223	3556	the / the	2
14224	3556	a / an	3
14225	3557	a	0
14226	3557	an	1
14227	3557	the	2
14228	3557	–	3
14229	3558	A	0
14230	3558	An	1
14231	3558	The	2
14232	3558	–	3
14233	3559	a / a	0
14234	3559	an / a	1
14235	3559	the / the	2
14236	3559	a / the	3
14237	3560	a	0
14238	3560	an	1
14239	3560	the	2
14240	3560	–	3
14241	3561	a	0
14242	3561	an	1
14243	3561	the	2
14244	3561	–	3
14245	3562	A	0
14246	3562	An	1
14247	3562	The	2
14248	3562	–	3
14249	3563	a	0
14250	3563	an	1
14251	3563	the	2
14252	3563	–	3
14253	3564	A	0
14254	3564	An	1
14255	3564	The	2
14256	3564	–	3
14257	3565	A	0
14258	3565	An	1
14259	3565	The	2
14260	3565	–	3
14261	3566	A	0
14262	3566	An	1
14263	3566	The	2
14264	3566	–	3
14265	3567	A	0
14266	3567	An	1
14267	3567	The	2
14268	3567	–	3
14269	3568	A	0
14270	3568	An	1
14271	3568	The	2
14272	3568	–	3
14273	3569	A	0
14274	3569	An	1
14275	3569	The	2
14276	3569	–	3
14277	3570	A	0
14278	3570	An	1
14279	3570	The	2
14280	3570	–	3
14281	3571	A	0
14282	3571	An	1
14283	3571	The	2
14284	3571	–	3
14285	3572	A	0
14286	3572	An	1
14287	3572	The	2
14288	3572	–	3
14289	3573	A	0
14290	3573	An	1
14291	3573	The	2
14292	3573	–	3
14293	3574	A	0
14294	3574	An	1
14295	3574	The	2
14296	3574	–	3
14297	3575	A	0
14298	3575	An	1
14299	3575	The	2
14300	3575	–	3
14301	3576	A	0
14302	3576	An	1
14303	3576	The	2
14304	3576	–	3
14305	3577	A	0
14306	3577	An	1
14307	3577	The	2
14308	3577	–	3
14309	3578	A	0
14310	3578	An	1
14311	3578	The	2
14312	3578	–	3
14313	3579	A	0
14314	3579	An	1
14315	3579	The	2
14316	3579	–	3
14317	3580	A	0
14318	3580	An	1
14319	3580	The	2
14320	3580	–	3
14321	3581	A	0
14322	3581	An	1
14323	3581	The	2
14324	3581	–	3
14325	3582	A	0
14326	3582	An	1
14327	3582	The	2
14328	3582	–	3
14329	3583	A	0
14330	3583	An	1
14331	3583	The	2
14332	3583	–	3
14333	3584	a	0
14334	3584	an	1
14335	3584	the	2
14336	3584	–	3
14337	3585	a	0
14338	3585	an	1
14339	3585	the	2
14340	3585	–	3
14341	3586	A	0
14342	3586	An	1
14343	3586	The	2
14344	3586	–	3
14345	3587	a	0
14346	3587	an	1
14347	3587	the	2
14348	3587	–	3
14349	3588	a	0
14350	3588	an	1
14351	3588	the	2
14352	3588	–	3
14353	3589	a	0
14354	3589	an	1
14355	3589	the	2
14356	3589	–	3
14357	3590	a	0
14358	3590	an	1
14359	3590	the	2
14360	3590	–	3
14361	3591	a	0
14362	3591	an	1
14363	3591	the	2
14364	3591	–	3
14365	3592	a	0
14366	3592	an	1
14367	3592	the	2
14368	3592	–	3
14369	3593	A	0
14370	3593	An	1
14371	3593	The	2
14372	3593	–	3
14373	3594	a / a	0
14374	3594	an / a	1
14375	3594	the / the	2
14376	3594	a / an	3
14377	3595	A	0
14378	3595	An	1
14379	3595	The	2
14380	3595	–	3
14381	3596	a / a	0
14382	3596	an / a	1
14383	3596	the / the	2
14384	3596	a / an	3
14385	3597	a	0
14386	3597	an	1
14387	3597	the	2
14388	3597	–	3
14389	3598	A	0
14390	3598	An	1
14391	3598	The	2
14392	3598	–	3
14393	3599	a / a	0
14394	3599	an / a	1
14395	3599	the / the	2
14396	3599	a / the	3
14397	3600	a	0
14398	3600	an	1
14399	3600	the	2
14400	3600	–	3
14401	3601	a	0
14402	3601	an	1
14403	3601	the	2
14404	3601	–	3
14405	3602	A	0
14406	3602	An	1
14407	3602	The	2
14408	3602	–	3
14409	3603	a	0
14410	3603	an	1
14411	3603	the	2
14412	3603	–	3
14413	3604	a	0
14414	3604	an	1
14415	3604	the	2
14416	3604	–	3
14417	3605	a	0
14418	3605	an	1
14419	3605	the	2
14420	3605	–	3
14421	3606	A	0
14422	3606	An	1
14423	3606	The	2
14424	3606	–	3
14425	3607	a	0
14426	3607	an	1
14427	3607	the	2
14428	3607	–	3
14429	3608	a	0
14430	3608	an	1
14431	3608	the	2
14432	3608	–	3
14433	3609	a	0
14434	3609	an	1
14435	3609	the	2
14436	3609	–	3
14437	3610	a	0
14438	3610	an	1
14439	3610	the	2
14440	3610	–	3
14441	3611	a	0
14442	3611	an	1
14443	3611	the	2
14444	3611	–	3
14445	3612	a	0
14446	3612	an	1
14447	3612	the	2
14448	3612	–	3
14449	3613	A	0
14450	3613	An	1
14451	3613	The	2
14452	3613	–	3
14453	3614	a / a	0
14454	3614	an / a	1
14455	3614	the / the	2
14456	3614	a / an	3
14457	3615	A	0
14458	3615	An	1
14459	3615	The	2
14460	3615	–	3
14461	3616	a / a	0
14462	3616	an / a	1
14463	3616	the / the	2
14464	3616	a / an	3
14465	3617	a	0
14466	3617	an	1
14467	3617	the	2
14468	3617	–	3
14469	3618	A	0
14470	3618	An	1
14471	3618	The	2
14472	3618	–	3
14473	3619	a / a	0
14474	3619	an / a	1
14475	3619	the / the	2
14476	3619	a / the	3
14477	3620	a	0
14478	3620	an	1
14479	3620	the	2
14480	3620	–	3
14481	3621	a	0
14482	3621	an	1
14483	3621	the	2
14484	3621	–	3
14485	3622	A	0
14486	3622	An	1
14487	3622	The	2
14488	3622	–	3
14489	3623	a	0
14490	3623	an	1
14491	3623	the	2
14492	3623	–	3
14493	3624	I	0
14494	3624	me	1
14495	3624	my	2
14496	3624	mine	3
14497	3625	Me	0
14498	3625	My	1
14499	3625	I	2
14500	3625	Mine	3
14501	3626	we	0
14502	3626	us	1
14503	3626	our	2
14504	3626	ours	3
14505	3627	Him	0
14506	3627	He	1
14507	3627	His	2
14508	3627	Himself	3
14509	3628	I	0
14510	3628	me	1
14511	3628	my	2
14512	3628	mine	3
14513	3629	they	0
14514	3629	them	1
14515	3629	their	2
14516	3629	theirs	3
14517	3630	Her	0
14518	3630	She	1
14519	3630	Hers	2
14520	3630	Herself	3
14521	3631	he	0
14522	3631	him	1
14523	3631	his	2
14524	3631	himself	3
14525	3632	Me	0
14526	3632	My	1
14527	3632	Mine	2
14528	3632	I	3
14529	3633	we	0
14530	3633	us	1
14531	3633	our	2
14532	3633	ours	3
14533	3634	mine	0
14534	3634	my	1
14535	3634	me	2
14536	3634	I	3
14537	3635	my	0
14538	3635	me	1
14539	3635	mine	2
14540	3635	I	3
14541	3636	Hers	0
14542	3636	Her	1
14543	3636	She	2
14544	3636	Herself	3
14545	3637	her	0
14546	3637	she	1
14547	3637	hers	2
14548	3637	herself	3
14549	3638	Our	0
14550	3638	Ours	1
14551	3638	We	2
14552	3638	Us	3
14553	3639	our	0
14554	3639	us	1
14555	3639	ours	2
14556	3639	we	3
14557	3640	your	0
14558	3640	yours	1
14559	3640	you	2
14560	3640	yourself	3
14561	3641	your	0
14562	3641	you	1
14563	3641	yours	2
14564	3641	yourself	3
14565	3642	Their	0
14566	3642	Theirs	1
14567	3642	Them	2
14568	3642	They	3
14569	3643	their	0
14570	3643	them	1
14571	3643	theirs	2
14572	3643	they	3
14573	3644	I	0
14574	3644	me	1
14575	3644	my	2
14576	3644	mine	3
14577	3645	Me	0
14578	3645	My	1
14579	3645	Mine	2
14580	3645	I	3
14581	3646	we	0
14582	3646	us	1
14583	3646	our	2
14584	3646	ours	3
14585	3647	Him	0
14586	3647	He	1
14587	3647	His	2
14588	3647	Himself	3
14589	3648	I	0
14590	3648	me	1
14591	3648	my	2
14592	3648	mine	3
14593	3649	we	0
14594	3649	us	1
14595	3649	our	2
14596	3649	ours	3
14597	3650	Her	0
14598	3650	She	1
14599	3650	Hers	2
14600	3650	Herself	3
14601	3651	he	0
14602	3651	him	1
14603	3651	his	2
14604	3651	himself	3
14605	3652	Them	0
14606	3652	Their	1
14607	3652	They	2
14608	3652	Theirs	3
14609	3653	we	0
14610	3653	us	1
14611	3653	our	2
14612	3653	ours	3
14613	3654	your	0
14614	3654	yours	1
14615	3654	you	2
14616	3654	yourself	3
14617	3655	your	0
14618	3655	you	1
14619	3655	yours	2
14620	3655	yourself	3
14621	3656	His	0
14622	3656	Him	1
14623	3656	He	2
14624	3656	Himself	3
14625	3657	her	0
14626	3657	she	1
14627	3657	hers	2
14628	3657	herself	3
14629	3658	Our	0
14630	3658	Ours	1
14631	3658	We	2
14632	3658	Us	3
14633	3659	our	0
14634	3659	us	1
14635	3659	ours	2
14636	3659	we	3
14637	3660	your	0
14638	3660	yours	1
14639	3660	you	2
14640	3660	yourself	3
14641	3661	your	0
14642	3661	you	1
14643	3661	yours	2
14644	3661	yourself	3
14645	3662	Their	0
14646	3662	Theirs	1
14647	3662	Them	2
14648	3662	They	3
14649	3663	their	0
14650	3663	them	1
14651	3663	theirs	2
14652	3663	they	3
14653	3664	These	0
14654	3664	Those	1
14655	3664	This	2
14656	3664	Them	3
14657	3665	This	0
14658	3665	That	1
14659	3665	These	2
14660	3665	It	3
14661	3666	she	0
14662	3666	her	1
14663	3666	hers	2
14664	3666	herself	3
14665	3667	Him	0
14666	3667	He	1
14667	3667	His	2
14668	3667	Himself	3
14669	3668	I	0
14670	3668	me	1
14671	3668	my	2
14672	3668	mine	3
14673	3669	Their	0
14674	3669	Theirs	1
14675	3669	Them	2
14676	3669	They	3
14677	3670	their	0
14678	3670	them	1
14679	3670	theirs	2
14680	3670	they	3
14681	3671	Him	0
14682	3671	He	1
14683	3671	His	2
14684	3671	Himself	3
14685	3672	I	0
14686	3672	me	1
14687	3672	my	2
14688	3672	mine	3
14689	3673	Them	0
14690	3673	Their	1
14691	3673	They	2
14692	3673	Theirs	3
14693	3674	my	0
14694	3674	me	1
14695	3674	mine	2
14696	3674	I	3
14697	3675	Mine	0
14698	3675	My	1
14699	3675	Me	2
14700	3675	I	3
14701	3676	her	0
14702	3676	she	1
14703	3676	hers	2
14704	3676	herself	3
14705	3677	His	0
14706	3677	Him	1
14707	3677	He	2
14708	3677	Himself	3
14709	3678	Us	0
14710	3678	We	1
14711	3678	Our	2
14712	3678	Ours	3
14713	3679	we	0
14714	3679	us	1
14715	3679	our	2
14716	3679	ours	3
14717	3680	This	0
14718	3680	That	1
14719	3680	These	2
14720	3680	It	3
14721	3681	These	0
14722	3681	Those	1
14723	3681	This	2
14724	3681	Them	3
14725	3682	they	0
14726	3682	them	1
14727	3682	their	2
14728	3682	theirs	3
14729	3683	Our	0
14730	3683	Ours	1
14731	3683	We	2
14732	3683	Us	3
14733	3684	He	0
14734	3684	She	1
14735	3684	It	2
14736	3684	They	3
14737	3685	she	0
14738	3685	her	1
14739	3685	hers	2
14740	3685	herself	3
14741	3686	Him	0
14742	3686	He	1
14743	3686	His	2
14744	3686	Himself	3
14745	3687	we	0
14746	3687	us	1
14747	3687	our	2
14748	3687	ours	3
14749	3688	Your	0
14750	3688	Yours	1
14751	3688	You	2
14752	3688	Yourself	3
14753	3689	your	0
14754	3689	you	1
14755	3689	yours	2
14756	3689	yourself	3
14757	3690	This	0
14758	3690	That	1
14759	3690	These	2
14760	3690	It	3
14761	3691	This	0
14762	3691	That	1
14763	3691	These	2
14764	3691	Those	3
14765	3692	I	0
14766	3692	me	1
14767	3692	my	2
14768	3692	mine	3
14769	3693	Us	0
14770	3693	We	1
14771	3693	Our	2
14772	3693	Ours	3
14773	3694	my	0
14774	3694	me	1
14775	3694	mine	2
14776	3694	I	3
14777	3695	Mine	0
14778	3695	My	1
14779	3695	Me	2
14780	3695	I	3
14781	3696	Her	0
14782	3696	Hers	1
14783	3696	She	2
14784	3696	Herself	3
14785	3697	his	0
14786	3697	him	1
14787	3697	his	2
14788	3697	himself	3
14789	3698	Him	0
14790	3698	He	1
14791	3698	His	2
14792	3698	Himself	3
14793	3699	they	0
14794	3699	them	1
14795	3699	their	2
14796	3699	theirs	3
14797	3700	This	0
14798	3700	That	1
14799	3700	These	2
14800	3700	It	3
14801	3701	This	0
14802	3701	These	1
14803	3701	Those	2
14804	3701	Them	3
14805	3702	Their	0
14806	3702	Theirs	1
14807	3702	Them	2
14808	3702	They	3
14809	3703	their	0
14810	3703	them	1
14811	3703	theirs	2
14812	3703	they	3
14813	3704	This	0
14814	3704	These	1
14815	3704	Those	2
14816	3704	Them	3
14817	3705	I	0
14818	3705	me	1
14819	3705	my	2
14820	3705	mine	3
14821	3706	Him	0
14822	3706	He	1
14823	3706	His	2
14824	3706	Himself	3
14825	3707	we	0
14826	3707	us	1
14827	3707	our	2
14828	3707	ours	3
14829	3708	Her	0
14830	3708	Hers	1
14831	3708	She	2
14832	3708	Herself	3
14833	3709	her	0
14834	3709	she	1
14835	3709	hers	2
14836	3709	herself	3
14837	3710	This	0
14838	3710	That	1
14839	3710	These	2
14840	3710	It	3
14841	3711	Which	0
14842	3711	What	1
14843	3711	Who	2
14844	3711	Whose	3
14845	3712	my	0
14846	3712	me	1
14847	3712	mine	2
14848	3712	I	3
14849	3713	Mine	0
14850	3713	My	1
14851	3713	Me	2
14852	3713	I	3
14853	3714	Him	0
14854	3714	He	1
14855	3714	His	2
14856	3714	Himself	3
14857	3715	she	0
14858	3715	her	1
14859	3715	hers	2
14860	3715	herself	3
14861	3716	Us	0
14862	3716	We	1
14863	3716	Our	2
14864	3716	Ours	3
14865	3717	their	0
14866	3717	them	1
14867	3717	theirs	2
14868	3717	they	3
14869	3718	Their	0
14870	3718	Theirs	1
14871	3718	Them	2
14872	3718	They	3
14873	3719	These	0
14874	3719	Those	1
14875	3719	This	2
14876	3719	Them	3
14877	3720	I	0
14878	3720	me	1
14879	3720	my	2
14880	3720	mine	3
14881	3721	This	0
14882	3721	That	1
14883	3721	These	2
14884	3721	It	3
14885	3722	These	0
14886	3722	Those	1
14887	3722	This	2
14888	3722	Them	3
14889	3723	our	0
14890	3723	us	1
14891	3723	ours	2
14892	3723	we	3
14893	3724	This	0
14894	3724	These	1
14895	3724	Those	2
14896	3724	Them	3
14897	3725	I	0
14898	3725	me	1
14899	3725	my	2
14900	3725	mine	3
14901	3726	Them	0
14902	3726	Their	1
14903	3726	They	2
14904	3726	Theirs	3
14905	3727	His	0
14906	3727	Him	1
14907	3727	He	2
14908	3727	Himself	3
14909	3728	his	0
14910	3728	him	1
14911	3728	he	2
14912	3728	himself	3
14913	3729	This	0
14914	3729	That	1
14915	3729	These	2
14916	3729	It	3
14917	3730	These	0
14918	3730	Those	1
14919	3730	This	2
14920	3730	Them	3
14921	3731	we	0
14922	3731	us	1
14923	3731	our	2
14924	3731	ours	3
14925	3732	Your	0
14926	3732	Yours	1
14927	3732	You	2
14928	3732	Yourself	3
14929	3733	your	0
14930	3733	you	1
14931	3733	yours	2
14932	3733	yourself	3
14933	3734	Them	0
14934	3734	Their	1
14935	3734	They	2
14936	3734	Theirs	3
14937	3735	she	0
14938	3735	her	1
14939	3735	hers	2
14940	3735	herself	3
14941	3736	Our	0
14942	3736	Ours	1
14943	3736	We	2
14944	3736	Us	3
14945	3737	our	0
14946	3737	us	1
14947	3737	ours	2
14948	3737	we	3
14949	3738	This	0
14950	3738	These	1
14951	3738	Those	2
14952	3738	Them	3
14953	3739	This	0
14954	3739	That	1
14955	3739	These	2
14956	3739	It	3
14957	3740	I	0
14958	3740	me	1
14959	3740	my	2
14960	3740	mine	3
14961	3741	These	0
14962	3741	Those	1
14963	3741	This	2
14964	3741	Them	3
14965	3742	Her	0
14966	3742	Hers	1
14967	3742	She	2
14968	3742	Herself	3
14969	3743	her	0
14970	3743	she	1
14971	3743	hers	2
14972	3743	herself	3
14973	3744	These	0
14974	3744	Those	1
14975	3744	This	2
14976	3744	Them	3
14977	3745	I	0
14978	3745	me	1
14979	3745	my	2
14980	3745	mine	3
14981	3746	Him	0
14982	3746	He	1
14983	3746	His	2
14984	3746	Himself	3
14985	3747	they	0
14986	3747	them	1
14987	3747	their	2
14988	3747	theirs	3
14989	3748	Our	0
14990	3748	Ours	1
14991	3748	We	2
14992	3748	Us	3
14993	3749	our	0
14994	3749	us	1
14995	3749	ours	2
14996	3749	we	3
14997	3750	This	0
14998	3750	That	1
14999	3750	These	2
15000	3750	It	3
15001	3751	This	0
15002	3751	These	1
15003	3751	Those	2
15004	3751	Them	3
15005	3752	she	0
15006	3752	her	1
15007	3752	hers	2
15008	3752	herself	3
15009	3753	These	0
15010	3753	Those	1
15011	3753	This	2
15012	3753	Them	3
15013	3754	My	0
15014	3754	Mine	1
15015	3754	Me	2
15016	3754	I	3
15017	3755	my	0
15018	3755	me	1
15019	3755	mine	2
15020	3755	I	3
15021	3756	Us	0
15022	3756	We	1
15023	3756	Our	2
15024	3756	Ours	3
15025	3757	we	0
15026	3757	us	1
15027	3757	our	2
15028	3757	ours	3
15029	3758	Her	0
15030	3758	Hers	1
15031	3758	She	2
15032	3758	Herself	3
15033	3759	her	0
15034	3759	she	1
15035	3759	hers	2
15036	3759	herself	3
15037	3760	These	0
15038	3760	Those	1
15039	3760	This	2
15040	3760	Them	3
15041	3761	This	0
15042	3761	That	1
15043	3761	These	2
15044	3761	It	3
15045	3762	Their	0
15046	3762	Theirs	1
15047	3762	Them	2
15048	3762	They	3
15049	3763	their	0
15050	3763	them	1
15051	3763	theirs	2
15052	3763	they	3
15053	3764	This	0
15054	3764	These	1
15055	3764	Those	2
15056	3764	Them	3
15057	3765	I	0
15058	3765	me	1
15059	3765	my	2
15060	3765	mine	3
15061	3766	It	0
15062	3766	He	1
15063	3766	She	2
15064	3766	They	3
15065	3767	Us	0
15066	3767	We	1
15067	3767	Our	2
15068	3767	Ours	3
15069	3768	he	0
15070	3768	him	1
15071	3768	his	2
15072	3768	himself	3
15073	3769	Your	0
15074	3769	Yours	1
15075	3769	You	2
15076	3769	Yourself	3
15077	3770	your	0
15078	3770	you	1
15079	3770	yours	2
15080	3770	yourself	3
15081	3771	This	0
15082	3771	That	1
15083	3771	These	2
15084	3771	It	3
15085	3772	These	0
15086	3772	Those	1
15087	3772	This	2
15088	3772	Them	3
15089	3773	we	0
15090	3773	us	1
15091	3773	our	2
15092	3773	ours	3
15093	3774	His	0
15094	3774	Him	1
15095	3774	He	2
15096	3774	Himself	3
15097	3775	his	0
15098	3775	him	1
15099	3775	he	2
15100	3775	himself	3
15101	3776	She	0
15102	3776	Her	1
15103	3776	Hers	2
15104	3776	Herself	3
15105	3777	they	0
15106	3777	them	1
15107	3777	their	2
15108	3777	theirs	3
15109	3778	This	0
15110	3778	That	1
15111	3778	These	2
15112	3778	It	3
15113	3779	These	0
15114	3779	Those	1
15115	3779	This	2
15116	3779	Them	3
15117	3780	Our	0
15118	3780	Ours	1
15119	3780	We	2
15120	3780	Us	3
15121	3781	our	0
15122	3781	us	1
15123	3781	ours	2
15124	3781	we	3
15125	3782	I	0
15126	3782	me	1
15127	3782	my	2
15128	3782	mine	3
15129	3783	Him	0
15130	3783	He	1
15131	3783	His	2
15132	3783	Himself	3
15133	3784	This	0
15134	3784	These	1
15135	3784	Those	2
15136	3784	Them	3
15137	3785	she	0
15138	3785	her	1
15139	3785	hers	2
15140	3785	herself	3
15141	3786	This	0
15142	3786	That	1
15143	3786	These	2
15144	3786	It	3
15145	3787	Him	0
15146	3787	He	1
15147	3787	His	2
15148	3787	Himself	3
15149	3788	we	0
15150	3788	us	1
15151	3788	our	2
15152	3788	ours	3
15153	3789	Their	0
15154	3789	Theirs	1
15155	3789	Them	2
15156	3789	They	3
15157	3790	their	0
15158	3790	them	1
15159	3790	theirs	2
15160	3790	they	3
15161	3791	This	0
15162	3791	These	1
15163	3791	Those	2
15164	3791	Them	3
15165	3792	I	0
15166	3792	me	1
15167	3792	my	2
15168	3792	mine	3
15169	3793	Us	0
15170	3793	We	1
15171	3793	Our	2
15172	3793	Ours	3
15173	3794	His	0
15174	3794	Him	1
15175	3794	He	2
15176	3794	Himself	3
15177	3795	her	0
15178	3795	she	1
15179	3795	hers	2
15180	3795	herself	3
15181	3796	This	0
15182	3796	That	1
15183	3796	These	2
15184	3796	It	3
15185	3797	These	0
15186	3797	Those	1
15187	3797	This	2
15188	3797	Them	3
15189	3798	I	0
15190	3798	me	1
15191	3798	my	2
15192	3798	mine	3
15193	3799	My	0
15194	3799	Mine	1
15195	3799	Me	2
15196	3799	I	3
15197	3800	my	0
15198	3800	me	1
15199	3800	mine	2
15200	3800	I	3
15201	3801	These	0
15202	3801	Those	1
15203	3801	This	2
15204	3801	Them	3
15205	3802	Our	0
15206	3802	Ours	1
15207	3802	We	2
15208	3802	Us	3
15209	3803	our	0
15210	3803	us	1
15211	3803	ours	2
15212	3803	we	3
15213	3804	This	0
15214	3804	These	1
15215	3804	Those	2
15216	3804	Them	3
15217	3805	I	0
15218	3805	me	1
15219	3805	my	2
15220	3805	mine	3
15221	3806	Him	0
15222	3806	He	1
15223	3806	His	2
15224	3806	Himself	3
15225	3807	they	0
15226	3807	them	1
15227	3807	their	2
15228	3807	theirs	3
15229	3808	Our	0
15230	3808	Ours	1
15231	3808	We	2
15232	3808	Us	3
15233	3809	our	0
15234	3809	us	1
15235	3809	ours	2
15236	3809	we	3
15237	3810	This	0
15238	3810	That	1
15239	3810	These	2
15240	3810	It	3
15241	3811	This	0
15242	3811	These	1
15243	3811	Those	2
15244	3811	Them	3
15245	3812	I	0
15246	3812	me	1
15247	3812	my	2
15248	3812	mine	3
15249	3813	These	0
15250	3813	Those	1
15251	3813	This	2
15252	3813	Them	3
15253	3814	His	0
15254	3814	Him	1
15255	3814	He	2
15256	3814	Himself	3
15257	3815	his	0
15258	3815	him	1
15259	3815	he	2
15260	3815	himself	3
15261	3816	Us	0
15262	3816	We	1
15263	3816	Our	2
15264	3816	Ours	3
15265	3817	we	0
15266	3817	us	1
15267	3817	our	2
15268	3817	ours	3
15269	3818	Her	0
15270	3818	Hers	1
15271	3818	She	2
15272	3818	Herself	3
15273	3819	her	0
15274	3819	she	1
15275	3819	hers	2
15276	3819	herself	3
15277	3820	These	0
15278	3820	Those	1
15279	3820	This	2
15280	3820	Them	3
15281	3821	This	0
15282	3821	That	1
15283	3821	These	2
15284	3821	It	3
15285	3822	Their	0
15286	3822	Theirs	1
15287	3822	Them	2
15288	3822	They	3
15289	3823	their	0
15290	3823	them	1
15291	3823	theirs	2
15292	3823	they	3
21286	5322	there are	1
21287	5322	it is	2
21288	5322	they are	3
21289	5323	there is	0
21290	5323	there isn't	1
21291	5323	it isn't	2
21292	5323	they aren't	3
21293	5324	there is	0
21294	5324	there isn't	1
21295	5324	it isn't	2
21296	5324	there aren't	3
21297	5325	there is	0
21298	5325	there are	1
21299	5325	it is	2
21300	5325	they are	3
21301	5326	there is	0
21302	5326	there are	1
21303	5326	it is	2
21304	5326	they are	3
21305	5327	there is	0
21306	5327	there isn't	1
21307	5327	it isn't	2
21308	5327	they aren't	3
21309	5328	there is	0
21310	5328	there isn't	1
21311	5328	it isn't	2
21312	5328	there aren't	3
21313	5329	there is	0
21314	5329	there are	1
21315	5329	it is	2
21316	5329	they are	3
21317	5330	there is	0
21318	5330	there are	1
21319	5330	it is	2
21320	5330	they are	3
21321	5331	there is	0
21322	5331	there isn't	1
21323	5331	it isn't	2
21324	5331	they aren't	3
21325	5332	there is	0
21326	5332	there isn't	1
21327	5332	it isn't	2
21328	5332	there aren't	3
21329	5333	there is	0
21330	5333	there are	1
21331	5333	it is	2
21332	5333	they are	3
21333	5334	there is	0
21334	5334	there are	1
21335	5334	it is	2
21336	5334	they are	3
21337	5335	there is	0
21338	5335	there isn't	1
21339	5335	it isn't	2
21340	5335	they aren't	3
21341	5336	there is	0
21342	5336	there isn't	1
21343	5336	it isn't	2
21344	5336	there aren't	3
21345	5337	in	0
21346	5337	on	1
21347	5337	under	2
21348	5337	at	3
21349	5338	in	0
21350	5338	on	1
21351	5338	under	2
21352	5338	at	3
21353	5339	in	0
21354	5339	on	1
21355	5339	under	2
21356	5339	at	3
21357	5340	in	0
21358	5340	on	1
21359	5340	under	2
21360	5340	at	3
21361	5341	in	0
21362	5341	on	1
21363	5341	under	2
21364	5341	at	3
21365	5342	in	0
21366	5342	on	1
21367	5342	under	2
21368	5342	at	3
21369	5343	in	0
21370	5343	on	1
21371	5343	under	2
21372	5343	at	3
21373	5344	in	0
21374	5344	on	1
21375	5344	under	2
21376	5344	at	3
21377	5345	in	0
21378	5345	on	1
21379	5345	under	2
21380	5345	at	3
21381	5346	in	0
21382	5346	on	1
21383	5346	under	2
21384	5346	at	3
21385	5347	in	0
21386	5347	on	1
21387	5347	under	2
21388	5347	at	3
21389	5348	in	0
21390	5348	on	1
21391	5348	under	2
21392	5348	at	3
21393	5349	in	0
21394	5349	on	1
21395	5349	under	2
21396	5349	at	3
21397	5350	in	0
21398	5350	on	1
21399	5350	under	2
21400	5350	at	3
21401	5351	in	0
21402	5351	on	1
21403	5351	under	2
21404	5351	at	3
21405	5352	in	0
21406	5352	on	1
21407	5352	under	2
21408	5352	at	3
21409	5353	in	0
21410	5353	on	1
21411	5353	under	2
21412	5353	at	3
21413	5354	in	0
21414	5354	on	1
21415	5354	under	2
21416	5354	at	3
21417	5355	in	0
21418	5355	on	1
21419	5355	under	2
21420	5355	at	3
21565	5392	in	0
21566	5392	on	1
21567	5392	under	2
21568	5392	at	3
21569	5393	in	0
21570	5393	on	1
21571	5393	under	2
21572	5393	at	3
21573	5394	in	0
21574	5394	on	1
21575	5394	under	2
21576	5394	at	3
21577	5395	in	0
21578	5395	on	1
21579	5395	under	2
21580	5395	at	3
21581	5396	in	0
21582	5396	on	1
21583	5396	under	2
21584	5396	at	3
21585	5397	in	0
21586	5397	on	1
21587	5397	next to	2
21588	5397	between	3
21589	5398	in	0
21590	5398	on	1
21591	5398	next to	2
21592	5398	between	3
21593	5399	in	0
21594	5399	on	1
21595	5399	next to	2
21596	5399	between	3
21597	5400	in	0
21598	5400	on	1
21599	5400	next to	2
21600	5400	between	3
21601	5401	in	0
21602	5401	on	1
21603	5401	next to	2
21604	5401	between	3
21605	5402	in	0
21606	5402	on	1
21607	5402	next to	2
21608	5402	between	3
21609	5403	in	0
21610	5403	on	1
21611	5403	next to	2
21612	5403	between	3
21613	5404	in	0
21614	5404	on	1
21615	5404	next to	2
21616	5404	between	3
21617	5405	in	0
21618	5405	on	1
21619	5405	next to	2
21620	5405	between	3
21621	5406	in	0
21622	5406	on	1
21623	5406	next to	2
21624	5406	between	3
21625	5407	in	0
21626	5407	on	1
21627	5407	next to	2
21628	5407	between	3
21629	5408	in	0
21630	5408	on	1
21631	5408	next to	2
21632	5408	between	3
21633	5409	in	0
21634	5409	on	1
21635	5409	next to	2
21636	5409	between	3
21637	5410	in	0
21638	5410	on	1
21639	5410	next to	2
21640	5410	between	3
21641	5411	in	0
21642	5411	on	1
21643	5411	next to	2
21644	5411	between	3
21645	5412	in	0
21646	5412	on	1
21647	5412	next to	2
21648	5412	between	3
21649	5413	in	0
21650	5413	on	1
21651	5413	next to	2
21652	5413	between	3
21653	5414	in	0
21654	5414	on	1
21655	5414	next to	2
21656	5414	between	3
21657	5415	in	0
21658	5415	on	1
21659	5415	next to	2
21660	5415	between	3
21661	5416	in	0
21662	5416	on	1
21663	5416	next to	2
21664	5416	between	3
21665	5417	in	0
21666	5417	on	1
21667	5417	next to	2
21668	5417	between	3
21669	5418	in	0
21670	5418	on	1
21671	5418	next to	2
21672	5418	between	3
21673	5419	in	0
21674	5419	on	1
21675	5419	next to	2
21676	5419	between	3
21677	5420	in	0
21678	5420	on	1
21679	5420	next to	2
21680	5420	between	3
21681	5421	in	0
21682	5421	on	1
21683	5421	next to	2
21684	5421	between	3
21685	5422	in	0
21686	5422	on	1
21687	5422	next to	2
21688	5422	between	3
21689	5423	in	0
21690	5423	on	1
21691	5423	next to	2
21692	5423	between	3
21693	5424	in	0
21694	5424	on	1
21695	5424	next to	2
21696	5424	between	3
21697	5425	in	0
21698	5425	on	1
21699	5425	next to	2
21700	5425	between	3
21701	5426	in	0
21702	5426	on	1
21703	5426	next to	2
21704	5426	between	3
21705	5427	in	0
21706	5427	on	1
21707	5427	next to	2
21708	5427	between	3
21709	5428	in	0
21710	5428	on	1
21711	5428	next to	2
21712	5428	between	3
21713	5429	in	0
21714	5429	on	1
21715	5429	next to	2
21716	5429	between	3
21717	5430	in	0
21718	5430	on	1
21719	5430	next to	2
21720	5430	between	3
21721	5431	in	0
21722	5431	on	1
21723	5431	next to	2
21724	5431	between	3
21725	5432	in	0
21726	5432	on	1
21727	5432	next to	2
21728	5432	between	3
21729	5433	in	0
21730	5433	on	1
21731	5433	next to	2
21732	5433	between	3
21733	5434	in	0
21734	5434	on	1
21735	5434	next to	2
21736	5434	between	3
21737	5435	in	0
21738	5435	on	1
21739	5435	next to	2
21740	5435	between	3
21741	5436	in	0
21742	5436	on	1
21743	5436	next to	2
21744	5436	between	3
21745	5437	in	0
21746	5437	on	1
21747	5437	under	2
21748	5437	at	3
21749	5438	in	0
21750	5438	on	1
21751	5438	under	2
21752	5438	at	3
21753	5439	in	0
21754	5439	on	1
21755	5439	under	2
21756	5439	at	3
21757	5440	in	0
21758	5440	on	1
21759	5440	under	2
21760	5440	at	3
21761	5441	in	0
21762	5441	on	1
21763	5441	under	2
21764	5441	at	3
21765	5442	in	0
21766	5442	on	1
21767	5442	under	2
21768	5442	at	3
21769	5443	in	0
21770	5443	on	1
21771	5443	under	2
21772	5443	at	3
21773	5444	in	0
21774	5444	on	1
21775	5444	under	2
21776	5444	at	3
21777	5445	in	0
21778	5445	on	1
21779	5445	under	2
21780	5445	at	3
21781	5446	in	0
21782	5446	on	1
21783	5446	under	2
21784	5446	at	3
21785	5447	in	0
21786	5447	on	1
21787	5447	under	2
21788	5447	at	3
21789	5448	in	0
21790	5448	on	1
21791	5448	under	2
21792	5448	at	3
21793	5449	in	0
21794	5449	on	1
21795	5449	under	2
21796	5449	at	3
21797	5450	in	0
21798	5450	on	1
21799	5450	under	2
21800	5450	at	3
21801	5451	in	0
21802	5451	on	1
21803	5451	under	2
21804	5451	at	3
21805	5452	in	0
21806	5452	on	1
21807	5452	under	2
21808	5452	at	3
21809	5453	in	0
21810	5453	on	1
21811	5453	under	2
21812	5453	at	3
21813	5454	in	0
21814	5454	on	1
21815	5454	under	2
21816	5454	at	3
21817	5455	in	0
21818	5455	on	1
21819	5455	under	2
21820	5455	at	3
21821	5456	in	0
21822	5456	on	1
21823	5456	under	2
21824	5456	at	3
21825	5457	in	0
21826	5457	on	1
21827	5457	under	2
21828	5457	next to	3
21829	5458	in	0
21830	5458	on	1
21831	5458	under	2
21832	5458	next to	3
21833	5459	in	0
21834	5459	on	1
21835	5459	under	2
21836	5459	next to	3
21837	5460	in	0
21838	5460	on	1
21839	5460	under	2
21840	5460	next to	3
21841	5461	in	0
21842	5461	on	1
21843	5461	under	2
21844	5461	next to	3
21845	5462	in	0
21846	5462	on	1
21847	5462	under	2
21848	5462	next to	3
21849	5463	in	0
21850	5463	on	1
21851	5463	under	2
21852	5463	next to	3
21853	5464	in	0
21854	5464	on	1
21855	5464	under	2
21856	5464	next to	3
21857	5465	in	0
21858	5465	on	1
21859	5465	under	2
21860	5465	next to	3
21861	5466	in	0
21862	5466	on	1
21863	5466	under	2
21864	5466	next to	3
21865	5467	in	0
21866	5467	on	1
21867	5467	under	2
21868	5467	next to	3
21869	5468	in	0
21870	5468	on	1
21871	5468	under	2
21872	5468	next to	3
21873	5469	in	0
21874	5469	on	1
21875	5469	under	2
21876	5469	next to	3
21877	5470	in	0
21878	5470	on	1
21879	5470	under	2
21880	5470	next to	3
21881	5471	in	0
21882	5471	on	1
21883	5471	under	2
21884	5471	next to	3
21885	5472	in	0
21886	5472	on	1
21887	5472	under	2
21888	5472	next to	3
21889	5473	in	0
21890	5473	on	1
21891	5473	under	2
21892	5473	next to	3
21893	5474	in	0
21894	5474	on	1
21895	5474	under	2
21896	5474	next to	3
21897	5475	in	0
21898	5475	on	1
21899	5475	under	2
21900	5475	next to	3
21901	5476	in	0
21902	5476	on	1
21903	5476	under	2
21904	5476	next to	3
21905	5477	in	0
21906	5477	on	1
21907	5477	next to	2
21908	5477	between	3
21909	5478	in	0
21910	5478	on	1
21911	5478	next to	2
21912	5478	between	3
21913	5479	in	0
21914	5479	on	1
21915	5479	next to	2
21916	5479	between	3
21917	5480	in	0
21918	5480	on	1
21919	5480	next to	2
21920	5480	between	3
21921	5481	in	0
21922	5481	on	1
21923	5481	next to	2
21924	5481	between	3
21925	5482	in	0
21926	5482	on	1
21927	5482	next to	2
21928	5482	between	3
21929	5483	in	0
21930	5483	on	1
21931	5483	next to	2
21932	5483	between	3
21933	5484	in	0
21934	5484	on	1
21935	5484	next to	2
21936	5484	between	3
21937	5485	in	0
21938	5485	on	1
21939	5485	next to	2
21940	5485	between	3
21941	5486	in	0
21942	5486	on	1
21943	5486	next to	2
21944	5486	between	3
21945	5487	in	0
21946	5487	on	1
21947	5487	next to	2
21948	5487	between	3
21949	5488	in	0
21950	5488	on	1
21951	5488	next to	2
21952	5488	between	3
21953	5489	in	0
21954	5489	on	1
21955	5489	next to	2
21956	5489	between	3
21957	5490	in	0
21958	5490	on	1
21959	5490	next to	2
21960	5490	between	3
21961	5491	in	0
21962	5491	on	1
21963	5491	next to	2
21964	5491	between	3
21965	5492	in	0
21966	5492	on	1
21967	5492	next to	2
21968	5492	between	3
21969	5493	in	0
21970	5493	on	1
21971	5493	next to	2
21972	5493	between	3
21973	5494	in	0
21974	5494	on	1
21975	5494	next to	2
21976	5494	between	3
21977	5495	in	0
21978	5495	on	1
21979	5495	next to	2
21980	5495	between	3
21981	5496	in	0
21982	5496	on	1
21983	5496	next to	2
21984	5496	between	3
21985	5497	in	0
21986	5497	on	1
21987	5497	under	2
21988	5497	next to	3
21989	5498	in	0
21990	5498	on	1
21991	5498	under	2
21992	5498	next to	3
21993	5499	in	0
21994	5499	on	1
21995	5499	under	2
21996	5499	next to	3
21997	5500	in	0
21998	5500	on	1
21999	5500	under	2
22000	5500	between	3
22001	5501	in	0
22002	5501	on	1
22003	5501	under	2
22004	5501	next to	3
22005	5502	in	0
22006	5502	on	1
22007	5502	under	2
22008	5502	next to	3
22009	5503	in	0
22010	5503	on	1
22011	5503	under	2
22012	5503	next to	3
22013	5504	in	0
22014	5504	on	1
22015	5504	between	2
22016	5504	next to	3
22017	5505	in	0
22018	5505	on	1
22019	5505	under	2
22020	5505	next to	3
22021	5506	in	0
22022	5506	on	1
22023	5506	under	2
22024	5506	next to	3
22025	5507	in	0
22026	5507	on	1
22027	5507	under	2
22028	5507	next to	3
22029	5508	in	0
22030	5508	on	1
22031	5508	between	2
22032	5508	next to	3
22033	5509	in	0
22034	5509	on	1
22035	5509	under	2
22036	5509	next to	3
22037	5510	in	0
22038	5510	on	1
22039	5510	under	2
22040	5510	next to	3
22041	5511	in	0
22042	5511	on	1
22043	5511	under	2
22044	5511	next to	3
22045	5512	in	0
22046	5512	on	1
22047	5512	between	2
22048	5512	next to	3
22049	5513	in	0
22050	5513	on	1
22051	5513	under	2
22052	5513	next to	3
22053	5514	in	0
22054	5514	on	1
22055	5514	under	2
22056	5514	next to	3
22057	5515	in	0
22058	5515	on	1
22059	5515	under	2
22060	5515	next to	3
22061	5516	in	0
22062	5516	on	1
22063	5516	between	2
22064	5516	next to	3
22065	5517	in	0
22066	5517	on	1
22067	5517	under	2
22068	5517	at	3
22069	5518	in	0
22070	5518	on	1
22071	5518	under	2
22072	5518	at	3
22073	5519	in	0
22074	5519	on	1
22075	5519	under	2
22076	5519	at	3
22077	5520	in	0
22078	5520	on	1
22079	5520	next to	2
22080	5520	between	3
22081	5521	in	0
22082	5521	on	1
22083	5521	under	2
22084	5521	at	3
22085	5522	in	0
22086	5522	on	1
22087	5522	under	2
22088	5522	at	3
22089	5523	in	0
22090	5523	on	1
22091	5523	under	2
22092	5523	at	3
22093	5524	in	0
22094	5524	on	1
22095	5524	between	2
22096	5524	next to	3
22097	5525	in	0
22098	5525	on	1
22099	5525	under	2
22100	5525	at	3
22101	5526	in	0
22102	5526	on	1
22103	5526	under	2
22104	5526	at	3
22105	5527	in	0
22106	5527	on	1
22107	5527	under	2
22108	5527	at	3
22109	5528	in	0
22110	5528	on	1
22111	5528	between	2
22112	5528	next to	3
22113	5529	in	0
22114	5529	on	1
22115	5529	under	2
22116	5529	at	3
22117	5530	in	0
22118	5530	on	1
22119	5530	under	2
22120	5530	at	3
22121	5531	in	0
22122	5531	on	1
22123	5531	under	2
22124	5531	at	3
22125	5532	in	0
22126	5532	on	1
22127	5532	between	2
22128	5532	next to	3
22129	5533	in	0
22130	5533	on	1
22131	5533	under	2
22132	5533	at	3
22133	5534	in	0
22134	5534	on	1
22135	5534	under	2
22136	5534	at	3
22137	5535	in	0
22138	5535	on	1
22139	5535	under	2
22140	5535	at	3
22141	5536	in	0
22142	5536	on	1
22143	5536	between	2
22144	5536	next to	3
22145	5537	What	0
22146	5537	Where	1
22147	5537	Who	2
22148	5537	When	3
22149	5538	What	0
22150	5538	Where	1
22151	5538	Who	2
22152	5538	When	3
22153	5539	What	0
22154	5539	Where	1
22155	5539	Who	2
22156	5539	When	3
22157	5540	What	0
22158	5540	Where	1
22159	5540	Who	2
22160	5540	When	3
22161	5541	What	0
22162	5541	Where	1
22163	5541	Who	2
22164	5541	When	3
22165	5542	What	0
22166	5542	Where	1
22167	5542	Who	2
22168	5542	When	3
22169	5543	What	0
22170	5543	Where	1
22171	5543	Who	2
22172	5543	When	3
22173	5544	What	0
22174	5544	Where	1
22175	5544	Who	2
22176	5544	When	3
22177	5545	What	0
22178	5545	Where	1
22179	5545	Who	2
22180	5545	When	3
22181	5546	What	0
22182	5546	Where	1
22183	5546	Who	2
22184	5546	When	3
22185	5547	What	0
22186	5547	Where	1
22187	5547	Who	2
22188	5547	When	3
22189	5548	What	0
22190	5548	Where	1
22191	5548	Who	2
22192	5548	When	3
22193	5549	What	0
22194	5549	Where	1
22195	5549	Who	2
22196	5549	When	3
22197	5550	What	0
22198	5550	Where	1
22199	5550	Who	2
22200	5550	When	3
22201	5551	What	0
22202	5551	Where	1
22203	5551	Who	2
22204	5551	When	3
22205	5552	What	0
22206	5552	Where	1
22207	5552	Who	2
22208	5552	When	3
22209	5553	What	0
22210	5553	Where	1
22211	5553	Who	2
22212	5553	When	3
22213	5554	What	0
22214	5554	Where	1
22215	5554	Who	2
22216	5554	When	3
22217	5555	What	0
22218	5555	Where	1
22219	5555	Who	2
22220	5555	When	3
22221	5556	What	0
22222	5556	Where	1
22223	5556	Who	2
22224	5556	When	3
22225	5557	What	0
22226	5557	Where	1
22227	5557	Who	2
22228	5557	When	3
22229	5558	What	0
22230	5558	Where	1
22231	5558	Who	2
22232	5558	When	3
22233	5559	What	0
22234	5559	Where	1
22235	5559	Who	2
22236	5559	When	3
22237	5560	What	0
22238	5560	Where	1
22239	5560	Who	2
22240	5560	When	3
22241	5561	What	0
22242	5561	Where	1
22243	5561	Who	2
22244	5561	When	3
22245	5562	What	0
22246	5562	Where	1
22247	5562	Who	2
22248	5562	When	3
22249	5563	What	0
22250	5563	Where	1
22251	5563	Who	2
22252	5563	When	3
22253	5564	What	0
22254	5564	Where	1
22255	5564	Who	2
22256	5564	When	3
22257	5565	What	0
22258	5565	Where	1
22259	5565	Who	2
22260	5565	When	3
22261	5566	What	0
22262	5566	Where	1
22263	5566	Who	2
22264	5566	When	3
22265	5567	What	0
22266	5567	Where	1
22267	5567	Who	2
22268	5567	When	3
22269	5568	What	0
22270	5568	Where	1
22271	5568	Who	2
22272	5568	When	3
22273	5569	What	0
22274	5569	Where	1
22275	5569	Who	2
22276	5569	When	3
22277	5570	What	0
22278	5570	Where	1
22279	5570	Who	2
22280	5570	When	3
22281	5571	What	0
22282	5571	Where	1
22283	5571	Who	2
22284	5571	When	3
22285	5572	What	0
22286	5572	Where	1
22287	5572	Who	2
22288	5572	When	3
22289	5573	What	0
22290	5573	Where	1
22291	5573	Who	2
22292	5573	When	3
22293	5574	What	0
22294	5574	Where	1
22295	5574	Who	2
22296	5574	When	3
22297	5575	What	0
22298	5575	Where	1
22299	5575	Who	2
22300	5575	When	3
22301	5576	What	0
22302	5576	Where	1
22303	5576	Who	2
22304	5576	When	3
22305	5577	What	0
22306	5577	Where	1
22307	5577	Who	2
22308	5577	When	3
22309	5578	What	0
22310	5578	Where	1
22311	5578	Who	2
22312	5578	When	3
22313	5579	What	0
22314	5579	Where	1
22315	5579	Who	2
22316	5579	When	3
22317	5580	What	0
22318	5580	Where	1
22319	5580	Who	2
22320	5580	When	3
22321	5581	What	0
22322	5581	Where	1
22323	5581	Who	2
22324	5581	When	3
22325	5582	What	0
22326	5582	Where	1
22327	5582	Who	2
22328	5582	When	3
22329	5583	What	0
22330	5583	Where	1
22331	5583	Who	2
22332	5583	When	3
22333	5584	What	0
22334	5584	Where	1
22335	5584	Who	2
22336	5584	When	3
22337	5585	What	0
22338	5585	Where	1
22339	5585	Who	2
22340	5585	When	3
22341	5586	What	0
22342	5586	Where	1
22343	5586	Who	2
22344	5586	When	3
22345	5587	What	0
22346	5587	Where	1
22347	5587	Who	2
22348	5587	When	3
22349	5588	What	0
22350	5588	Where	1
22351	5588	Who	2
22352	5588	When	3
22353	5589	What	0
22354	5589	Where	1
22355	5589	Who	2
22356	5589	When	3
22357	5590	What	0
22358	5590	Where	1
22359	5590	Who	2
22360	5590	When	3
22361	5591	What	0
22362	5591	Where	1
22363	5591	Who	2
22364	5591	When	3
22365	5592	What	0
22366	5592	Where	1
22367	5592	Who	2
22368	5592	When	3
22369	5593	What	0
22370	5593	Where	1
22371	5593	Who	2
22372	5593	When	3
22373	5594	What	0
22374	5594	Where	1
22375	5594	Who	2
22376	5594	When	3
22377	5595	What	0
22378	5595	Where	1
22379	5595	Who	2
22380	5595	When	3
22381	5596	What	0
22382	5596	Where	1
22383	5596	Who	2
22384	5596	When	3
22385	5597	What	0
22386	5597	Where	1
22387	5597	Who	2
22388	5597	When	3
22389	5598	What	0
22390	5598	Where	1
22391	5598	Who	2
22392	5598	When	3
22393	5599	What	0
22394	5599	Where	1
22395	5599	Who	2
22396	5599	When	3
22397	5600	What	0
22398	5600	Where	1
22399	5600	Who	2
22400	5600	When	3
22401	5601	What	0
22402	5601	Where	1
22403	5601	Who	2
22404	5601	When	3
22405	5602	What	0
22406	5602	Where	1
22407	5602	Who	2
22408	5602	When	3
22409	5603	What	0
22410	5603	Where	1
22411	5603	Who	2
22412	5603	When	3
22413	5604	What	0
22414	5604	Where	1
22415	5604	Who	2
22416	5604	When	3
22417	5605	What	0
22418	5605	Where	1
22419	5605	Who	2
22420	5605	When	3
22421	5606	What	0
22422	5606	Where	1
22423	5606	Who	2
22424	5606	When	3
22425	5607	What	0
22426	5607	Where	1
22427	5607	Who	2
22428	5607	When	3
22429	5608	What	0
22430	5608	Where	1
22431	5608	Who	2
22432	5608	When	3
22433	5609	What	0
22434	5609	Where	1
22435	5609	Who	2
22436	5609	When	3
22437	5610	What	0
22438	5610	Where	1
22439	5610	Who	2
22440	5610	When	3
22441	5611	What	0
22442	5611	Where	1
22443	5611	Who	2
22444	5611	When	3
22445	5612	What	0
22446	5612	Where	1
22447	5612	Who	2
22448	5612	When	3
22449	5613	What	0
22450	5613	Where	1
22451	5613	Who	2
22452	5613	When	3
22453	5614	What	0
22454	5614	Where	1
22455	5614	Who	2
22456	5614	When	3
22457	5615	What	0
22458	5615	Where	1
22459	5615	Who	2
22460	5615	When	3
22461	5616	What	0
22462	5616	Where	1
22463	5616	Who	2
22464	5616	When	3
22465	5617	What	0
22466	5617	How	1
22467	5617	Why	2
22468	5617	When	3
22469	5618	What	0
22470	5618	How	1
22471	5618	Why	2
22472	5618	When	3
22473	5619	What	0
22474	5619	How	1
22475	5619	Why	2
22476	5619	When	3
22477	5620	What	0
22478	5620	How	1
22479	5620	Why	2
22480	5620	When	3
22481	5621	What	0
22482	5621	How	1
22483	5621	Why	2
22484	5621	When	3
22485	5622	What	0
22486	5622	How	1
22487	5622	Why	2
22488	5622	When	3
22489	5623	What	0
22490	5623	How	1
22491	5623	Why	2
22492	5623	When	3
22493	5624	What	0
22494	5624	How	1
22495	5624	Why	2
22496	5624	When	3
22497	5625	What	0
22498	5625	How	1
22499	5625	Why	2
22500	5625	When	3
22501	5626	What	0
22502	5626	How	1
22503	5626	Why	2
22504	5626	When	3
22505	5627	What	0
22506	5627	How	1
22507	5627	Why	2
22508	5627	When	3
22509	5628	What	0
22510	5628	How	1
22511	5628	Why	2
22512	5628	When	3
22513	5629	What	0
22514	5629	How	1
22515	5629	Why	2
22516	5629	When	3
22517	5630	What	0
22518	5630	How	1
22519	5630	Why	2
22520	5630	When	3
22521	5631	What	0
22522	5631	How	1
22523	5631	Why	2
22524	5631	When	3
22525	5632	What	0
22526	5632	How	1
22527	5632	Why	2
22528	5632	When	3
22529	5633	What	0
22530	5633	How	1
22531	5633	Why	2
22532	5633	When	3
22533	5634	What	0
22534	5634	How	1
22535	5634	Why	2
22536	5634	When	3
22537	5635	What	0
22538	5635	How	1
22539	5635	Why	2
22540	5635	When	3
22541	5636	What	0
22542	5636	How	1
22543	5636	Why	2
22544	5636	When	3
22545	5637	What	0
22546	5637	Where	1
22547	5637	How	2
22548	5637	When	3
22549	5638	What	0
22550	5638	Where	1
22551	5638	How	2
22552	5638	When	3
22553	5639	What	0
22554	5639	Where	1
22555	5639	How	2
22556	5639	When	3
22557	5640	What	0
22558	5640	Where	1
22559	5640	How	2
22560	5640	When	3
22561	5641	What	0
22562	5641	Where	1
22563	5641	How	2
22564	5641	When	3
22565	5642	What	0
22566	5642	Where	1
22567	5642	How	2
22568	5642	When	3
22569	5643	What	0
22570	5643	Where	1
22571	5643	How	2
22572	5643	When	3
22573	5644	What	0
22574	5644	Where	1
22575	5644	How	2
22576	5644	When	3
22577	5645	What	0
22578	5645	Where	1
22579	5645	How	2
22580	5645	When	3
22581	5646	What	0
22582	5646	Where	1
22583	5646	How	2
22584	5646	When	3
22585	5647	What	0
22586	5647	Where	1
22587	5647	How	2
22588	5647	When	3
22589	5648	What	0
22590	5648	Where	1
22591	5648	How	2
22592	5648	When	3
22593	5649	What	0
22594	5649	Where	1
22595	5649	How	2
22596	5649	When	3
22597	5650	What	0
22598	5650	Where	1
22599	5650	How	2
22600	5650	When	3
22601	5651	What	0
22602	5651	Where	1
22603	5651	How	2
22604	5651	When	3
22605	5652	What	0
22606	5652	Where	1
22607	5652	How	2
22608	5652	When	3
22609	5653	What	0
22610	5653	Where	1
22611	5653	How	2
22612	5653	When	3
22613	5654	What	0
22614	5654	Where	1
22615	5654	How	2
22616	5654	When	3
22617	5655	What	0
22618	5655	Where	1
22619	5655	How	2
22620	5655	When	3
22621	5656	What	0
22622	5656	Where	1
22623	5656	How	2
22624	5656	When	3
22625	5657	What	0
22626	5657	Where	1
22627	5657	Who	2
22628	5657	When	3
22629	5658	What	0
22630	5658	Where	1
22631	5658	Who	2
22632	5658	When	3
22633	5659	What	0
22634	5659	Where	1
22635	5659	Who	2
22636	5659	When	3
22637	5660	What	0
22638	5660	Where	1
22639	5660	Who	2
22640	5660	When	3
22641	5661	What	0
22642	5661	Where	1
22643	5661	Who	2
22644	5661	When	3
22645	5662	What	0
22646	5662	Where	1
22647	5662	Who	2
22648	5662	When	3
22649	5663	What	0
22650	5663	Where	1
22651	5663	Who	2
22652	5663	When	3
22653	5664	What	0
22654	5664	Where	1
22655	5664	Who	2
22656	5664	When	3
22657	5665	What	0
22658	5665	Where	1
22659	5665	Who	2
22660	5665	When	3
22661	5666	What	0
22662	5666	Where	1
22663	5666	Who	2
22664	5666	When	3
22665	5667	What	0
22666	5667	Where	1
22667	5667	Who	2
22668	5667	When	3
22669	5668	What	0
22670	5668	Where	1
22671	5668	Who	2
22672	5668	When	3
22673	5669	What	0
22674	5669	Where	1
22675	5669	Who	2
22676	5669	When	3
22677	5670	What	0
22678	5670	Where	1
22679	5670	Who	2
22680	5670	When	3
22681	5671	What	0
22682	5671	Where	1
22683	5671	Who	2
22684	5671	When	3
22685	5672	What	0
22686	5672	Where	1
22687	5672	Who	2
22688	5672	When	3
22689	5673	What	0
22690	5673	Where	1
22691	5673	Who	2
22692	5673	When	3
22693	5674	What	0
22694	5674	Where	1
22695	5674	Who	2
22696	5674	When	3
22697	5675	What	0
22698	5675	Where	1
22699	5675	Who	2
22700	5675	When	3
22701	5676	What	0
22702	5676	Where	1
22703	5676	Who	2
22704	5676	When	3
22705	5677	How	0
22706	5677	When	1
22707	5677	Why	2
22708	5677	What	3
22709	5678	How	0
22710	5678	When	1
22711	5678	Why	2
22712	5678	What	3
22713	5679	How	0
22714	5679	When	1
22715	5679	Why	2
22716	5679	What	3
22717	5680	How	0
22718	5680	When	1
22719	5680	Why	2
22720	5680	What	3
22721	5681	How	0
22722	5681	When	1
22723	5681	Why	2
22724	5681	What	3
22725	5682	How	0
22726	5682	When	1
22727	5682	Why	2
22728	5682	What	3
22729	5683	How	0
22730	5683	When	1
22731	5683	Why	2
22732	5683	What	3
22733	5684	How	0
22734	5684	When	1
22735	5684	Why	2
22736	5684	What	3
22737	5685	How	0
22738	5685	When	1
22739	5685	Why	2
22740	5685	What	3
22741	5686	How	0
22742	5686	When	1
22743	5686	Why	2
22744	5686	What	3
22745	5687	How	0
22746	5687	When	1
22747	5687	Why	2
22748	5687	What	3
22749	5688	How	0
22750	5688	When	1
22751	5688	Why	2
22752	5688	What	3
22753	5689	How	0
22754	5689	When	1
22755	5689	Why	2
22756	5689	What	3
22757	5690	How	0
22758	5690	When	1
22759	5690	Why	2
22760	5690	What	3
22761	5691	How	0
22762	5691	When	1
22763	5691	Why	2
22764	5691	What	3
22765	5692	How	0
22766	5692	When	1
22767	5692	Why	2
22768	5692	What	3
22769	5693	How	0
22770	5693	When	1
22771	5693	Why	2
22772	5693	What	3
22773	5694	How	0
22774	5694	When	1
22775	5694	Why	2
22776	5694	What	3
22777	5695	How	0
22778	5695	When	1
22779	5695	Why	2
22780	5695	What	3
22781	5696	How	0
22782	5696	When	1
22783	5696	Why	2
22784	5696	What	3
22785	5697	What	0
22786	5697	Where	1
22787	5697	Who	2
22788	5697	How	3
22789	5698	What	0
22790	5698	Where	1
22791	5698	Who	2
22792	5698	How	3
22793	5699	What	0
22794	5699	Where	1
22795	5699	Who	2
22796	5699	How	3
22797	5700	What	0
22798	5700	Where	1
22799	5700	Who	2
22800	5700	How	3
22801	5701	What	0
22802	5701	Where	1
22803	5701	When	2
22804	5701	Why	3
22805	5702	What	0
22806	5702	Where	1
22807	5702	When	2
22808	5702	Why	3
22809	5703	What	0
22810	5703	Where	1
22811	5703	When	2
22812	5703	Why	3
22813	5704	What	0
22814	5704	Where	1
22815	5704	When	2
22816	5704	Why	3
22817	5705	What	0
22818	5705	Where	1
22819	5705	Who	2
22820	5705	Why	3
22821	5706	What	0
22822	5706	Where	1
22823	5706	How	2
22824	5706	Why	3
22825	5707	What	0
22826	5707	When	1
22827	5707	Who	2
22828	5707	Where	3
22829	5708	How	0
22830	5708	When	1
22831	5708	Why	2
22832	5708	Where	3
22833	5709	What	0
22834	5709	Where	1
22835	5709	Who	2
22836	5709	How	3
22837	5710	What	0
22838	5710	Where	1
22839	5710	Who	2
22840	5710	How	3
22841	5711	What	0
22842	5711	Where	1
22843	5711	Who	2
22844	5711	How	3
22845	5712	What	0
22846	5712	Where	1
22847	5712	How	2
22848	5712	When	3
22849	5713	What	0
22850	5713	Where	1
22851	5713	When	2
22852	5713	How	3
22853	5714	How	0
22854	5714	When	1
22855	5714	Why	2
22856	5714	Where	3
22857	5715	What	0
22858	5715	Where	1
22859	5715	Who	2
22860	5715	When	3
22861	5716	What	0
22862	5716	Where	1
22863	5716	Who	2
22864	5716	How	3
22865	5717	What	0
22866	5717	Where	1
22867	5717	Who	2
22868	5717	How	3
22869	5718	What	0
22870	5718	Where	1
22871	5718	Who	2
22872	5718	How	3
22873	5719	What	0
22874	5719	Where	1
22875	5719	Who	2
22876	5719	How	3
22877	5720	What	0
22878	5720	Where	1
22879	5720	Who	2
22880	5720	How	3
22881	5721	What	0
22882	5721	When	1
22883	5721	Why	2
22884	5721	How	3
22885	5722	What	0
22886	5722	When	1
22887	5722	Why	2
22888	5722	How	3
22889	5723	What	0
22890	5723	Where	1
22891	5723	Who	2
22892	5723	How	3
22893	5724	What	0
22894	5724	Where	1
22895	5724	When	2
22896	5724	How	3
22897	5725	What	0
22898	5725	Where	1
22899	5725	Who	2
22900	5725	How	3
22901	5726	What	0
22902	5726	Where	1
22903	5726	When	2
22904	5726	How	3
22905	5727	What	0
22906	5727	Where	1
22907	5727	Who	2
22908	5727	How	3
22909	5728	What	0
22910	5728	Where	1
22911	5728	When	2
22912	5728	How	3
22913	5729	What	0
22914	5729	Where	1
22915	5729	Who	2
22916	5729	How	3
22917	5730	What	0
22918	5730	Where	1
22919	5730	When	2
22920	5730	How	3
22921	5731	What	0
22922	5731	When	1
22923	5731	Why	2
22924	5731	How	3
22925	5732	What	0
22926	5732	When	1
22927	5732	Why	2
22928	5732	How	3
22929	5733	What	0
22930	5733	Where	1
22931	5733	Who	2
22932	5733	How	3
22933	5734	What	0
22934	5734	Where	1
22935	5734	When	2
22936	5734	How	3
22937	5735	What	0
22938	5735	Where	1
22939	5735	Who	2
22940	5735	How	3
22941	5736	What	0
22942	5736	Where	1
22943	5736	When	2
22944	5736	How	3
22945	5737	six	0
22946	5737	seven	1
22947	5737	eight	2
22948	5737	nine	3
22949	5738	twelve	0
22950	5738	twenty	1
22951	5738	eleven	2
22952	5738	thirteen	3
22953	5739	fourteen	0
22954	5739	fifteen	1
22955	5739	sixteen	2
22956	5739	fifty	3
22957	5740	tree	0
22958	5740	three	1
22959	5740	free	2
22960	5740	there	3
22961	5741	ten	0
22962	5741	teen	1
22963	5741	tan	2
22964	5741	tin	3
22965	5742	one	0
22966	5742	won	1
22967	5742	on	2
22968	5742	an	3
22969	5743	eighty	0
22970	5743	eighteen	1
22971	5743	eight	2
22972	5743	eightteen	3
22973	5744	fife	0
22974	5744	five	1
22975	5744	fiv	2
22976	5744	fieve	3
22977	5745	thirty	0
22978	5745	threeteen	1
22979	5745	thirteen	2
22980	5745	thirteen	3
22981	5746	twenty	0
22982	5746	twunty	1
22983	5746	twente	2
22984	5746	twelty	3
22985	5747	eleven	0
22986	5747	onety-one	1
22987	5747	leven	2
22988	5747	elefen	3
22989	5748	ate	0
22990	5748	eight	1
22991	5748	eith	2
22992	5748	eigth	3
22993	5749	ninety	0
22994	5749	nineteen	1
22995	5749	ninetin	2
22996	5749	nineten	3
22997	5750	for	0
22998	5750	four	1
22999	5750	fore	2
23000	5750	foor	3
23001	5751	sixteen	0
23002	5751	sixty	1
23003	5751	sixtee	2
23004	5751	siksten	3
23005	5752	to	0
23006	5752	too	1
23007	5752	two	2
23008	5752	tue	3
23009	5753	seventy	0
23010	5753	seventeen	1
23011	5753	seventee	2
23012	5753	sebenteen	3
23013	5754	siks	0
23014	5754	six	1
23015	5754	sex	2
23016	5754	sicks	3
23017	5755	forty	0
23018	5755	forteen	1
23019	5755	fourteen	2
23020	5755	fourten	3
23021	5756	nine	0
23022	5756	nein	1
23023	5756	nyne	2
23024	5756	nin	3
23025	5757	thirty	0
23026	5757	thirteen	1
23027	5757	therty	2
23028	5757	threety	3
23029	5758	fivety	0
23030	5758	fifty	1
23031	5758	fivty	2
23032	5758	fiftee	3
23033	5759	twenty-one	0
23034	5759	twenty one	1
23035	5759	twentyone	2
23036	5759	two-one	3
23037	5760	fourty	0
23038	5760	forty	1
23039	5760	forteen	2
23040	5760	fourthy	3
23041	5761	sixty	0
23042	5761	sixteen	1
23043	5761	sikty	2
23044	5761	sixtee	3
23045	5762	seventy-five	0
23046	5762	seventy five	1
23047	5762	seven-five	2
23048	5762	seventyfive	3
23049	5763	eighty	0
23050	5763	eighteen	1
23051	5763	eightty	2
23052	5763	eightie	3
23053	5764	ninety	0
23054	5764	nineteen	1
23055	5764	nintee	2
23056	5764	ninetie	3
23057	5765	thirty-three	0
23058	5765	thirty three	1
23059	5765	thirtythree	2
23060	5765	three-three	3
23061	5766	forty-five	0
23062	5766	fourty-five	1
23063	5766	four-five	2
23064	5766	fortyfive	3
23065	5767	sixty-seven	0
23066	5767	sixty seven	1
23067	5767	sixtyseven	2
23068	5767	six-seven	3
23069	5768	eighty-nine	0
23070	5768	eighty nine	1
23071	5768	eightynine	2
23072	5768	eight-nine	3
23073	5769	twenty-two	0
23074	5769	twenty two	1
23075	5769	twentytwo	2
23076	5769	two-two	3
23077	5770	seventy	0
23078	5770	seventeen	1
23079	5770	seventee	2
23080	5770	seventie	3
23081	5771	one hundred	0
23082	5771	hundred	1
23083	5771	one hunderd	2
23084	5771	a hunderd	3
23085	5772	fifty-five	0
23086	5772	fifty five	1
23087	5772	fiftyfive	2
23088	5772	five-five	3
23089	5773	forty-four	0
23090	5773	fourty-four	1
23091	5773	fortyfour	2
23092	5773	four-four	3
23093	5774	ninety-nine	0
23094	5774	ninety nine	1
23095	5774	ninetynine	2
23096	5774	nine-nine	3
23097	5775	thirty-six	0
23098	5775	thirty six	1
23099	5775	thirtysix	2
23100	5775	three-six	3
23101	5776	eighty-eight	0
23102	5776	eighty eight	1
23103	5776	eightyeight	2
23104	5776	eight-eight	3
23105	5777	first	0
23106	5777	one	1
23107	5777	oneth	2
23108	5777	fist	3
23109	5778	second	0
23110	5778	two	1
23111	5778	twoth	2
23112	5778	secund	3
23113	5779	third	0
23114	5779	three	1
23115	5779	threeth	2
23116	5779	therd	3
23117	5780	fourth	0
23118	5780	four	1
23119	5780	forth	2
23120	5780	fourt	3
23121	5781	fifth	0
23122	5781	five	1
23123	5781	fiveth	2
23124	5781	fift	3
23125	5782	sixth	0
23126	5782	six	1
23127	5782	sixt	2
23128	5782	sikth	3
23129	5783	seventh	0
23130	5783	seven	1
23131	5783	sevth	2
23132	5783	sevent	3
23133	5784	eighth	0
23134	5784	eight	1
23135	5784	eightth	2
23136	5784	eith	3
23137	5785	ninth	0
23138	5785	nine	1
23139	5785	nineth	2
23140	5785	nint	3
23141	5786	tenth	0
23142	5786	ten	1
23143	5786	teeth	2
23144	5786	tent	3
23145	5787	eleventh	0
23146	5787	eleven	1
23147	5787	elevent	2
23148	5787	elevnth	3
23149	5788	twelfth	0
23150	5788	twelve	1
23151	5788	twelft	2
23152	5788	twelvth	3
23153	5789	5th	0
23154	5789	5st	1
23155	5789	5nd	2
23156	5789	5rd	3
23157	5790	21st	0
23158	5790	21th	1
23159	5790	21nd	2
23160	5790	21rd	3
23161	5791	2nd	0
23162	5791	2th	1
23163	5791	2st	2
23164	5791	2rd	3
23165	5792	3rd	0
23166	5792	3th	1
23167	5792	3st	2
23168	5792	3nd	3
23169	5793	15th	0
23170	5793	15st	1
23171	5793	15nd	2
23172	5793	15rd	3
23173	5794	1st	0
23174	5794	1th	1
23175	5794	1nd	2
23176	5794	1rd	3
23177	5795	31st	0
23178	5795	31th	1
23179	5795	31nd	2
23180	5795	31rd	3
23181	5796	20th	0
23182	5796	20st	1
23183	5796	20nd	2
23184	5796	20rd	3
23185	5797	Monday	0
23186	5797	Sunday	1
23187	5797	Saturday	2
23188	5797	Tuesday	3
23189	5798	in	0
23190	5798	on	1
23191	5798	at	2
23192	5798	to	3
23193	5799	Wensday	0
23194	5799	Wednesday	1
23195	5799	Wendsday	2
23196	5799	Wednsday	3
23197	5800	Tuesday	0
23198	5800	Sunday	1
23199	5800	Friday	2
23200	5800	Wednesday	3
23201	5801	Friday	0
23202	5801	Monday	1
23203	5801	Saturday	2
23204	5801	Thursday	3
23205	5802	in	0
23206	5802	on	1
23207	5802	at	2
23208	5802	to	3
23209	5803	Friday	0
23210	5803	Wednesday	1
23211	5803	Tuesday	2
23212	5803	Saturday	3
23213	5804	six	0
23214	5804	seven	1
23215	5804	eight	2
23216	5804	five	3
23217	5805	in	0
23218	5805	on	1
23219	5805	at	2
23220	5805	to	3
23221	5806	Monday	0
23222	5806	Friday	1
23223	5806	Wednesday	2
23224	5806	Saturday	3
23225	5807	in	0
23226	5807	on	1
23227	5807	at	2
23228	5807	to	3
23229	5808	Thursday	0
23230	5808	Friday	1
23231	5808	Saturday	2
23232	5808	Sunday	3
23233	5809	Tuesday	0
23234	5809	Friday	1
23235	5809	Thursday	2
23236	5809	Monday	3
23237	5810	in	0
23238	5810	on	1
23239	5810	at	2
23240	5810	to	3
23241	5811	Monday	0
23242	5811	Wednesday	1
23243	5811	Friday	2
23244	5811	Sunday	3
23245	5812	in	0
23246	5812	on	1
23247	5812	at	2
23248	5812	to	3
23249	5813	Thursday	0
23250	5813	Friday	1
23251	5813	Sunday	2
23252	5813	Monday	3
23253	5814	in	0
23254	5814	on	1
23255	5814	at	2
23256	5814	to	3
23257	5815	Saturday	0
23258	5815	Monday	1
23259	5815	Friday	2
23260	5815	Tuesday	3
23261	5816	Wednesday	0
23262	5816	Monday	1
23263	5816	Thursday	2
23264	5816	Friday	3
23265	5817	January	0
23266	5817	February	1
23267	5817	March	2
23268	5817	April	3
23269	5818	in	0
23270	5818	on	1
23271	5818	at	2
23272	5818	to	3
23273	5819	January	0
23274	5819	February	1
23275	5819	March	2
23276	5819	April	3
23277	5820	August	0
23278	5820	September	1
23279	5820	May	2
23280	5820	October	3
23281	5821	November	0
23282	5821	December	1
23283	5821	October	2
23284	5821	September	3
23285	5822	in	0
23286	5822	on	1
23287	5822	at	2
23288	5822	to	3
23289	5823	May	0
23290	5823	July	1
23291	5823	August	2
23292	5823	September	3
23293	5824	ten	0
23294	5824	eleven	1
23295	5824	twelve	2
23296	5824	thirteen	3
23297	5825	in	0
23298	5825	on	1
23299	5825	at	2
23300	5825	to	3
23301	5826	May	0
23302	5826	February	1
23303	5826	March	2
23304	5826	June	3
23305	5827	in	0
23306	5827	on	1
23307	5827	at	2
23308	5827	to	3
23309	5828	July	0
23310	5828	September	1
23311	5828	October	2
23312	5828	November	3
23313	5829	January	0
23314	5829	February	1
23315	5829	March	2
23316	5829	April	3
23317	5830	March	0
23318	5830	February	1
23319	5830	November	2
23320	5830	October	3
23321	5831	February	0
23322	5831	April	1
23323	5831	June	2
23324	5831	January	3
23325	5832	in	0
23326	5832	on	1
23327	5832	at	2
23328	5832	to	3
23329	5833	February	0
23330	5833	April	1
23331	5833	June	2
23332	5833	January	3
23333	5834	in	0
23334	5834	on	1
23335	5834	at	2
23336	5834	to	3
23337	5835	September	0
23338	5835	December	1
23339	5835	October	2
23340	5835	August	3
23341	5836	January	0
23342	5836	February	1
23343	5836	March	2
23344	5836	June	3
23345	5837	five June	0
23346	5837	the fifth of June	1
23347	5837	June fiveth	2
23348	5837	fiveth June	3
23349	5838	in	0
23350	5838	on	1
23351	5838	at	2
23352	5838	to	3
23353	5839	1th	0
23354	5839	1st	1
23355	5839	1nd	2
23356	5839	1rd	3
23357	5840	first	0
23358	5840	oneth	1
23359	5840	firth	2
23360	5840	firsted	3
23361	5841	in	0
23362	5841	on	1
23363	5841	at	2
23364	5841	to	3
23365	5842	25st	0
23366	5842	25th	1
23367	5842	25nd	2
23368	5842	25rd	3
23369	5843	22th March	0
23370	5843	March 22nd	1
23371	5843	March 22th	2
23372	5843	22st March	3
23373	5844	in	0
23374	5844	on	1
23375	5844	at	2
23376	5844	to	3
23377	5845	4st	0
23378	5845	4th	1
23379	5845	4nd	2
23380	5845	4rd	3
23381	5846	in	0
23382	5846	on	1
23383	5846	at	2
23384	5846	to	3
23385	5847	14th	0
23386	5847	14st	1
23387	5847	14nd	2
23388	5847	14rd	3
23389	5848	third	0
23390	5848	threeth	1
23391	5848	thirth	2
23392	5848	thirded	3
23393	5849	in	0
23394	5849	on	1
23395	5849	at	2
23396	5849	to	3
23397	5850	31st	0
23398	5850	31th	1
23399	5850	31nd	2
23400	5850	31rd	3
23401	5851	in	0
23402	5851	on	1
23403	5851	at	2
23404	5851	to	3
23405	5852	1st	0
23406	5852	1th	1
23407	5852	1nd	2
23408	5852	1rd	3
23409	5853	1st	0
23410	5853	1th	1
23411	5853	1nd	2
23412	5853	1rd	3
23413	5854	in	0
23414	5854	on	1
23415	5854	at	2
23416	5854	to	3
23417	5855	21st	0
23418	5855	21th	1
23419	5855	21nd	2
23420	5855	21rd	3
23421	5856	in	0
23422	5856	on	1
23423	5856	at	2
23424	5856	to	3
23425	5857	five o'clock	0
23426	5857	five clock	1
23427	5857	five hour	2
23428	5857	o'clock five	3
23429	5858	in	0
23430	5858	on	1
23431	5858	at	2
23432	5858	to	3
23433	5859	midnight	0
23434	5859	noon	1
23435	5859	evening	2
23436	5859	morning	3
23437	5860	in	0
23438	5860	on	1
23439	5860	at	2
23440	5860	to	3
23441	5861	noon	0
23442	5861	midnight	1
23443	5861	evening	2
23444	5861	morning	3
23445	5862	ten o'clock	0
23446	5862	ten clock	1
23447	5862	o'clock ten	2
23448	5862	ten hour	3
23449	5863	in	0
23450	5863	on	1
23451	5863	at	2
23452	5863	to	3
23453	5864	in	0
23454	5864	on	1
23455	5864	at	2
23456	5864	to	3
23457	5865	8 in the morning	0
23458	5865	8 in the evening	1
23459	5865	8 at noon	2
23460	5865	8 at midnight	3
23461	5866	in	0
23462	5866	on	1
23463	5866	at	2
23464	5866	to	3
23465	5867	six o'clock	0
23466	5867	six clock	1
23467	5867	o'clock six	2
23468	5867	six hour	3
23469	5868	in	0
23470	5868	on	1
23471	5868	at	2
23472	5868	to	3
23473	5869	7 in the evening	0
23474	5869	7 in the morning	1
23475	5869	7 at noon	2
23476	5869	7 at night	3
23477	5870	in	0
23478	5870	on	1
23479	5870	at	2
23480	5870	to	3
23481	5871	one o'clock	0
23482	5871	one clock	1
23483	5871	o'clock one	2
23484	5871	one hour	3
23485	5872	in	0
23486	5872	on	1
23487	5872	at	2
23488	5872	to	3
23489	5873	two o'clock	0
23490	5873	two clock	1
23491	5873	two hour	2
23492	5873	o'clock two	3
23493	5874	in	0
23494	5874	on	1
23495	5874	at	2
23496	5874	to	3
23497	5875	eleven o'clock	0
23498	5875	eleven clock	1
23499	5875	o'clock eleven	2
23500	5875	eleven hour	3
23501	5876	in	0
23502	5876	on	1
23503	5876	at	2
23504	5876	to	3
23505	5877	quarter past three	0
23506	5877	three past quarter	1
23507	5877	quarter to three	2
23508	5877	three quarter	3
23509	5878	half past four	0
23510	5878	four past half	1
23511	5878	half to four	2
23512	5878	four half	3
23513	5879	quarter past five	0
23514	5879	half past five	1
23515	5879	quarter to six	2
23516	5879	five forty	3
23517	5880	ten past two	0
23518	5880	two past ten	1
23519	5880	ten to two	2
23520	5880	two ten	3
23521	5881	ten past six	0
23522	5881	half past six	1
23523	5881	ten to seven	2
23524	5881	six fifty	3
23525	5882	in	0
23526	5882	on	1
23527	5882	at	2
23528	5882	to	3
23529	5883	quarter past seven	0
23530	5883	quarter to seven	1
23531	5883	half past seven	2
23532	5883	seven quarter	3
23533	5884	in	0
23534	5884	on	1
23535	5884	at	2
23536	5884	to	3
23537	5885	half past nine	0
23538	5885	nine past half	1
23539	5885	half to nine	2
23540	5885	quarter past nine	3
23541	5886	in	0
23542	5886	on	1
23543	5886	at	2
23544	5886	to	3
23545	5887	quarter past eight	0
23546	5887	half past eight	1
23547	5887	quarter to nine	2
23548	5887	eight forty	3
23549	5888	twenty past one	0
23550	5888	one past twenty	1
23551	5888	twenty to one	2
23552	5888	one twenty	3
23553	5889	in	0
23554	5889	on	1
23555	5889	at	2
23556	5889	to	3
23557	5890	half past eleven	0
23558	5890	eleven past half	1
23559	5890	quarter past eleven	2
23560	5890	eleven half	3
23561	5891	five past four	0
23562	5891	five to five	1
23563	5891	half past four	2
23564	5891	quarter to five	3
23565	5892	in	0
23566	5892	on	1
23567	5892	at	2
23568	5892	to	3
23569	5893	quarter past ten	0
23570	5893	quarter to ten	1
23571	5893	half past ten	2
23572	5893	ten quarter	3
23573	5894	twenty past three	0
23574	5894	twenty to four	1
23575	5894	half past three	2
23576	5894	forty past three	3
23577	5895	in	0
23578	5895	on	1
23579	5895	at	2
23580	5895	to	3
23581	5896	half past twelve	0
23582	5896	twelve past half	1
23583	5896	quarter past twelve	2
23584	5896	twelve half	3
23585	5897	9 in the morning	0
23586	5897	9 in the evening	1
23587	5897	9 at night	2
23588	5897	9 at noon	3
23589	5898	9 in the morning	0
23590	5898	9 in the evening	1
23591	5898	9 at noon	2
23592	5898	9 at midnight	3
23593	5899	in	0
23594	5899	on	1
23595	5899	at	2
23596	5899	to	3
23597	5900	12 AM	0
23598	5900	12 PM	1
23599	5900	0 PM	2
23600	5900	24 AM	3
23601	5901	12 AM	0
23602	5901	12 PM	1
23603	5901	0 AM	2
23604	5901	24 PM	3
23605	5902	in	0
23606	5902	on	1
23607	5902	at	2
23608	5902	to	3
23609	5903	six in the morning	0
23610	5903	six in the evening	1
23611	5903	six at noon	2
23612	5903	six at night	3
23613	5904	six in the morning	0
23614	5904	six in the evening	1
23615	5904	six at noon	2
23616	5904	six at midnight	3
23617	5905	in	0
23618	5905	on	1
23619	5905	at	2
23620	5905	to	3
23621	5906	in	0
23622	5906	on	1
23623	5906	at	2
23624	5906	to	3
23625	5907	in	0
23626	5907	on	1
23627	5907	at	2
23628	5907	to	3
23629	5908	3 in the morning	0
23630	5908	3 in the afternoon	1
23631	5908	3 in the evening	2
23632	5908	3 at noon	3
23633	5909	in	0
23634	5909	on	1
23635	5909	at	2
23636	5909	to	3
23637	5910	in	0
23638	5910	on	1
23639	5910	at	2
23640	5910	to	3
23641	5911	in	0
23642	5911	on	1
23643	5911	at	2
23644	5911	to	3
23645	5912	4 in the morning	0
23646	5912	4 in the afternoon	1
23647	5912	4 in the night	2
23648	5912	4 at midnight	3
23649	5913	in	0
23650	5913	on	1
23651	5913	at	2
23652	5913	to	3
23653	5914	in	0
23654	5914	on	1
23655	5914	at	2
23656	5914	to	3
23657	5915	in	0
23658	5915	on	1
23659	5915	at	2
23660	5915	to	3
23661	5916	11 in the morning	0
23662	5916	11 at night	1
23663	5916	11 at noon	2
23664	5916	11 at midnight	3
23665	5917	twenty-five	0
23666	5917	two-five	1
23667	5917	twentyfive	2
23668	5917	twenty five	3
23669	5918	first	0
23670	5918	one	1
23671	5918	oneth	2
23672	5918	firth	3
23673	5919	in	0
23674	5919	on	1
23675	5919	at	2
23676	5919	to	3
23677	5920	Monday	0
23678	5920	Wednesday	1
23679	5920	Thursday	2
23680	5920	Friday	3
23681	5921	in	0
23682	5921	on	1
23683	5921	at	2
23684	5921	to	3
23685	5922	half past three	0
23686	5922	three past half	1
23687	5922	quarter past three	2
23688	5922	three thirty	3
23689	5923	twenty	0
23690	5923	twelve	1
23691	5923	twelfth	2
23692	5923	tenth	3
23693	5924	in	0
23694	5924	on	1
23695	5924	at	2
23696	5924	to	3
23697	5925	February	0
23698	5925	March	1
23699	5925	April	2
23700	5925	May	3
23701	5926	in	0
23702	5926	on	1
23703	5926	at	2
23704	5926	to	3
23705	5927	fifteen	0
23706	5927	fifty	1
23707	5927	five	2
23708	5927	fivety	3
23709	5928	November	0
23710	5928	December	1
23711	5928	October	2
23712	5928	September	3
23713	5929	quarter past four	0
23714	5929	quarter to four	1
23715	5929	half past four	2
23716	5929	four quarter	3
23717	5930	in	0
23718	5930	on	1
23719	5930	at	2
23720	5930	to	3
23721	5931	1st	0
23722	5931	1th	1
23723	5931	1nd	2
23724	5931	1rd	3
23725	5932	9 in the morning	0
23726	5932	9 in the evening	1
23727	5932	9 at noon	2
23728	5932	9 at midnight	3
23729	5933	thirty-three	0
23730	5933	three-three	1
23731	5933	thirtythree	2
23732	5933	thirty three	3
23733	5934	in	0
23734	5934	on	1
23735	5934	at	2
23736	5934	to	3
23737	5935	Thursday	0
23738	5935	Friday	1
23739	5935	Sunday	2
23740	5935	Monday	3
23741	5936	in	0
23742	5936	on	1
23743	5936	at	2
23744	5936	to	3
23745	5937	working	0
23746	5937	workking	1
23747	5937	workin	2
23748	5937	workeing	3
23749	5938	plaiing	0
23750	5938	playing	1
23751	5938	playying	2
23752	5938	plaing	3
23753	5939	reading	0
23754	5939	readding	1
23755	5939	readin	2
23756	5939	readeing	3
23757	5940	watcing	0
23758	5940	watchhing	1
23759	5940	watching	2
23760	5940	watchin	3
23761	5941	studing	0
23762	5941	studying	1
23763	5941	studyying	2
23764	5941	studing	3
23765	5942	sleeping	0
23766	5942	sleepping	1
23767	5942	sleepin	2
23768	5942	sleepeing	3
23769	5943	talking	0
23770	5943	talkking	1
23771	5943	talkin	2
23772	5943	talkeing	3
23773	5944	listening	0
23774	5944	listenning	1
23775	5944	listenin	2
23776	5944	listeneing	3
23777	5945	walking	0
23778	5945	walkking	1
23779	5945	walkin	2
23780	5945	walkeing	3
23781	5946	eating	0
23782	5946	eatting	1
23783	5946	eatin	2
23784	5946	eateing	3
23785	5947	drinking	0
23786	5947	drinkking	1
23787	5947	drinkin	2
23788	5947	drinkeing	3
23789	5948	cooking	0
23790	5948	cookking	1
23791	5948	cookin	2
23792	5948	cookeing	3
23793	5949	cleaning	0
23794	5949	cleannnig	1
23795	5949	cleanin	2
23796	5949	cleaneing	3
23797	5950	teacing	0
23798	5950	teaching	1
23799	5950	teachhing	2
23800	5950	teachin	3
23801	5951	learning	0
23802	5951	learnning	1
23803	5951	learnin	2
23804	5951	learneing	3
23805	5952	helping	0
23806	5952	helpping	1
23807	5952	helpin	2
23808	5952	helpeing	3
23809	5953	waiting	0
23810	5953	waitting	1
23811	5953	waitin	2
23812	5953	waiteing	3
23813	5954	calling	0
23814	5954	callling	1
23815	5954	callin	2
23816	5954	calleing	3
23817	5955	starting	0
23818	5955	startting	1
23819	5955	startin	2
23820	5955	starteing	3
23821	5956	finishing	0
23822	5956	finishhing	1
23823	5956	finishin	2
23824	5956	finisheing	3
23825	5957	makeing	0
23826	5957	making	1
23827	5957	makking	2
23828	5957	makiing	3
23829	5958	writeing	0
23830	5958	writing	1
23831	5958	writting	2
23832	5958	writiing	3
23833	5959	comeing	0
23834	5959	coming	1
23835	5959	comming	2
23836	5959	comiing	3
23837	5960	takeing	0
23838	5960	taking	1
23839	5960	takking	2
23840	5960	takiing	3
23841	5961	haveing	0
23842	5961	having	1
23843	5961	havving	2
23844	5961	haviing	3
23845	5962	liveing	0
23846	5962	living	1
23847	5962	livving	2
23848	5962	liviing	3
23849	5963	giveing	0
23850	5963	giving	1
23851	5963	givving	2
23852	5963	giviing	3
23853	5964	useing	0
23854	5964	using	1
23855	5964	ussing	2
23856	5964	usiing	3
23857	5965	danceing	0
23858	5965	dancing	1
23859	5965	danccing	2
23860	5965	danciing	3
23861	5966	driveing	0
23862	5966	driving	1
23863	5966	drivving	2
23864	5966	driviing	3
23865	5967	rideing	0
23866	5967	riding	1
23867	5967	ridding	2
23868	5967	ridiing	3
23869	5968	smileing	0
23870	5968	smiling	1
23871	5968	smilling	2
23872	5968	smiliing	3
23873	5969	leaveing	0
23874	5969	leaving	1
23875	5969	leavving	2
23876	5969	leaviing	3
23877	5970	arriveing	0
23878	5970	arriving	1
23879	5970	arrivving	2
23880	5970	arriviing	3
23881	5971	closeing	0
23882	5971	closing	1
23883	5971	clossing	2
23884	5971	closiing	3
23885	5972	hopeing	0
23886	5972	hoping	1
23887	5972	hopping	2
23888	5972	hopiing	3
23889	5973	saveing	0
23890	5973	saving	1
23891	5973	savving	2
23892	5973	saviing	3
23893	5974	moveing	0
23894	5974	moving	1
23895	5974	movving	2
23896	5974	moviing	3
23897	5975	changeing	0
23898	5975	changing	1
23899	5975	changgin	2
23900	5975	changiing	3
23901	5976	loseing	0
23902	5976	losing	1
23903	5976	lossing	2
23904	5976	losiing	3
23905	5977	runing	0
23906	5977	running	1
23907	5977	runniing	2
23908	5977	runnin	3
23909	5978	siting	0
23910	5978	sitting	1
23911	5978	sittiing	2
23912	5978	sittin	3
23913	5979	stoping	0
23914	5979	stopping	1
23915	5979	stoppiing	2
23916	5979	stoppin	3
23917	5980	swiming	0
23918	5980	swimming	1
23919	5980	swimmiing	2
23920	5980	swimmin	3
23921	5981	geting	0
23922	5981	getting	1
23923	5981	gettiing	2
23924	5981	gettin	3
23925	5982	puting	0
23926	5982	putting	1
23927	5982	puttiing	2
23928	5982	puttin	3
23929	5983	cuting	0
23930	5983	cutting	1
23931	5983	cuttiing	2
23932	5983	cuttin	3
23933	5984	planing	0
23934	5984	planning	1
23935	5984	planniing	2
23936	5984	plannin	3
23937	5985	begining	0
23938	5985	beginning	1
23939	5985	beginniing	2
23940	5985	beginnin	3
23941	5986	forgeting	0
23942	5986	forgetting	1
23943	5986	forgettiing	2
23944	5986	forgettin	3
23945	5987	opening	0
23946	5987	openning	1
23947	5987	openiing	2
23948	5987	openin	3
23949	5988	happening	0
23950	5988	happenning	1
23951	5988	happeniing	2
23952	5988	happenin	3
23953	5989	listening	0
23954	5989	listenning	1
23955	5989	listeniing	2
23956	5989	listenin	3
23957	5990	visiting	0
23958	5990	visitting	1
23959	5990	visitiing	2
23960	5990	visitin	3
23961	5991	wining	0
23962	5991	winning	1
23963	5991	winniing	2
23964	5991	winnin	3
23965	5992	seting	0
23966	5992	setting	1
23967	5992	settiing	2
23968	5992	settin	3
23969	5993	leting	0
23970	5993	letting	1
23971	5993	lettiing	2
23972	5993	lettin	3
23973	5994	shoping	0
23974	5994	shopping	1
23975	5994	shoppiing	2
23976	5994	shoppin	3
23977	5995	droping	0
23978	5995	dropping	1
23979	5995	droppiing	2
23980	5995	droppin	3
23981	5996	entering	0
23982	5996	enterring	1
23983	5996	enteriing	2
23984	5996	enterin	3
23985	5997	am	0
23986	5997	is	1
23987	5997	are	2
23988	5997	be	3
23989	5998	am	0
23990	5998	is	1
23991	5998	are	2
23992	5998	be	3
23993	5999	am	0
23994	5999	is	1
23995	5999	are	2
23996	5999	be	3
23997	6000	am	0
23998	6000	is	1
23999	6000	are	2
24000	6000	be	3
24001	6001	am	0
24002	6001	is	1
24003	6001	are	2
24004	6001	be	3
24005	6002	am	0
24006	6002	is	1
24007	6002	are	2
24008	6002	be	3
24009	6003	am	0
24010	6003	is	1
24011	6003	are	2
24012	6003	be	3
24013	6004	am	0
24014	6004	is	1
24015	6004	are	2
24016	6004	be	3
24017	6005	am	0
24018	6005	is	1
24019	6005	are	2
24020	6005	be	3
24021	6006	am	0
24022	6006	is	1
24023	6006	are	2
24024	6006	be	3
24025	6007	am	0
24026	6007	is	1
24027	6007	are	2
24028	6007	be	3
24029	6008	am	0
24030	6008	is	1
24031	6008	are	2
24032	6008	be	3
24033	6009	am	0
24034	6009	is	1
24035	6009	are	2
24036	6009	be	3
24037	6010	am	0
24038	6010	is	1
24039	6010	are	2
24040	6010	be	3
24041	6011	am	0
24042	6011	is	1
24043	6011	are	2
24044	6011	be	3
24045	6012	am	0
24046	6012	is	1
24047	6012	are	2
24048	6012	be	3
24049	6013	am	0
24050	6013	is	1
24051	6013	are	2
24052	6013	be	3
24053	6014	am	0
24054	6014	is	1
24055	6014	are	2
24056	6014	be	3
24057	6015	am	0
24058	6015	is	1
24059	6015	are	2
24060	6015	be	3
24061	6016	am	0
24062	6016	is	1
24063	6016	are	2
24064	6016	be	3
24065	6017	am	0
24066	6017	is	1
24067	6017	are	2
24068	6017	be	3
24069	6018	am	0
24070	6018	is	1
24071	6018	are	2
24072	6018	be	3
24073	6019	am	0
24074	6019	is	1
24075	6019	are	2
24076	6019	be	3
24077	6020	am	0
24078	6020	is	1
24079	6020	are	2
24080	6020	be	3
24081	6021	am	0
24082	6021	is	1
24083	6021	are	2
24084	6021	be	3
24085	6022	am	0
24086	6022	is	1
24087	6022	are	2
24088	6022	be	3
24089	6023	am	0
24090	6023	is	1
24091	6023	are	2
24092	6023	be	3
24093	6024	am	0
24094	6024	is	1
24095	6024	are	2
24096	6024	be	3
24097	6025	am	0
24098	6025	is	1
24099	6025	are	2
24100	6025	be	3
24101	6026	am	0
24102	6026	is	1
24103	6026	are	2
24104	6026	be	3
24105	6027	am	0
24106	6027	is	1
24107	6027	are	2
24108	6027	be	3
24109	6028	am	0
24110	6028	is	1
24111	6028	are	2
24112	6028	be	3
24113	6029	am	0
24114	6029	is	1
24115	6029	are	2
24116	6029	be	3
24117	6030	am	0
24118	6030	is	1
24119	6030	are	2
24120	6030	be	3
24121	6031	am	0
24122	6031	is	1
24123	6031	are	2
24124	6031	be	3
24125	6032	am	0
24126	6032	is	1
24127	6032	are	2
24128	6032	be	3
24129	6033	am	0
24130	6033	is	1
24131	6033	are	2
24132	6033	be	3
24133	6034	am	0
24134	6034	is	1
24135	6034	are	2
24136	6034	be	3
24137	6035	am	0
24138	6035	is	1
24139	6035	are	2
24140	6035	be	3
24141	6036	am	0
24142	6036	is	1
24143	6036	are	2
24144	6036	be	3
24145	6037	am	0
24146	6037	is	1
24147	6037	are	2
24148	6037	be	3
24149	6038	am	0
24150	6038	is	1
24151	6038	are	2
24152	6038	be	3
24153	6039	am	0
24154	6039	is	1
24155	6039	are	2
24156	6039	be	3
24157	6040	am	0
24158	6040	is	1
24159	6040	are	2
24160	6040	be	3
24161	6041	am	0
24162	6041	is	1
24163	6041	are	2
24164	6041	be	3
24165	6042	am	0
24166	6042	is	1
24167	6042	are	2
24168	6042	be	3
24169	6043	am	0
24170	6043	is	1
24171	6043	are	2
24172	6043	be	3
24173	6044	am	0
24174	6044	not	1
24175	6044	are	2
24176	6044	no	3
24177	6045	isn't	0
24178	6045	aren't	1
24179	6045	amn't	2
24180	6045	not	3
24181	6046	isn't	0
24182	6046	aren't	1
24183	6046	amn't	2
24184	6046	not	3
24185	6047	isn't	0
24186	6047	aren't	1
24187	6047	amn't	2
24188	6047	not	3
24189	6048	isn't	0
24190	6048	aren't	1
24191	6048	amn't	2
24192	6048	not	3
24193	6049	isn't	0
24194	6049	aren't	1
24195	6049	amn't	2
24196	6049	not	3
24197	6050	isn't	0
24198	6050	aren't	1
24199	6050	amn't	2
24200	6050	not	3
24201	6051	'm not	0
24202	6051	isn't	1
24203	6051	aren't	2
24204	6051	amn't	3
24205	6052	'm not	0
24206	6052	isn't	1
24207	6052	aren't	2
24208	6052	amn't	3
24209	6053	'm not	0
24210	6053	isn't	1
24211	6053	aren't	2
24212	6053	amn't	3
24213	6054	'm not	0
24214	6054	isn't	1
24215	6054	aren't	2
24216	6054	amn't	3
24217	6055	'm not	0
24218	6055	isn't	1
24219	6055	aren't	2
24220	6055	amn't	3
24221	6056	'm not	0
24222	6056	isn't	1
24223	6056	aren't	2
24224	6056	amn't	3
24225	6057	Am	0
24226	6057	Is	1
24227	6057	Are	2
24228	6057	Do	3
24229	6058	Am	0
24230	6058	Is	1
24231	6058	Are	2
24232	6058	Does	3
24233	6059	Am	0
24234	6059	Is	1
24235	6059	Are	2
24236	6059	Do	3
24237	6060	Am	0
24238	6060	Is	1
24239	6060	Are	2
24240	6060	Does	3
24241	6061	Am	0
24242	6061	Is	1
24243	6061	Are	2
24244	6061	Do	3
24245	6062	Am	0
24246	6062	Is	1
24247	6062	Are	2
24248	6062	Do	3
24249	6063	Am	0
24250	6063	Is	1
24251	6063	Are	2
24252	6063	Does	3
24253	6064	Am	0
24254	6064	Is	1
24255	6064	Are	2
24256	6064	Do	3
24257	6065	Am	0
24258	6065	Is	1
24259	6065	Are	2
24260	6065	Does	3
24261	6066	Am	0
24262	6066	Is	1
24263	6066	Are	2
24264	6066	Do	3
24265	6067	Am	0
24266	6067	Is	1
24267	6067	Are	2
24268	6067	Does	3
24269	6068	Am	0
24270	6068	Is	1
24271	6068	Are	2
24272	6068	Do	3
24273	6069	Am	0
24274	6069	Is	1
24275	6069	Are	2
24276	6069	Do	3
24277	6070	Am	0
24278	6070	Is	1
24279	6070	Are	2
24280	6070	Does	3
24281	6071	Am	0
24282	6071	Is	1
24283	6071	Are	2
24284	6071	Do	3
24285	6072	Am	0
24286	6072	Is	1
24287	6072	Are	2
24288	6072	Does	3
24289	6073	Am	0
24290	6073	Is	1
24291	6073	Are	2
24292	6073	Do	3
24293	6074	Am	0
24294	6074	Is	1
24295	6074	Are	2
24296	6074	Does	3
24297	6075	Am	0
24298	6075	Is	1
24299	6075	Are	2
24300	6075	Do	3
24301	6076	Am	0
24302	6076	Is	1
24303	6076	Are	2
24304	6076	Do	3
24305	6077	study	0
24306	6077	am studying	1
24307	6077	studying	2
24308	6077	studies	3
24309	6078	study	0
24310	6078	am studying	1
24311	6078	studying	2
24312	6078	studies	3
24313	6079	play	0
24314	6079	is playing	1
24315	6079	playing	2
24316	6079	plays	3
24317	6080	play	0
24318	6080	is playing	1
24319	6080	playing	2
24320	6080	plays	3
24321	6081	live	0
24322	6081	are living	1
24323	6081	living	2
24324	6081	lives	3
24325	6082	stay	0
24326	6082	are staying	1
24327	6082	staying	2
24328	6082	stays	3
24329	6083	go	0
24330	6083	is going	1
24331	6083	going	2
24332	6083	goes	3
24333	6084	go	0
24334	6084	is going	1
24335	6084	going	2
24336	6084	goes	3
24337	6085	like	0
24338	6085	are liking	1
24339	6085	liking	2
24340	6085	likes	3
24341	6086	have	0
24342	6086	are having	1
24343	6086	having	2
24344	6086	has	3
24345	6087	drink	0
24346	6087	am drinking	1
24347	6087	drinking	2
24348	6087	drinks	3
24349	6088	drink	0
24350	6088	am drinking	1
24351	6088	drinking	2
24352	6088	drinks	3
24353	6089	watch	0
24354	6089	is watching	1
24355	6089	watching	2
24356	6089	watches	3
24357	6090	watch	0
24358	6090	is watching	1
24359	6090	watching	2
24360	6090	watches	3
24361	6091	wake up	0
24362	6091	are waking up	1
24363	6091	waking up	2
24364	6091	wakes up	3
24365	6092	wake	0
24366	6092	are waking	1
24367	6092	waking	2
24368	6092	wakes	3
24369	6093	listen	0
24370	6093	is listening	1
24371	6093	listening	2
24372	6093	listens	3
24373	6094	listen	0
24374	6094	is listening	1
24375	6094	listening	2
24376	6094	listens	3
24377	6095	read	0
24378	6095	am reading	1
24379	6095	reading	2
24380	6095	reads	3
24381	6096	read	0
24382	6096	am reading	1
24383	6096	reading	2
24384	6096	reads	3
24385	6097	now	0
24386	6097	every day	1
24387	6097	always	2
24388	6097	usually	3
24389	6098	now	0
24390	6098	every day	1
24391	6098	at the moment	2
24392	6098	right now	3
24393	6099	always	0
24394	6099	often	1
24395	6099	at the moment	2
24396	6099	usually	3
24397	6100	now	0
24398	6100	right now	1
24399	6100	at the moment	2
24400	6100	every day	3
24401	6101	am	0
24402	6101	is	1
24403	6101	are	2
24404	6101	do	3
24405	6102	am	0
24406	6102	is	1
24407	6102	are	2
24408	6102	X	3
24409	6103	is	0
24410	6103	does	1
24411	6103	rains	2
24412	6103	rain	3
24413	6104	is	0
24414	6104	does	1
24415	6104	are	2
24416	6104	always	3
24417	6105	is	0
24418	6105	does	1
24419	6105	sings	2
24420	6105	sing	3
24421	6106	are	0
24422	6106	is	1
24423	6106	staying	2
24424	6106	stay	3
24425	6107	read	0
24426	6107	reading	1
24427	6107	reads	2
24428	6107	to read	3
24429	6108	study	0
24430	6108	is studying	1
24431	6108	studies	2
24432	6108	studying	3
24433	6109	have	0
24434	6109	having	1
24435	6109	has	2
24436	6109	to have	3
24437	6110	eat	0
24438	6110	is eating	1
24439	6110	eats	2
24440	6110	eating	3
24441	6111	go	0
24442	6111	going	1
24443	6111	goes	2
24444	6111	to go	3
24445	6112	drink	0
24446	6112	am drinking	1
24447	6112	drinks	2
24448	6112	drinking	3
24449	6113	talk	0
24450	6113	talking	1
24451	6113	talks	2
24452	6113	to talk	3
24453	6114	play	0
24454	6114	are playing	1
24455	6114	plays	2
24456	6114	playing	3
24457	6115	do	0
24458	6115	doing	1
24459	6115	does	2
24460	6115	to do	3
24461	6116	are	0
24462	6116	is	1
24463	6116	being	2
24464	6116	be	3
24465	6117	am	0
24466	6117	is	1
24467	6117	are	2
24468	6117	do	3
24469	6118	am	0
24470	6118	is	1
24471	6118	are	2
24472	6118	do	3
24473	6119	am	0
24474	6119	is	1
24475	6119	are	2
24476	6119	does	3
24477	6120	am	0
24478	6120	is	1
24479	6120	are	2
24480	6120	do	3
24481	6121	am	0
24482	6121	is	1
24483	6121	are	2
24484	6121	does	3
24485	6122	Am	0
24486	6122	Is	1
24487	6122	Are	2
24488	6122	Does	3
24489	6123	am	0
24490	6123	is	1
24491	6123	are	2
24492	6123	do	3
24493	6124	am	0
24494	6124	is	1
24495	6124	are	2
24496	6124	do	3
24497	6125	Am	0
24498	6125	Is	1
24499	6125	Are	2
24500	6125	Do	3
24501	6126	am	0
24502	6126	is	1
24503	6126	are	2
24504	6126	does	3
24505	6127	makeing	0
24506	6127	making	1
24507	6127	makking	2
24508	6127	makiing	3
24509	6128	runing	0
24510	6128	running	1
24511	6128	runniing	2
24512	6128	runnin	3
24513	6129	am	0
24514	6129	am liking	1
24515	6129	like	2
24516	6129	liking	3
24517	6130	go	0
24518	6130	is going	1
24519	6130	goes	2
24520	6130	going	3
24521	6131	leave	0
24522	6131	leaving	1
24523	6131	leaves	2
24524	6131	to leave	3
24525	6132	wake up	0
24526	6132	is waking up	1
24527	6132	wakes up	2
24528	6132	waking up	3
24529	6133	is	0
24530	6133	does	1
24531	6133	comes	2
24532	6133	come	3
24533	6134	drink	0
24534	6134	are drinking	1
24535	6134	drinks	2
24536	6134	drinking	3
24537	6135	write	0
24538	6135	writing	1
24539	6135	writes	2
24540	6135	to write	3
24541	6136	eat	0
24542	6136	are eating	1
24543	6136	eats	2
24544	6136	eating	3
24545	6138	will	0
24546	6138	goes	1
24547	6138	went	2
24548	6138	going	3
24549	6139	will	0
24550	6139	calls	1
24551	6139	called	2
24552	6139	calling	3
24553	6140	will	0
24554	6140	helps	1
24555	6140	helped	2
24556	6140	helping	3
24557	6141	will	0
24558	6141	travels	1
24559	6141	traveled	2
24560	6141	traveling	3
24561	6142	will	0
24562	6142	studies	1
24563	6142	studied	2
24564	6142	studying	3
24565	6143	will	0
24566	6143	sees	1
24567	6143	saw	2
24568	6143	seeing	3
24569	6144	will	0
24570	6144	rains	1
24571	6144	rained	2
24572	6144	raining	3
24573	6145	will	0
24574	6145	works	1
24575	6145	worked	2
24576	6145	working	3
24577	6146	will	0
24578	6146	comes	1
24579	6146	came	2
24580	6146	coming	3
24581	6147	will	0
24582	6147	buys	1
24583	6147	bought	2
24584	6147	buying	3
24585	6148	will	0
24586	6148	finishes	1
24587	6148	finished	2
24588	6148	finishing	3
24589	6149	will	0
24590	6149	visits	1
24591	6149	visited	2
24592	6149	visiting	3
24593	6150	will	0
24594	6150	learns	1
24595	6150	learned	2
24596	6150	learning	3
24597	6151	will	0
24598	6151	is	1
24599	6151	was	2
24600	6151	being	3
24601	6152	will	0
24602	6152	makes	1
24603	6152	made	2
24604	6152	making	3
24605	6153	will	0
24606	6153	writes	1
24607	6153	wrote	2
24608	6153	writing	3
24609	6154	will	0
24610	6154	moves	1
24611	6154	moved	2
24612	6154	moving	3
24613	6155	will	0
24614	6155	meets	1
24615	6155	met	2
24616	6155	meeting	3
24617	6156	will	0
24618	6156	gets	1
24619	6156	got	2
24620	6156	getting	3
24621	6157	will	0
24622	6157	are	1
24623	6157	were	2
24624	6157	being	3
24625	6158	will	0
24626	6158	do	1
24627	6158	am	2
24628	6158	is	3
24629	6159	will	0
24630	6159	does	1
24631	6159	is	2
24632	6159	are	3
24633	6160	will	0
24634	6160	do	1
24635	6160	are	2
24636	6160	is	3
24637	6161	will	0
24638	6161	do	1
24639	6161	are	2
24640	6161	is	3
24641	6162	will	0
24642	6162	does	1
24643	6162	is	2
24644	6162	are	3
24645	6163	will	0
24646	6163	do	1
24647	6163	are	2
24648	6163	is	3
24649	6164	will	0
24650	6164	does	1
24651	6164	is	2
24652	6164	are	3
24653	6165	will	0
24654	6165	do	1
24655	6165	am	2
24656	6165	is	3
24657	6166	will	0
24658	6166	does	1
24659	6166	is	2
24660	6166	are	3
24661	6167	will	0
24662	6167	do	1
24663	6167	are	2
24664	6167	is	3
24665	6168	will	0
24666	6168	do	1
24667	6168	are	2
24668	6168	is	3
24669	6169	will	0
24670	6169	does	1
24671	6169	is	2
24672	6169	are	3
24673	6170	will	0
24674	6170	do	1
24675	6170	are	2
24676	6170	is	3
24677	6171	will	0
24678	6171	does	1
24679	6171	is	2
24680	6171	are	3
24681	6172	will	0
24682	6172	do	1
24683	6172	am	2
24684	6172	is	3
24685	6173	will	0
24686	6173	does	1
24687	6173	is	2
24688	6173	are	3
24689	6174	will	0
24690	6174	do	1
24691	6174	are	2
24692	6174	is	3
24693	6175	will	0
24694	6175	do	1
24695	6175	are	2
24696	6175	is	3
24697	6176	will	0
24698	6176	does	1
24699	6176	is	2
24700	6176	are	3
24701	6177	will	0
24702	6177	do	1
24703	6177	are	2
24704	6177	is	3
24705	6178	will	0
24706	6178	won't	1
24707	6178	do	2
24708	6178	don't	3
24709	6179	will	0
24710	6179	won't	1
24711	6179	does	2
24712	6179	doesn't	3
24713	6180	will	0
24714	6180	won't	1
24715	6180	do	2
24716	6180	don't	3
24717	6181	will	0
24718	6181	won't	1
24719	6181	do	2
24720	6181	don't	3
24721	6182	will	0
24722	6182	won't	1
24723	6182	does	2
24724	6182	doesn't	3
24725	6183	will	0
24726	6183	won't	1
24727	6183	do	2
24728	6183	don't	3
24729	6184	will	0
24730	6184	won't	1
24731	6184	is	2
24732	6184	isn't	3
24733	6185	will	0
24734	6185	won't	1
24735	6185	do	2
24736	6185	don't	3
24737	6186	will	0
24738	6186	won't	1
24739	6186	does	2
24740	6186	doesn't	3
24741	6187	will	0
24742	6187	won't	1
24743	6187	do	2
24744	6187	don't	3
24745	6188	will	0
24746	6188	won't	1
24747	6188	do	2
24748	6188	don't	3
24749	6189	will	0
24750	6189	won't	1
24751	6189	does	2
24752	6189	doesn't	3
24753	6190	will	0
24754	6190	won't	1
24755	6190	do	2
24756	6190	don't	3
24757	6191	will	0
24758	6191	won't	1
24759	6191	does	2
24760	6191	doesn't	3
24761	6192	will	0
24762	6192	won't	1
24763	6192	do	2
24764	6192	don't	3
24765	6193	will	0
24766	6193	won't	1
24767	6193	does	2
24768	6193	doesn't	3
24769	6194	will	0
24770	6194	won't	1
24771	6194	do	2
24772	6194	don't	3
24773	6195	will	0
24774	6195	won't	1
24775	6195	do	2
24776	6195	don't	3
24777	6196	will	0
24778	6196	won't	1
24779	6196	does	2
24780	6196	doesn't	3
24781	6197	will	0
24782	6197	won't	1
24783	6197	are	2
24784	6197	aren't	3
24785	6198	tomorrow	0
24786	6198	yesterday	1
24787	6198	now	2
24788	6198	always	3
24789	6199	later	0
24790	6199	ago	1
24791	6199	before	2
24792	6199	already	3
24793	6200	next	0
24794	6200	last	1
24795	6200	every	2
24796	6200	this	3
24797	6201	in	0
24798	6201	ago	1
24799	6201	for	2
24800	6201	since	3
24801	6202	next	0
24802	6202	last	1
24803	6202	every	2
24804	6202	ago	3
24805	6203	soon	0
24806	6203	yesterday	1
24807	6203	ago	2
24808	6203	before	3
24809	6204	tonight	0
24810	6204	yesterday	1
24811	6204	ago	2
24812	6204	before	3
24813	6205	next	0
24814	6205	last	1
24815	6205	ago	2
24816	6205	every	3
24817	6206	in	0
24818	6206	at	1
24819	6206	on	2
24820	6206	ago	3
24821	6207	next	0
24822	6207	last	1
24823	6207	ago	2
24824	6207	every	3
24825	6208	next	0
24826	6208	last	1
24827	6208	ago	2
24828	6208	every	3
24829	6209	in	0
24830	6209	ago	1
24831	6209	for	2
24832	6209	since	3
24833	6210	soon	0
24834	6210	yesterday	1
24835	6210	ago	2
24836	6210	before	3
24837	6211	tomorrow	0
24838	6211	yesterday	1
24839	6211	ago	2
24840	6211	before	3
24841	6212	later	0
24842	6212	ago	1
24843	6212	before	2
24844	6212	yesterday	3
24845	6213	next	0
24846	6213	last	1
24847	6213	ago	2
24848	6213	every	3
24849	6214	in	0
24850	6214	ago	1
24851	6214	for	2
24852	6214	since	3
24853	6215	soon	0
24854	6215	yesterday	1
24855	6215	ago	2
24856	6215	before	3
24857	6216	tonight	0
24858	6216	yesterday	1
24859	6216	ago	2
24860	6216	before	3
24861	6217	next	0
24862	6217	last	1
24863	6217	ago	2
24864	6217	every	3
24865	6218	will	0
24866	6218	do	1
24867	6218	am	2
24868	6218	can	3
24869	6219	won't	0
24870	6219	doesn't	1
24871	6219	isn't	2
24872	6219	can't	3
24873	6220	will	0
24874	6220	do	1
24875	6220	are	2
24876	6220	can	3
24877	6221	won't	0
24878	6221	don't	1
24879	6221	aren't	2
24880	6221	can't	3
24881	6222	will	0
24882	6222	does	1
24883	6222	is	2
24884	6222	can	3
24885	6223	won't	0
24886	6223	don't	1
24887	6223	am not	2
24888	6223	can't	3
24889	6224	will	0
24890	6224	does	1
24891	6224	is	2
24892	6224	can	3
24893	6225	won't	0
24894	6225	don't	1
24895	6225	aren't	2
24896	6225	can't	3
24897	6226	will	0
24898	6226	does	1
24899	6226	is	2
24900	6226	can	3
24901	6227	won't	0
24902	6227	don't	1
24903	6227	aren't	2
24904	6227	can't	3
24905	6228	will	0
24906	6228	do	1
24907	6228	are	2
24908	6228	can	3
24909	6229	won't	0
24910	6229	doesn't	1
24911	6229	isn't	2
24912	6229	can't	3
24913	6230	will	0
24914	6230	do	1
24915	6230	am	2
24916	6230	can	3
24917	6231	won't	0
24918	6231	doesn't	1
24919	6231	isn't	2
24920	6231	can't	3
24921	6232	will	0
24922	6232	do	1
24923	6232	are	2
24924	6232	can	3
24925	6233	won't	0
24926	6233	doesn't	1
24927	6233	isn't	2
24928	6233	can't	3
24929	6234	will	0
24930	6234	do	1
24931	6234	are	2
24932	6234	can	3
24933	6235	won't	0
24934	6235	don't	1
24935	6235	aren't	2
24936	6235	can't	3
24937	6236	will	0
24938	6236	does	1
24939	6236	is	2
24940	6236	can	3
24941	6237	won't	0
24942	6237	don't	1
24943	6237	am not	2
24944	6237	can't	3
24945	6238	go	0
24946	6238	goes	1
24947	6238	going	2
24948	6238	to go	3
24949	6239	call	0
24950	6239	calls	1
24951	6239	calling	2
24952	6239	to call	3
24953	6240	help	0
24954	6240	helps	1
24955	6240	helping	2
24956	6240	to help	3
24957	6241	travel	0
24958	6241	travels	1
24959	6241	traveling	2
24960	6241	to travel	3
24961	6242	study	0
24962	6242	studies	1
24963	6242	studying	2
24964	6242	to study	3
24965	6243	see	0
24966	6243	sees	1
24967	6243	seeing	2
24968	6243	to see	3
24969	6244	rain	0
24970	6244	rains	1
24971	6244	raining	2
24972	6244	to rain	3
24973	6245	work	0
24974	6245	works	1
24975	6245	working	2
24976	6245	to work	3
24977	6246	come	0
24978	6246	comes	1
24979	6246	coming	2
24980	6246	to come	3
24981	6247	buy	0
24982	6247	buys	1
24983	6247	buying	2
24984	6247	to buy	3
24985	6248	finish	0
24986	6248	finishes	1
24987	6248	finishing	2
24988	6248	to finish	3
24989	6249	visit	0
24990	6249	visits	1
24991	6249	visiting	2
24992	6249	to visit	3
24993	6250	learn	0
24994	6250	learns	1
24995	6250	learning	2
24996	6250	to learn	3
24997	6251	be	0
24998	6251	is	1
24999	6251	being	2
25000	6251	to be	3
25001	6252	make	0
25002	6252	makes	1
25003	6252	making	2
25004	6252	to make	3
25005	6253	write	0
25006	6253	writes	1
25007	6253	writing	2
25008	6253	to write	3
25009	6254	move	0
25010	6254	moves	1
25011	6254	moving	2
25012	6254	to move	3
25013	6255	meet	0
25014	6255	meets	1
25015	6255	meeting	2
25016	6255	to meet	3
25017	6256	get	0
25018	6256	gets	1
25019	6256	getting	2
25020	6256	to get	3
25021	6257	be	0
25022	6257	are	1
25023	6257	being	2
25024	6257	to be	3
25025	6258	I will go to school	0
25026	6258	I will going to school	1
25027	6258	I go to school	2
25028	6258	I will goes to school	3
25029	6259	She will call you	0
25030	6259	She will calling you	1
25031	6259	She calls you	2
25032	6259	She will to call you	3
25033	6260	They will help us	0
25034	6260	They will helping us	1
25035	6260	They helps us	2
25036	6260	They will to help us	3
25037	6261	He won't go there	0
25038	6261	He won't going there	1
25039	6261	He not go there	2
25040	6261	He won't to go there	3
25041	6262	Will she come?	0
25042	6262	Will she coming?	1
25043	6262	Will she to come?	2
25044	6263	I will not work	0
25045	6263	I will not working	1
25046	6263	I not work	2
25047	6263	I do not work	3
25048	6264	They will travel	0
25049	6264	They will to travel	1
25050	6264	They travel	2
25051	6264	They will travels	3
25052	6265	Will he go?	0
25053	6265	Will he going?	1
25054	6265	Will he to go?	2
25055	6266	She won't come	0
25056	6266	She won't to come	1
25057	6266	She doesn't come	2
25058	6266	She won't comes	3
25059	6267	We will meet you	0
25060	6267	We will meeting you	1
25061	6267	We meets you	2
25062	6267	We will to meet you	3
25063	6268	I will study	0
25064	6268	I will to study	1
25065	6268	I study	2
25066	6268	I will studies	3
25067	6269	He will visit	0
25068	6269	He will visiting	1
25069	6269	He visits	2
25070	6269	He will visits	3
25071	6270	You will go	0
25072	6270	You will be go	1
25073	6270	You goes	2
25074	6270	You will to go	3
25075	6271	It will rain	0
25076	6271	It will raining	1
25077	6271	It rains	2
25078	6271	It will to rain	3
25079	6272	Will they help?	0
25080	6272	Will they helping?	1
25081	6272	Will they to help?	2
25082	6273	She will not come	0
25083	6273	She will not coming	1
25084	6273	She not comes	2
25085	6273	She will not to come	3
25086	6274	I will see you	0
25087	6274	I will to see you	1
25088	6274	I see you	2
25089	6274	I will sees you	3
25090	6275	They won't help	0
25091	6275	They won't helping	1
25092	6275	They not help	2
25093	6275	They won't helps	3
25094	6276	Will you go?	0
25095	6276	Will you to go?	1
25096	6276	Will you goes?	2
25097	6277	He will come	0
25098	6277	He will to come	1
25099	6277	He comes	2
25100	6277	He will comes	3
25101	6278	will go	0
25102	6278	go	1
25103	6278	went	2
25104	6278	going	3
25105	6279	won't	0
25106	6279	doesn't	1
25107	6279	isn't	2
25108	6279	don't	3
25109	6280	will	0
25110	6280	do	1
25111	6280	are	2
25112	6280	is	3
25113	6281	won't	0
25114	6281	doesn't	1
25115	6281	isn't	2
25116	6281	don't	3
25117	6282	will	0
25118	6282	does	1
25119	6282	is	2
25120	6282	do	3
25121	6283	won't	0
25122	6283	don't	1
25123	6283	am not	2
25124	6283	isn't	3
25125	6284	will	0
25126	6284	do	1
25127	6284	are	2
25128	6284	is	3
25129	6285	won't	0
25130	6285	don't	1
25131	6285	aren't	2
25132	6285	isn't	3
25133	6286	will	0
25134	6286	do	1
25135	6286	are	2
25136	6286	is	3
25137	6287	won't	0
25138	6287	doesn't	1
25139	6287	isn't	2
25140	6287	don't	3
25141	6288	will	0
25142	6288	does	1
25143	6288	is	2
25144	6288	do	3
25145	6289	won't	0
25146	6289	don't	1
25147	6289	aren't	2
25148	6289	isn't	3
25149	6290	will	0
25150	6290	does	1
25151	6290	is	2
25152	6290	do	3
25153	6291	won't	0
25154	6291	don't	1
25155	6291	aren't	2
25156	6291	isn't	3
25157	6292	will go	0
25158	6292	will goes	1
25159	6292	will to go	2
25160	6292	will going	3
25161	6293	will, call	0
25162	6293	will, calls	1
25163	6293	will, to call	2
25164	6293	will, calling	3
25165	6294	Will, help	0
25166	6294	Will, helps	1
25167	6294	Will, to help	2
25168	6294	Will, helping	3
25169	6295	will travel	0
25170	6295	will travels	1
25171	6295	will to travel	2
25172	6295	will traveling	3
25173	6296	won't study	0
25174	6296	won't studies	1
25175	6296	won't to study	2
25176	6296	won't studying	3
25177	6297	Will, see	0
25178	6297	Will, sees	1
25179	6297	Will, to see	2
25180	6297	Will, seeing	3
25181	6298	will rain	0
25182	6298	will rains	1
25183	6298	will to rain	2
25184	6298	will raining	3
25185	6299	won't work	0
25186	6299	won't works	1
25187	6299	won't to work	2
25188	6299	won't working	3
25189	6300	Will, come	0
25190	6300	Will, comes	1
25191	6300	Will, to come	2
25192	6300	Will, coming	3
25193	6301	will buy	0
25194	6301	will buys	1
25195	6301	will to buy	2
25196	6301	will buying	3
25197	6302	won't finish	0
25198	6302	won't finishes	1
25199	6302	won't to finish	2
25200	6302	won't finishing	3
25201	6303	Will, visit	0
25202	6303	Will, visits	1
25203	6303	Will, to visit	2
25204	6303	Will, visiting	3
25205	6304	will learn	0
25206	6304	will learns	1
25207	6304	will to learn	2
25208	6304	will learning	3
25209	6305	won't be	0
25210	6305	won't is	1
25211	6305	won't to be	2
25212	6305	won't being	3
25213	6306	Will, make	0
25214	6306	Will, makes	1
25215	6306	Will, to make	2
25216	6306	Will, making	3
25217	6307	will write	0
25218	6307	will writes	1
25219	6307	will to write	2
25220	6307	will writing	3
25221	6308	won't move	0
25222	6308	won't moves	1
25223	6308	won't to move	2
25224	6308	won't moving	3
25225	6309	Will, meet	0
25226	6309	Will, meets	1
25227	6309	Will, to meet	2
25228	6309	Will, meeting	3
25229	6310	will get	0
25230	6310	will gets	1
25231	6310	will to get	2
25232	6310	will getting	3
25233	6311	won't be	0
25234	6311	won't is	1
25235	6311	won't to be	2
25236	6311	won't being	3
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: doc
--

COPY public.questions (id, topic_id, question_text, correct_index, explanation, display_order, created_at, quiz_set) FROM stdin;
1	alphabet-pronunciation	Что в английском языке чаще всего определяет смысл предложения?	2	В английском языке порядок слов определяет смысл предложения, в отличие от русского, где важны окончания.	0	2025-12-19 02:31:31.784783+03	1
2	alphabet-pronunciation	Какая базовая структура английского предложения считается правильной?	1	Базовая структура: Подлежащее (кто) → Глагол (что делает) → Остальное.	1	2025-12-19 02:31:31.784783+03	1
3	alphabet-pronunciation	Какое минимальное количество обязательных элементов есть в английском предложении?	1	Минимальное английское предложение состоит из подлежащего и глагола.	2	2025-12-19 02:31:31.784783+03	1
4	alphabet-pronunciation	Почему нельзя сказать просто: Student?	2	В английском предложении всегда должен быть глагол. Правильно: I am a student.	3	2025-12-19 02:31:31.784783+03	1
5	alphabet-pronunciation	Как правильно сказать «Я студент»?	3	Правильный вариант включает глагол 'am' и артикль 'a': I am a student.	4	2025-12-19 02:31:31.784783+03	1
6	alphabet-pronunciation	Какой глагол используется, когда нет действия, но есть состояние или описание?	2	Глагол 'to be' используется для описания состояния, местоположения или идентификации.	5	2025-12-19 02:31:31.784783+03	1
7	alphabet-pronunciation	Выбери правильное предложение:	1	Правильный порядок: подлежащее + глагол to be + прилагательное.	6	2025-12-19 02:31:31.784783+03	1
8	alphabet-pronunciation	Почему в английском нельзя «выкинуть» глагол из предложения?	2	Глагол — обязательный элемент английского предложения, без него предложение грамматически невозможно.	7	2025-12-19 02:31:31.784783+03	1
9	alphabet-pronunciation	Как правильно сказать «Холодно»?	3	Нужно использовать формальное подлежащее 'it' и глагол 'is': It is cold.	8	2025-12-19 02:31:31.784783+03	1
10	alphabet-pronunciation	Что обязательно должно быть в английском предложении, даже если по-русски этого нет?	2	Глагол обязателен в каждом английском предложении, даже если в русском переводе его нет.	9	2025-12-19 02:31:31.784783+03	1
11	alphabet-pronunciation	Как правильно сказать «Я работаю»?	2	В Present Simple используется базовая форма глагола: I work.	10	2025-12-19 02:31:31.784783+03	1
12	alphabet-pronunciation	Что означает мысль «английский — язык конструктора»?	2	Английский язык строится по чётким схемам, как конструктор из блоков.	11	2025-12-19 02:31:31.784783+03	1
13	alphabet-pronunciation	Как правильно задать вопрос «Ты работаешь?»?	1	Для вопроса в Present Simple используется вспомогательный глагол 'do': Do you work?	12	2025-12-19 02:31:31.784783+03	1
14	alphabet-pronunciation	Как правильно построить отрицание?	2	Для отрицания в Present Simple используется 'do not' (don't): I do not work.	13	2025-12-19 02:31:31.784783+03	1
4564	to_be	I ___ a student.	2		0	2025-12-21 13:08:53.039059+03	1
4565	to_be	She ___ very tired today.	3		1	2025-12-21 13:08:53.039059+03	1
4566	to_be	They ___ at home now.	3		2	2025-12-21 13:08:53.039059+03	1
4567	to_be	We ___ ready to start.	1		3	2025-12-21 13:08:53.039059+03	1
4568	to_be	He ___ my best friend.	3		4	2025-12-21 13:08:53.039059+03	1
4569	to_be	You ___ late again.	2		5	2025-12-21 13:08:53.039059+03	1
4570	to_be	It ___ cold outside.	3		6	2025-12-21 13:08:53.039059+03	1
4571	to_be	I ___ not hungry.	2		7	2025-12-21 13:08:53.039059+03	1
4572	to_be	She ___ from Canada.	2		8	2025-12-21 13:08:53.039059+03	1
4573	to_be	They ___ very happy together.	2		9	2025-12-21 13:08:53.039059+03	1
4574	to_be	We ___ in the same class.	3		10	2025-12-21 13:08:53.039059+03	1
4575	to_be	He ___ not at work today.	2		11	2025-12-21 13:08:53.039059+03	1
4576	to_be	You ___ my teacher.	1		12	2025-12-21 13:08:53.039059+03	1
4577	to_be	It ___ a good idea.	3		13	2025-12-21 13:08:53.039059+03	1
4578	to_be	I ___ ready for the test.	2		14	2025-12-21 13:08:53.039059+03	1
4579	to_be	She ___ my sister.	2		15	2025-12-21 13:08:53.039059+03	1
4580	to_be	They ___ not students.	1		16	2025-12-21 13:08:53.039059+03	1
4581	to_be	We ___ very busy today.	3		17	2025-12-21 13:08:53.039059+03	1
4582	to_be	He ___ at home now.	3		18	2025-12-21 13:08:53.039059+03	1
4583	to_be	You ___ welcome here.	2		19	2025-12-21 13:08:53.039059+03	1
4584	to_be	She ___ not ready.	2		0	2025-12-21 13:08:53.039059+03	2
4585	to_be	I ___ not late.	2		1	2025-12-21 13:08:53.039059+03	2
4386	adjectives	My room is ___ than yours.	0	Правильный ответ: A	2	2025-12-20 16:17:42.675045+03	2
4586	to_be	They ___ not at school.	3		2	2025-12-21 13:08:53.039059+03	2
4587	to_be	We ___ not tired.	1		3	2025-12-21 13:08:53.039059+03	2
4588	to_be	He ___ not my boss.	3		4	2025-12-21 13:08:53.039059+03	2
4589	to_be	You ___ not wrong.	2		5	2025-12-21 13:08:53.039059+03	2
4590	to_be	It ___ not easy.	3		6	2025-12-21 13:08:53.039059+03	2
4591	to_be	I ___ not afraid.	2		7	2025-12-21 13:08:53.039059+03	2
4592	to_be	She ___ not at home.	2		8	2025-12-21 13:08:53.039059+03	2
4593	to_be	They ___ not friends.	2		9	2025-12-21 13:08:53.039059+03	2
4594	to_be	We ___ not students.	3		10	2025-12-21 13:08:53.039059+03	2
4595	to_be	He ___ not happy.	2		11	2025-12-21 13:08:53.039059+03	2
4596	to_be	You ___ not alone.	1		12	2025-12-21 13:08:53.039059+03	2
4597	to_be	It ___ not my fault.	3		13	2025-12-21 13:08:53.039059+03	2
4598	to_be	I ___ not busy today.	2		14	2025-12-21 13:08:53.039059+03	2
4599	to_be	She ___ not sure.	2		15	2025-12-21 13:08:53.039059+03	2
4600	to_be	They ___ not here now.	1		16	2025-12-21 13:08:53.039059+03	2
4601	to_be	We ___ not late.	3		17	2025-12-21 13:08:53.039059+03	2
4602	to_be	He ___ not at work.	3		18	2025-12-21 13:08:53.039059+03	2
4603	to_be	You ___ not ready yet.	2		19	2025-12-21 13:08:53.039059+03	2
4604	to_be	I ___ happy today.	2		0	2025-12-21 13:08:53.039059+03	3
4605	to_be	She ___ my neighbor.	2		1	2025-12-21 13:08:53.039059+03	3
4606	to_be	They ___ in the park.	3		2	2025-12-21 13:08:53.039059+03	3
4607	to_be	We ___ very lucky.	1		3	2025-12-21 13:08:53.039059+03	3
4608	to_be	He ___ a good teacher.	3		4	2025-12-21 13:08:53.039059+03	3
4609	to_be	You ___ very kind.	2		5	2025-12-21 13:08:53.039059+03	3
4610	to_be	It ___ my turn.	3		6	2025-12-21 13:08:53.039059+03	3
4611	to_be	I ___ ready now.	2		7	2025-12-21 13:08:53.039059+03	3
4612	to_be	She ___ late again.	2		8	2025-12-21 13:08:53.039059+03	3
4613	to_be	They ___ my classmates.	2		9	2025-12-21 13:08:53.039059+03	3
4614	to_be	We ___ at the cafe.	3		10	2025-12-21 13:08:53.039059+03	3
4615	to_be	He ___ very calm.	2		11	2025-12-21 13:08:53.039059+03	3
4616	to_be	You ___ my best friend.	1		12	2025-12-21 13:08:53.039059+03	3
4617	to_be	It ___ too hot.	3		13	2025-12-21 13:08:53.039059+03	3
4618	to_be	I ___ not sure yet.	2		14	2025-12-21 13:08:53.039059+03	3
4619	to_be	She ___ very smart.	2		15	2025-12-21 13:08:53.039059+03	3
4408	adjectives	The movie was ___ interesting.	1	Правильный ответ: B	4	2025-12-20 16:17:42.675045+03	3
4620	to_be	They ___ at work now.	1		16	2025-12-21 13:08:53.039059+03	3
4621	to_be	We ___ together.	3		17	2025-12-21 13:08:53.039059+03	3
4622	to_be	He ___ from Italy.	3		18	2025-12-21 13:08:53.039059+03	3
4623	to_be	You ___ welcome.	2		19	2025-12-21 13:08:53.039059+03	3
4624	to_be	___ you ready?	2		0	2025-12-21 13:08:53.039059+03	4
4625	to_be	___ she at home?	2		1	2025-12-21 13:08:53.039059+03	4
4626	to_be	___ they friends?	3		2	2025-12-21 13:08:53.039059+03	4
4627	to_be	___ he your brother?	2		3	2025-12-21 13:08:53.039059+03	4
4628	to_be	___ it cold today?	3		4	2025-12-21 13:08:53.039059+03	4
4629	to_be	___ I right?	2		5	2025-12-21 13:08:53.039059+03	4
4630	to_be	___ she happy?	2		6	2025-12-21 13:08:53.039059+03	4
4631	to_be	___ they here now?	3		7	2025-12-21 13:08:53.039059+03	4
4632	to_be	___ you tired?	2		8	2025-12-21 13:08:53.039059+03	4
4633	to_be	___ he at work?	2		9	2025-12-21 13:08:53.039059+03	4
4634	to_be	___ it your bag?	3		10	2025-12-21 13:08:53.039059+03	4
4635	to_be	___ I late?	2		11	2025-12-21 13:08:53.039059+03	4
4636	to_be	___ she your teacher?	2		12	2025-12-21 13:08:53.039059+03	4
4637	to_be	___ they students?	3		13	2025-12-21 13:08:53.039059+03	4
4638	to_be	___ he angry?	2		14	2025-12-21 13:08:53.039059+03	4
4639	to_be	___ it important?	3		15	2025-12-21 13:08:53.039059+03	4
4640	to_be	___ you okay?	2		16	2025-12-21 13:08:53.039059+03	4
4430	adjectives	___ ideas (интересные идеи)	0	Правильный ответ: A	6	2025-12-20 16:17:42.675045+03	4
4641	to_be	I ___ at home now.	2		17	2025-12-21 13:08:53.039059+03	5
4642	to_be	She ___ not angry.	2		18	2025-12-21 13:08:53.039059+03	5
4643	to_be	___ they ready?	3		19	2025-12-21 13:08:53.039059+03	5
4644	to_be	We ___ very busy.	1		0	2025-12-21 13:08:53.039059+03	5
4645	to_be	He ___ not here.	3		1	2025-12-21 13:08:53.039059+03	5
4646	to_be	___ you sure?	2		2	2025-12-21 13:08:53.039059+03	5
4647	to_be	It ___ my mistake.	3		3	2025-12-21 13:08:53.039059+03	5
4648	to_be	I ___ not late today.	2		4	2025-12-21 13:08:53.039059+03	5
4649	to_be	She ___ my cousin.	2		5	2025-12-21 13:08:53.039059+03	5
4650	to_be	They ___ not happy.	2		6	2025-12-21 13:08:53.039059+03	5
4651	to_be	He ___ very polite.	2		7	2025-12-21 13:08:53.039059+03	5
4652	to_be	You ___ not alone.	1		8	2025-12-21 13:08:53.039059+03	5
4653	to_be	It ___ not fair.	3		9	2025-12-21 13:08:53.039059+03	5
4654	to_be	___ I right again?	2		10	2025-12-21 13:08:53.039059+03	5
4655	to_be	She ___ at work now.	2		11	2025-12-21 13:08:53.039059+03	5
4656	to_be	They ___ my neighbors.	1		12	2025-12-21 13:08:53.039059+03	5
4657	to_be	We ___ not students.	3		13	2025-12-21 13:08:53.039059+03	5
4658	to_be	He ___ from London.	3		14	2025-12-21 13:08:53.039059+03	5
4659	to_be	___ you happy?	2		15	2025-12-21 13:08:53.039059+03	5
4660	to_be	I ___ nervous.	2		16	2025-12-21 13:08:53.039059+03	6
4661	to_be	She ___ not ready yet.	2		17	2025-12-21 13:08:53.039059+03	6
4662	to_be	They ___ at the door.	3		18	2025-12-21 13:08:53.039059+03	6
4663	to_be	We ___ very close.	1		19	2025-12-21 13:08:53.039059+03	6
4664	to_be	He ___ my teammate.	3		0	2025-12-21 13:08:53.039059+03	6
4665	to_be	You ___ not wrong.	2		1	2025-12-21 13:08:53.039059+03	6
4666	to_be	It ___ my turn now.	3		2	2025-12-21 13:08:53.039059+03	6
4667	to_be	I ___ not busy.	2		3	2025-12-21 13:08:53.039059+03	6
4668	to_be	She ___ my sister.	2		4	2025-12-21 13:08:53.039059+03	6
4669	to_be	They ___ very polite.	2		5	2025-12-21 13:08:53.039059+03	6
4670	to_be	We ___ in the room.	3		6	2025-12-21 13:08:53.039059+03	6
4671	to_be	He ___ not tired.	2		7	2025-12-21 13:08:53.039059+03	6
4672	to_be	You ___ my friend.	1		8	2025-12-21 13:08:53.039059+03	6
4673	to_be	It ___ too late.	3		9	2025-12-21 13:08:53.039059+03	6
4674	to_be	I ___ calm now.	2		10	2025-12-21 13:08:53.039059+03	6
4675	to_be	She ___ not angry.	2		11	2025-12-21 13:08:53.039059+03	6
4676	to_be	They ___ ready to go.	1		12	2025-12-21 13:08:53.039059+03	6
4677	to_be	We ___ not alone.	3		13	2025-12-21 13:08:53.039059+03	6
4678	to_be	He ___ my neighbor.	3		14	2025-12-21 13:08:53.039059+03	6
4679	to_be	You ___ welcome here.	2		15	2025-12-21 13:08:53.039059+03	6
4680	to_be	___ I late again?	2		16	2025-12-21 13:08:53.039059+03	7
4681	to_be	___ she your boss?	2		17	2025-12-21 13:08:53.039059+03	7
4682	to_be	___ they in class?	3		18	2025-12-21 13:08:53.039059+03	7
4683	to_be	___ he your friend?	2		19	2025-12-21 13:08:53.039059+03	7
4684	to_be	___ you okay now?	2		0	2025-12-21 13:08:53.039059+03	7
4685	to_be	___ it serious?	3		1	2025-12-21 13:08:53.039059+03	7
4686	to_be	___ I wrong?	2		2	2025-12-21 13:08:53.039059+03	7
4687	to_be	___ she tired?	2		3	2025-12-21 13:08:53.039059+03	7
4688	to_be	___ they ready?	3		4	2025-12-21 13:08:53.039059+03	7
4689	to_be	___ he calm?	2		5	2025-12-21 13:08:53.039059+03	7
4690	to_be	___ you busy?	2		6	2025-12-21 13:08:53.039059+03	7
4691	to_be	___ it yours?	3		7	2025-12-21 13:08:53.039059+03	7
4692	to_be	___ I welcome here?	2		8	2025-12-21 13:08:53.039059+03	7
4693	to_be	___ she happy now?	2		9	2025-12-21 13:08:53.039059+03	7
4694	to_be	___ they polite?	3		10	2025-12-21 13:08:53.039059+03	7
4695	to_be	___ he serious?	2		11	2025-12-21 13:08:53.039059+03	7
4696	to_be	___ you ready?	2		12	2025-12-21 13:08:53.039059+03	7
4697	to_be	I ___ confident.	2		13	2025-12-21 13:08:53.039059+03	8
4698	to_be	She ___ not here.	2		14	2025-12-21 13:08:53.039059+03	8
4699	to_be	They ___ my friends.	3		15	2025-12-21 13:08:53.039059+03	8
4700	to_be	We ___ very close.	1		16	2025-12-21 13:08:53.039059+03	8
4701	to_be	He ___ at home.	3		17	2025-12-21 13:08:53.039059+03	8
4702	to_be	You ___ not late.	2		18	2025-12-21 13:08:53.039059+03	8
4703	to_be	It ___ important.	3		19	2025-12-21 13:08:53.039059+03	8
4704	to_be	I ___ ready now.	2		0	2025-12-21 13:08:53.039059+03	8
4705	to_be	She ___ my classmate.	2		1	2025-12-21 13:08:53.039059+03	8
4706	to_be	They ___ not busy.	2		2	2025-12-21 13:08:53.039059+03	8
4707	to_be	We ___ at school.	3		3	2025-12-21 13:08:53.039059+03	8
4708	to_be	He ___ polite.	2		4	2025-12-21 13:08:53.039059+03	8
4709	to_be	You ___ my teacher.	1		5	2025-12-21 13:08:53.039059+03	8
4710	to_be	It ___ not fair.	3		6	2025-12-21 13:08:53.039059+03	8
4711	to_be	I ___ calm today.	2		7	2025-12-21 13:08:53.039059+03	8
4712	to_be	She ___ not angry.	2		8	2025-12-21 13:08:53.039059+03	8
4713	to_be	They ___ from Spain.	1		9	2025-12-21 13:08:53.039059+03	8
4714	to_be	We ___ not ready.	3		10	2025-12-21 13:08:53.039059+03	8
4715	to_be	He ___ my neighbor.	3		11	2025-12-21 13:08:53.039059+03	8
4716	to_be	You ___ welcome.	2		12	2025-12-21 13:08:53.039059+03	8
4717	to_be	I ___ excited.	2		13	2025-12-21 13:08:53.039059+03	9
4718	to_be	She ___ very calm.	2		14	2025-12-21 13:08:53.039059+03	9
4719	to_be	They ___ at the cafe.	3		15	2025-12-21 13:08:53.039059+03	9
4720	to_be	We ___ together now.	1		16	2025-12-21 13:08:53.039059+03	9
4721	to_be	He ___ my partner.	3		17	2025-12-21 13:08:53.039059+03	9
4722	to_be	You ___ not wrong.	2		18	2025-12-21 13:08:53.039059+03	9
4723	to_be	It ___ my idea.	3		19	2025-12-21 13:08:53.039059+03	9
4724	to_be	I ___ not afraid.	2		0	2025-12-21 13:08:53.039059+03	9
4725	to_be	She ___ my manager.	2		1	2025-12-21 13:08:53.039059+03	9
4726	to_be	They ___ very helpful.	2		2	2025-12-21 13:08:53.039059+03	9
4727	to_be	We ___ at work.	3		3	2025-12-21 13:08:53.039059+03	9
4728	to_be	He ___ confident.	2		4	2025-12-21 13:08:53.039059+03	9
4729	to_be	You ___ my friend.	1		5	2025-12-21 13:08:53.039059+03	9
4730	to_be	It ___ not easy.	3		6	2025-12-21 13:08:53.039059+03	9
4731	to_be	I ___ ready again.	2		7	2025-12-21 13:08:53.039059+03	9
4732	to_be	She ___ from France.	2		8	2025-12-21 13:08:53.039059+03	9
4733	to_be	They ___ not students.	1		9	2025-12-21 13:08:53.039059+03	9
4734	to_be	We ___ not late.	3		10	2025-12-21 13:08:53.039059+03	9
4735	to_be	He ___ at school.	3		11	2025-12-21 13:08:53.039059+03	9
4736	to_be	You ___ welcome here.	2		12	2025-12-21 13:08:53.039059+03	9
5657	question_words	___ is your name?	0		0	2025-12-21 17:04:34.76891+03	7
5658	question_words	___ do you live?	1		1	2025-12-21 17:04:34.76891+03	7
5659	question_words	___ is this?	2		2	2025-12-21 17:04:34.76891+03	7
5660	question_words	___ is the bank?	1		3	2025-12-21 17:04:34.76891+03	7
5661	question_words	___ do you do?	0		4	2025-12-21 17:04:34.76891+03	7
5662	question_words	___ are you?	2		5	2025-12-21 17:04:34.76891+03	7
5663	question_words	___ is your job?	0		6	2025-12-21 17:04:34.76891+03	7
5664	question_words	___ do you work?	1		7	2025-12-21 17:04:34.76891+03	7
5665	question_words	___ lives here?	2		8	2025-12-21 17:04:34.76891+03	7
5666	question_words	___ time is it?	0		9	2025-12-21 17:04:34.76891+03	7
5667	question_words	___ are my keys?	1		10	2025-12-21 17:04:34.76891+03	7
5668	question_words	___ is your friend?	2		11	2025-12-21 17:04:34.76891+03	7
5669	question_words	___ colour is it?	0		12	2025-12-21 17:04:34.76891+03	7
5670	question_words	___ is he from?	1		13	2025-12-21 17:04:34.76891+03	7
5671	question_words	___ called me?	2		14	2025-12-21 17:04:34.76891+03	7
5672	question_words	___ are you doing?	0		15	2025-12-21 17:04:34.76891+03	7
5673	question_words	___ is the bathroom?	1		16	2025-12-21 17:04:34.76891+03	7
5674	question_words	___ is she?	2		17	2025-12-21 17:04:34.76891+03	7
5675	question_words	___ do you like?	0		18	2025-12-21 17:04:34.76891+03	7
5676	question_words	___ are you going?	1		19	2025-12-21 17:04:34.76891+03	7
5677	question_words	___ is your birthday?	1		0	2025-12-21 17:04:34.76891+03	8
5678	question_words	___ are you sad?	2		1	2025-12-21 17:04:34.76891+03	8
5679	question_words	___ are you?	0		2	2025-12-21 17:04:34.76891+03	8
5680	question_words	___ do you work?	1		3	2025-12-21 17:04:34.76891+03	8
5681	question_words	___ do you study English?	2		4	2025-12-21 17:04:34.76891+03	8
5682	question_words	___ old are you?	0		5	2025-12-21 17:04:34.76891+03	8
5683	question_words	___ is the meeting?	1		6	2025-12-21 17:04:34.76891+03	8
5684	question_words	___ is she late?	2		7	2025-12-21 17:04:34.76891+03	8
5685	question_words	___ do you do this?	0		8	2025-12-21 17:04:34.76891+03	8
5686	question_words	___ did you arrive?	1		9	2025-12-21 17:04:34.76891+03	8
5687	question_words	___ did you leave?	2		10	2025-12-21 17:04:34.76891+03	8
5688	question_words	___ much is it?	0		11	2025-12-21 17:04:34.76891+03	8
5689	question_words	___ is the exam?	1		12	2025-12-21 17:04:34.76891+03	8
5690	question_words	___ don't you try?	2		13	2025-12-21 17:04:34.76891+03	8
5691	question_words	___ do you know?	0		14	2025-12-21 17:04:34.76891+03	8
5692	question_words	___ can you come?	1		15	2025-12-21 17:04:34.76891+03	8
5693	question_words	___ is he angry?	2		16	2025-12-21 17:04:34.76891+03	8
5694	question_words	___ far is it?	0		17	2025-12-21 17:04:34.76891+03	8
5695	question_words	___ is the party?	1		18	2025-12-21 17:04:34.76891+03	8
5696	question_words	___ do you like it?	2		19	2025-12-21 17:04:34.76891+03	8
5697	question_words	___ is your name?	0		0	2025-12-21 17:04:34.76891+03	9
5698	question_words	___ do you live?	1		1	2025-12-21 17:04:34.76891+03	9
5699	question_words	___ is this?	2		2	2025-12-21 17:04:34.76891+03	9
5700	question_words	___ are you?	3		3	2025-12-21 17:04:34.76891+03	9
5701	question_words	___ is your birthday?	2		4	2025-12-21 17:04:34.76891+03	9
4737	present_simple	I ___ football every weekend.	1		0	2025-12-21 13:20:37.35672+03	1
4738	present_simple	She ___ tea in the morning.	1		1	2025-12-21 13:20:37.35672+03	1
4739	present_simple	They ___ to school by bus.	0		2	2025-12-21 13:20:37.35672+03	1
4740	present_simple	We ___ homework after class.	0		3	2025-12-21 13:20:37.35672+03	1
4741	present_simple	He ___ English very well.	0		4	2025-12-21 13:20:37.35672+03	1
4742	present_simple	You ___ a lot of water every day.	0		5	2025-12-21 13:20:37.35672+03	1
4519	adjectives	He appears ___.	3	Правильный ответ: D	15	2025-12-20 16:17:42.675045+03	8
4743	present_simple	It ___ every winter in this city.	0		6	2025-12-21 13:20:37.35672+03	1
4744	present_simple	I ___ not like chocolate.	0		7	2025-12-21 13:20:37.35672+03	1
4745	present_simple	She ___ not watch TV in the morning.	1		8	2025-12-21 13:20:37.35672+03	1
4746	present_simple	They ___ not play football on Monday.	0		9	2025-12-21 13:20:37.35672+03	1
4747	present_simple	We ___ not go to school on Sunday.	0		10	2025-12-21 13:20:37.35672+03	1
4748	present_simple	He ___ not like pizza.	1		11	2025-12-21 13:20:37.35672+03	1
4749	present_simple	You ___ not speak Spanish.	0		12	2025-12-21 13:20:37.35672+03	1
4750	present_simple	It ___ not rain in summer.	1		13	2025-12-21 13:20:37.35672+03	1
4751	present_simple	I ___ usually wake up at 7 am.	3		14	2025-12-21 13:20:37.35672+03	1
4752	present_simple	She ___ always drinks coffee.	1		15	2025-12-21 13:20:37.35672+03	1
4753	present_simple	They ___ often play chess.	0		16	2025-12-21 13:20:37.35672+03	1
4754	present_simple	We ___ sometimes eat out.	0		17	2025-12-21 13:20:37.35672+03	1
4755	present_simple	He ___ never eats meat.	1		18	2025-12-21 13:20:37.35672+03	1
4756	present_simple	You ___ usually read books.	0		19	2025-12-21 13:20:37.35672+03	1
4757	present_simple	Do you ___ football on weekends?	1		0	2025-12-21 13:20:37.35672+03	2
4758	present_simple	Does she ___ tea in the morning?	0		1	2025-12-21 13:20:37.35672+03	2
4759	present_simple	Do they ___ to school by bus?	0		2	2025-12-21 13:20:37.35672+03	2
4760	present_simple	Do we ___ homework after class?	0		3	2025-12-21 13:20:37.35672+03	2
4761	present_simple	Does he ___ English very well?	1		4	2025-12-21 13:20:37.35672+03	2
4762	present_simple	Do you ___ a lot of water every day?	0		5	2025-12-21 13:20:37.35672+03	2
4763	present_simple	Does it ___ every winter in this city?	1		6	2025-12-21 13:20:37.35672+03	2
4764	present_simple	Do I ___ like chocolate?	0		7	2025-12-21 13:20:37.35672+03	2
4765	present_simple	Does she ___ watch TV in the morning?	1		8	2025-12-21 13:20:37.35672+03	2
4766	present_simple	Do they ___ play football on Monday?	0		9	2025-12-21 13:20:37.35672+03	2
4767	present_simple	Do we ___ go to school on Sunday?	0		10	2025-12-21 13:20:37.35672+03	2
4768	present_simple	Does he ___ like pizza?	1		11	2025-12-21 13:20:37.35672+03	2
4769	present_simple	Do you ___ speak Spanish?	0		12	2025-12-21 13:20:37.35672+03	2
4770	present_simple	Does it ___ rain in summer?	1		13	2025-12-21 13:20:37.35672+03	2
4771	present_simple	Do I ___ usually wake up at 7 am?	3		14	2025-12-21 13:20:37.35672+03	2
4772	present_simple	Does she ___ always drink coffee?	1		15	2025-12-21 13:20:37.35672+03	2
4773	present_simple	Do they ___ often play chess?	0		16	2025-12-21 13:20:37.35672+03	2
4774	present_simple	Do we ___ sometimes eat out?	0		17	2025-12-21 13:20:37.35672+03	2
4775	present_simple	Does he ___ never eat meat?	1		18	2025-12-21 13:20:37.35672+03	2
4776	present_simple	Do you ___ usually read books?	0		19	2025-12-21 13:20:37.35672+03	2
4777	present_simple	I ___ play football on Monday.	0		0	2025-12-21 13:20:37.35672+03	3
4778	present_simple	She ___ drink coffee in the evening.	1		1	2025-12-21 13:20:37.35672+03	3
4779	present_simple	They ___ go to school on Sundays.	0		2	2025-12-21 13:20:37.35672+03	3
4780	present_simple	We ___ eat meat.	0		3	2025-12-21 13:20:37.35672+03	3
4781	present_simple	He ___ speak Spanish.	1		4	2025-12-21 13:20:37.35672+03	3
4782	present_simple	You ___ watch TV in the morning.	0		5	2025-12-21 13:20:37.35672+03	3
4783	present_simple	It ___ snow in summer.	1		6	2025-12-21 13:20:37.35672+03	3
4784	present_simple	I ___ usually wake up at 6 am.	2		7	2025-12-21 13:20:37.35672+03	3
4785	present_simple	She ___ like pizza.	1		8	2025-12-21 13:20:37.35672+03	3
4786	present_simple	They ___ play chess every day.	0		9	2025-12-21 13:20:37.35672+03	3
3442	articles	___ moon looks amazing tonight.	2	Правильный ответ: C	8	2025-12-20 02:57:32.382395+03	10
3443	articles	I don’t like ___ music that is too loud.	3	Правильный ответ: D	18	2025-12-20 02:57:32.382395+03	10
3444	articles	I saw ___ owl in the tree.	1	Правильный ответ: B	3	2025-12-20 02:57:32.382395+03	1
3445	articles	She has ___ orange dress.	1	Правильный ответ: B	17	2025-12-20 02:57:32.382395+03	1
3447	articles	I drink ___ tea every morning.	3	Правильный ответ: D	15	2025-12-20 02:57:32.382395+03	2
3448	articles	He bought ___ old book yesterday.	0	Правильный ответ: A	2	2025-12-20 02:57:32.382395+03	3
4787	present_simple	We ___ go out on weekdays.	0		10	2025-12-21 13:20:37.35672+03	3
4788	present_simple	He ___ eat vegetables.	1		11	2025-12-21 13:20:37.35672+03	3
4789	present_simple	You ___ read novels.	0		12	2025-12-21 13:20:37.35672+03	3
4790	present_simple	It ___ rain in winter.	1		13	2025-12-21 13:20:37.35672+03	3
4791	present_simple	I ___ always study at night.	2		14	2025-12-21 13:20:37.35672+03	3
4792	present_simple	She ___ sometimes go to the park.	1		15	2025-12-21 13:20:37.35672+03	3
4793	present_simple	They ___ often watch movies.	0		16	2025-12-21 13:20:37.35672+03	3
4794	present_simple	We ___ like ice cream.	0		17	2025-12-21 13:20:37.35672+03	3
4795	present_simple	He ___ usually play football.	1		18	2025-12-21 13:20:37.35672+03	3
4796	present_simple	You ___ often drink tea.	0		19	2025-12-21 13:20:37.35672+03	3
4797	present_simple	Do I ___ football on weekends?	1		0	2025-12-21 13:20:37.35672+03	4
4798	present_simple	Does she ___ tea in the morning?	0		1	2025-12-21 13:20:37.35672+03	4
4799	present_simple	Do they ___ to school by bus?	0		2	2025-12-21 13:20:37.35672+03	4
4800	present_simple	Do we ___ homework after class?	0		3	2025-12-21 13:20:37.35672+03	4
4801	present_simple	Does he ___ English very well?	1		4	2025-12-21 13:20:37.35672+03	4
4802	present_simple	Do you ___ a lot of water every day?	0		5	2025-12-21 13:20:37.35672+03	4
3449	articles	We visited ___ Great Wall of China.	2	Правильный ответ: C	10	2025-12-20 02:57:32.382395+03	3
3450	articles	I need ___ notebook for class.	0	Правильный ответ: A	9	2025-12-20 02:57:32.382395+03	4
3451	articles	She is ___ smartest student in class.	2	Правильный ответ: C	14	2025-12-20 02:57:32.382395+03	4
3452	articles	I saw ___ iguana in the garden.	1	Правильный ответ: B	5	2025-12-20 02:57:32.382395+03	5
3453	articles	___ tigers are very dangerous.	3	Правильный ответ: D	19	2025-12-20 02:57:32.382395+03	5
3454	articles	He wants ___ sandwich for lunch.	0	Правильный ответ: A	9	2025-12-20 02:57:32.382395+03	6
3455	articles	___ Nile is the longest river in the world.	2	Правильный ответ: C	10	2025-12-20 02:57:32.382395+03	6
3456	articles	I need ___ eraser and ___ pencil.	1	Правильный ответ: B	7	2025-12-20 02:57:32.382395+03	7
3457	articles	She goes to ___ university by bus.	1	Правильный ответ: B	14	2025-12-20 02:57:32.382395+03	7
3458	articles	___ stars are shining in the sky.	3	Правильный ответ: D	3	2025-12-20 02:57:32.382395+03	8
3459	articles	I saw ___ rabbit and ___ fox in the forest.	0	Правильный ответ: A	18	2025-12-20 02:57:32.382395+03	8
3460	articles	He is reading ___ article in the newspaper.	1	Правильный ответ: B	5	2025-12-20 02:57:32.382395+03	9
3461	articles	We went to ___ park yesterday.	2	Правильный ответ: C	16	2025-12-20 02:57:32.382395+03	9
3462	articles	___ sky is blue today.	3	Правильный ответ: D	9	2025-12-20 02:57:32.382395+03	10
3463	articles	I don’t like ___ noise in the street.	3	Правильный ответ: D	16	2025-12-20 02:57:32.382395+03	10
3464	articles	I found ___ egg on the table.	1	Правильный ответ: B	9	2025-12-20 02:57:32.382395+03	1
3465	articles	She wants ___ cat as a pet.	0	Правильный ответ: A	19	2025-12-20 02:57:32.382395+03	1
3466	articles	___ Pacific Ocean is very deep.	2	Правильный ответ: C	4	2025-12-20 02:57:32.382395+03	2
3467	articles	I like drinking ___ milk in the morning.	3	Правильный ответ: D	19	2025-12-20 02:57:32.382395+03	2
3469	articles	We climbed ___ Mount Everest last year.	2	Правильный ответ: C	12	2025-12-20 02:57:32.382395+03	3
3470	articles	I need ___ hour to finish my homework.	1	Правильный ответ: B	0	2025-12-20 02:57:32.382395+03	4
3471	articles	She is ___ most talented singer in the choir.	2	Правильный ответ: C	16	2025-12-20 02:57:32.382395+03	4
3472	articles	I saw ___ octopus at the aquarium.	1	Правильный ответ: B	8	2025-12-20 02:57:32.382395+03	5
3473	articles	___ giraffes eat leaves from tall trees.	3	Правильный ответ: D	16	2025-12-20 02:57:32.382395+03	5
3474	articles	He wants ___ sandwich and ___ juice.	3	Правильный ответ: D	8	2025-12-20 02:57:32.382395+03	6
3475	articles	___ Amazon rainforest is huge.	2	Правильный ответ: C	16	2025-12-20 02:57:32.382395+03	6
3476	articles	I need ___ pencil and ___ eraser.	3	Правильный ответ: D	9	2025-12-20 02:57:32.382395+03	7
3477	articles	She usually goes to ___ office by car.	2	Правильный ответ: C	10	2025-12-20 02:57:32.382395+03	7
3478	articles	___ stars shine brightly at night.	3	Правильный ответ: D	9	2025-12-20 02:57:32.382395+03	8
3479	articles	I saw ___ mouse and ___ cat in the kitchen.	0	Правильный ответ: A	14	2025-12-20 02:57:32.382395+03	8
3480	articles	He is reading ___ article about technology.	1	Правильный ответ: B	1	2025-12-20 02:57:32.382395+03	9
3481	articles	We went to ___ museum yesterday.	2	Правильный ответ: C	17	2025-12-20 02:57:32.382395+03	9
3482	articles	___ sky looks gray today.	3	Правильный ответ: D	0	2025-12-20 02:57:32.382395+03	10
3483	articles	I don’t like ___ traffic in the city.	3	Правильный ответ: D	10	2025-12-20 02:57:32.382395+03	10
3484	articles	I saw ___ iguana in the zoo.	1	Правильный ответ: B	1	2025-12-20 02:57:32.382395+03	1
3485	articles	She bought ___ book about history.	0	Правильный ответ: A	14	2025-12-20 02:57:32.382395+03	1
3486	articles	___ Atlantic Ocean is wide.	2	Правильный ответ: C	7	2025-12-20 02:57:32.382395+03	2
3487	articles	I drink ___ water every day.	3	Правильный ответ: D	10	2025-12-20 02:57:32.382395+03	2
3488	articles	He found ___ interesting coin.	1	Правильный ответ: B	8	2025-12-20 02:57:32.382395+03	3
3489	articles	We visited ___ Statue of Liberty last summer.	2	Правильный ответ: C	13	2025-12-20 02:57:32.382395+03	3
3491	articles	She is ___ smartest girl in the class.	2	Правильный ответ: C	12	2025-12-20 02:57:32.382395+03	4
3492	articles	I saw ___ eagle flying in the sky.	1	Правильный ответ: B	4	2025-12-20 02:57:32.382395+03	5
3493	articles	___ tigers are dangerous animals.	3	Правильный ответ: D	12	2025-12-20 02:57:32.382395+03	5
3494	articles	He bought ___ apple and ___ banana.	1	Правильный ответ: B	4	2025-12-20 02:57:32.382395+03	6
3495	articles	___ Himalayas are very tall.	2	Правильный ответ: C	18	2025-12-20 02:57:32.382395+03	6
3496	articles	I need ___ notebook and ___ pen.	3	Правильный ответ: D	3	2025-12-20 02:57:32.382395+03	7
3497	articles	She usually goes to ___ hospital by bus.	2	Правильный ответ: C	13	2025-12-20 02:57:32.382395+03	7
3498	articles	___ sun rises in the east.	2	Правильный ответ: C	1	2025-12-20 02:57:32.382395+03	8
3499	articles	I saw ___ fox and ___ rabbit in the forest.	0	Правильный ответ: A	16	2025-12-20 02:57:32.382395+03	8
3500	articles	He is reading ___ article about science.	1	Правильный ответ: B	8	2025-12-20 02:57:32.382395+03	9
3501	articles	We went to ___ cinema yesterday.	2	Правильный ответ: C	11	2025-12-20 02:57:32.382395+03	9
3502	articles	___ sky is clear today.	3	Правильный ответ: D	6	2025-12-20 02:57:32.382395+03	10
3503	articles	I don’t like ___ noise at night.	3	Правильный ответ: D	17	2025-12-20 02:57:32.382395+03	10
3504	articles	I saw ___ owl in the tree.	1	Правильный ответ: B	2	2025-12-20 02:57:32.382395+03	1
3505	articles	She bought ___ old chair.	0	Правильный ответ: A	13	2025-12-20 02:57:32.382395+03	1
3506	articles	___ Sahara Desert is very hot.	2	Правильный ответ: C	9	2025-12-20 02:57:32.382395+03	2
3507	articles	I usually drink ___ juice in the morning.	3	Правильный ответ: D	18	2025-12-20 02:57:32.382395+03	2
3508	articles	He found ___ unusual coin.	1	Правильный ответ: B	9	2025-12-20 02:57:32.382395+03	3
3509	articles	We visited ___ Colosseum in Rome.	2	Правильный ответ: C	14	2025-12-20 02:57:32.382395+03	3
3510	articles	I need ___ hour to finish my homework.	1	Правильный ответ: B	7	2025-12-20 02:57:32.382395+03	4
3511	articles	She is ___ tallest student in the class.	2	Правильный ответ: C	18	2025-12-20 02:57:32.382395+03	4
3512	articles	I saw ___ eagle at the cliff.	1	Правильный ответ: B	3	2025-12-20 02:57:32.382395+03	5
3513	articles	___ elephants are large animals.	3	Правильный ответ: D	14	2025-12-20 02:57:32.382395+03	5
3514	articles	He wants ___ sandwich and ___ water.	3	Правильный ответ: D	7	2025-12-20 02:57:32.382395+03	6
3515	articles	___ Alps are beautiful in winter.	2	Правильный ответ: C	12	2025-12-20 02:57:32.382395+03	6
3516	articles	I need ___ notebook and ___ pen.	3	Правильный ответ: D	0	2025-12-20 02:57:32.382395+03	7
3517	articles	She usually goes to ___ hospital by bus.	2	Правильный ответ: C	12	2025-12-20 02:57:32.382395+03	7
3518	articles	___ stars shine at night.	3	Правильный ответ: D	0	2025-12-20 02:57:32.382395+03	8
3519	articles	I saw ___ rabbit and ___ fox in the forest.	0	Правильный ответ: A	13	2025-12-20 02:57:32.382395+03	8
3520	articles	He is reading ___ article about technology.	1	Правильный ответ: B	7	2025-12-20 02:57:32.382395+03	9
3521	articles	We went to ___ theater yesterday.	2	Правильный ответ: C	12	2025-12-20 02:57:32.382395+03	9
3522	articles	___ sky is gray today.	3	Правильный ответ: D	7	2025-12-20 02:57:32.382395+03	10
3523	articles	I don’t like ___ traffic in the city.	3	Правильный ответ: D	14	2025-12-20 02:57:32.382395+03	10
3524	articles	I saw ___ octopus at the aquarium.	1	Правильный ответ: B	6	2025-12-20 02:57:32.382395+03	1
3525	articles	She wants ___ cat as a pet.	0	Правильный ответ: A	11	2025-12-20 02:57:32.382395+03	1
3526	articles	___ Pacific Ocean is very large.	2	Правильный ответ: C	3	2025-12-20 02:57:32.382395+03	2
3527	articles	I drink ___ tea every morning.	3	Правильный ответ: D	17	2025-12-20 02:57:32.382395+03	2
3528	articles	He bought ___ old painting.	1	Правильный ответ: B	0	2025-12-20 02:57:32.382395+03	3
3529	articles	We visited ___ Statue of Liberty.	2	Правильный ответ: C	15	2025-12-20 02:57:32.382395+03	3
3530	articles	I need ___ egg for breakfast.	1	Правильный ответ: B	1	2025-12-20 02:57:32.382395+03	4
3531	articles	She is ___ most talented girl in the choir.	2	Правильный ответ: C	19	2025-12-20 02:57:32.382395+03	4
3532	articles	I saw ___ iguana in the zoo.	1	Правильный ответ: B	6	2025-12-20 02:57:32.382395+03	5
3533	articles	___ lions live in Africa.	3	Правильный ответ: D	17	2025-12-20 02:57:32.382395+03	5
3534	articles	He bought ___ apple and ___ banana.	1	Правильный ответ: B	0	2025-12-20 02:57:32.382395+03	6
3535	articles	___ Himalayas are very high.	2	Правильный ответ: C	13	2025-12-20 02:57:32.382395+03	6
3536	articles	I need ___ pencil and ___ eraser.	3	Правильный ответ: D	5	2025-12-20 02:57:32.382395+03	7
3537	articles	She usually goes to ___ university by bus.	1	Правильный ответ: B	17	2025-12-20 02:57:32.382395+03	7
3538	articles	___ sun rises in the east.	2	Правильный ответ: C	4	2025-12-20 02:57:32.382395+03	8
3539	articles	I saw ___ fox and ___ rabbit in the forest.	0	Правильный ответ: A	11	2025-12-20 02:57:32.382395+03	8
3540	articles	He is reading ___ article about science.	1	Правильный ответ: B	4	2025-12-20 02:57:32.382395+03	9
3541	articles	We went to ___ cinema yesterday.	2	Правильный ответ: C	13	2025-12-20 02:57:32.382395+03	9
3542	articles	___ sky is clear today.	3	Правильный ответ: D	5	2025-12-20 02:57:32.382395+03	10
3543	articles	I don’t like ___ noise in the street.	3	Правильный ответ: D	19	2025-12-20 02:57:32.382395+03	10
3544	articles	I saw ___ elephant near the river.	1	Правильный ответ: B	4	2025-12-20 02:57:32.382395+03	1
3545	articles	She bought ___ old dress.	0	Правильный ответ: A	10	2025-12-20 02:57:32.382395+03	1
3546	articles	___ Atlantic Ocean is very wide.	2	Правильный ответ: C	1	2025-12-20 02:57:32.382395+03	2
3547	articles	I usually drink ___ milk in the morning.	3	Правильный ответ: D	16	2025-12-20 02:57:32.382395+03	2
3548	articles	He found ___ unusual coin.	1	Правильный ответ: B	1	2025-12-20 02:57:32.382395+03	3
3549	articles	We visited ___ Colosseum in Rome.	2	Правильный ответ: C	16	2025-12-20 02:57:32.382395+03	3
3550	articles	I need ___ hour to finish my homework.	1	Правильный ответ: B	2	2025-12-20 02:57:32.382395+03	4
3551	articles	She is ___ tallest student in class.	2	Правильный ответ: C	13	2025-12-20 02:57:32.382395+03	4
3552	articles	I saw ___ eagle at the cliff.	1	Правильный ответ: B	1	2025-12-20 02:57:32.382395+03	5
3553	articles	___ elephants are very large.	3	Правильный ответ: D	10	2025-12-20 02:57:32.382395+03	5
3554	articles	He wants ___ sandwich and ___ juice.	3	Правильный ответ: D	6	2025-12-20 02:57:32.382395+03	6
3555	articles	___ Alps are beautiful in winter.	2	Правильный ответ: C	19	2025-12-20 02:57:32.382395+03	6
3556	articles	I need ___ notebook and ___ pen.	3	Правильный ответ: D	2	2025-12-20 02:57:32.382395+03	7
3557	articles	She usually goes to ___ hospital by bus.	2	Правильный ответ: C	16	2025-12-20 02:57:32.382395+03	7
3558	articles	___ stars shine at night.	3	Правильный ответ: D	5	2025-12-20 02:57:32.382395+03	8
3559	articles	I saw ___ rabbit and ___ fox in the forest.	0	Правильный ответ: A	12	2025-12-20 02:57:32.382395+03	8
3560	articles	He is reading ___ article about technology.	1	Правильный ответ: B	0	2025-12-20 02:57:32.382395+03	9
3561	articles	We went to ___ theater yesterday.	2	Правильный ответ: C	14	2025-12-20 02:57:32.382395+03	9
3562	articles	___ sky is gray today.	3	Правильный ответ: D	2	2025-12-20 02:57:32.382395+03	10
3563	articles	I don’t like ___ traffic in the city.	3	Правильный ответ: D	12	2025-12-20 02:57:32.382395+03	10
3564	articles	She is looking for ___ job in IT.	0	Правильный ответ: A	7	2025-12-20 02:57:32.382395+03	1
3565	articles	He bought ___ expensive watch.	1	Правильный ответ: B	16	2025-12-20 02:57:32.382395+03	1
3566	articles	___ Earth goes around the Sun.	2	Правильный ответ: C	8	2025-12-20 02:57:32.382395+03	2
5702	question_words	___ are you sad?	3		5	2025-12-21 17:04:34.76891+03	9
3567	articles	I don’t like ___ sugar in my coffee.	3	Правильный ответ: D	14	2025-12-20 02:57:32.382395+03	2
3568	articles	She adopted ___ small puppy.	0	Правильный ответ: A	5	2025-12-20 02:57:32.382395+03	3
3569	articles	We stayed at ___ hotel near the airport.	0	Правильный ответ: A	17	2025-12-20 02:57:32.382395+03	3
3570	articles	He has ___ idea how to solve this problem.	1	Правильный ответ: B	5	2025-12-20 02:57:32.382395+03	4
3571	articles	___ manager called you this morning.	2	Правильный ответ: C	10	2025-12-20 02:57:32.382395+03	4
3572	articles	She plays ___ piano very well.	2	Правильный ответ: C	9	2025-12-20 02:57:32.382395+03	5
3573	articles	I usually eat ___ breakfast at home.	3	Правильный ответ: D	11	2025-12-20 02:57:32.382395+03	5
3574	articles	He works as ___ engineer.	1	Правильный ответ: B	1	2025-12-20 02:57:32.382395+03	6
3575	articles	___ police are investigating the case.	2	Правильный ответ: C	15	2025-12-20 02:57:32.382395+03	6
3576	articles	She felt ___ fear when she heard the noise.	3	Правильный ответ: D	6	2025-12-20 02:57:32.382395+03	7
3577	articles	We need ___ taxi right now.	0	Правильный ответ: A	11	2025-12-20 02:57:32.382395+03	7
3578	articles	___ information you gave me was helpful.	2	Правильный ответ: C	6	2025-12-20 02:57:32.382395+03	8
3580	articles	She found ___ solution to the problem.	0	Правильный ответ: A	2	2025-12-20 02:57:32.382395+03	9
3581	articles	We visited ___ museum of modern art.	2	Правильный ответ: C	15	2025-12-20 02:57:32.382395+03	9
3582	articles	___ honesty is very important in relationships.	3	Правильный ответ: D	4	2025-12-20 02:57:32.382395+03	10
3583	articles	He opened ___ window to get some fresh air.	0	Правильный ответ: A	11	2025-12-20 02:57:32.382395+03	10
3584	articles	I found ___ egg on the table.	1	Правильный ответ: B	5	2025-12-20 02:57:32.382395+03	1
3585	articles	She wants ___ cat as a pet.	0	Правильный ответ: A	15	2025-12-20 02:57:32.382395+03	1
3586	articles	___ Pacific Ocean is very deep.	2	Правильный ответ: C	0	2025-12-20 02:57:32.382395+03	2
3587	articles	I like drinking ___ milk in the morning.	3	Правильный ответ: D	13	2025-12-20 02:57:32.382395+03	2
3588	articles	He bought ___ old painting.	1	Правильный ответ: B	6	2025-12-20 02:57:32.382395+03	3
3589	articles	We visited ___ Statue of Liberty.	2	Правильный ответ: C	18	2025-12-20 02:57:32.382395+03	3
3590	articles	I need ___ egg for breakfast.	1	Правильный ответ: B	4	2025-12-20 02:57:32.382395+03	4
3591	articles	She is ___ most talented girl in the choir.	2	Правильный ответ: C	15	2025-12-20 02:57:32.382395+03	4
3592	articles	I saw ___ iguana in the zoo.	1	Правильный ответ: B	7	2025-12-20 02:57:32.382395+03	5
3593	articles	___ lions live in Africa.	3	Правильный ответ: D	18	2025-12-20 02:57:32.382395+03	5
3594	articles	He bought ___ apple and ___ banana.	1	Правильный ответ: B	2	2025-12-20 02:57:32.382395+03	6
3595	articles	___ Himalayas are very high.	2	Правильный ответ: C	11	2025-12-20 02:57:32.382395+03	6
3596	articles	I need ___ pencil and ___ eraser.	3	Правильный ответ: D	1	2025-12-20 02:57:32.382395+03	7
3597	articles	She usually goes to ___ university by bus.	1	Правильный ответ: B	19	2025-12-20 02:57:32.382395+03	7
3598	articles	___ sun rises in the east.	2	Правильный ответ: C	8	2025-12-20 02:57:32.382395+03	8
3599	articles	I saw ___ fox and ___ rabbit in the forest.	0	Правильный ответ: A	17	2025-12-20 02:57:32.382395+03	8
3600	articles	He is reading ___ article about science.	1	Правильный ответ: B	6	2025-12-20 02:57:32.382395+03	9
3601	articles	We went to ___ cinema yesterday.	2	Правильный ответ: C	19	2025-12-20 02:57:32.382395+03	9
3602	articles	___ sky is clear today.	3	Правильный ответ: D	1	2025-12-20 02:57:32.382395+03	10
3603	articles	I don’t like ___ noise in the street.	3	Правильный ответ: D	13	2025-12-20 02:57:32.382395+03	10
3604	articles	I saw ___ owl in the forest.	1	Правильный ответ: B	0	2025-12-20 02:57:32.382395+03	1
3605	articles	She bought ___ new book.	0	Правильный ответ: A	12	2025-12-20 02:57:32.382395+03	1
3606	articles	___ Nile River is very long.	2	Правильный ответ: C	5	2025-12-20 02:57:32.382395+03	2
3607	articles	I usually drink ___ tea in the morning.	3	Правильный ответ: D	12	2025-12-20 02:57:32.382395+03	2
3608	articles	He found ___ interesting stone.	1	Правильный ответ: B	7	2025-12-20 02:57:32.382395+03	3
3609	articles	We visited ___ Great Wall of China.	2	Правильный ответ: C	19	2025-12-20 02:57:32.382395+03	3
3610	articles	I need ___ hour to finish my task.	1	Правильный ответ: B	8	2025-12-20 02:57:32.382395+03	4
3611	articles	She is ___ fastest runner in the school.	2	Правильный ответ: C	17	2025-12-20 02:57:32.382395+03	4
3612	articles	I saw ___ eagle flying high.	1	Правильный ответ: B	2	2025-12-20 02:57:32.382395+03	5
3613	articles	___ whales are huge animals.	3	Правильный ответ: D	13	2025-12-20 02:57:32.382395+03	5
3614	articles	He bought ___ sandwich and ___ juice.	3	Правильный ответ: D	3	2025-12-20 02:57:32.382395+03	6
3615	articles	___ Alps are covered with snow in winter.	2	Правильный ответ: C	14	2025-12-20 02:57:32.382395+03	6
3616	articles	I need ___ notebook and ___ pencil.	3	Правильный ответ: D	8	2025-12-20 02:57:32.382395+03	7
3617	articles	She usually goes to ___ hospital for checkups.	2	Правильный ответ: C	18	2025-12-20 02:57:32.382395+03	7
3618	articles	___ stars shine brightly in the night sky.	3	Правильный ответ: D	2	2025-12-20 02:57:32.382395+03	8
3619	articles	I saw ___ rabbit and ___ squirrel in the garden.	0	Правильный ответ: A	19	2025-12-20 02:57:32.382395+03	8
3620	articles	He is reading ___ article about history.	1	Правильный ответ: B	3	2025-12-20 02:57:32.382395+03	9
3621	articles	We went to ___ theater last weekend.	2	Правильный ответ: C	18	2025-12-20 02:57:32.382395+03	9
3622	articles	___ sky is cloudy today.	3	Правильный ответ: D	3	2025-12-20 02:57:32.382395+03	10
3623	articles	I don’t like ___ noise near my house.	3	Правильный ответ: D	15	2025-12-20 02:57:32.382395+03	10
3633	pronouns	The teacher praised ___.	1	Правильный ответ: B	15	2025-12-20 02:57:32.688528+03	5
3634	pronouns	This is ___ phone.	1	Правильный ответ: B	5	2025-12-20 02:57:32.688528+03	6
3635	pronouns	This phone is ___.	2	Правильный ответ: C	17	2025-12-20 02:57:32.688528+03	6
3636	pronouns	___ car is parked outside.	1	Правильный ответ: B	4	2025-12-20 02:57:32.688528+03	7
3637	pronouns	That bag is ___.	2	Правильный ответ: C	15	2025-12-20 02:57:32.688528+03	7
3638	pronouns	___ house is very big.	0	Правильный ответ: A	7	2025-12-20 02:57:32.688528+03	8
3639	pronouns	The house is ___.	2	Правильный ответ: C	10	2025-12-20 02:57:32.688528+03	8
3640	pronouns	Is this ___ jacket?	0	Правильный ответ: A	9	2025-12-20 02:57:32.688528+03	9
3641	pronouns	That jacket is ___.	2	Правильный ответ: C	10	2025-12-20 02:57:32.688528+03	9
3642	pronouns	___ laptop is new.	0	Правильный ответ: A	8	2025-12-20 02:57:32.688528+03	10
3643	pronouns	The laptop is ___.	2	Правильный ответ: C	18	2025-12-20 02:57:32.688528+03	10
3644	pronouns	She is taller than ___.	1	Правильный ответ: B	3	2025-12-20 02:57:32.688528+03	1
3645	pronouns	___ don’t like cold weather.	3	Правильный ответ: D	17	2025-12-20 02:57:32.688528+03	1
3647	pronouns	___ works in this company.	1	Правильный ответ: B	15	2025-12-20 02:57:32.688528+03	2
3648	pronouns	Can you see ___ clearly?	1	Правильный ответ: B	2	2025-12-20 02:57:32.688528+03	3
3649	pronouns	They asked ___ to wait.	1	Правильный ответ: B	10	2025-12-20 02:57:32.688528+03	3
3650	pronouns	___ forgot her phone at home.	1	Правильный ответ: B	9	2025-12-20 02:57:32.688528+03	4
3651	pronouns	I met ___ last week.	1	Правильный ответ: B	14	2025-12-20 02:57:32.688528+03	4
3652	pronouns	___ are responsible for this project.	2	Правильный ответ: C	5	2025-12-20 02:57:32.688528+03	5
3653	pronouns	She trusts ___.	1	Правильный ответ: B	19	2025-12-20 02:57:32.688528+03	5
3654	pronouns	This is ___ problem, not mine.	0	Правильный ответ: A	9	2025-12-20 02:57:32.688528+03	6
3655	pronouns	The problem is ___.	2	Правильный ответ: C	10	2025-12-20 02:57:32.688528+03	6
3656	pronouns	___ opinion matters.	0	Правильный ответ: A	7	2025-12-20 02:57:32.688528+03	7
3657	pronouns	That decision was ___.	2	Правильный ответ: C	14	2025-12-20 02:57:32.688528+03	7
3658	pronouns	___ team won the match.	0	Правильный ответ: A	3	2025-12-20 02:57:32.688528+03	8
3659	pronouns	The victory was ___.	2	Правильный ответ: C	18	2025-12-20 02:57:32.688528+03	8
3660	pronouns	Is this ___ seat or mine?	0	Правильный ответ: A	5	2025-12-20 02:57:32.688528+03	9
3661	pronouns	That seat is ___.	2	Правильный ответ: C	16	2025-12-20 02:57:32.688528+03	9
3662	pronouns	___ dog is very friendly.	0	Правильный ответ: A	9	2025-12-20 02:57:32.688528+03	10
3663	pronouns	The friendly dog is ___.	2	Правильный ответ: C	16	2025-12-20 02:57:32.688528+03	10
3664	pronouns	___ is my favorite movie.	2	Правильный ответ: C	9	2025-12-20 02:57:32.688528+03	1
3665	pronouns	___ are my friends.	2	Правильный ответ: C	19	2025-12-20 02:57:32.688528+03	1
3666	pronouns	I don’t know ___.	1	Правильный ответ: B	4	2025-12-20 02:57:32.688528+03	2
3667	pronouns	___ broke the window.	1	Правильный ответ: B	19	2025-12-20 02:57:32.688528+03	2
3669	pronouns	___ house is old.	0	Правильный ответ: A	12	2025-12-20 02:57:32.688528+03	3
3670	pronouns	The house is ___.	2	Правильный ответ: C	0	2025-12-20 02:57:32.688528+03	4
3671	pronouns	___ doesn’t work here anymore.	1	Правильный ответ: B	16	2025-12-20 02:57:32.688528+03	4
3672	pronouns	Can you hear ___?	1	Правильный ответ: B	8	2025-12-20 02:57:32.688528+03	5
3673	pronouns	___ are late again.	2	Правильный ответ: C	16	2025-12-20 02:57:32.688528+03	5
3674	pronouns	This book is ___.	2	Правильный ответ: C	8	2025-12-20 02:57:32.688528+03	6
3675	pronouns	___ book is on the table.	1	Правильный ответ: B	16	2025-12-20 02:57:32.688528+03	6
3676	pronouns	That opinion is ___.	2	Правильный ответ: C	9	2025-12-20 02:57:32.688528+03	7
3677	pronouns	___ idea sounds good.	0	Правильный ответ: A	10	2025-12-20 02:57:32.688528+03	7
3678	pronouns	___ are ready to leave.	1	Правильный ответ: B	9	2025-12-20 02:57:32.688528+03	8
3679	pronouns	She spoke to ___.	1	Правильный ответ: B	14	2025-12-20 02:57:32.688528+03	8
3680	pronouns	___ shoes are dirty.	2	Правильный ответ: C	1	2025-12-20 02:57:32.688528+03	9
3681	pronouns	___ doesn’t belong here.	2	Правильный ответ: C	17	2025-12-20 02:57:32.688528+03	9
3682	pronouns	I trust ___.	1	Правильный ответ: B	0	2025-12-20 02:57:32.688528+03	10
3683	pronouns	___ decision was final.	0	Правильный ответ: A	10	2025-12-20 02:57:32.688528+03	10
3684	pronouns	___ is raining again.	2	Правильный ответ: C	1	2025-12-20 02:57:32.688528+03	1
3685	pronouns	I like ___ very much.	1	Правильный ответ: B	14	2025-12-20 02:57:32.688528+03	1
3686	pronouns	___ forgot his wallet.	1	Правильный ответ: B	7	2025-12-20 02:57:32.688528+03	2
3687	pronouns	Can you help ___ with this?	1	Правильный ответ: B	10	2025-12-20 02:57:32.688528+03	2
3688	pronouns	___ room is bigger than mine.	0	Правильный ответ: A	8	2025-12-20 02:57:32.688528+03	3
3689	pronouns	That room is ___.	2	Правильный ответ: C	13	2025-12-20 02:57:32.688528+03	3
3691	pronouns	___ car over there is new.	1	Правильный ответ: B	12	2025-12-20 02:57:32.688528+03	4
3692	pronouns	She looked at ___.	1	Правильный ответ: B	4	2025-12-20 02:57:32.688528+03	5
3693	pronouns	___ like to travel.	1	Правильный ответ: B	12	2025-12-20 02:57:32.688528+03	5
3694	pronouns	This pen is ___.	2	Правильный ответ: C	4	2025-12-20 02:57:32.688528+03	6
3695	pronouns	___ pen is broken.	1	Правильный ответ: B	18	2025-12-20 02:57:32.688528+03	6
3696	pronouns	___ parents are strict.	0	Правильный ответ: A	3	2025-12-20 02:57:32.688528+03	7
3697	pronouns	The choice is ___.	2	Правильный ответ: C	13	2025-12-20 02:57:32.688528+03	7
3698	pronouns	___ doesn’t feel well.	1	Правильный ответ: B	1	2025-12-20 02:57:32.688528+03	8
3699	pronouns	I met ___ at work.	1	Правильный ответ: B	16	2025-12-20 02:57:32.688528+03	8
3700	pronouns	___ shoes are too small.	2	Правильный ответ: C	8	2025-12-20 02:57:32.688528+03	9
3701	pronouns	___ belongs to me.	0	Правильный ответ: A	11	2025-12-20 02:57:32.688528+03	9
3702	pronouns	___ dog is barking.	0	Правильный ответ: A	6	2025-12-20 02:57:32.688528+03	10
3703	pronouns	The dog is ___.	2	Правильный ответ: C	17	2025-12-20 02:57:32.688528+03	10
3704	pronouns	___ is my responsibility.	0	Правильный ответ: A	2	2025-12-20 02:57:32.688528+03	1
3705	pronouns	She invited ___.	1	Правильный ответ: B	13	2025-12-20 02:57:32.688528+03	1
3706	pronouns	___ knows the answer.	1	Правильный ответ: B	9	2025-12-20 02:57:32.688528+03	2
3707	pronouns	They helped ___.	1	Правильный ответ: B	18	2025-12-20 02:57:32.688528+03	2
3708	pronouns	___ idea was rejected.	0	Правильный ответ: A	9	2025-12-20 02:57:32.688528+03	3
3709	pronouns	The idea was ___.	2	Правильный ответ: C	14	2025-12-20 02:57:32.688528+03	3
3710	pronouns	___ are expensive.	2	Правильный ответ: C	7	2025-12-20 02:57:32.688528+03	4
3711	pronouns	___ jacket do you like?	3	Правильный ответ: D	18	2025-12-20 02:57:32.688528+03	4
3712	pronouns	This jacket is ___.	2	Правильный ответ: C	3	2025-12-20 02:57:32.688528+03	5
3713	pronouns	___ jacket is blue.	1	Правильный ответ: B	14	2025-12-20 02:57:32.688528+03	5
3714	pronouns	___ didn’t call back.	1	Правильный ответ: B	7	2025-12-20 02:57:32.688528+03	6
3715	pronouns	I listened to ___.	1	Правильный ответ: B	12	2025-12-20 02:57:32.688528+03	6
3716	pronouns	___ don’t agree.	1	Правильный ответ: B	0	2025-12-20 02:57:32.688528+03	7
3717	pronouns	That mistake was ___.	2	Правильный ответ: C	12	2025-12-20 02:57:32.688528+03	7
3718	pronouns	___ phone is ringing.	0	Правильный ответ: A	0	2025-12-20 02:57:32.688528+03	8
3719	pronouns	___ looks familiar.	2	Правильный ответ: C	13	2025-12-20 02:57:32.688528+03	8
3720	pronouns	She borrowed ___.	1	Правильный ответ: B	7	2025-12-20 02:57:32.688528+03	9
3721	pronouns	___ bags are heavy.	2	Правильный ответ: C	12	2025-12-20 02:57:32.688528+03	9
3722	pronouns	___ isn’t working.	2	Правильный ответ: C	7	2025-12-20 02:57:32.688528+03	10
3723	pronouns	The final choice was ___.	2	Правильный ответ: C	14	2025-12-20 02:57:32.688528+03	10
3724	pronouns	___ was my idea.	0	Правильный ответ: A	6	2025-12-20 02:57:32.688528+03	1
3725	pronouns	He thanked ___.	1	Правильный ответ: B	11	2025-12-20 02:57:32.688528+03	1
3726	pronouns	___ are waiting outside.	2	Правильный ответ: C	3	2025-12-20 02:57:32.688528+03	2
3727	pronouns	___ problem is serious.	0	Правильный ответ: A	17	2025-12-20 02:57:32.688528+03	2
3728	pronouns	The problem is ___.	0	Правильный ответ: A	0	2025-12-20 02:57:32.688528+03	3
3729	pronouns	___ are delicious.	2	Правильный ответ: C	15	2025-12-20 02:57:32.688528+03	3
3730	pronouns	___ is too loud.	2	Правильный ответ: C	1	2025-12-20 02:57:32.688528+03	4
3731	pronouns	She trusts ___.	1	Правильный ответ: B	19	2025-12-20 02:57:32.688528+03	4
3732	pronouns	___ opinion matters.	0	Правильный ответ: A	6	2025-12-20 02:57:32.688528+03	5
3733	pronouns	The opinion is ___.	2	Правильный ответ: C	17	2025-12-20 02:57:32.688528+03	5
3734	pronouns	___ forgot their keys.	2	Правильный ответ: C	0	2025-12-20 02:57:32.688528+03	6
3735	pronouns	I saw ___ again.	1	Правильный ответ: B	13	2025-12-20 02:57:32.688528+03	6
3736	pronouns	___ house is far away.	0	Правильный ответ: A	5	2025-12-20 02:57:32.688528+03	7
3737	pronouns	The house is ___.	2	Правильный ответ: C	17	2025-12-20 02:57:32.688528+03	7
3738	pronouns	___ isn’t mine.	0	Правильный ответ: A	4	2025-12-20 02:57:32.688528+03	8
3739	pronouns	___ are broken.	2	Правильный ответ: C	11	2025-12-20 02:57:32.688528+03	8
3740	pronouns	He explained ___ clearly.	1	Правильный ответ: B	4	2025-12-20 02:57:32.688528+03	9
3741	pronouns	___ doesn’t fit.	2	Правильный ответ: C	13	2025-12-20 02:57:32.688528+03	9
3742	pronouns	___ friends are here.	0	Правильный ответ: A	5	2025-12-20 02:57:32.688528+03	10
3743	pronouns	The friends are ___.	2	Правильный ответ: C	19	2025-12-20 02:57:32.688528+03	10
3744	pronouns	___ is my seat.	2	Правильный ответ: C	4	2025-12-20 02:57:32.688528+03	1
3745	pronouns	She called ___.	1	Правильный ответ: B	10	2025-12-20 02:57:32.688528+03	1
3746	pronouns	___ arrived late.	1	Правильный ответ: B	1	2025-12-20 02:57:32.688528+03	2
3747	pronouns	We invited ___.	1	Правильный ответ: B	16	2025-12-20 02:57:32.688528+03	2
3748	pronouns	___ plan failed.	0	Правильный ответ: A	1	2025-12-20 02:57:32.688528+03	3
3749	pronouns	The plan was ___.	2	Правильный ответ: C	16	2025-12-20 02:57:32.688528+03	3
3750	pronouns	___ are expensive shoes.	2	Правильный ответ: C	2	2025-12-20 02:57:32.688528+03	4
3751	pronouns	___ belongs to him.	0	Правильный ответ: A	13	2025-12-20 02:57:32.688528+03	4
3752	pronouns	He likes ___.	1	Правильный ответ: B	1	2025-12-20 02:57:32.688528+03	5
3753	pronouns	___ doesn’t matter.	2	Правильный ответ: C	10	2025-12-20 02:57:32.688528+03	5
3754	pronouns	___ phone is missing.	0	Правильный ответ: A	6	2025-12-20 02:57:32.688528+03	6
3755	pronouns	The phone is ___.	2	Правильный ответ: C	19	2025-12-20 02:57:32.688528+03	6
3756	pronouns	___ are responsible.	1	Правильный ответ: B	2	2025-12-20 02:57:32.688528+03	7
3757	pronouns	She talked to ___.	1	Правильный ответ: B	16	2025-12-20 02:57:32.688528+03	7
3758	pronouns	___ dress is beautiful.	0	Правильный ответ: A	5	2025-12-20 02:57:32.688528+03	8
3759	pronouns	The dress is ___.	2	Правильный ответ: C	12	2025-12-20 02:57:32.688528+03	8
3760	pronouns	___ doesn’t belong here.	2	Правильный ответ: C	0	2025-12-20 02:57:32.688528+03	9
3761	pronouns	___ bags are ready.	2	Правильный ответ: C	14	2025-12-20 02:57:32.688528+03	9
3762	pronouns	___ teacher is strict.	0	Правильный ответ: A	2	2025-12-20 02:57:32.688528+03	10
3763	pronouns	The teacher is ___.	2	Правильный ответ: C	12	2025-12-20 02:57:32.688528+03	10
3764	pronouns	___ was a mistake.	0	Правильный ответ: A	7	2025-12-20 02:57:32.688528+03	1
3765	pronouns	He blamed ___.	1	Правильный ответ: B	16	2025-12-20 02:57:32.688528+03	1
3766	pronouns	___ is my fault.	0	Правильный ответ: A	8	2025-12-20 02:57:32.688528+03	2
3767	pronouns	___ are not ready.	1	Правильный ответ: B	14	2025-12-20 02:57:32.688528+03	2
3768	pronouns	She believes ___.	1	Правильный ответ: B	5	2025-12-20 02:57:32.688528+03	3
3769	pronouns	___ answer is correct.	0	Правильный ответ: A	17	2025-12-20 02:57:32.688528+03	3
3770	pronouns	The answer is ___.	2	Правильный ответ: C	5	2025-12-20 02:57:32.688528+03	4
3771	pronouns	___ are my notes.	2	Правильный ответ: C	10	2025-12-20 02:57:32.688528+03	4
3772	pronouns	___ doesn’t work.	2	Правильный ответ: C	9	2025-12-20 02:57:32.688528+03	5
3773	pronouns	They trust ___.	1	Правильный ответ: B	11	2025-12-20 02:57:32.688528+03	5
3774	pronouns	___ jacket is warm.	0	Правильный ответ: A	1	2025-12-20 02:57:32.688528+03	6
3775	pronouns	The jacket is ___.	0	Правильный ответ: A	15	2025-12-20 02:57:32.688528+03	6
3776	pronouns	___ doesn’t agree.	0	Правильный ответ: A	6	2025-12-20 02:57:32.688528+03	7
3777	pronouns	I listened to ___.	1	Правильный ответ: B	11	2025-12-20 02:57:32.688528+03	7
3778	pronouns	___ bags are heavy.	2	Правильный ответ: C	6	2025-12-20 02:57:32.688528+03	8
3780	pronouns	___ dog is barking.	0	Правильный ответ: A	2	2025-12-20 02:57:32.688528+03	9
3781	pronouns	The dog is ___.	2	Правильный ответ: C	15	2025-12-20 02:57:32.688528+03	9
3782	pronouns	She helped ___.	1	Правильный ответ: B	4	2025-12-20 02:57:32.688528+03	10
3783	pronouns	___ forgot the keys.	1	Правильный ответ: B	11	2025-12-20 02:57:32.688528+03	10
3784	pronouns	___ is interesting.	0	Правильный ответ: A	5	2025-12-20 02:57:32.688528+03	1
3785	pronouns	I like ___.	1	Правильный ответ: B	15	2025-12-20 02:57:32.688528+03	1
3786	pronouns	___ are expensive tickets.	2	Правильный ответ: C	0	2025-12-20 02:57:32.688528+03	2
3787	pronouns	___ didn’t answer.	1	Правильный ответ: B	13	2025-12-20 02:57:32.688528+03	2
3788	pronouns	They invited ___.	1	Правильный ответ: B	6	2025-12-20 02:57:32.688528+03	3
3789	pronouns	___ house is new.	0	Правильный ответ: A	18	2025-12-20 02:57:32.688528+03	3
3790	pronouns	The house is ___.	2	Правильный ответ: C	4	2025-12-20 02:57:32.688528+03	4
3791	pronouns	___ is not mine.	0	Правильный ответ: A	15	2025-12-20 02:57:32.688528+03	4
3792	pronouns	She trusts ___.	1	Правильный ответ: B	7	2025-12-20 02:57:32.688528+03	5
3793	pronouns	___ don’t agree.	1	Правильный ответ: B	18	2025-12-20 02:57:32.688528+03	5
3794	pronouns	___ opinion matters.	0	Правильный ответ: A	2	2025-12-20 02:57:32.688528+03	6
3795	pronouns	That choice is ___.	2	Правильный ответ: C	11	2025-12-20 02:57:32.688528+03	6
3796	pronouns	___ bags are ready.	2	Правильный ответ: C	1	2025-12-20 02:57:32.688528+03	7
3797	pronouns	___ is too expensive.	2	Правильный ответ: C	19	2025-12-20 02:57:32.688528+03	7
3798	pronouns	He spoke to ___.	1	Правильный ответ: B	8	2025-12-20 02:57:32.688528+03	8
3799	pronouns	___ jacket is dirty.	0	Правильный ответ: A	17	2025-12-20 02:57:32.688528+03	8
3800	pronouns	The jacket is ___.	2	Правильный ответ: C	6	2025-12-20 02:57:32.688528+03	9
3801	pronouns	___ doesn’t work properly.	2	Правильный ответ: C	19	2025-12-20 02:57:32.688528+03	9
3802	pronouns	___ friends arrived.	0	Правильный ответ: A	1	2025-12-20 02:57:32.688528+03	10
3803	pronouns	The friends are ___.	2	Правильный ответ: C	13	2025-12-20 02:57:32.688528+03	10
3804	pronouns	___ is my turn.	0	Правильный ответ: A	0	2025-12-20 02:57:32.688528+03	1
3805	pronouns	She called ___.	1	Правильный ответ: B	12	2025-12-20 02:57:32.688528+03	1
3806	pronouns	___ arrived early.	1	Правильный ответ: B	5	2025-12-20 02:57:32.688528+03	2
4364	adjectives	She has a ___ car.	0	Правильный ответ: A	8	2025-12-20 16:17:42.675045+03	1
4365	adjectives	The house is ___.	1	Правильный ответ: B	18	2025-12-20 16:17:42.675045+03	1
4366	adjectives	This is ___ than that book.	2	Правильный ответ: C	6	2025-12-20 16:17:42.675045+03	2
4367	adjectives	He is ___ student in the class.	3	Правильный ответ: D	11	2025-12-20 16:17:42.675045+03	2
4368	adjectives	I need a ___ car.	0	Правильный ответ: A	3	2025-12-20 16:17:42.675045+03	3
4369	adjectives	She is ___ beautiful.	1	Правильный ответ: B	11	2025-12-20 16:17:42.675045+03	3
4370	adjectives	They live in ___ house.	2	Правильный ответ: C	3	2025-12-20 16:17:42.675045+03	4
4371	adjectives	The movie ___ boring.	3	Правильный ответ: D	11	2025-12-20 16:17:42.675045+03	4
4372	adjectives	___ girls are here.	0	Правильный ответ: A	0	2025-12-20 16:17:42.675045+03	5
4373	adjectives	He is ___ than me.	1	Правильный ответ: B	15	2025-12-20 16:17:42.675045+03	5
4374	adjectives	This is ___ book in the library.	1	Правильный ответ: B	5	2025-12-20 16:17:42.675045+03	6
4375	adjectives	My car is ___ than yours.	2	Правильный ответ: C	17	2025-12-20 16:17:42.675045+03	6
4376	adjectives	She bought a ___ dress.	1	Правильный ответ: B	4	2025-12-20 16:17:42.675045+03	7
4377	adjectives	The weather ___ cold.	2	Правильный ответ: C	15	2025-12-20 16:17:42.675045+03	7
4378	adjectives	I saw a ___ dog.	3	Правильный ответ: D	7	2025-12-20 16:17:42.675045+03	8
4379	adjectives	This is ___ movie I've seen.	0	Правильный ответ: A	10	2025-12-20 16:17:42.675045+03	8
4380	adjectives	We need ___ table.	1	Правильный ответ: B	9	2025-12-20 16:17:42.675045+03	9
4381	adjectives	He ___ hungry.	2	Правильный ответ: C	10	2025-12-20 16:17:42.675045+03	9
4382	adjectives	___ cars are expensive.	3	Правильный ответ: D	8	2025-12-20 16:17:42.675045+03	10
4383	adjectives	She is ___ person here.	0	Правильный ответ: A	18	2025-12-20 16:17:42.675045+03	10
4384	adjectives	This book is ___ than that one.	1	Правильный ответ: B	3	2025-12-20 16:17:42.675045+03	1
4385	adjectives	She is ___ girl in school.	3	Правильный ответ: D	17	2025-12-20 16:17:42.675045+03	1
4387	adjectives	This is ___ day of the year.	1	Правильный ответ: B	15	2025-12-20 16:17:42.675045+03	2
4388	adjectives	He is ___ than his brother.	1	Правильный ответ: B	2	2025-12-20 16:17:42.675045+03	3
4389	adjectives	This is ___ problem we have.	3	Правильный ответ: D	10	2025-12-20 16:17:42.675045+03	3
4390	adjectives	The red bag is ___ than the blue one.	2	Правильный ответ: C	9	2025-12-20 16:17:42.675045+03	4
4391	adjectives	She is ___ singer in the competition.	3	Правильный ответ: D	14	2025-12-20 16:17:42.675045+03	4
4392	adjectives	Today is ___ than yesterday.	0	Правильный ответ: A	5	2025-12-20 16:17:42.675045+03	5
4393	adjectives	This is ___ car in the parking lot.	2	Правильный ответ: C	19	2025-12-20 16:17:42.675045+03	5
4394	adjectives	He is ___ runner on the team.	3	Правильный ответ: D	9	2025-12-20 16:17:42.675045+03	6
4395	adjectives	This movie is ___ than the first one.	1	Правильный ответ: B	10	2025-12-20 16:17:42.675045+03	6
4396	adjectives	She is ___ person I know.	0	Правильный ответ: A	7	2025-12-20 16:17:42.675045+03	7
4397	adjectives	This test is ___ than the last one.	1	Правильный ответ: B	14	2025-12-20 16:17:42.675045+03	7
4398	adjectives	He is ___ teacher in school.	2	Правильный ответ: C	3	2025-12-20 16:17:42.675045+03	8
4399	adjectives	Summer is ___ than winter.	3	Правильный ответ: D	18	2025-12-20 16:17:42.675045+03	8
4400	adjectives	This is ___ hotel in the city.	0	Правильный ответ: A	5	2025-12-20 16:17:42.675045+03	9
4401	adjectives	She is ___ than before.	1	Правильный ответ: B	16	2025-12-20 16:17:42.675045+03	9
4402	adjectives	This street is ___ than that one.	3	Правильный ответ: D	9	2025-12-20 16:17:42.675045+03	10
4403	adjectives	This is ___ building in the city.	2	Правильный ответ: C	16	2025-12-20 16:17:42.675045+03	10
4404	adjectives	This pizza is ___ than that one.	1	Правильный ответ: B	9	2025-12-20 16:17:42.675045+03	1
4405	adjectives	This is ___ pizza in town.	2	Правильный ответ: C	19	2025-12-20 16:17:42.675045+03	1
4406	adjectives	The weather is ___ today than yesterday.	3	Правильный ответ: D	4	2025-12-20 16:17:42.675045+03	2
4407	adjectives	This is ___ day of the week.	0	Правильный ответ: A	19	2025-12-20 16:17:42.675045+03	2
4409	adjectives	She is ___ beautiful.	2	Правильный ответ: C	12	2025-12-20 16:17:42.675045+03	3
4410	adjectives	The test was ___ difficult.	3	Правильный ответ: D	0	2025-12-20 16:17:42.675045+03	4
4411	adjectives	My result is ___ than yours.	1	Правильный ответ: B	16	2025-12-20 16:17:42.675045+03	4
4412	adjectives	This is ___ important.	1	Правильный ответ: B	8	2025-12-20 16:17:42.675045+03	5
4413	adjectives	Your English is ___ than mine.	2	Правильный ответ: C	16	2025-12-20 16:17:42.675045+03	5
4414	adjectives	This is ___ idea ever.	3	Правильный ответ: D	8	2025-12-20 16:17:42.675045+03	6
4415	adjectives	She is ___ tired.	0	Правильный ответ: A	16	2025-12-20 16:17:42.675045+03	6
4416	adjectives	His score is ___ than hers.	1	Правильный ответ: B	9	2025-12-20 16:17:42.675045+03	7
4417	adjectives	The book is ___ boring.	2	Правильный ответ: C	10	2025-12-20 16:17:42.675045+03	7
4418	adjectives	That was ___ decision I made.	1	Правильный ответ: B	9	2025-12-20 16:17:42.675045+03	8
4419	adjectives	He was ___ angry.	2	Правильный ответ: C	14	2025-12-20 16:17:42.675045+03	8
4420	adjectives	This is ___ movie I've seen.	0	Правильный ответ: A	1	2025-12-20 16:17:42.675045+03	9
4421	adjectives	This is ___ expensive.	3	Правильный ответ: D	17	2025-12-20 16:17:42.675045+03	9
4422	adjectives	The food was ___ delicious.	0	Правильный ответ: A	0	2025-12-20 16:17:42.675045+03	10
4423	adjectives	He is ___ smart.	2	Правильный ответ: C	10	2025-12-20 16:17:42.675045+03	10
4424	adjectives	___ girls (красивые девушки)	2	Правильный ответ: C	1	2025-12-20 16:17:42.675045+03	1
4425	adjectives	___ houses (большие дома)	3	Правильный ответ: D	14	2025-12-20 16:17:42.675045+03	1
4426	adjectives	I saw a ___ cat.	0	Правильный ответ: A	7	2025-12-20 16:17:42.675045+03	2
4427	adjectives	She has ___ hair.	1	Правильный ответ: B	10	2025-12-20 16:17:42.675045+03	2
4428	adjectives	___ cars (быстрые машины)	2	Правильный ответ: C	8	2025-12-20 16:17:42.675045+03	3
4429	adjectives	He drives a ___ car.	3	Правильный ответ: D	13	2025-12-20 16:17:42.675045+03	3
4431	adjectives	They live in a ___ apartment.	1	Правильный ответ: B	12	2025-12-20 16:17:42.675045+03	4
4432	adjectives	___ books (старые книги)	2	Правильный ответ: C	4	2025-12-20 16:17:42.675045+03	5
4433	adjectives	I bought ___ shoes.	3	Правильный ответ: D	12	2025-12-20 16:17:42.675045+03	5
4434	adjectives	___ students (умные студенты)	0	Правильный ответ: A	4	2025-12-20 16:17:42.675045+03	6
4435	adjectives	She wore a ___ dress.	1	Правильный ответ: B	18	2025-12-20 16:17:42.675045+03	6
4436	adjectives	___ flowers (красивые цветы)	2	Правильный ответ: C	3	2025-12-20 16:17:42.675045+03	7
4437	adjectives	He has a ___ phone.	2	Правильный ответ: C	13	2025-12-20 16:17:42.675045+03	7
4438	adjectives	___ dogs (маленькие собаки)	3	Правильный ответ: D	1	2025-12-20 16:17:42.675045+03	8
4439	adjectives	We saw a ___ building.	0	Правильный ответ: A	16	2025-12-20 16:17:42.675045+03	8
4440	adjectives	___ children (счастливые дети)	1	Правильный ответ: B	8	2025-12-20 16:17:42.675045+03	9
4441	adjectives	I need a ___ pen.	2	Правильный ответ: C	11	2025-12-20 16:17:42.675045+03	9
4442	adjectives	___ teachers (хорошие учителя)	3	Правильный ответ: D	6	2025-12-20 16:17:42.675045+03	10
4443	adjectives	She found a ___ bag.	0	Правильный ответ: A	17	2025-12-20 16:17:42.675045+03	10
4444	adjectives	She has a ___ car.	0	Правильный ответ: A	2	2025-12-20 16:17:42.675045+03	1
4445	adjectives	The house ___ big.	1	Правильный ответ: B	13	2025-12-20 16:17:42.675045+03	1
4446	adjectives	I saw a ___ dog.	2	Правильный ответ: C	9	2025-12-20 16:17:42.675045+03	2
4447	adjectives	She ___ smart.	3	Правильный ответ: D	18	2025-12-20 16:17:42.675045+03	2
4448	adjectives	He bought a ___ house.	0	Правильный ответ: A	9	2025-12-20 16:17:42.675045+03	3
4449	adjectives	The weather ___ cold.	1	Правильный ответ: B	14	2025-12-20 16:17:42.675045+03	3
4450	adjectives	She wore a ___ dress.	2	Правильный ответ: C	7	2025-12-20 16:17:42.675045+03	4
4451	adjectives	They ___ happy.	3	Правильный ответ: D	18	2025-12-20 16:17:42.675045+03	4
4452	adjectives	They have a ___ table.	0	Правильный ответ: A	3	2025-12-20 16:17:42.675045+03	5
4453	adjectives	I ___ tired.	3	Правильный ответ: D	14	2025-12-20 16:17:42.675045+03	5
4454	adjectives	I need a ___ bag.	1	Правильный ответ: B	7	2025-12-20 16:17:42.675045+03	6
4455	adjectives	The movie ___ boring.	2	Правильный ответ: C	12	2025-12-20 16:17:42.675045+03	6
4456	adjectives	She found a ___ book.	1	Правильный ответ: B	0	2025-12-20 16:17:42.675045+03	7
4457	adjectives	We ___ ready.	3	Правильный ответ: D	12	2025-12-20 16:17:42.675045+03	7
4458	adjectives	He drives a ___ car.	0	Правильный ответ: A	0	2025-12-20 16:17:42.675045+03	8
4459	adjectives	The books ___ expensive.	1	Правильный ответ: B	13	2025-12-20 16:17:42.675045+03	8
4460	adjectives	We saw a ___ bird.	2	Правильный ответ: C	7	2025-12-20 16:17:42.675045+03	9
4461	adjectives	He ___ hungry.	3	Правильный ответ: D	12	2025-12-20 16:17:42.675045+03	9
4462	adjectives	I bought a ___ laptop.	0	Правильный ответ: A	7	2025-12-20 16:17:42.675045+03	10
4463	adjectives	The children ___ quiet.	1	Правильный ответ: B	14	2025-12-20 16:17:42.675045+03	10
4464	adjectives	My car is faster ___ yours.	0	Правильный ответ: A	6	2025-12-20 16:17:42.675045+03	1
4465	adjectives	She is taller ___ her sister.	1	Правильный ответ: B	11	2025-12-20 16:17:42.675045+03	1
4466	adjectives	This book is more interesting ___ that one.	2	Правильный ответ: C	3	2025-12-20 16:17:42.675045+03	2
4467	adjectives	He is older ___ me.	3	Правильный ответ: D	17	2025-12-20 16:17:42.675045+03	2
4468	adjectives	This house is bigger ___ mine.	0	Правильный ответ: A	0	2025-12-20 16:17:42.675045+03	3
4469	adjectives	She is smarter ___ him.	1	Правильный ответ: B	15	2025-12-20 16:17:42.675045+03	3
4470	adjectives	Today is colder ___ yesterday.	2	Правильный ответ: C	1	2025-12-20 16:17:42.675045+03	4
4471	adjectives	This test is easier ___ the last one.	3	Правильный ответ: D	19	2025-12-20 16:17:42.675045+03	4
4472	adjectives	My room is cleaner ___ yours.	0	Правильный ответ: A	6	2025-12-20 16:17:42.675045+03	5
4473	adjectives	She is more beautiful ___ before.	1	Правильный ответ: B	17	2025-12-20 16:17:42.675045+03	5
4474	adjectives	He runs faster ___ everyone.	2	Правильный ответ: C	0	2025-12-20 16:17:42.675045+03	6
4475	adjectives	This car is cheaper ___ that one.	3	Правильный ответ: D	13	2025-12-20 16:17:42.675045+03	6
4476	adjectives	She is more confident ___ yesterday.	0	Правильный ответ: A	5	2025-12-20 16:17:42.675045+03	7
4477	adjectives	My phone is newer ___ yours.	1	Правильный ответ: B	17	2025-12-20 16:17:42.675045+03	7
4478	adjectives	This problem is harder ___ I thought.	2	Правильный ответ: C	4	2025-12-20 16:17:42.675045+03	8
4479	adjectives	He is stronger ___ his brother.	3	Правильный ответ: D	11	2025-12-20 16:17:42.675045+03	8
4480	adjectives	The movie was longer ___ expected.	0	Правильный ответ: A	4	2025-12-20 16:17:42.675045+03	9
4481	adjectives	This lesson is more important ___ the last.	1	Правильный ответ: B	13	2025-12-20 16:17:42.675045+03	9
4482	adjectives	She speaks louder ___ him.	2	Правильный ответ: C	5	2025-12-20 16:17:42.675045+03	10
4483	adjectives	Winter is colder ___ autumn.	3	Правильный ответ: D	19	2025-12-20 16:17:42.675045+03	10
4484	adjectives	This is ___ biggest house in town.	0	Правильный ответ: A	4	2025-12-20 16:17:42.675045+03	1
4485	adjectives	He is ___ smartest student.	1	Правильный ответ: B	10	2025-12-20 16:17:42.675045+03	1
4486	adjectives	She is ___ most beautiful girl.	2	Правильный ответ: C	1	2025-12-20 16:17:42.675045+03	2
4487	adjectives	This is ___ oldest building.	3	Правильный ответ: D	16	2025-12-20 16:17:42.675045+03	2
4488	adjectives	He is ___ fastest runner.	0	Правильный ответ: A	1	2025-12-20 16:17:42.675045+03	3
4489	adjectives	This is ___ best pizza.	1	Правильный ответ: B	16	2025-12-20 16:17:42.675045+03	3
4490	adjectives	She is ___ youngest child.	2	Правильный ответ: C	2	2025-12-20 16:17:42.675045+03	4
4491	adjectives	This is ___ most expensive car.	3	Правильный ответ: D	13	2025-12-20 16:17:42.675045+03	4
4492	adjectives	He is ___ tallest player.	0	Правильный ответ: A	1	2025-12-20 16:17:42.675045+03	5
4493	adjectives	This is ___ worst day.	1	Правильный ответ: B	10	2025-12-20 16:17:42.675045+03	5
4494	adjectives	She is ___ kindest person.	2	Правильный ответ: C	6	2025-12-20 16:17:42.675045+03	6
4495	adjectives	This is ___ longest road.	3	Правильный ответ: D	19	2025-12-20 16:17:42.675045+03	6
4496	adjectives	He is ___ strongest boy.	0	Правильный ответ: A	2	2025-12-20 16:17:42.675045+03	7
4497	adjectives	This is ___ hottest day.	1	Правильный ответ: B	16	2025-12-20 16:17:42.675045+03	7
4498	adjectives	She is ___ most talented singer.	2	Правильный ответ: C	5	2025-12-20 16:17:42.675045+03	8
4499	adjectives	This is ___ cheapest option.	3	Правильный ответ: D	12	2025-12-20 16:17:42.675045+03	8
4500	adjectives	He is ___ most successful person.	0	Правильный ответ: A	0	2025-12-20 16:17:42.675045+03	9
4501	adjectives	This is ___ coldest winter.	1	Правильный ответ: B	14	2025-12-20 16:17:42.675045+03	9
4502	adjectives	She is ___ most popular student.	2	Правильный ответ: C	2	2025-12-20 16:17:42.675045+03	10
4503	adjectives	This is ___ most comfortable hotel.	3	Правильный ответ: D	12	2025-12-20 16:17:42.675045+03	10
4504	adjectives	The soup tastes ___.	0	Правильный ответ: A	7	2025-12-20 16:17:42.675045+03	1
4505	adjectives	She looks ___.	1	Правильный ответ: B	16	2025-12-20 16:17:42.675045+03	1
4506	adjectives	The flowers smell ___.	2	Правильный ответ: C	8	2025-12-20 16:17:42.675045+03	2
4507	adjectives	He seems ___.	3	Правильный ответ: D	14	2025-12-20 16:17:42.675045+03	2
4508	adjectives	The music sounds ___.	0	Правильный ответ: A	5	2025-12-20 16:17:42.675045+03	3
4509	adjectives	She feels ___.	1	Правильный ответ: B	17	2025-12-20 16:17:42.675045+03	3
4510	adjectives	The cake tastes ___.	2	Правильный ответ: C	5	2025-12-20 16:17:42.675045+03	4
4511	adjectives	He appears ___.	3	Правильный ответ: D	10	2025-12-20 16:17:42.675045+03	4
4512	adjectives	The weather seems ___.	0	Правильный ответ: A	9	2025-12-20 16:17:42.675045+03	5
4513	adjectives	She looks ___.	1	Правильный ответ: B	11	2025-12-20 16:17:42.675045+03	5
4514	adjectives	The coffee smells ___.	2	Правильный ответ: C	1	2025-12-20 16:17:42.675045+03	6
4515	adjectives	He feels ___.	3	Правильный ответ: D	15	2025-12-20 16:17:42.675045+03	6
4516	adjectives	The food tastes ___.	0	Правильный ответ: A	6	2025-12-20 16:17:42.675045+03	7
4517	adjectives	She seems ___.	1	Правильный ответ: B	11	2025-12-20 16:17:42.675045+03	7
4518	adjectives	The room looks ___.	2	Правильный ответ: C	6	2025-12-20 16:17:42.675045+03	8
4520	adjectives	The flowers smell ___.	0	Правильный ответ: A	2	2025-12-20 16:17:42.675045+03	9
4521	adjectives	She feels ___.	1	Правильный ответ: B	15	2025-12-20 16:17:42.675045+03	9
4522	adjectives	The music sounds ___.	2	Правильный ответ: C	4	2025-12-20 16:17:42.675045+03	10
4523	adjectives	The situation seems ___.	1	Правильный ответ: B	11	2025-12-20 16:17:42.675045+03	10
4524	adjectives	Правильная форма: красивые дома	3	Правильный ответ: D	5	2025-12-20 16:17:42.675045+03	1
4525	adjectives	Правильная форма: она красивая	3	Правильный ответ: D	15	2025-12-20 16:17:42.675045+03	1
4526	adjectives	Правильная форма: большой дом	3	Правильный ответ: D	0	2025-12-20 16:17:42.675045+03	2
4527	adjectives	Правильная форма: лучше	3	Правильный ответ: D	13	2025-12-20 16:17:42.675045+03	2
4528	adjectives	Правильная форма: самый интересный	3	Правильный ответ: D	6	2025-12-20 16:17:42.675045+03	3
4529	adjectives	Правильная форма: очень умный	2	Правильный ответ: C	18	2025-12-20 16:17:42.675045+03	3
4530	adjectives	Правильная форма: быстрые машины	1	Правильный ответ: B	4	2025-12-20 16:17:42.675045+03	4
4531	adjectives	Правильная форма: старая книга	0	Правильный ответ: A	15	2025-12-20 16:17:42.675045+03	4
4532	adjectives	Правильная форма: хуже	1	Правильный ответ: B	7	2025-12-20 16:17:42.675045+03	5
4533	adjectives	Правильная форма: маленький ребенок	2	Правильный ответ: C	18	2025-12-20 16:17:42.675045+03	5
4534	adjectives	Правильная форма: они счастливы	1	Правильный ответ: B	2	2025-12-20 16:17:42.675045+03	6
4535	adjectives	Правильная форма: новый телефон	3	Правильный ответ: D	11	2025-12-20 16:17:42.675045+03	6
4536	adjectives	Правильная форма: самый лучший	0	Правильный ответ: A	1	2025-12-20 16:17:42.675045+03	7
4537	adjectives	Правильная форма: более дорогой	1	Правильный ответ: B	19	2025-12-20 16:17:42.675045+03	7
4538	adjectives	Правильная форма: холодная вода	2	Правильный ответ: C	8	2025-12-20 16:17:42.675045+03	8
4539	adjectives	Правильная форма: умные студенты	3	Правильный ответ: D	17	2025-12-20 16:17:42.675045+03	8
4540	adjectives	Правильная форма: самый худший	0	Правильный ответ: A	6	2025-12-20 16:17:42.675045+03	9
4541	adjectives	Правильная форма: очень холодно	1	Правильный ответ: B	19	2025-12-20 16:17:42.675045+03	9
4542	adjectives	Правильная форма: высокий человек	2	Правильный ответ: C	1	2025-12-20 16:17:42.675045+03	10
4543	adjectives	Правильная форма: более интересный	3	Правильный ответ: D	13	2025-12-20 16:17:42.675045+03	10
4544	adjectives	She has ___ eyes.	0	Правильный ответ: A	0	2025-12-20 16:17:42.675045+03	1
4545	adjectives	This pizza is ___ than that one.	1	Правильный ответ: B	12	2025-12-20 16:17:42.675045+03	1
4546	adjectives	He is ___ person I know.	2	Правильный ответ: C	5	2025-12-20 16:17:42.675045+03	2
4547	adjectives	I bought a ___ phone.	3	Правильный ответ: D	12	2025-12-20 16:17:42.675045+03	2
4548	adjectives	The movie was ___ boring.	0	Правильный ответ: A	7	2025-12-20 16:17:42.675045+03	3
4549	adjectives	She is ___ her sister.	1	Правильный ответ: B	19	2025-12-20 16:17:42.675045+03	3
4550	adjectives	This is ___ expensive restaurant in town.	2	Правильный ответ: C	8	2025-12-20 16:17:42.675045+03	4
4551	adjectives	He looks ___.	3	Правильный ответ: D	17	2025-12-20 16:17:42.675045+03	4
4552	adjectives	This house is ___ than mine.	0	Правильный ответ: A	2	2025-12-20 16:17:42.675045+03	5
4553	adjectives	She is ___ beautiful.	1	Правильный ответ: B	13	2025-12-20 16:17:42.675045+03	5
4554	adjectives	This car is ___ (быстрее).	2	Правильный ответ: C	3	2025-12-20 16:17:42.675045+03	6
4555	adjectives	The weather ___ nice today.	3	Правильный ответ: D	14	2025-12-20 16:17:42.675045+03	6
4556	adjectives	I need ___ coffee.	0	Правильный ответ: A	8	2025-12-20 16:17:42.675045+03	7
4557	adjectives	This is ___ (самый важный).	1	Правильный ответ: B	18	2025-12-20 16:17:42.675045+03	7
4558	adjectives	___ books are on the table.	2	Правильный ответ: C	2	2025-12-20 16:17:42.675045+03	8
4559	adjectives	She is ___ (моложе).	3	Правильный ответ: D	19	2025-12-20 16:17:42.675045+03	8
4560	adjectives	He drives a ___ car.	0	Правильный ответ: A	3	2025-12-20 16:17:42.675045+03	9
4561	adjectives	This is ___ idea ever.	1	Правильный ответ: B	18	2025-12-20 16:17:42.675045+03	9
4562	adjectives	My room is ___ than yours.	2	Правильный ответ: C	3	2025-12-20 16:17:42.675045+03	10
4563	adjectives	She wore a ___ dress.	3	Правильный ответ: D	15	2025-12-20 16:17:42.675045+03	10
4803	present_simple	Does it ___ every winter in this city?	1		6	2025-12-21 13:20:37.35672+03	4
4804	present_simple	Do I ___ like chocolate?	0		7	2025-12-21 13:20:37.35672+03	4
4805	present_simple	Does she ___ watch TV in the morning?	1		8	2025-12-21 13:20:37.35672+03	4
4806	present_simple	Do they ___ play football on Monday?	0		9	2025-12-21 13:20:37.35672+03	4
4807	present_simple	Do we ___ go to school on Sunday?	0		10	2025-12-21 13:20:37.35672+03	4
4808	present_simple	Does he ___ like pizza?	1		11	2025-12-21 13:20:37.35672+03	4
4809	present_simple	Do you ___ speak Spanish?	0		12	2025-12-21 13:20:37.35672+03	4
4810	present_simple	Does it ___ rain in summer?	1		13	2025-12-21 13:20:37.35672+03	4
4811	present_simple	Do I ___ usually wake up at 7 am?	3		14	2025-12-21 13:20:37.35672+03	4
4812	present_simple	Does she ___ always drink coffee?	1		15	2025-12-21 13:20:37.35672+03	4
4813	present_simple	Do they ___ often play chess?	0		16	2025-12-21 13:20:37.35672+03	4
4814	present_simple	Do we ___ sometimes eat out?	0		17	2025-12-21 13:20:37.35672+03	4
4815	present_simple	Does he ___ never eat meat?	1		18	2025-12-21 13:20:37.35672+03	4
4816	present_simple	Do you ___ usually read books?	0		19	2025-12-21 13:20:37.35672+03	4
4817	present_simple	I ___ usually wake up early.	2		0	2025-12-21 13:20:37.35672+03	5
4818	present_simple	She ___ always drinks coffee.	1		1	2025-12-21 13:20:37.35672+03	5
4819	present_simple	They ___ often play chess.	0		2	2025-12-21 13:20:37.35672+03	5
4820	present_simple	We ___ sometimes eat out.	0		3	2025-12-21 13:20:37.35672+03	5
4821	present_simple	He ___ never eats meat.	1		4	2025-12-21 13:20:37.35672+03	5
4822	present_simple	You ___ usually read books.	0		5	2025-12-21 13:20:37.35672+03	5
4823	present_simple	It ___ always rains in April.	1		6	2025-12-21 13:20:37.35672+03	5
4824	present_simple	I ___ often go to the park.	0		7	2025-12-21 13:20:37.35672+03	5
4825	present_simple	She ___ never watches TV.	1		8	2025-12-21 13:20:37.35672+03	5
4826	present_simple	They ___ usually take the bus.	0		9	2025-12-21 13:20:37.35672+03	5
4827	present_simple	We ___ always do homework.	0		10	2025-12-21 13:20:37.35672+03	5
4828	present_simple	He ___ often drinks tea.	1		11	2025-12-21 13:20:37.35672+03	5
4829	present_simple	You ___ sometimes eat out.	0		12	2025-12-21 13:20:37.35672+03	5
4830	present_simple	It ___ usually snows in December.	1		13	2025-12-21 13:20:37.35672+03	5
4831	present_simple	I ___ never eat fast food.	0		14	2025-12-21 13:20:37.35672+03	5
4832	present_simple	She ___ often goes to the gym.	1		15	2025-12-21 13:20:37.35672+03	5
4833	present_simple	They ___ always help me.	0		16	2025-12-21 13:20:37.35672+03	5
4834	present_simple	We ___ sometimes visit friends.	0		17	2025-12-21 13:20:37.35672+03	5
4835	present_simple	He ___ never plays football.	1		18	2025-12-21 13:20:37.35672+03	5
4836	present_simple	You ___ usually study English.	0		19	2025-12-21 13:20:37.35672+03	5
4837	present_simple	I ___ not usually wake up late.	0		0	2025-12-21 13:20:37.35672+03	6
4838	present_simple	She ___ never drinks soda.	1		1	2025-12-21 13:20:37.35672+03	6
4839	present_simple	They ___ not often play football.	0		2	2025-12-21 13:20:37.35672+03	6
4840	present_simple	We ___ not always eat fast food.	0		3	2025-12-21 13:20:37.35672+03	6
4841	present_simple	He ___ never eats meat.	1		4	2025-12-21 13:20:37.35672+03	6
4842	present_simple	You ___ not usually read comics.	0		5	2025-12-21 13:20:37.35672+03	6
4843	present_simple	It ___ not often rains here.	1		6	2025-12-21 13:20:37.35672+03	6
4844	present_simple	I ___ not always study at night.	2		7	2025-12-21 13:20:37.35672+03	6
4845	present_simple	She ___ not sometimes go to the park.	1		8	2025-12-21 13:20:37.35672+03	6
4846	present_simple	They ___ never watch TV.	0		9	2025-12-21 13:20:37.35672+03	6
4847	present_simple	We ___ not often take the bus.	0		10	2025-12-21 13:20:37.35672+03	6
4848	present_simple	He ___ not always drink tea.	1		11	2025-12-21 13:20:37.35672+03	6
4849	present_simple	You ___ never play chess.	0		12	2025-12-21 13:20:37.35672+03	6
4850	present_simple	It ___ not usually snows in summer.	1		13	2025-12-21 13:20:37.35672+03	6
4851	present_simple	I ___ not often eat fast food.	0		14	2025-12-21 13:20:37.35672+03	6
4852	present_simple	She ___ not always go to the gym.	1		15	2025-12-21 13:20:37.35672+03	6
4853	present_simple	They ___ never help me.	0		16	2025-12-21 13:20:37.35672+03	6
4854	present_simple	We ___ not sometimes visit friends.	0		17	2025-12-21 13:20:37.35672+03	6
4855	present_simple	He ___ not always plays football.	1		18	2025-12-21 13:20:37.35672+03	6
4856	present_simple	You ___ not usually study English.	0		19	2025-12-21 13:20:37.35672+03	6
4857	present_simple	Do I ___ usually wake up early?	0		0	2025-12-21 13:20:37.35672+03	7
4858	present_simple	Does she ___ always drink coffee?	0		1	2025-12-21 13:20:37.35672+03	7
4859	present_simple	Do they ___ often play chess?	0		2	2025-12-21 13:20:37.35672+03	7
4860	present_simple	Do we ___ sometimes eat out?	0		3	2025-12-21 13:20:37.35672+03	7
4861	present_simple	Does he ___ never eat meat?	1		4	2025-12-21 13:20:37.35672+03	7
4862	present_simple	Do you ___ usually read books?	0		5	2025-12-21 13:20:37.35672+03	7
4863	present_simple	Does it ___ always rain in April?	1		6	2025-12-21 13:20:37.35672+03	7
4864	present_simple	Do I ___ often go to the park?	0		7	2025-12-21 13:20:37.35672+03	7
4865	present_simple	Does she ___ never watch TV?	0		8	2025-12-21 13:20:37.35672+03	7
4866	present_simple	Do they ___ usually take the bus?	0		9	2025-12-21 13:20:37.35672+03	7
4867	present_simple	Do we ___ always do homework?	0		10	2025-12-21 13:20:37.35672+03	7
4868	present_simple	Does he ___ often drink tea?	1		11	2025-12-21 13:20:37.35672+03	7
4869	present_simple	Do you ___ sometimes eat out?	0		12	2025-12-21 13:20:37.35672+03	7
4870	present_simple	Does it ___ usually snow in December?	1		13	2025-12-21 13:20:37.35672+03	7
4871	present_simple	Do I ___ never eat fast food?	0		14	2025-12-21 13:20:37.35672+03	7
4872	present_simple	Does she ___ often go to the gym?	1		15	2025-12-21 13:20:37.35672+03	7
4873	present_simple	Do they ___ always help me?	0		16	2025-12-21 13:20:37.35672+03	7
4874	present_simple	Do we ___ sometimes visit friends?	0		17	2025-12-21 13:20:37.35672+03	7
4875	present_simple	Does he ___ never play football?	1		18	2025-12-21 13:20:37.35672+03	7
4876	present_simple	Do you ___ usually study English?	0		19	2025-12-21 13:20:37.35672+03	7
4877	present_simple	I ___ football on Sundays.	0		0	2025-12-21 13:20:37.35672+03	8
4878	present_simple	She ___ coffee every morning.	1		1	2025-12-21 13:20:37.35672+03	8
4879	present_simple	They ___ to school by bus.	0		2	2025-12-21 13:20:37.35672+03	8
4880	present_simple	We ___ homework after classes.	0		3	2025-12-21 13:20:37.35672+03	8
4881	present_simple	He ___ English very well.	1		4	2025-12-21 13:20:37.35672+03	8
4882	present_simple	You ___ water every day.	0		5	2025-12-21 13:20:37.35672+03	8
4883	present_simple	It ___ in winter.	1		6	2025-12-21 13:20:37.35672+03	8
4884	present_simple	I ___ not like chocolate.	0		7	2025-12-21 13:20:37.35672+03	8
5703	question_words	___ time is it?	0		6	2025-12-21 17:04:34.76891+03	9
4885	present_simple	She ___ not watch TV in the morning.	1		8	2025-12-21 13:20:37.35672+03	8
4886	present_simple	They ___ not play football on Monday.	0		9	2025-12-21 13:20:37.35672+03	8
4887	present_simple	We ___ sometimes eat out.	0		10	2025-12-21 13:20:37.35672+03	8
4888	present_simple	He ___ never eats meat.	1		11	2025-12-21 13:20:37.35672+03	8
4889	present_simple	You ___ usually read books.	0		12	2025-12-21 13:20:37.35672+03	8
4890	present_simple	It ___ usually rains in April.	1		13	2025-12-21 13:20:37.35672+03	8
4891	present_simple	I ___ often go to the park.	0		14	2025-12-21 13:20:37.35672+03	8
4892	present_simple	She ___ never watches TV.	1		15	2025-12-21 13:20:37.35672+03	8
4893	present_simple	They ___ usually take the bus.	0		16	2025-12-21 13:20:37.35672+03	8
4894	present_simple	We ___ always do homework.	0		17	2025-12-21 13:20:37.35672+03	8
4895	present_simple	He ___ often drinks tea.	1		18	2025-12-21 13:20:37.35672+03	8
4896	present_simple	You ___ sometimes eat out.	0		19	2025-12-21 13:20:37.35672+03	8
4897	present_simple	Do you ___ a lot of water every day?	0		0	2025-12-21 13:20:37.35672+03	9
4898	present_simple	Does it ___ every winter in this city?	1		1	2025-12-21 13:20:37.35672+03	9
4899	present_simple	Do I ___ like chocolate?	0		2	2025-12-21 13:20:37.35672+03	9
4900	present_simple	Does she ___ watch TV in the morning?	1		3	2025-12-21 13:20:37.35672+03	9
4901	present_simple	Do they ___ play football on Monday?	0		4	2025-12-21 13:20:37.35672+03	9
4902	present_simple	Do we ___ go to school on Sunday?	0		5	2025-12-21 13:20:37.35672+03	9
4903	present_simple	Does he ___ like pizza?	1		6	2025-12-21 13:20:37.35672+03	9
4904	present_simple	Do you ___ speak Spanish?	0		7	2025-12-21 13:20:37.35672+03	9
4905	present_simple	Does it ___ rain in summer?	1		8	2025-12-21 13:20:37.35672+03	9
4906	present_simple	Do I ___ usually wake up at 7 am?	3		9	2025-12-21 13:20:37.35672+03	9
4907	present_simple	Does she ___ always drink coffee?	1		10	2025-12-21 13:20:37.35672+03	9
4908	present_simple	Do they ___ often play chess?	0		11	2025-12-21 13:20:37.35672+03	9
4909	present_simple	Do we ___ sometimes eat out?	0		12	2025-12-21 13:20:37.35672+03	9
4910	present_simple	Does he ___ never eat meat?	1		13	2025-12-21 13:20:37.35672+03	9
4911	present_simple	Do you ___ usually read books?	0		14	2025-12-21 13:20:37.35672+03	9
4912	present_simple	Does she ___ sometimes go to the park?	1		15	2025-12-21 13:20:37.35672+03	9
4913	present_simple	Do they ___ always help me?	0		16	2025-12-21 13:20:37.35672+03	9
4914	present_simple	Do we ___ often visit friends?	0		17	2025-12-21 13:20:37.35672+03	9
4915	present_simple	Does he ___ never play football?	1		18	2025-12-21 13:20:37.35672+03	9
4916	present_simple	Do you ___ usually study English?	0		19	2025-12-21 13:20:37.35672+03	9
4917	present_simple	I ___ football every weekend.	1		0	2025-12-21 13:20:37.35672+03	10
4918	present_simple	She ___ tea in the morning.	1		1	2025-12-21 13:20:37.35672+03	10
4919	present_simple	They ___ to school by bus.	0		2	2025-12-21 13:20:37.35672+03	10
4920	present_simple	We ___ homework after class.	0		3	2025-12-21 13:20:37.35672+03	10
4921	present_simple	He ___ English very well.	0		4	2025-12-21 13:20:37.35672+03	10
4922	present_simple	You ___ a lot of water every day.	0		5	2025-12-21 13:20:37.35672+03	10
4923	present_simple	It ___ every winter in this city.	0		6	2025-12-21 13:20:37.35672+03	10
4924	present_simple	I ___ not like chocolate.	0		7	2025-12-21 13:20:37.35672+03	10
4925	present_simple	She ___ not watch TV in the morning.	1		8	2025-12-21 13:20:37.35672+03	10
4926	present_simple	They ___ not play football on Monday.	0		9	2025-12-21 13:20:37.35672+03	10
4927	present_simple	We ___ sometimes eat out.	0		10	2025-12-21 13:20:37.35672+03	10
4928	present_simple	He ___ never eats meat.	1		11	2025-12-21 13:20:37.35672+03	10
4929	present_simple	You ___ usually read books.	0		12	2025-12-21 13:20:37.35672+03	10
4930	present_simple	It ___ always rains in April.	1		13	2025-12-21 13:20:37.35672+03	10
4931	present_simple	I ___ often go to the park.	0		14	2025-12-21 13:20:37.35672+03	10
4932	present_simple	She ___ never watches TV.	1		15	2025-12-21 13:20:37.35672+03	10
4933	present_simple	They ___ usually take the bus.	0		16	2025-12-21 13:20:37.35672+03	10
4934	present_simple	We ___ always do homework.	0		17	2025-12-21 13:20:37.35672+03	10
4935	present_simple	He ___ often drinks tea.	1		18	2025-12-21 13:20:37.35672+03	10
4936	present_simple	You ___ sometimes eat out.	0		19	2025-12-21 13:20:37.35672+03	10
5704	question_words	___ is the bank?	1		7	2025-12-21 17:04:34.76891+03	9
5705	question_words	___ lives here?	2		8	2025-12-21 17:04:34.76891+03	9
5706	question_words	___ old are you?	2		9	2025-12-21 17:04:34.76891+03	9
5707	question_words	___ do you work?	3		10	2025-12-21 17:04:34.76891+03	9
5708	question_words	___ do you study English?	2		11	2025-12-21 17:04:34.76891+03	9
5709	question_words	___ do you do?	0		12	2025-12-21 17:04:34.76891+03	9
5710	question_words	___ are my keys?	1		13	2025-12-21 17:04:34.76891+03	9
5711	question_words	___ is your friend?	2		14	2025-12-21 17:04:34.76891+03	9
5712	question_words	___ much is it?	2		15	2025-12-21 17:04:34.76891+03	9
5713	question_words	___ is the meeting?	2		16	2025-12-21 17:04:34.76891+03	9
5714	question_words	___ is she late?	2		17	2025-12-21 17:04:34.76891+03	9
5715	question_words	___ are you going?	1		18	2025-12-21 17:04:34.76891+03	9
5716	question_words	___ do you feel?	3		19	2025-12-21 17:04:34.76891+03	9
5717	question_words	___ is your phone number?	0		0	2025-12-21 17:04:34.76891+03	10
5718	question_words	___ does she live?	1		1	2025-12-21 17:04:34.76891+03	10
5719	question_words	___ told you?	2		2	2025-12-21 17:04:34.76891+03	10
5720	question_words	___ many books do you have?	3		3	2025-12-21 17:04:34.76891+03	10
5721	question_words	___ is the deadline?	1		4	2025-12-21 17:04:34.76891+03	10
5722	question_words	___ did it happen?	2		5	2025-12-21 17:04:34.76891+03	10
5723	question_words	___ kind of music do you like?	0		6	2025-12-21 17:04:34.76891+03	10
5724	question_words	___ is the party?	1		7	2025-12-21 17:04:34.76891+03	10
5725	question_words	___ made this?	2		8	2025-12-21 17:04:34.76891+03	10
5726	question_words	___ often do you exercise?	3		9	2025-12-21 17:04:34.76891+03	10
5727	question_words	___ is your address?	0		10	2025-12-21 17:04:34.76891+03	10
5728	question_words	___ can I park?	1		11	2025-12-21 17:04:34.76891+03	10
4937	modal_verbs	I ___ swim very well.	0		0	2025-12-21 17:04:33.156028+03	1
4938	modal_verbs	She ___ speak three languages.	0		1	2025-12-21 17:04:33.156028+03	1
4939	modal_verbs	They ___ play football.	0		2	2025-12-21 17:04:33.156028+03	1
4940	modal_verbs	We ___ help you tomorrow.	0		3	2025-12-21 17:04:33.156028+03	1
4941	modal_verbs	He ___ drive a car.	0		4	2025-12-21 17:04:33.156028+03	1
4942	modal_verbs	You ___ use my phone.	0		5	2025-12-21 17:04:33.156028+03	1
4943	modal_verbs	It ___ wait here.	0		6	2025-12-21 17:04:33.156028+03	1
4944	modal_verbs	I ___ cook pasta.	0		7	2025-12-21 17:04:33.156028+03	1
4945	modal_verbs	She ___ dance salsa.	0		8	2025-12-21 17:04:33.156028+03	1
4946	modal_verbs	They ___ come tonight.	0		9	2025-12-21 17:04:33.156028+03	1
4947	modal_verbs	We ___ see the mountains.	0		10	2025-12-21 17:04:33.156028+03	1
4948	modal_verbs	He ___ understand Russian.	0		11	2025-12-21 17:04:33.156028+03	1
4949	modal_verbs	You ___ take this book.	0		12	2025-12-21 17:04:33.156028+03	1
4950	modal_verbs	It ___ fly very high.	0		13	2025-12-21 17:04:33.156028+03	1
4951	modal_verbs	I ___ hear the music.	0		14	2025-12-21 17:04:33.156028+03	1
4952	modal_verbs	She ___ run fast.	0		15	2025-12-21 17:04:33.156028+03	1
4953	modal_verbs	They ___ solve this problem.	0		16	2025-12-21 17:04:33.156028+03	1
4954	modal_verbs	We ___ finish this today.	0		17	2025-12-21 17:04:33.156028+03	1
4955	modal_verbs	He ___ read English books.	0		18	2025-12-21 17:04:33.156028+03	1
4956	modal_verbs	You ___ trust me.	0		19	2025-12-21 17:04:33.156028+03	1
4957	modal_verbs	I ___ swim.	0		0	2025-12-21 17:04:33.156028+03	2
4958	modal_verbs	She ___ speak Chinese.	0		1	2025-12-21 17:04:33.156028+03	2
4959	modal_verbs	They ___ play tennis.	0		2	2025-12-21 17:04:33.156028+03	2
4960	modal_verbs	We ___ help you today.	0		3	2025-12-21 17:04:33.156028+03	2
4961	modal_verbs	He ___ drive a truck.	0		4	2025-12-21 17:04:33.156028+03	2
4962	modal_verbs	You ___ use this computer.	0		5	2025-12-21 17:04:33.156028+03	2
4963	modal_verbs	It ___ work properly.	0		6	2025-12-21 17:04:33.156028+03	2
4964	modal_verbs	I ___ understand this.	0		7	2025-12-21 17:04:33.156028+03	2
4965	modal_verbs	She ___ come tomorrow.	0		8	2025-12-21 17:04:33.156028+03	2
4966	modal_verbs	They ___ find the answer.	0		9	2025-12-21 17:04:33.156028+03	2
4967	modal_verbs	We ___ see anything.	0		10	2025-12-21 17:04:33.156028+03	2
4968	modal_verbs	He ___ remember the name.	0		11	2025-12-21 17:04:33.156028+03	2
4969	modal_verbs	You ___ park here.	0		12	2025-12-21 17:04:33.156028+03	2
4970	modal_verbs	It ___ be true.	0		13	2025-12-21 17:04:33.156028+03	2
4971	modal_verbs	I ___ hear you well.	0		14	2025-12-21 17:04:33.156028+03	2
4972	modal_verbs	She ___ believe this.	0		15	2025-12-21 17:04:33.156028+03	2
4973	modal_verbs	They ___ wait any longer.	0		16	2025-12-21 17:04:33.156028+03	2
4974	modal_verbs	We ___ accept this offer.	0		17	2025-12-21 17:04:33.156028+03	2
4975	modal_verbs	He ___ open the door.	0		18	2025-12-21 17:04:33.156028+03	2
4976	modal_verbs	You ___ leave now.	0		19	2025-12-21 17:04:33.156028+03	2
4977	modal_verbs	___ you swim?	0		0	2025-12-21 17:04:33.156028+03	3
4978	modal_verbs	___ she speak English?	0		1	2025-12-21 17:04:33.156028+03	3
4979	modal_verbs	___ they play guitar?	0		2	2025-12-21 17:04:33.156028+03	3
4980	modal_verbs	___ we help you?	0		3	2025-12-21 17:04:33.156028+03	3
4981	modal_verbs	___ he drive?	0		4	2025-12-21 17:04:33.156028+03	3
4982	modal_verbs	___ you come tonight?	0		5	2025-12-21 17:04:33.156028+03	3
4983	modal_verbs	___ it fly?	0		6	2025-12-21 17:04:33.156028+03	3
4984	modal_verbs	___ I use your phone?	0		7	2025-12-21 17:04:33.156028+03	3
4985	modal_verbs	___ she dance?	0		8	2025-12-21 17:04:33.156028+03	3
4986	modal_verbs	___ they understand?	0		9	2025-12-21 17:04:33.156028+03	3
4987	modal_verbs	___ we park here?	0		10	2025-12-21 17:04:33.156028+03	3
4988	modal_verbs	___ he cook?	0		11	2025-12-21 17:04:33.156028+03	3
4989	modal_verbs	___ you help me?	0		12	2025-12-21 17:04:33.156028+03	3
4990	modal_verbs	___ it work?	0		13	2025-12-21 17:04:33.156028+03	3
4991	modal_verbs	___ I sit here?	0		14	2025-12-21 17:04:33.156028+03	3
4992	modal_verbs	___ she come?	0		15	2025-12-21 17:04:33.156028+03	3
4993	modal_verbs	___ they wait?	0		16	2025-12-21 17:04:33.156028+03	3
4994	modal_verbs	___ we trust you?	0		17	2025-12-21 17:04:33.156028+03	3
4995	modal_verbs	___ he see us?	0		18	2025-12-21 17:04:33.156028+03	3
4996	modal_verbs	___ you hear me?	0		19	2025-12-21 17:04:33.156028+03	3
4997	modal_verbs	I ___ go to work.	0		0	2025-12-21 17:04:33.156028+03	4
4998	modal_verbs	She ___ study tonight.	0		1	2025-12-21 17:04:33.156028+03	4
4999	modal_verbs	They ___ finish this.	0		2	2025-12-21 17:04:33.156028+03	4
5000	modal_verbs	We ___ leave now.	0		3	2025-12-21 17:04:33.156028+03	4
5001	modal_verbs	He ___ call his mom.	0		4	2025-12-21 17:04:33.156028+03	4
5002	modal_verbs	You ___ listen carefully.	0		5	2025-12-21 17:04:33.156028+03	4
5003	modal_verbs	It ___ be ready.	0		6	2025-12-21 17:04:33.156028+03	4
5004	modal_verbs	I ___ tell the truth.	0		7	2025-12-21 17:04:33.156028+03	4
5005	modal_verbs	She ___ wear a uniform.	0		8	2025-12-21 17:04:33.156028+03	4
5006	modal_verbs	They ___ pay the bill.	0		9	2025-12-21 17:04:33.156028+03	4
5007	modal_verbs	We ___ be careful.	0		10	2025-12-21 17:04:33.156028+03	4
5008	modal_verbs	He ___ work harder.	0		11	2025-12-21 17:04:33.156028+03	4
5009	modal_verbs	You ___ follow the rules.	0		12	2025-12-21 17:04:33.156028+03	4
5010	modal_verbs	It ___ stop now.	0		13	2025-12-21 17:04:33.156028+03	4
5011	modal_verbs	I ___ remember this.	0		14	2025-12-21 17:04:33.156028+03	4
5012	modal_verbs	She ___ arrive on time.	0		15	2025-12-21 17:04:33.156028+03	4
5013	modal_verbs	They ___ wait here.	0		16	2025-12-21 17:04:33.156028+03	4
5014	modal_verbs	We ___ try again.	0		17	2025-12-21 17:04:33.156028+03	4
5015	modal_verbs	He ___ understand this.	0		18	2025-12-21 17:04:33.156028+03	4
5016	modal_verbs	You ___ believe me.	0		19	2025-12-21 17:04:33.156028+03	4
5017	modal_verbs	You ___ smoke here.	0		0	2025-12-21 17:04:33.156028+03	5
5018	modal_verbs	He ___ be late.	0		1	2025-12-21 17:04:33.156028+03	5
5019	modal_verbs	They ___ leave now.	0		2	2025-12-21 17:04:33.156028+03	5
5020	modal_verbs	We ___ tell anyone.	0		3	2025-12-21 17:04:33.156028+03	5
5021	modal_verbs	She ___ forget this.	0		4	2025-12-21 17:04:33.156028+03	5
5022	modal_verbs	You ___ touch this.	0		5	2025-12-21 17:04:33.156028+03	5
5023	modal_verbs	I ___ eat this.	0		6	2025-12-21 17:04:33.156028+03	5
5024	modal_verbs	It ___ break.	0		7	2025-12-21 17:04:33.156028+03	5
5025	modal_verbs	He ___ drive fast.	0		8	2025-12-21 17:04:33.156028+03	5
5026	modal_verbs	They ___ park here.	0		9	2025-12-21 17:04:33.156028+03	5
5027	modal_verbs	We ___ waste time.	0		10	2025-12-21 17:04:33.156028+03	5
5028	modal_verbs	She ___ use her phone.	0		11	2025-12-21 17:04:33.156028+03	5
5029	modal_verbs	You ___ run here.	0		12	2025-12-21 17:04:33.156028+03	5
5030	modal_verbs	I ___ worry about this.	0		13	2025-12-21 17:04:33.156028+03	5
5031	modal_verbs	It ___ get wet.	0		14	2025-12-21 17:04:33.156028+03	5
5032	modal_verbs	He ___ miss the train.	0		15	2025-12-21 17:04:33.156028+03	5
5033	modal_verbs	They ___ give up.	0		16	2025-12-21 17:04:33.156028+03	5
5034	modal_verbs	We ___ make noise.	0		17	2025-12-21 17:04:33.156028+03	5
5035	modal_verbs	She ___ be rude.	0		18	2025-12-21 17:04:33.156028+03	5
5036	modal_verbs	You ___ cheat.	0		19	2025-12-21 17:04:33.156028+03	5
5037	modal_verbs	You ___ rest more.	0		0	2025-12-21 17:04:33.156028+03	6
5038	modal_verbs	He ___ study harder.	0		1	2025-12-21 17:04:33.156028+03	6
5039	modal_verbs	They ___ call a doctor.	0		2	2025-12-21 17:04:33.156028+03	6
5040	modal_verbs	We ___ go home.	0		3	2025-12-21 17:04:33.156028+03	6
5041	modal_verbs	She ___ eat healthier.	0		4	2025-12-21 17:04:33.156028+03	6
5042	modal_verbs	You ___ drink water.	0		5	2025-12-21 17:04:33.156028+03	6
5043	modal_verbs	I ___ take a break.	0		6	2025-12-21 17:04:33.156028+03	6
5044	modal_verbs	It ___ be fine.	0		7	2025-12-21 17:04:33.156028+03	6
5045	modal_verbs	He ___ apologize.	0		8	2025-12-21 17:04:33.156028+03	6
5046	modal_verbs	They ___ try this.	0		9	2025-12-21 17:04:33.156028+03	6
5047	modal_verbs	We ___ help them.	0		10	2025-12-21 17:04:33.156028+03	6
5048	modal_verbs	She ___ see a dentist.	0		11	2025-12-21 17:04:33.156028+03	6
5049	modal_verbs	You ___ be careful.	0		12	2025-12-21 17:04:33.156028+03	6
5050	modal_verbs	I ___ listen to you.	0		13	2025-12-21 17:04:33.156028+03	6
5051	modal_verbs	It ___ work now.	0		14	2025-12-21 17:04:33.156028+03	6
5052	modal_verbs	He ___ tell the truth.	0		15	2025-12-21 17:04:33.156028+03	6
5053	modal_verbs	They ___ wait a bit.	0		16	2025-12-21 17:04:33.156028+03	6
5054	modal_verbs	We ___ check this.	0		17	2025-12-21 17:04:33.156028+03	6
5055	modal_verbs	She ___ take medicine.	0		18	2025-12-21 17:04:33.156028+03	6
5056	modal_verbs	You ___ trust me.	0		19	2025-12-21 17:04:33.156028+03	6
5057	modal_verbs	You ___ eat too much.	0		0	2025-12-21 17:04:33.156028+03	7
5058	modal_verbs	He ___ drive when tired.	0		1	2025-12-21 17:04:33.156028+03	7
5059	modal_verbs	They ___ waste money.	0		2	2025-12-21 17:04:33.156028+03	7
5060	modal_verbs	We ___ be late.	0		3	2025-12-21 17:04:33.156028+03	7
5061	modal_verbs	She ___ worry so much.	0		4	2025-12-21 17:04:33.156028+03	7
5062	modal_verbs	You ___ smoke.	0		5	2025-12-21 17:04:33.156028+03	7
5063	modal_verbs	I ___ stay up late.	0		6	2025-12-21 17:04:33.156028+03	7
5064	modal_verbs	It ___ take long.	0		7	2025-12-21 17:04:33.156028+03	7
5065	modal_verbs	He ___ drink coffee at night.	0		8	2025-12-21 17:04:33.156028+03	7
5066	modal_verbs	They ___ argue.	0		9	2025-12-21 17:04:33.156028+03	7
5067	modal_verbs	We ___ give up.	0		10	2025-12-21 17:04:33.156028+03	7
5068	modal_verbs	She ___ skip breakfast.	0		11	2025-12-21 17:04:33.156028+03	7
5069	modal_verbs	You ___ be rude.	0		12	2025-12-21 17:04:33.156028+03	7
5070	modal_verbs	I ___ forget this.	0		13	2025-12-21 17:04:33.156028+03	7
5071	modal_verbs	It ___ be difficult.	0		14	2025-12-21 17:04:33.156028+03	7
5072	modal_verbs	He ___ work too much.	0		15	2025-12-21 17:04:33.156028+03	7
5073	modal_verbs	They ___ complain.	0		16	2025-12-21 17:04:33.156028+03	7
5074	modal_verbs	We ___ rush.	0		17	2025-12-21 17:04:33.156028+03	7
5075	modal_verbs	She ___ use her phone now.	0		18	2025-12-21 17:04:33.156028+03	7
5076	modal_verbs	You ___ lie.	0		19	2025-12-21 17:04:33.156028+03	7
5077	modal_verbs	I ___ speak English.	0		0	2025-12-21 17:04:33.156028+03	8
5078	modal_verbs	You ___ study for the exam.	1		1	2025-12-21 17:04:33.156028+03	8
5079	modal_verbs	She ___ rest today.	2		2	2025-12-21 17:04:33.156028+03	8
5080	modal_verbs	They ___ swim very well.	0		3	2025-12-21 17:04:33.156028+03	8
5081	modal_verbs	We ___ leave immediately.	1		4	2025-12-21 17:04:33.156028+03	8
5082	modal_verbs	He ___ see a doctor.	2		5	2025-12-21 17:04:33.156028+03	8
5083	modal_verbs	You ___ play guitar.	0		6	2025-12-21 17:04:33.156028+03	8
5084	modal_verbs	I ___ finish this work.	1		7	2025-12-21 17:04:33.156028+03	8
5085	modal_verbs	She ___ try harder.	2		8	2025-12-21 17:04:33.156028+03	8
5086	modal_verbs	They ___ help us.	0		9	2025-12-21 17:04:33.156028+03	8
5087	modal_verbs	We ___ be honest.	1		10	2025-12-21 17:04:33.156028+03	8
5088	modal_verbs	He ___ eat healthier.	2		11	2025-12-21 17:04:33.156028+03	8
5089	modal_verbs	You ___ drive a car.	0		12	2025-12-21 17:04:33.156028+03	8
5090	modal_verbs	I ___ go to school.	1		13	2025-12-21 17:04:33.156028+03	8
5091	modal_verbs	She ___ call her mother.	2		14	2025-12-21 17:04:33.156028+03	8
5092	modal_verbs	They ___ speak Russian.	0		15	2025-12-21 17:04:33.156028+03	8
5093	modal_verbs	We ___ obey the law.	1		16	2025-12-21 17:04:33.156028+03	8
5094	modal_verbs	He ___ drink more water.	2		17	2025-12-21 17:04:33.156028+03	8
5095	modal_verbs	You ___ cook well.	0		18	2025-12-21 17:04:33.156028+03	8
5096	modal_verbs	I ___ pay the bills.	1		19	2025-12-21 17:04:33.156028+03	8
5097	modal_verbs	___ you swim?	0		0	2025-12-21 17:04:33.156028+03	9
5098	modal_verbs	___ I go now?	1		1	2025-12-21 17:04:33.156028+03	9
5099	modal_verbs	___ we call her?	2		2	2025-12-21 17:04:33.156028+03	9
5100	modal_verbs	___ she speak French?	0		3	2025-12-21 17:04:33.156028+03	9
5101	modal_verbs	___ they leave?	1		4	2025-12-21 17:04:33.156028+03	9
5102	modal_verbs	___ he study more?	2		5	2025-12-21 17:04:33.156028+03	9
5103	modal_verbs	___ you help me?	0		6	2025-12-21 17:04:33.156028+03	9
5104	modal_verbs	___ I wear a uniform?	1		7	2025-12-21 17:04:33.156028+03	9
5105	modal_verbs	___ we wait here?	2		8	2025-12-21 17:04:33.156028+03	9
3424	articles	I saw ___ cat in the garden.	0	Правильный ответ: A	8	2025-12-20 02:57:32.382395+03	1
3425	articles	She wants to buy ___ umbrella.	1	Правильный ответ: B	18	2025-12-20 02:57:32.382395+03	1
3426	articles	___ Moon looks beautiful tonight.	2	Правильный ответ: C	6	2025-12-20 02:57:32.382395+03	2
3427	articles	I usually drink ___ coffee in the morning.	3	Правильный ответ: D	11	2025-12-20 02:57:32.382395+03	2
3428	articles	He is reading ___ interesting book.	1	Правильный ответ: B	3	2025-12-20 02:57:32.382395+03	3
3429	articles	We visited ___ Eiffel Tower last summer.	2	Правильный ответ: C	11	2025-12-20 02:57:32.382395+03	3
3430	articles	I need ___ pen to write this note.	0	Правильный ответ: A	3	2025-12-20 02:57:32.382395+03	4
3431	articles	She is ___ best singer in our class.	2	Правильный ответ: C	11	2025-12-20 02:57:32.382395+03	4
3432	articles	I saw ___ elephant in the zoo.	1	Правильный ответ: B	0	2025-12-20 02:57:32.382395+03	5
3433	articles	___ lions are very strong animals.	3	Правильный ответ: D	15	2025-12-20 02:57:32.382395+03	5
3434	articles	He wants to eat ___ apple.	1	Правильный ответ: B	5	2025-12-20 02:57:32.382395+03	6
3435	articles	___ Pacific Ocean is huge.	2	Правильный ответ: C	17	2025-12-20 02:57:32.382395+03	6
3436	articles	I bought ___ orange and ___ banana.	1	Правильный ответ: B	4	2025-12-20 02:57:32.382395+03	7
3437	articles	She usually goes to ___ school by bus.	3	Правильный ответ: D	15	2025-12-20 02:57:32.382395+03	7
3438	articles	___ Sun is shining brightly today.	2	Правильный ответ: C	7	2025-12-20 02:57:32.382395+03	8
3439	articles	I saw ___ dog and ___ cat in the park.	0	Правильный ответ: A	10	2025-12-20 02:57:32.382395+03	8
3440	articles	He is reading ___ book about space.	0	Правильный ответ: A	9	2025-12-20 02:57:32.382395+03	9
3441	articles	We are going to ___ restaurant tonight.	0	Правильный ответ: A	10	2025-12-20 02:57:32.382395+03	9
5106	modal_verbs	___ it fly?	0		9	2025-12-21 17:04:33.156028+03	9
5107	modal_verbs	___ she finish this?	1		10	2025-12-21 17:04:33.156028+03	9
5108	modal_verbs	___ they apologize?	2		11	2025-12-21 17:04:33.156028+03	9
5109	modal_verbs	___ you understand?	0		12	2025-12-21 17:04:33.156028+03	9
5110	modal_verbs	___ I tell the truth?	1		13	2025-12-21 17:04:33.156028+03	9
5111	modal_verbs	___ we try again?	2		14	2025-12-21 17:04:33.156028+03	9
5112	modal_verbs	___ he cook?	0		15	2025-12-21 17:04:33.156028+03	9
5113	modal_verbs	___ they pay now?	1		16	2025-12-21 17:04:33.156028+03	9
5114	modal_verbs	___ she rest?	2		17	2025-12-21 17:04:33.156028+03	9
5115	modal_verbs	___ you see this?	0		18	2025-12-21 17:04:33.156028+03	9
5116	modal_verbs	___ I be careful?	1		19	2025-12-21 17:04:33.156028+03	9
5117	modal_verbs	I ___ swim.	0		0	2025-12-21 17:04:33.156028+03	10
5118	modal_verbs	You ___ smoke here.	1		1	2025-12-21 17:04:33.156028+03	10
5119	modal_verbs	She ___ worry.	2		2	2025-12-21 17:04:33.156028+03	10
3416	greetings-introductions	Что в английском чаще всего выполняет роль подлежащего?	2	Правильный ответ: C	0	2025-12-20 02:57:32.282549+03	1
3417	greetings-introductions	Какое существительное является неисчисляемым?	2	Правильный ответ: C	1	2025-12-20 02:57:32.282549+03	1
3418	greetings-introductions	Как правильно сказать «две книги»?	1	Правильный ответ: B	2	2025-12-20 02:57:32.282549+03	1
3419	greetings-introductions	Как правильно образовать множественное число от city?	2	Правильный ответ: C	3	2025-12-20 02:57:32.282549+03	1
3420	greetings-introductions	Как правильно показать, что машина принадлежит Джону?	3	Правильный ответ: D	4	2025-12-20 02:57:32.282549+03	1
3421	greetings-introductions	Почему предложение I student неправильное?	1	Правильный ответ: B	5	2025-12-20 02:57:32.282549+03	1
3422	greetings-introductions	Как правильно?	2	Правильный ответ: C	6	2025-12-20 02:57:32.282549+03	1
3423	greetings-introductions	Где чаще всего стоит существительное в английском предложении?	1	Правильный ответ: B	7	2025-12-20 02:57:32.282549+03	1
5120	modal_verbs	They ___ understand.	0		3	2025-12-21 17:04:33.156028+03	10
5121	modal_verbs	We ___ touch this.	1		4	2025-12-21 17:04:33.156028+03	10
5122	modal_verbs	He ___ eat junk food.	2		5	2025-12-21 17:04:33.156028+03	10
5123	modal_verbs	You ___ speak Chinese.	0		6	2025-12-21 17:04:33.156028+03	10
5124	modal_verbs	I ___ be late.	1		7	2025-12-21 17:04:33.156028+03	10
5125	modal_verbs	She ___ skip class.	2		8	2025-12-21 17:04:33.156028+03	10
5126	modal_verbs	They ___ help us.	0		9	2025-12-21 17:04:33.156028+03	10
5127	modal_verbs	We ___ park here.	1		10	2025-12-21 17:04:33.156028+03	10
5128	modal_verbs	He ___ work late.	2		11	2025-12-21 17:04:33.156028+03	10
5129	modal_verbs	You ___ drive.	0		12	2025-12-21 17:04:33.156028+03	10
5130	modal_verbs	I ___ give up.	1		13	2025-12-21 17:04:33.156028+03	10
5131	modal_verbs	She ___ argue.	2		14	2025-12-21 17:04:33.156028+03	10
5132	modal_verbs	They ___ finish today.	0		15	2025-12-21 17:04:33.156028+03	10
5133	modal_verbs	We ___ waste time.	1		16	2025-12-21 17:04:33.156028+03	10
5134	modal_verbs	He ___ complain.	2		17	2025-12-21 17:04:33.156028+03	10
5135	modal_verbs	You ___ hear me.	0		18	2025-12-21 17:04:33.156028+03	10
5136	modal_verbs	I ___ forget this.	1		19	2025-12-21 17:04:33.156028+03	10
5137	there_is_are	___ a book on the table.	0		0	2025-12-21 17:04:34.081445+03	1
5138	there_is_are	___ a cat in the garden.	0		1	2025-12-21 17:04:34.081445+03	1
5139	there_is_are	___ a problem here.	0		2	2025-12-21 17:04:34.081445+03	1
5140	there_is_are	___ milk in the fridge.	0		3	2025-12-21 17:04:34.081445+03	1
5141	there_is_are	___ a pen on the desk.	0		4	2025-12-21 17:04:34.081445+03	1
5142	there_is_are	___ a car outside.	0		5	2025-12-21 17:04:34.081445+03	1
5143	there_is_are	___ a dog under the tree.	0		6	2025-12-21 17:04:34.081445+03	1
5144	there_is_are	___ a shop near here.	0		7	2025-12-21 17:04:34.081445+03	1
5145	there_is_are	___ a teacher in the room.	0		8	2025-12-21 17:04:34.081445+03	1
5146	there_is_are	___ water in the bottle.	0		9	2025-12-21 17:04:34.081445+03	1
5147	there_is_are	___ a park in the city.	0		10	2025-12-21 17:04:34.081445+03	1
5148	there_is_are	___ a phone on the sofa.	0		11	2025-12-21 17:04:34.081445+03	1
5149	there_is_are	___ a doctor here.	0		12	2025-12-21 17:04:34.081445+03	1
5150	there_is_are	___ a key in my pocket.	0		13	2025-12-21 17:04:34.081445+03	1
5151	there_is_are	___ a bird on the roof.	0		14	2025-12-21 17:04:34.081445+03	1
3446	articles	___ Amazon River is very long.	2	Правильный ответ: C	2	2025-12-20 02:57:32.382395+03	2
5152	there_is_are	___ a museum in town.	0		15	2025-12-21 17:04:34.081445+03	1
5153	there_is_are	___ a lamp on the table.	0		16	2025-12-21 17:04:34.081445+03	1
5154	there_is_are	___ a letter for you.	0		17	2025-12-21 17:04:34.081445+03	1
5155	there_is_are	___ a bank nearby.	0		18	2025-12-21 17:04:34.081445+03	1
5156	there_is_are	___ a computer in the office.	0		19	2025-12-21 17:04:34.081445+03	1
5157	there_is_are	___ books on the shelf.	1		0	2025-12-21 17:04:34.081445+03	2
5158	there_is_are	___ cats in the garden.	1		1	2025-12-21 17:04:34.081445+03	2
5159	there_is_are	___ apples in the basket.	1		2	2025-12-21 17:04:34.081445+03	2
5160	there_is_are	___ people in the room.	1		3	2025-12-21 17:04:34.081445+03	2
5161	there_is_are	___ cars on the street.	1		4	2025-12-21 17:04:34.081445+03	2
5162	there_is_are	___ flowers in the vase.	1		5	2025-12-21 17:04:34.081445+03	2
5163	there_is_are	___ students in the class.	1		6	2025-12-21 17:04:34.081445+03	2
5164	there_is_are	___ chairs around the table.	1		7	2025-12-21 17:04:34.081445+03	2
5165	there_is_are	___ trees in the park.	1		8	2025-12-21 17:04:34.081445+03	2
5166	there_is_are	___ plates on the table.	1		9	2025-12-21 17:04:34.081445+03	2
5167	there_is_are	___ two dogs outside.	1		10	2025-12-21 17:04:34.081445+03	2
5168	there_is_are	___ many shops here.	1		11	2025-12-21 17:04:34.081445+03	2
5169	there_is_are	___ three windows in the room.	1		12	2025-12-21 17:04:34.081445+03	2
5170	there_is_are	___ children in the playground.	1		13	2025-12-21 17:04:34.081445+03	2
5171	there_is_are	___ bottles in the fridge.	1		14	2025-12-21 17:04:34.081445+03	2
5172	there_is_are	___ some questions.	1		15	2025-12-21 17:04:34.081445+03	2
3468	articles	He bought ___ old painting.	0	Правильный ответ: A	4	2025-12-20 02:57:32.382395+03	3
5173	there_is_are	___ five pencils on the desk.	1		16	2025-12-21 17:04:34.081445+03	2
5174	there_is_are	___ birds on the tree.	1		17	2025-12-21 17:04:34.081445+03	2
5175	there_is_are	___ several problems.	1		18	2025-12-21 17:04:34.081445+03	2
5176	there_is_are	___ pictures on the wall.	1		19	2025-12-21 17:04:34.081445+03	2
5177	there_is_are	___ a cat and two dogs.	0		0	2025-12-21 17:04:34.081445+03	3
5178	there_is_are	___ two dogs and a cat.	1		1	2025-12-21 17:04:34.081445+03	3
5179	there_is_are	___ one book on the table.	0		2	2025-12-21 17:04:34.081445+03	3
5180	there_is_are	___ three cups here.	1		3	2025-12-21 17:04:34.081445+03	3
5181	there_is_are	___ a teacher in the classroom.	0		4	2025-12-21 17:04:34.081445+03	3
5182	there_is_are	___ students outside.	1		5	2025-12-21 17:04:34.081445+03	3
5183	there_is_are	___ milk in the glass.	0		6	2025-12-21 17:04:34.081445+03	3
5184	there_is_are	___ apples in the bowl.	1		7	2025-12-21 17:04:34.081445+03	3
5185	there_is_are	___ a phone on the chair.	0		8	2025-12-21 17:04:34.081445+03	3
5186	there_is_are	___ many people here.	1		9	2025-12-21 17:04:34.081445+03	3
5187	there_is_are	___ a problem with this.	0		10	2025-12-21 17:04:34.081445+03	3
5188	there_is_are	___ some problems.	1		11	2025-12-21 17:04:34.081445+03	3
5189	there_is_are	___ water in the bottle.	0		12	2025-12-21 17:04:34.081445+03	3
5190	there_is_are	___ five bottles.	1		13	2025-12-21 17:04:34.081445+03	3
5191	there_is_are	___ a car in the garage.	0		14	2025-12-21 17:04:34.081445+03	3
5192	there_is_are	___ two cars outside.	1		15	2025-12-21 17:04:34.081445+03	3
5193	there_is_are	___ a park nearby.	0		16	2025-12-21 17:04:34.081445+03	3
3490	articles	I need ___ egg for the recipe.	1	Правильный ответ: B	6	2025-12-20 02:57:32.382395+03	4
5194	there_is_are	___ parks in the city.	1		17	2025-12-21 17:04:34.081445+03	3
5195	there_is_are	___ one chair.	0		18	2025-12-21 17:04:34.081445+03	3
5196	there_is_are	___ four chairs.	1		19	2025-12-21 17:04:34.081445+03	3
5197	there_is_are	___ a book on the table.	0		0	2025-12-21 17:04:34.081445+03	4
5198	there_is_are	___ books on the shelf.	1		1	2025-12-21 17:04:34.081445+03	4
5199	there_is_are	___ milk in the fridge.	0		2	2025-12-21 17:04:34.081445+03	4
5200	there_is_are	___ apples in the basket.	1		3	2025-12-21 17:04:34.081445+03	4
5201	there_is_are	___ a cat here.	0		4	2025-12-21 17:04:34.081445+03	4
5202	there_is_are	___ people in the room.	1		5	2025-12-21 17:04:34.081445+03	4
5203	there_is_are	___ a problem.	0		6	2025-12-21 17:04:34.081445+03	4
5204	there_is_are	___ any questions.	1		7	2025-12-21 17:04:34.081445+03	4
5205	there_is_are	___ water in the glass.	0		8	2025-12-21 17:04:34.081445+03	4
5206	there_is_are	___ cars outside.	1		9	2025-12-21 17:04:34.081445+03	4
5207	there_is_are	___ a pen on the desk.	0		10	2025-12-21 17:04:34.081445+03	4
5208	there_is_are	___ chairs here.	1		11	2025-12-21 17:04:34.081445+03	4
5209	there_is_are	___ time.	0		12	2025-12-21 17:04:34.081445+03	4
5210	there_is_are	___ students in class.	1		13	2025-12-21 17:04:34.081445+03	4
5211	there_is_are	___ a doctor available.	0		14	2025-12-21 17:04:34.081445+03	4
5212	there_is_are	___ any cookies left.	1		15	2025-12-21 17:04:34.081445+03	4
5213	there_is_are	___ a bank nearby.	0		16	2025-12-21 17:04:34.081445+03	4
5214	there_is_are	___ shops here.	1		17	2025-12-21 17:04:34.081445+03	4
5215	there_is_are	___ a solution.	0		18	2025-12-21 17:04:34.081445+03	4
5216	there_is_are	___ tickets available.	1		19	2025-12-21 17:04:34.081445+03	4
5217	there_is_are	___ no milk.	0		0	2025-12-21 17:04:34.081445+03	5
5218	there_is_are	___ no apples.	1		1	2025-12-21 17:04:34.081445+03	5
5219	there_is_are	___ no time.	0		2	2025-12-21 17:04:34.081445+03	5
5220	there_is_are	___ no people here.	1		3	2025-12-21 17:04:34.081445+03	5
5221	there_is_are	___ no problem.	0		4	2025-12-21 17:04:34.081445+03	5
5222	there_is_are	___ no books.	1		5	2025-12-21 17:04:34.081445+03	5
5223	there_is_are	___ no water.	0		6	2025-12-21 17:04:34.081445+03	5
5224	there_is_are	___ no students.	1		7	2025-12-21 17:04:34.081445+03	5
5225	there_is_are	___ no coffee left.	0		8	2025-12-21 17:04:34.081445+03	5
5226	there_is_are	___ no chairs available.	1		9	2025-12-21 17:04:34.081445+03	5
5227	there_is_are	___ no internet.	0		10	2025-12-21 17:04:34.081445+03	5
5228	there_is_are	___ no cars outside.	1		11	2025-12-21 17:04:34.081445+03	5
5229	there_is_are	___ no hope.	0		12	2025-12-21 17:04:34.081445+03	5
5230	there_is_are	___ no options.	1		13	2025-12-21 17:04:34.081445+03	5
5231	there_is_are	___ no sugar.	0		14	2025-12-21 17:04:34.081445+03	5
5232	there_is_are	___ no questions.	1		15	2025-12-21 17:04:34.081445+03	5
5233	there_is_are	___ no space.	0		16	2025-12-21 17:04:34.081445+03	5
5234	there_is_are	___ no tickets.	1		17	2025-12-21 17:04:34.081445+03	5
5235	there_is_are	___ no food.	0		18	2025-12-21 17:04:34.081445+03	5
5236	there_is_are	___ no places.	1		19	2025-12-21 17:04:34.081445+03	5
5237	there_is_are	___ a bank near here?	0		0	2025-12-21 17:04:34.081445+03	6
5238	there_is_are	___ any milk?	0		1	2025-12-21 17:04:34.081445+03	6
5239	there_is_are	___ a problem?	0		2	2025-12-21 17:04:34.081445+03	6
5240	there_is_are	___ a pen on the desk?	0		3	2025-12-21 17:04:34.081445+03	6
5241	there_is_are	___ a cat in the garden?	0		4	2025-12-21 17:04:34.081445+03	6
5242	there_is_are	___ time for this?	0		5	2025-12-21 17:04:34.081445+03	6
5243	there_is_are	___ a doctor here?	0		6	2025-12-21 17:04:34.081445+03	6
5244	there_is_are	___ water in the bottle?	0		7	2025-12-21 17:04:34.081445+03	6
5245	there_is_are	___ a solution?	0		8	2025-12-21 17:04:34.081445+03	6
5246	there_is_are	___ a phone in the room?	0		9	2025-12-21 17:04:34.081445+03	6
5247	there_is_are	___ coffee left?	0		10	2025-12-21 17:04:34.081445+03	6
5248	there_is_are	___ a shop nearby?	0		11	2025-12-21 17:04:34.081445+03	6
5249	there_is_are	___ a meeting today?	0		12	2025-12-21 17:04:34.081445+03	6
5250	there_is_are	___ sugar in the tea?	0		13	2025-12-21 17:04:34.081445+03	6
5251	there_is_are	___ a park here?	0		14	2025-12-21 17:04:34.081445+03	6
5252	there_is_are	___ hope?	0		15	2025-12-21 17:04:34.081445+03	6
5253	there_is_are	___ a way out?	0		16	2025-12-21 17:04:34.081445+03	6
5254	there_is_are	___ internet?	0		17	2025-12-21 17:04:34.081445+03	6
5255	there_is_are	___ a reason?	0		18	2025-12-21 17:04:34.081445+03	6
5256	there_is_are	___ space here?	0		19	2025-12-21 17:04:34.081445+03	6
5257	there_is_are	___ any books?	1		0	2025-12-21 17:04:34.081445+03	7
5258	there_is_are	___ people in the room?	1		1	2025-12-21 17:04:34.081445+03	7
5259	there_is_are	___ apples in the basket?	1		2	2025-12-21 17:04:34.081445+03	7
5260	there_is_are	___ any questions?	1		3	2025-12-21 17:04:34.081445+03	7
5261	there_is_are	___ students here?	1		4	2025-12-21 17:04:34.081445+03	7
5262	there_is_are	___ cars outside?	1		5	2025-12-21 17:04:34.081445+03	7
5263	there_is_are	___ any cookies?	1		6	2025-12-21 17:04:34.081445+03	7
5264	there_is_are	___ chairs available?	1		7	2025-12-21 17:04:34.081445+03	7
5265	there_is_are	___ problems?	1		8	2025-12-21 17:04:34.081445+03	7
5266	there_is_are	___ tickets left?	1		9	2025-12-21 17:04:34.081445+03	7
5267	there_is_are	___ any shops nearby?	1		10	2025-12-21 17:04:34.081445+03	7
5268	there_is_are	___ children in the park?	1		11	2025-12-21 17:04:34.081445+03	7
5269	there_is_are	___ options?	1		12	2025-12-21 17:04:34.081445+03	7
5270	there_is_are	___ any plates?	1		13	2025-12-21 17:04:34.081445+03	7
5271	there_is_are	___ trees here?	1		14	2025-12-21 17:04:34.081445+03	7
5272	there_is_are	___ messages for me?	1		15	2025-12-21 17:04:34.081445+03	7
5273	there_is_are	___ any restaurants?	1		16	2025-12-21 17:04:34.081445+03	7
5274	there_is_are	___ places to sit?	1		17	2025-12-21 17:04:34.081445+03	7
5275	there_is_are	___ buses at night?	1		18	2025-12-21 17:04:34.081445+03	7
5276	there_is_are	___ any reasons?	1		19	2025-12-21 17:04:34.081445+03	7
5277	there_is_are	There is a book ___ the table.	1		0	2025-12-21 17:04:34.081445+03	8
5278	there_is_are	There are flowers ___ the vase.	0		1	2025-12-21 17:04:34.081445+03	8
5279	there_is_are	There is a cat ___ the bed.	1		2	2025-12-21 17:04:34.081445+03	8
5280	there_is_are	There are people ___ the room.	0		3	2025-12-21 17:04:34.081445+03	8
5281	there_is_are	There is a shop ___ my house.	2		4	2025-12-21 17:04:34.081445+03	8
5282	there_is_are	There are birds ___ the tree.	0		5	2025-12-21 17:04:34.081445+03	8
5283	there_is_are	There is a park ___ two buildings.	1		6	2025-12-21 17:04:34.081445+03	8
5284	there_is_are	There are plates ___ the table.	1		7	2025-12-21 17:04:34.081445+03	8
5285	there_is_are	There is a dog ___ the car.	0		8	2025-12-21 17:04:34.081445+03	8
5286	there_is_are	There are books ___ the shelf.	1		9	2025-12-21 17:04:34.081445+03	8
5287	there_is_are	There is a pen ___ my pocket.	0		10	2025-12-21 17:04:34.081445+03	8
5288	there_is_are	There are children ___ the playground.	0		11	2025-12-21 17:04:34.081445+03	8
5289	there_is_are	There is a lamp ___ the desk.	1		12	2025-12-21 17:04:34.081445+03	8
5290	there_is_are	There are cars ___ the street.	1		13	2025-12-21 17:04:34.081445+03	8
5291	there_is_are	There is a cafe ___ the bank.	1		14	2025-12-21 17:04:34.081445+03	8
5292	there_is_are	There are photos ___ the wall.	1		15	2025-12-21 17:04:34.081445+03	8
5293	there_is_are	There is water ___ the bottle.	0		16	2025-12-21 17:04:34.081445+03	8
5294	there_is_are	There are people ___ the bus.	1		17	2025-12-21 17:04:34.081445+03	8
5295	there_is_are	There is a box ___ the table.	1		18	2025-12-21 17:04:34.081445+03	8
5296	there_is_are	There are shoes ___ the door.	1		19	2025-12-21 17:04:34.081445+03	8
5297	there_is_are	___ a cat.	0		0	2025-12-21 17:04:34.081445+03	9
5298	there_is_are	___ two cats.	1		1	2025-12-21 17:04:34.081445+03	9
5299	there_is_are	___ a problem?	2		2	2025-12-21 17:04:34.081445+03	9
5300	there_is_are	___ any books?	3		3	2025-12-21 17:04:34.081445+03	9
5301	there_is_are	___ no milk.	0		4	2025-12-21 17:04:34.081445+03	9
5302	there_is_are	___ no apples.	1		5	2025-12-21 17:04:34.081445+03	9
5303	there_is_are	___ a shop?	2		6	2025-12-21 17:04:34.081445+03	9
5304	there_is_are	___ people here.	1		7	2025-12-21 17:04:34.081445+03	9
5305	there_is_are	There ___ a car.	0		8	2025-12-21 17:04:34.081445+03	9
5306	there_is_are	There ___ cars.	1		9	2025-12-21 17:04:34.081445+03	9
5307	there_is_are	There ___ a pen.	2		10	2025-12-21 17:04:34.081445+03	9
5308	there_is_are	There ___ pens.	3		11	2025-12-21 17:04:34.081445+03	9
5309	there_is_are	___ time?	2		12	2025-12-21 17:04:34.081445+03	9
5310	there_is_are	___ students?	3		13	2025-12-21 17:04:34.081445+03	9
5311	there_is_are	___ a park.	0		14	2025-12-21 17:04:34.081445+03	9
5312	there_is_are	___ no water.	0		15	2025-12-21 17:04:34.081445+03	9
5313	there_is_are	___ tickets?	3		16	2025-12-21 17:04:34.081445+03	9
5314	there_is_are	There ___ no chairs.	1		17	2025-12-21 17:04:34.081445+03	9
5315	there_is_are	___ a meeting today.	0		18	2025-12-21 17:04:34.081445+03	9
5316	there_is_are	___ questions.	1		19	2025-12-21 17:04:34.081445+03	9
5317	there_is_are	Is there a bank? — Yes, ___.	0		0	2025-12-21 17:04:34.081445+03	10
5318	there_is_are	Are there shops? — Yes, ___.	1		1	2025-12-21 17:04:34.081445+03	10
5319	there_is_are	Is there milk? — No, ___.	1		2	2025-12-21 17:04:34.081445+03	10
5320	there_is_are	Are there apples? — No, ___.	3		3	2025-12-21 17:04:34.081445+03	10
5321	there_is_are	Is there a problem? — Yes, ___.	0		4	2025-12-21 17:04:34.081445+03	10
5322	there_is_are	Are there people? — Yes, ___.	1		5	2025-12-21 17:04:34.081445+03	10
5323	there_is_are	Is there time? — No, ___.	1		6	2025-12-21 17:04:34.081445+03	10
5324	there_is_are	Are there chairs? — No, ___.	3		7	2025-12-21 17:04:34.081445+03	10
5325	there_is_are	Is there a cat? — Yes, ___.	0		8	2025-12-21 17:04:34.081445+03	10
5326	there_is_are	Are there books? — Yes, ___.	1		9	2025-12-21 17:04:34.081445+03	10
5327	there_is_are	Is there water? — No, ___.	1		10	2025-12-21 17:04:34.081445+03	10
5328	there_is_are	Are there students? — No, ___.	3		11	2025-12-21 17:04:34.081445+03	10
5329	there_is_are	Is there hope? — Yes, ___.	0		12	2025-12-21 17:04:34.081445+03	10
5330	there_is_are	Are there options? — Yes, ___.	1		13	2025-12-21 17:04:34.081445+03	10
5331	there_is_are	Is there space? — No, ___.	1		14	2025-12-21 17:04:34.081445+03	10
3579	articles	He likes listening to ___ music while working.	3	Правильный ответ: D	15	2025-12-20 02:57:32.382395+03	8
5332	there_is_are	Are there tickets? — No, ___.	3		15	2025-12-21 17:04:34.081445+03	10
5333	there_is_are	Is there a doctor? — Yes, ___.	0		16	2025-12-21 17:04:34.081445+03	10
5334	there_is_are	Are there cars? — Yes, ___.	1		17	2025-12-21 17:04:34.081445+03	10
5335	there_is_are	Is there coffee? — No, ___.	1		18	2025-12-21 17:04:34.081445+03	10
5336	there_is_are	Are there problems? — No, ___.	3		19	2025-12-21 17:04:34.081445+03	10
5337	prepositions_place	The book is ___ the bag.	0		0	2025-12-21 17:04:34.354873+03	1
5338	prepositions_place	The cat is ___ the box.	0		1	2025-12-21 17:04:34.354873+03	1
5339	prepositions_place	I live ___ Moscow.	0		2	2025-12-21 17:04:34.354873+03	1
5340	prepositions_place	The keys are ___ my pocket.	0		3	2025-12-21 17:04:34.354873+03	1
5341	prepositions_place	The milk is ___ the fridge.	0		4	2025-12-21 17:04:34.354873+03	1
5342	prepositions_place	She is ___ the room.	0		5	2025-12-21 17:04:34.354873+03	1
5343	prepositions_place	The water is ___ the bottle.	0		6	2025-12-21 17:04:34.354873+03	1
5344	prepositions_place	The pen is ___ the drawer.	0		7	2025-12-21 17:04:34.354873+03	1
5345	prepositions_place	The people are ___ the building.	0		8	2025-12-21 17:04:34.354873+03	1
5346	prepositions_place	The dog is ___ the house.	0		9	2025-12-21 17:04:34.354873+03	1
5347	prepositions_place	The clothes are ___ the wardrobe.	0		10	2025-12-21 17:04:34.354873+03	1
5348	prepositions_place	I am ___ the kitchen.	0		11	2025-12-21 17:04:34.354873+03	1
5349	prepositions_place	The fish is ___ the water.	0		12	2025-12-21 17:04:34.354873+03	1
5350	prepositions_place	The toys are ___ the box.	0		13	2025-12-21 17:04:34.354873+03	1
5351	prepositions_place	She works ___ an office.	0		14	2025-12-21 17:04:34.354873+03	1
5352	prepositions_place	The bird is ___ the cage.	0		15	2025-12-21 17:04:34.354873+03	1
5353	prepositions_place	The money is ___ the wallet.	0		16	2025-12-21 17:04:34.354873+03	1
5354	prepositions_place	The letter is ___ the envelope.	0		17	2025-12-21 17:04:34.354873+03	1
5355	prepositions_place	The students are ___ the classroom.	0		18	2025-12-21 17:04:34.354873+03	1
5356	prepositions_place	The car is ___ the garage.	0		19	2025-12-21 17:04:34.354873+03	1
5357	prepositions_place	The book is ___ the table.	1		0	2025-12-21 17:04:34.354873+03	2
5358	prepositions_place	The picture is ___ the wall.	1		1	2025-12-21 17:04:34.354873+03	2
5359	prepositions_place	The cat is ___ the roof.	1		2	2025-12-21 17:04:34.354873+03	2
5360	prepositions_place	The cup is ___ the desk.	1		3	2025-12-21 17:04:34.354873+03	2
5361	prepositions_place	The plates are ___ the table.	1		4	2025-12-21 17:04:34.354873+03	2
5362	prepositions_place	The bag is ___ the chair.	1		5	2025-12-21 17:04:34.354873+03	2
5363	prepositions_place	The hat is ___ your head.	1		6	2025-12-21 17:04:34.354873+03	2
5364	prepositions_place	The phone is ___ the sofa.	1		7	2025-12-21 17:04:34.354873+03	2
5365	prepositions_place	The vase is ___ the shelf.	1		8	2025-12-21 17:04:34.354873+03	2
5366	prepositions_place	The lamp is ___ the table.	1		9	2025-12-21 17:04:34.354873+03	2
5367	prepositions_place	The clock is ___ the wall.	1		10	2025-12-21 17:04:34.354873+03	2
5368	prepositions_place	The notebook is ___ the desk.	1		11	2025-12-21 17:04:34.354873+03	2
5369	prepositions_place	The apple is ___ the plate.	1		12	2025-12-21 17:04:34.354873+03	2
5370	prepositions_place	The bird is ___ the branch.	1		13	2025-12-21 17:04:34.354873+03	2
5371	prepositions_place	The glasses are ___ the table.	1		14	2025-12-21 17:04:34.354873+03	2
5372	prepositions_place	The calendar is ___ the wall.	1		15	2025-12-21 17:04:34.354873+03	2
5373	prepositions_place	The keys are ___ the counter.	1		16	2025-12-21 17:04:34.354873+03	2
5374	prepositions_place	The newspaper is ___ the bench.	1		17	2025-12-21 17:04:34.354873+03	2
5375	prepositions_place	The butterfly is ___ the flower.	1		18	2025-12-21 17:04:34.354873+03	2
5376	prepositions_place	The coat is ___ the hanger.	1		19	2025-12-21 17:04:34.354873+03	2
5377	prepositions_place	The cat is ___ the table.	2		0	2025-12-21 17:04:34.354873+03	3
5378	prepositions_place	The ball is ___ the bed.	2		1	2025-12-21 17:04:34.354873+03	3
5379	prepositions_place	The shoes are ___ the chair.	2		2	2025-12-21 17:04:34.354873+03	3
5380	prepositions_place	The dog is ___ the tree.	2		3	2025-12-21 17:04:34.354873+03	3
5381	prepositions_place	The pen is ___ the book.	2		4	2025-12-21 17:04:34.354873+03	3
5382	prepositions_place	The box is ___ the desk.	2		5	2025-12-21 17:04:34.354873+03	3
5383	prepositions_place	The keys are ___ the newspaper.	2		6	2025-12-21 17:04:34.354873+03	3
5384	prepositions_place	The cat sleeps ___ the blanket.	2		7	2025-12-21 17:04:34.354873+03	3
5385	prepositions_place	The toys are ___ the bed.	2		8	2025-12-21 17:04:34.354873+03	3
5386	prepositions_place	The mouse is ___ the sofa.	2		9	2025-12-21 17:04:34.354873+03	3
5387	prepositions_place	The bag is ___ the table.	2		10	2025-12-21 17:04:34.354873+03	3
5388	prepositions_place	The children hide ___ the stairs.	2		11	2025-12-21 17:04:34.354873+03	3
5389	prepositions_place	The wallet is ___ the pillow.	2		12	2025-12-21 17:04:34.354873+03	3
5390	prepositions_place	The car is ___ the bridge.	2		13	2025-12-21 17:04:34.354873+03	3
5391	prepositions_place	The cat is ___ the car.	2		14	2025-12-21 17:04:34.354873+03	3
5392	prepositions_place	The letter is ___ the books.	2		15	2025-12-21 17:04:34.354873+03	3
5393	prepositions_place	The phone is ___ the cushion.	2		16	2025-12-21 17:04:34.354873+03	3
5394	prepositions_place	The dog sits ___ the table.	2		17	2025-12-21 17:04:34.354873+03	3
5395	prepositions_place	The glasses are ___ the newspaper.	2		18	2025-12-21 17:04:34.354873+03	3
5396	prepositions_place	The socks are ___ the bed.	2		19	2025-12-21 17:04:34.354873+03	3
5397	prepositions_place	The bank is ___ the shop.	2		0	2025-12-21 17:04:34.354873+03	4
5398	prepositions_place	The chair is ___ the table.	2		1	2025-12-21 17:04:34.354873+03	4
5399	prepositions_place	The cafe is ___ my house.	2		2	2025-12-21 17:04:34.354873+03	4
5400	prepositions_place	The lamp is ___ the bed.	2		3	2025-12-21 17:04:34.354873+03	4
5401	prepositions_place	The park is ___ the school.	2		4	2025-12-21 17:04:34.354873+03	4
5402	prepositions_place	She sits ___ me.	2		5	2025-12-21 17:04:34.354873+03	4
5403	prepositions_place	He stands ___ his friend.	2		6	2025-12-21 17:04:34.354873+03	4
5404	prepositions_place	The cat is ___ the dog.	2		7	2025-12-21 17:04:34.354873+03	4
5405	prepositions_place	The sofa is ___ the window.	2		8	2025-12-21 17:04:34.354873+03	4
3646	pronouns	He gave ___ the keys.	1	Правильный ответ: B	2	2025-12-20 02:57:32.688528+03	2
5406	prepositions_place	The car is ___ the garage.	2		9	2025-12-21 17:04:34.354873+03	4
5407	prepositions_place	The shop is ___ the bank.	2		10	2025-12-21 17:04:34.354873+03	4
5408	prepositions_place	The bed is ___ the wardrobe.	2		11	2025-12-21 17:04:34.354873+03	4
5409	prepositions_place	The tree is ___ the house.	2		12	2025-12-21 17:04:34.354873+03	4
5410	prepositions_place	I live ___ the park.	2		13	2025-12-21 17:04:34.354873+03	4
5411	prepositions_place	The hotel is ___ the restaurant.	2		14	2025-12-21 17:04:34.354873+03	4
5412	prepositions_place	The phone is ___ the laptop.	2		15	2025-12-21 17:04:34.354873+03	4
5413	prepositions_place	The gym is ___ the supermarket.	2		16	2025-12-21 17:04:34.354873+03	4
5414	prepositions_place	The station is ___ the mall.	2		17	2025-12-21 17:04:34.354873+03	4
5415	prepositions_place	The vase is ___ the clock.	2		18	2025-12-21 17:04:34.354873+03	4
5416	prepositions_place	The bookshelf is ___ the desk.	2		19	2025-12-21 17:04:34.354873+03	4
5417	prepositions_place	The cat is ___ the boxes.	3		0	2025-12-21 17:04:34.354873+03	5
5418	prepositions_place	I sit ___ Tom and Mary.	3		1	2025-12-21 17:04:34.354873+03	5
5419	prepositions_place	The shop is ___ the bank and the cafe.	3		2	2025-12-21 17:04:34.354873+03	5
5420	prepositions_place	The ball is ___ the chairs.	3		3	2025-12-21 17:04:34.354873+03	5
5421	prepositions_place	The park is ___ two buildings.	3		4	2025-12-21 17:04:34.354873+03	5
5422	prepositions_place	The pen is ___ the books.	3		5	2025-12-21 17:04:34.354873+03	5
5423	prepositions_place	She stands ___ her parents.	3		6	2025-12-21 17:04:34.354873+03	5
5424	prepositions_place	The table is ___ two chairs.	3		7	2025-12-21 17:04:34.354873+03	5
5425	prepositions_place	The house is ___ two trees.	3		8	2025-12-21 17:04:34.354873+03	5
5426	prepositions_place	I stand ___ you and him.	3		9	2025-12-21 17:04:34.354873+03	5
3668	pronouns	She saw ___ yesterday.	1	Правильный ответ: B	4	2025-12-20 02:57:32.688528+03	3
5427	prepositions_place	The cafe is ___ the shop and the bank.	3		10	2025-12-21 17:04:34.354873+03	5
5428	prepositions_place	The sofa is ___ two lamps.	3		11	2025-12-21 17:04:34.354873+03	5
5429	prepositions_place	The dog sits ___ two cats.	3		12	2025-12-21 17:04:34.354873+03	5
5430	prepositions_place	The hotel is ___ the restaurant and the gym.	3		13	2025-12-21 17:04:34.354873+03	5
5431	prepositions_place	The bed is ___ two nightstands.	3		14	2025-12-21 17:04:34.354873+03	5
5432	prepositions_place	The car is ___ two trucks.	3		15	2025-12-21 17:04:34.354873+03	5
5433	prepositions_place	The bench is ___ two trees.	3		16	2025-12-21 17:04:34.354873+03	5
5434	prepositions_place	She sits ___ her friends.	3		17	2025-12-21 17:04:34.354873+03	5
5435	prepositions_place	The lamp is ___ the sofa and the chair.	3		18	2025-12-21 17:04:34.354873+03	5
3624	pronouns	She likes ___ very much.	1	Правильный ответ: B	8	2025-12-20 02:57:32.688528+03	1
3625	pronouns	___ am ready to start.	2	Правильный ответ: C	18	2025-12-20 02:57:32.688528+03	1
3626	pronouns	They invited ___ to the party.	1	Правильный ответ: B	6	2025-12-20 02:57:32.688528+03	2
3627	pronouns	___ lives next door.	1	Правильный ответ: B	11	2025-12-20 02:57:32.688528+03	2
3628	pronouns	Can you help ___?	1	Правильный ответ: B	3	2025-12-20 02:57:32.688528+03	3
3629	pronouns	We saw ___ at the station.	1	Правильный ответ: B	11	2025-12-20 02:57:32.688528+03	3
3630	pronouns	___ is my best friend.	1	Правильный ответ: B	3	2025-12-20 02:57:32.688528+03	4
3631	pronouns	She called ___ yesterday.	1	Правильный ответ: B	11	2025-12-20 02:57:32.688528+03	4
3632	pronouns	___ don’t understand this rule.	3	Правильный ответ: D	0	2025-12-20 02:57:32.688528+03	5
5436	prepositions_place	The phone is ___ the laptop and the book.	3		19	2025-12-21 17:04:34.354873+03	5
5437	prepositions_place	The book is ___ the bag.	0		0	2025-12-21 17:04:34.354873+03	6
5438	prepositions_place	The book is ___ the table.	1		1	2025-12-21 17:04:34.354873+03	6
5439	prepositions_place	The cat is ___ the box.	0		2	2025-12-21 17:04:34.354873+03	6
5440	prepositions_place	The cat is ___ the roof.	1		3	2025-12-21 17:04:34.354873+03	6
5441	prepositions_place	The milk is ___ the fridge.	0		4	2025-12-21 17:04:34.354873+03	6
5442	prepositions_place	The cup is ___ the desk.	1		5	2025-12-21 17:04:34.354873+03	6
5443	prepositions_place	I live ___ London.	0		6	2025-12-21 17:04:34.354873+03	6
5444	prepositions_place	The picture is ___ the wall.	1		7	2025-12-21 17:04:34.354873+03	6
5445	prepositions_place	The water is ___ the glass.	0		8	2025-12-21 17:04:34.354873+03	6
5446	prepositions_place	The phone is ___ the sofa.	1		9	2025-12-21 17:04:34.354873+03	6
5447	prepositions_place	The people are ___ the room.	0		10	2025-12-21 17:04:34.354873+03	6
5448	prepositions_place	The plates are ___ the table.	1		11	2025-12-21 17:04:34.354873+03	6
5449	prepositions_place	The fish is ___ the water.	0		12	2025-12-21 17:04:34.354873+03	6
5450	prepositions_place	The hat is ___ your head.	1		13	2025-12-21 17:04:34.354873+03	6
5451	prepositions_place	The keys are ___ my pocket.	0		14	2025-12-21 17:04:34.354873+03	6
5452	prepositions_place	The vase is ___ the shelf.	1		15	2025-12-21 17:04:34.354873+03	6
5453	prepositions_place	The bird is ___ the cage.	0		16	2025-12-21 17:04:34.354873+03	6
5454	prepositions_place	The bird is ___ the branch.	1		17	2025-12-21 17:04:34.354873+03	6
5455	prepositions_place	The money is ___ the wallet.	0		18	2025-12-21 17:04:34.354873+03	6
5456	prepositions_place	The clock is ___ the wall.	1		19	2025-12-21 17:04:34.354873+03	6
5457	prepositions_place	The book is ___ the table.	1		0	2025-12-21 17:04:34.354873+03	7
3690	pronouns	___ are my classmates.	2	Правильный ответ: C	6	2025-12-20 02:57:32.688528+03	4
5458	prepositions_place	The cat is ___ the box.	0		1	2025-12-21 17:04:34.354873+03	7
5459	prepositions_place	The ball is ___ the bed.	2		2	2025-12-21 17:04:34.354873+03	7
5460	prepositions_place	I live ___ Moscow.	0		3	2025-12-21 17:04:34.354873+03	7
5461	prepositions_place	The picture is ___ the wall.	1		4	2025-12-21 17:04:34.354873+03	7
5462	prepositions_place	The dog is ___ the tree.	2		5	2025-12-21 17:04:34.354873+03	7
5463	prepositions_place	The keys are ___ my pocket.	0		6	2025-12-21 17:04:34.354873+03	7
5464	prepositions_place	The cup is ___ the desk.	1		7	2025-12-21 17:04:34.354873+03	7
5465	prepositions_place	The shoes are ___ the chair.	2		8	2025-12-21 17:04:34.354873+03	7
5466	prepositions_place	The milk is ___ the fridge.	0		9	2025-12-21 17:04:34.354873+03	7
5467	prepositions_place	The phone is ___ the sofa.	1		10	2025-12-21 17:04:34.354873+03	7
5468	prepositions_place	The cat sleeps ___ the blanket.	2		11	2025-12-21 17:04:34.354873+03	7
5469	prepositions_place	The people are ___ the building.	0		12	2025-12-21 17:04:34.354873+03	7
5470	prepositions_place	The plates are ___ the table.	1		13	2025-12-21 17:04:34.354873+03	7
5471	prepositions_place	The toys are ___ the bed.	2		14	2025-12-21 17:04:34.354873+03	7
5472	prepositions_place	The water is ___ the bottle.	0		15	2025-12-21 17:04:34.354873+03	7
5473	prepositions_place	The hat is ___ your head.	1		16	2025-12-21 17:04:34.354873+03	7
5474	prepositions_place	The pen is ___ the book.	2		17	2025-12-21 17:04:34.354873+03	7
5475	prepositions_place	The fish is ___ the water.	0		18	2025-12-21 17:04:34.354873+03	7
5476	prepositions_place	The vase is ___ the shelf.	1		19	2025-12-21 17:04:34.354873+03	7
5477	prepositions_place	The chair is ___ the table.	2		0	2025-12-21 17:04:34.354873+03	8
5478	prepositions_place	The cat is ___ the boxes.	3		1	2025-12-21 17:04:34.354873+03	8
5479	prepositions_place	The bank is ___ the shop.	2		2	2025-12-21 17:04:34.354873+03	8
5480	prepositions_place	I sit ___ Tom and Mary.	3		3	2025-12-21 17:04:34.354873+03	8
5481	prepositions_place	The cafe is ___ my house.	2		4	2025-12-21 17:04:34.354873+03	8
5482	prepositions_place	The shop is ___ the bank and the cafe.	3		5	2025-12-21 17:04:34.354873+03	8
5483	prepositions_place	The lamp is ___ the bed.	2		6	2025-12-21 17:04:34.354873+03	8
5484	prepositions_place	The ball is ___ the chairs.	3		7	2025-12-21 17:04:34.354873+03	8
5485	prepositions_place	She sits ___ me.	2		8	2025-12-21 17:04:34.354873+03	8
5486	prepositions_place	The park is ___ two buildings.	3		9	2025-12-21 17:04:34.354873+03	8
5487	prepositions_place	The sofa is ___ the window.	2		10	2025-12-21 17:04:34.354873+03	8
5488	prepositions_place	The pen is ___ the books.	3		11	2025-12-21 17:04:34.354873+03	8
5489	prepositions_place	The tree is ___ the house.	2		12	2025-12-21 17:04:34.354873+03	8
5490	prepositions_place	She stands ___ her parents.	3		13	2025-12-21 17:04:34.354873+03	8
5491	prepositions_place	The bed is ___ the wardrobe.	2		14	2025-12-21 17:04:34.354873+03	8
5492	prepositions_place	The table is ___ two chairs.	3		15	2025-12-21 17:04:34.354873+03	8
5493	prepositions_place	I live ___ the park.	2		16	2025-12-21 17:04:34.354873+03	8
5494	prepositions_place	The house is ___ two trees.	3		17	2025-12-21 17:04:34.354873+03	8
5495	prepositions_place	The phone is ___ the laptop.	2		18	2025-12-21 17:04:34.354873+03	8
5496	prepositions_place	I stand ___ you and him.	3		19	2025-12-21 17:04:34.354873+03	8
5497	prepositions_place	The book is ___ the bag.	0		0	2025-12-21 17:04:34.354873+03	9
5498	prepositions_place	The cup is ___ the desk.	1		1	2025-12-21 17:04:34.354873+03	9
5499	prepositions_place	The cat is ___ the table.	2		2	2025-12-21 17:04:34.354873+03	9
5500	prepositions_place	The chair is ___ the table.	3		3	2025-12-21 17:04:34.354873+03	9
5501	prepositions_place	The milk is ___ the fridge.	0		4	2025-12-21 17:04:34.354873+03	9
5502	prepositions_place	The picture is ___ the wall.	1		5	2025-12-21 17:04:34.354873+03	9
5503	prepositions_place	The ball is ___ the bed.	2		6	2025-12-21 17:04:34.354873+03	9
5504	prepositions_place	I sit ___ Tom and Mary.	2		7	2025-12-21 17:04:34.354873+03	9
5505	prepositions_place	I live ___ Moscow.	0		8	2025-12-21 17:04:34.354873+03	9
5506	prepositions_place	The phone is ___ the sofa.	1		9	2025-12-21 17:04:34.354873+03	9
5507	prepositions_place	The dog is ___ the tree.	2		10	2025-12-21 17:04:34.354873+03	9
5508	prepositions_place	The bank is ___ the shop.	3		11	2025-12-21 17:04:34.354873+03	9
5509	prepositions_place	The keys are ___ my pocket.	0		12	2025-12-21 17:04:34.354873+03	9
5510	prepositions_place	The plates are ___ the table.	1		13	2025-12-21 17:04:34.354873+03	9
5511	prepositions_place	The shoes are ___ the chair.	2		14	2025-12-21 17:04:34.354873+03	9
5512	prepositions_place	The shop is ___ the bank and the cafe.	2		15	2025-12-21 17:04:34.354873+03	9
5513	prepositions_place	The water is ___ the bottle.	0		16	2025-12-21 17:04:34.354873+03	9
5514	prepositions_place	The hat is ___ your head.	1		17	2025-12-21 17:04:34.354873+03	9
5515	prepositions_place	The toys are ___ the bed.	2		18	2025-12-21 17:04:34.354873+03	9
5516	prepositions_place	The cafe is ___ my house.	3		19	2025-12-21 17:04:34.354873+03	9
5517	prepositions_place	Where is the book? — It's ___ the table.	1		0	2025-12-21 17:04:34.354873+03	10
5518	prepositions_place	Where is the cat? — It's ___ the box.	0		1	2025-12-21 17:04:34.354873+03	10
5519	prepositions_place	Where are the shoes? — They're ___ the chair.	2		2	2025-12-21 17:04:34.354873+03	10
5520	prepositions_place	Where is the bank? — It's ___ the shop.	2		3	2025-12-21 17:04:34.354873+03	10
5521	prepositions_place	Where do you live? — I live ___ London.	0		4	2025-12-21 17:04:34.354873+03	10
5522	prepositions_place	Where is the picture? — It's ___ the wall.	1		5	2025-12-21 17:04:34.354873+03	10
5523	prepositions_place	Where is the dog? — It's ___ the tree.	2		6	2025-12-21 17:04:34.354873+03	10
5524	prepositions_place	Where do you sit? — I sit ___ Tom and Mary.	2		7	2025-12-21 17:04:34.354873+03	10
5525	prepositions_place	Where are the keys? — They're ___ my pocket.	0		8	2025-12-21 17:04:34.354873+03	10
5526	prepositions_place	Where is the phone? — It's ___ the sofa.	1		9	2025-12-21 17:04:34.354873+03	10
5527	prepositions_place	Where is the ball? — It's ___ the bed.	2		10	2025-12-21 17:04:34.354873+03	10
5528	prepositions_place	Where is the cafe? — It's ___ my house.	3		11	2025-12-21 17:04:34.354873+03	10
5529	prepositions_place	Where is the milk? — It's ___ the fridge.	0		12	2025-12-21 17:04:34.354873+03	10
5530	prepositions_place	Where are the plates? — They're ___ the table.	1		13	2025-12-21 17:04:34.354873+03	10
5531	prepositions_place	Where is the cat? — It's ___ the table.	2		14	2025-12-21 17:04:34.354873+03	10
5532	prepositions_place	Where is the shop? — It's ___ the bank and the cafe.	2		15	2025-12-21 17:04:34.354873+03	10
5533	prepositions_place	Where is the water? — It's ___ the bottle.	0		16	2025-12-21 17:04:34.354873+03	10
5534	prepositions_place	Where is the hat? — It's ___ your head.	1		17	2025-12-21 17:04:34.354873+03	10
5535	prepositions_place	Where are the toys? — They're ___ the bed.	2		18	2025-12-21 17:04:34.354873+03	10
5536	prepositions_place	Where is the lamp? — It's ___ the bed.	3		19	2025-12-21 17:04:34.354873+03	10
5537	question_words	___ is this?	0		0	2025-12-21 17:04:34.76891+03	1
5538	question_words	___ is your name?	0		1	2025-12-21 17:04:34.76891+03	1
5539	question_words	___ do you do?	0		2	2025-12-21 17:04:34.76891+03	1
5540	question_words	___ time is it?	0		3	2025-12-21 17:04:34.76891+03	1
5541	question_words	___ do you like?	0		4	2025-12-21 17:04:34.76891+03	1
5542	question_words	___ is your job?	0		5	2025-12-21 17:04:34.76891+03	1
5543	question_words	___ are you doing?	0		6	2025-12-21 17:04:34.76891+03	1
5544	question_words	___ colour is it?	0		7	2025-12-21 17:04:34.76891+03	1
5545	question_words	___ is that?	0		8	2025-12-21 17:04:34.76891+03	1
5546	question_words	___ do you want?	0		9	2025-12-21 17:04:34.76891+03	1
5547	question_words	___ is the problem?	0		10	2025-12-21 17:04:34.76891+03	1
5548	question_words	___ did you say?	0		11	2025-12-21 17:04:34.76891+03	1
5549	question_words	___ are you reading?	0		12	2025-12-21 17:04:34.76891+03	1
5550	question_words	___ is your phone number?	0		13	2025-12-21 17:04:34.76891+03	1
5551	question_words	___ kind of music do you like?	0		14	2025-12-21 17:04:34.76891+03	1
5552	question_words	___ is your address?	0		15	2025-12-21 17:04:34.76891+03	1
5553	question_words	___ do you think?	0		16	2025-12-21 17:04:34.76891+03	1
5554	question_words	___ is the answer?	0		17	2025-12-21 17:04:34.76891+03	1
5555	question_words	___ are you talking about?	0		18	2025-12-21 17:04:34.76891+03	1
3779	pronouns	___ is broken again.	2	Правильный ответ: C	15	2025-12-20 02:57:32.688528+03	8
5556	question_words	___ happened?	0		19	2025-12-21 17:04:34.76891+03	1
5557	question_words	___ do you live?	1		0	2025-12-21 17:04:34.76891+03	2
5558	question_words	___ is the bank?	1		1	2025-12-21 17:04:34.76891+03	2
5559	question_words	___ are you?	1		2	2025-12-21 17:04:34.76891+03	2
5560	question_words	___ are you going?	1		3	2025-12-21 17:04:34.76891+03	2
5561	question_words	___ is the book?	1		4	2025-12-21 17:04:34.76891+03	2
5562	question_words	___ do you work?	1		5	2025-12-21 17:04:34.76891+03	2
5563	question_words	___ are my keys?	1		6	2025-12-21 17:04:34.76891+03	2
5564	question_words	___ is he from?	1		7	2025-12-21 17:04:34.76891+03	2
5565	question_words	___ is the bathroom?	1		8	2025-12-21 17:04:34.76891+03	2
5566	question_words	___ are you from?	1		9	2025-12-21 17:04:34.76891+03	2
5567	question_words	___ does she live?	1		10	2025-12-21 17:04:34.76891+03	2
5568	question_words	___ is the station?	1		11	2025-12-21 17:04:34.76891+03	2
5569	question_words	___ can I park?	1		12	2025-12-21 17:04:34.76891+03	2
5570	question_words	___ is the meeting?	1		13	2025-12-21 17:04:34.76891+03	2
5571	question_words	___ is my phone?	1		14	2025-12-21 17:04:34.76891+03	2
5572	question_words	___ do they study?	1		15	2025-12-21 17:04:34.76891+03	2
5573	question_words	___ is the party?	1		16	2025-12-21 17:04:34.76891+03	2
5574	question_words	___ can I find it?	1		17	2025-12-21 17:04:34.76891+03	2
5575	question_words	___ should I go?	1		18	2025-12-21 17:04:34.76891+03	2
5576	question_words	___ is your house?	1		19	2025-12-21 17:04:34.76891+03	2
5577	question_words	___ is this?	2		0	2025-12-21 17:04:34.76891+03	3
5578	question_words	___ are you?	2		1	2025-12-21 17:04:34.76891+03	3
5579	question_words	___ is your friend?	2		2	2025-12-21 17:04:34.76891+03	3
5580	question_words	___ lives here?	2		3	2025-12-21 17:04:34.76891+03	3
5581	question_words	___ is she?	2		4	2025-12-21 17:04:34.76891+03	3
5582	question_words	___ do you love?	2		5	2025-12-21 17:04:34.76891+03	3
5583	question_words	___ called me?	2		6	2025-12-21 17:04:34.76891+03	3
5584	question_words	___ works here?	2		7	2025-12-21 17:04:34.76891+03	3
5585	question_words	___ is your teacher?	2		8	2025-12-21 17:04:34.76891+03	3
5586	question_words	___ did you see?	2		9	2025-12-21 17:04:34.76891+03	3
5587	question_words	___ is that man?	2		10	2025-12-21 17:04:34.76891+03	3
5588	question_words	___ knows the answer?	2		11	2025-12-21 17:04:34.76891+03	3
5589	question_words	___ is your boss?	2		12	2025-12-21 17:04:34.76891+03	3
5590	question_words	___ did you talk to?	2		13	2025-12-21 17:04:34.76891+03	3
5591	question_words	___ is he?	2		14	2025-12-21 17:04:34.76891+03	3
5592	question_words	___ are they?	2		15	2025-12-21 17:04:34.76891+03	3
5593	question_words	___ made this?	2		16	2025-12-21 17:04:34.76891+03	3
5594	question_words	___ is coming?	2		17	2025-12-21 17:04:34.76891+03	3
5595	question_words	___ told you?	2		18	2025-12-21 17:04:34.76891+03	3
5596	question_words	___ is your doctor?	2		19	2025-12-21 17:04:34.76891+03	3
3807	pronouns	We trust ___.	1	Правильный ответ: B	12	2025-12-20 02:57:32.688528+03	2
3808	pronouns	___ idea worked.	0	Правильный ответ: A	7	2025-12-20 02:57:32.688528+03	3
3809	pronouns	The idea was ___.	2	Правильный ответ: C	19	2025-12-20 02:57:32.688528+03	3
3810	pronouns	___ are beautiful flowers.	2	Правильный ответ: C	8	2025-12-20 02:57:32.688528+03	4
3811	pronouns	___ belongs to her.	0	Правильный ответ: A	17	2025-12-20 02:57:32.688528+03	4
3812	pronouns	He thanked ___.	1	Правильный ответ: B	2	2025-12-20 02:57:32.688528+03	5
3813	pronouns	___ doesn’t matter now.	2	Правильный ответ: C	13	2025-12-20 02:57:32.688528+03	5
3814	pronouns	___ phone is ringing.	0	Правильный ответ: A	3	2025-12-20 02:57:32.688528+03	6
3815	pronouns	The phone is ___.	0	Правильный ответ: A	14	2025-12-20 02:57:32.688528+03	6
3816	pronouns	___ are ready to start.	1	Правильный ответ: B	8	2025-12-20 02:57:32.688528+03	7
3817	pronouns	She spoke to ___.	1	Правильный ответ: B	18	2025-12-20 02:57:32.688528+03	7
3818	pronouns	___ dress is nice.	0	Правильный ответ: A	2	2025-12-20 02:57:32.688528+03	8
3819	pronouns	The dress is ___.	2	Правильный ответ: C	19	2025-12-20 02:57:32.688528+03	8
3820	pronouns	___ doesn’t belong here.	2	Правильный ответ: C	3	2025-12-20 02:57:32.688528+03	9
3821	pronouns	___ bags are heavy.	2	Правильный ответ: C	18	2025-12-20 02:57:32.688528+03	9
3822	pronouns	___ teacher is strict.	0	Правильный ответ: A	3	2025-12-20 02:57:32.688528+03	10
3823	pronouns	The teacher is ___.	2	Правильный ответ: C	15	2025-12-20 02:57:32.688528+03	10
5597	question_words	___ is your birthday?	3		0	2025-12-21 17:04:34.76891+03	4
5598	question_words	___ do you work?	3		1	2025-12-21 17:04:34.76891+03	4
5599	question_words	___ did you arrive?	3		2	2025-12-21 17:04:34.76891+03	4
5600	question_words	___ is the meeting?	3		3	2025-12-21 17:04:34.76891+03	4
5601	question_words	___ do you wake up?	3		4	2025-12-21 17:04:34.76891+03	4
5602	question_words	___ is the exam?	3		5	2025-12-21 17:04:34.76891+03	4
5603	question_words	___ did you see her?	3		6	2025-12-21 17:04:34.76891+03	4
5604	question_words	___ can you come?	3		7	2025-12-21 17:04:34.76891+03	4
5605	question_words	___ is the party?	3		8	2025-12-21 17:04:34.76891+03	4
5606	question_words	___ do you go to bed?	3		9	2025-12-21 17:04:34.76891+03	4
5607	question_words	___ does the class start?	3		10	2025-12-21 17:04:34.76891+03	4
5608	question_words	___ is the deadline?	3		11	2025-12-21 17:04:34.76891+03	4
5609	question_words	___ did it happen?	3		12	2025-12-21 17:04:34.76891+03	4
5610	question_words	___ will you finish?	3		13	2025-12-21 17:04:34.76891+03	4
5611	question_words	___ is your appointment?	3		14	2025-12-21 17:04:34.76891+03	4
5612	question_words	___ do they arrive?	3		15	2025-12-21 17:04:34.76891+03	4
5613	question_words	___ is the concert?	3		16	2025-12-21 17:04:34.76891+03	4
5614	question_words	___ should I call?	3		17	2025-12-21 17:04:34.76891+03	4
5615	question_words	___ is lunch?	3		18	2025-12-21 17:04:34.76891+03	4
5616	question_words	___ do you leave?	3		19	2025-12-21 17:04:34.76891+03	4
5617	question_words	___ are you sad?	2		0	2025-12-21 17:04:34.76891+03	5
5618	question_words	___ do you study English?	2		1	2025-12-21 17:04:34.76891+03	5
5619	question_words	___ is she late?	2		2	2025-12-21 17:04:34.76891+03	5
5620	question_words	___ not?	2		3	2025-12-21 17:04:34.76891+03	5
5621	question_words	___ do you like it?	2		4	2025-12-21 17:04:34.76891+03	5
5622	question_words	___ is he angry?	2		5	2025-12-21 17:04:34.76891+03	5
5623	question_words	___ did you leave?	2		6	2025-12-21 17:04:34.76891+03	5
5624	question_words	___ don't you try?	2		7	2025-12-21 17:04:34.76891+03	5
5625	question_words	___ are you here?	2		8	2025-12-21 17:04:34.76891+03	5
5626	question_words	___ did she cry?	2		9	2025-12-21 17:04:34.76891+03	5
5627	question_words	___ is it important?	2		10	2025-12-21 17:04:34.76891+03	5
5628	question_words	___ do you ask?	2		11	2025-12-21 17:04:34.76891+03	5
5629	question_words	___ is he happy?	2		12	2025-12-21 17:04:34.76891+03	5
5630	question_words	___ did you call me?	2		13	2025-12-21 17:04:34.76891+03	5
5631	question_words	___ are they laughing?	2		14	2025-12-21 17:04:34.76891+03	5
5632	question_words	___ don't you come?	2		15	2025-12-21 17:04:34.76891+03	5
5633	question_words	___ is she worried?	2		16	2025-12-21 17:04:34.76891+03	5
5634	question_words	___ do you think so?	2		17	2025-12-21 17:04:34.76891+03	5
5635	question_words	___ did it break?	2		18	2025-12-21 17:04:34.76891+03	5
5636	question_words	___ is this necessary?	2		19	2025-12-21 17:04:34.76891+03	5
5637	question_words	___ are you?	2		0	2025-12-21 17:04:34.76891+03	6
5638	question_words	___ do you do this?	2		1	2025-12-21 17:04:34.76891+03	6
5639	question_words	___ old are you?	2		2	2025-12-21 17:04:34.76891+03	6
5640	question_words	___ much is it?	2		3	2025-12-21 17:04:34.76891+03	6
5641	question_words	___ do you know?	2		4	2025-12-21 17:04:34.76891+03	6
5642	question_words	___ is your mother?	2		5	2025-12-21 17:04:34.76891+03	6
5643	question_words	___ did you learn?	2		6	2025-12-21 17:04:34.76891+03	6
5644	question_words	___ far is it?	2		7	2025-12-21 17:04:34.76891+03	6
5645	question_words	___ many books?	2		8	2025-12-21 17:04:34.76891+03	6
5646	question_words	___ do you feel?	2		9	2025-12-21 17:04:34.76891+03	6
5647	question_words	___ does it work?	2		10	2025-12-21 17:04:34.76891+03	6
5648	question_words	___ long does it take?	2		11	2025-12-21 17:04:34.76891+03	6
5649	question_words	___ can I help?	2		12	2025-12-21 17:04:34.76891+03	6
5650	question_words	___ do you spell it?	2		13	2025-12-21 17:04:34.76891+03	6
5651	question_words	___ tall are you?	2		14	2025-12-21 17:04:34.76891+03	6
5652	question_words	___ often do you exercise?	2		15	2025-12-21 17:04:34.76891+03	6
5653	question_words	___ was your day?	2		16	2025-12-21 17:04:34.76891+03	6
5654	question_words	___ do you say it in English?	2		17	2025-12-21 17:04:34.76891+03	6
5655	question_words	___ much time do you have?	2		18	2025-12-21 17:04:34.76891+03	6
5656	question_words	___ many people are there?	2		19	2025-12-21 17:04:34.76891+03	6
5729	question_words	___ is coming?	2		12	2025-12-21 17:04:34.76891+03	10
5730	question_words	___ long does it take?	3		13	2025-12-21 17:04:34.76891+03	10
5731	question_words	___ do you wake up?	1		14	2025-12-21 17:04:34.76891+03	10
5732	question_words	___ is this necessary?	2		15	2025-12-21 17:04:34.76891+03	10
5733	question_words	___ happened?	0		16	2025-12-21 17:04:34.76891+03	10
5734	question_words	___ should I go?	1		17	2025-12-21 17:04:34.76891+03	10
5735	question_words	___ is your teacher?	2		18	2025-12-21 17:04:34.76891+03	10
5736	question_words	___ was your day?	3		19	2025-12-21 17:04:34.76891+03	10
5737	numbers_dates_time	How do you say '7'?	1		0	2025-12-21 17:04:35.050243+03	1
5738	numbers_dates_time	How do you say '12'?	0		1	2025-12-21 17:04:35.050243+03	1
5739	numbers_dates_time	How do you say '15'?	1		2	2025-12-21 17:04:35.050243+03	1
5740	numbers_dates_time	How do you say '3'?	1		3	2025-12-21 17:04:35.050243+03	1
5741	numbers_dates_time	How do you say '10'?	0		4	2025-12-21 17:04:35.050243+03	1
5742	numbers_dates_time	How do you say '1'?	0		5	2025-12-21 17:04:35.050243+03	1
5743	numbers_dates_time	How do you say '18'?	1		6	2025-12-21 17:04:35.050243+03	1
5744	numbers_dates_time	How do you say '5'?	1		7	2025-12-21 17:04:35.050243+03	1
5745	numbers_dates_time	How do you say '13'?	2		8	2025-12-21 17:04:35.050243+03	1
5746	numbers_dates_time	How do you say '20'?	0		9	2025-12-21 17:04:35.050243+03	1
5747	numbers_dates_time	How do you say '11'?	0		10	2025-12-21 17:04:35.050243+03	1
5748	numbers_dates_time	How do you say '8'?	1		11	2025-12-21 17:04:35.050243+03	1
5749	numbers_dates_time	How do you say '19'?	1		12	2025-12-21 17:04:35.050243+03	1
5750	numbers_dates_time	How do you say '4'?	1		13	2025-12-21 17:04:35.050243+03	1
5751	numbers_dates_time	How do you say '16'?	0		14	2025-12-21 17:04:35.050243+03	1
5752	numbers_dates_time	How do you say '2'?	2		15	2025-12-21 17:04:35.050243+03	1
5753	numbers_dates_time	How do you say '17'?	1		16	2025-12-21 17:04:35.050243+03	1
5754	numbers_dates_time	How do you say '6'?	1		17	2025-12-21 17:04:35.050243+03	1
5755	numbers_dates_time	How do you say '14'?	2		18	2025-12-21 17:04:35.050243+03	1
5756	numbers_dates_time	How do you say '9'?	0		19	2025-12-21 17:04:35.050243+03	1
5757	numbers_dates_time	How do you say '30'?	0		0	2025-12-21 17:04:35.050243+03	2
5758	numbers_dates_time	How do you say '50'?	1		1	2025-12-21 17:04:35.050243+03	2
5759	numbers_dates_time	How do you say '21'?	0		2	2025-12-21 17:04:35.050243+03	2
5760	numbers_dates_time	How do you say '40'?	1		3	2025-12-21 17:04:35.050243+03	2
5761	numbers_dates_time	How do you say '60'?	0		4	2025-12-21 17:04:35.050243+03	2
5762	numbers_dates_time	How do you say '75'?	0		5	2025-12-21 17:04:35.050243+03	2
5763	numbers_dates_time	How do you say '80'?	0		6	2025-12-21 17:04:35.050243+03	2
5764	numbers_dates_time	How do you say '90'?	0		7	2025-12-21 17:04:35.050243+03	2
5765	numbers_dates_time	How do you say '33'?	0		8	2025-12-21 17:04:35.050243+03	2
5766	numbers_dates_time	How do you say '45'?	0		9	2025-12-21 17:04:35.050243+03	2
5767	numbers_dates_time	How do you say '67'?	0		10	2025-12-21 17:04:35.050243+03	2
5768	numbers_dates_time	How do you say '89'?	0		11	2025-12-21 17:04:35.050243+03	2
5769	numbers_dates_time	How do you say '22'?	0		12	2025-12-21 17:04:35.050243+03	2
5770	numbers_dates_time	How do you say '70'?	0		13	2025-12-21 17:04:35.050243+03	2
5771	numbers_dates_time	How do you say '100'?	0		14	2025-12-21 17:04:35.050243+03	2
5772	numbers_dates_time	How do you say '55'?	0		15	2025-12-21 17:04:35.050243+03	2
5773	numbers_dates_time	How do you say '44'?	0		16	2025-12-21 17:04:35.050243+03	2
5774	numbers_dates_time	How do you say '99'?	0		17	2025-12-21 17:04:35.050243+03	2
5775	numbers_dates_time	How do you say '36'?	0		18	2025-12-21 17:04:35.050243+03	2
5776	numbers_dates_time	How do you say '88'?	0		19	2025-12-21 17:04:35.050243+03	2
5777	numbers_dates_time	The ___ of March	0		0	2025-12-21 17:04:35.050243+03	3
5778	numbers_dates_time	The ___ day	0		1	2025-12-21 17:04:35.050243+03	3
5779	numbers_dates_time	The ___ place	0		2	2025-12-21 17:04:35.050243+03	3
5780	numbers_dates_time	The ___ floor	0		3	2025-12-21 17:04:35.050243+03	3
5781	numbers_dates_time	The ___ time	0		4	2025-12-21 17:04:35.050243+03	3
5782	numbers_dates_time	The ___ chapter	0		5	2025-12-21 17:04:35.050243+03	3
5783	numbers_dates_time	The ___ week	0		6	2025-12-21 17:04:35.050243+03	3
5784	numbers_dates_time	The ___ month	0		7	2025-12-21 17:04:35.050243+03	3
5785	numbers_dates_time	The ___ grade	0		8	2025-12-21 17:04:35.050243+03	3
5786	numbers_dates_time	The ___ year	0		9	2025-12-21 17:04:35.050243+03	3
5787	numbers_dates_time	The ___ lesson	0		10	2025-12-21 17:04:35.050243+03	3
5788	numbers_dates_time	The ___ hour	0		11	2025-12-21 17:04:35.050243+03	3
5789	numbers_dates_time	May ___	0		12	2025-12-21 17:04:35.050243+03	3
5790	numbers_dates_time	March ___	0		13	2025-12-21 17:04:35.050243+03	3
5791	numbers_dates_time	June ___	0		14	2025-12-21 17:04:35.050243+03	3
5792	numbers_dates_time	July ___	0		15	2025-12-21 17:04:35.050243+03	3
5793	numbers_dates_time	April ___	0		16	2025-12-21 17:04:35.050243+03	3
5794	numbers_dates_time	January ___	0		17	2025-12-21 17:04:35.050243+03	3
5795	numbers_dates_time	December ___	0		18	2025-12-21 17:04:35.050243+03	3
5796	numbers_dates_time	August ___	0		19	2025-12-21 17:04:35.050243+03	3
5797	numbers_dates_time	The first day of the week is ___.	0		0	2025-12-21 17:04:35.050243+03	4
5798	numbers_dates_time	I work ___ Monday.	1		1	2025-12-21 17:04:35.050243+03	4
5799	numbers_dates_time	How do you spell Wednesday?	1		2	2025-12-21 17:04:35.050243+03	4
5800	numbers_dates_time	___ is after Monday.	0		3	2025-12-21 17:04:35.050243+03	4
5801	numbers_dates_time	The weekend is ___ and Sunday.	2		4	2025-12-21 17:04:35.050243+03	4
5802	numbers_dates_time	I have class ___ Friday.	1		5	2025-12-21 17:04:35.050243+03	4
5803	numbers_dates_time	___ comes before Thursday.	1		6	2025-12-21 17:04:35.050243+03	4
5804	numbers_dates_time	How many days in a week?	1		7	2025-12-21 17:04:35.050243+03	4
5805	numbers_dates_time	Sunday is ___ the weekend.	1		8	2025-12-21 17:04:35.050243+03	4
5806	numbers_dates_time	___ is between Tuesday and Thursday.	2		9	2025-12-21 17:04:35.050243+03	4
5807	numbers_dates_time	I don't work ___ Saturday.	1		10	2025-12-21 17:04:35.050243+03	4
5808	numbers_dates_time	The last day of the workweek is ___.	1		11	2025-12-21 17:04:35.050243+03	4
5809	numbers_dates_time	___ comes after Wednesday.	2		12	2025-12-21 17:04:35.050243+03	4
5810	numbers_dates_time	I go to the gym ___ Monday and Wednesday.	1		13	2025-12-21 17:04:35.050243+03	4
5811	numbers_dates_time	___ is the middle of the week.	1		14	2025-12-21 17:04:35.050243+03	4
5812	numbers_dates_time	We have a meeting ___ Thursday.	1		15	2025-12-21 17:04:35.050243+03	4
5813	numbers_dates_time	___ comes before Saturday.	1		16	2025-12-21 17:04:35.050243+03	4
5814	numbers_dates_time	I rest ___ Sunday.	1		17	2025-12-21 17:04:35.050243+03	4
5815	numbers_dates_time	___ is after Sunday.	1		18	2025-12-21 17:04:35.050243+03	4
5816	numbers_dates_time	Tuesday comes after ___.	1		19	2025-12-21 17:04:35.050243+03	4
5817	numbers_dates_time	The first month is ___.	0		0	2025-12-21 17:04:35.050243+03	5
5818	numbers_dates_time	I was born ___ May.	0		1	2025-12-21 17:04:35.050243+03	5
5819	numbers_dates_time	___ has 28 or 29 days.	1		2	2025-12-21 17:04:35.050243+03	5
5820	numbers_dates_time	Summer months: June, July, ___.	0		3	2025-12-21 17:04:35.050243+03	5
5821	numbers_dates_time	___ is the last month.	1		4	2025-12-21 17:04:35.050243+03	5
5822	numbers_dates_time	Spring starts ___ March.	0		5	2025-12-21 17:04:35.050243+03	5
5823	numbers_dates_time	___ comes after June.	1		6	2025-12-21 17:04:35.050243+03	5
5824	numbers_dates_time	How many months in a year?	2		7	2025-12-21 17:04:35.050243+03	5
5825	numbers_dates_time	Christmas is ___ December.	0		8	2025-12-21 17:04:35.050243+03	5
5826	numbers_dates_time	___ is before April.	2		9	2025-12-21 17:04:35.050243+03	5
5827	numbers_dates_time	Halloween is ___ October.	0		10	2025-12-21 17:04:35.050243+03	5
5828	numbers_dates_time	___ comes after August.	1		11	2025-12-21 17:04:35.050243+03	5
5829	numbers_dates_time	The third month is ___.	2		12	2025-12-21 17:04:35.050243+03	5
5830	numbers_dates_time	Winter months: December, January, ___.	1		13	2025-12-21 17:04:35.050243+03	5
5831	numbers_dates_time	___ is between March and May.	1		14	2025-12-21 17:04:35.050243+03	5
5832	numbers_dates_time	My birthday is ___ July.	0		15	2025-12-21 17:04:35.050243+03	5
5833	numbers_dates_time	___ has 31 days.	3		16	2025-12-21 17:04:35.050243+03	5
5834	numbers_dates_time	Autumn starts ___ September.	0		17	2025-12-21 17:04:35.050243+03	5
5835	numbers_dates_time	___ comes before November.	2		18	2025-12-21 17:04:35.050243+03	5
5836	numbers_dates_time	The shortest month is ___.	1		19	2025-12-21 17:04:35.050243+03	5
5837	numbers_dates_time	How do you say June 5th?	1		0	2025-12-21 17:04:35.050243+03	6
5838	numbers_dates_time	I have an exam ___ June 5th.	1		1	2025-12-21 17:04:35.050243+03	6
5839	numbers_dates_time	January ___	1		2	2025-12-21 17:04:35.050243+03	6
5840	numbers_dates_time	The ___ of March	0		3	2025-12-21 17:04:35.050243+03	6
5841	numbers_dates_time	My birthday is ___ the 15th.	1		4	2025-12-21 17:04:35.050243+03	6
5842	numbers_dates_time	December ___ is Christmas.	1		5	2025-12-21 17:04:35.050243+03	6
5843	numbers_dates_time	How do you write March 22?	1		6	2025-12-21 17:04:35.050243+03	6
5844	numbers_dates_time	The meeting is ___ May 10th.	1		7	2025-12-21 17:04:35.050243+03	6
5845	numbers_dates_time	July ___ is Independence Day (US).	1		8	2025-12-21 17:04:35.050243+03	6
5846	numbers_dates_time	I arrive ___ the 3rd of June.	1		9	2025-12-21 17:04:35.050243+03	6
5847	numbers_dates_time	February ___	0		10	2025-12-21 17:04:35.050243+03	6
5848	numbers_dates_time	The ___ of January	0		11	2025-12-21 17:04:35.050243+03	6
5849	numbers_dates_time	Classes start ___ September 1st.	1		12	2025-12-21 17:04:35.050243+03	6
5850	numbers_dates_time	Halloween is October ___.	0		13	2025-12-21 17:04:35.050243+03	6
5851	numbers_dates_time	The exam is ___ the 20th.	1		14	2025-12-21 17:04:35.050243+03	6
5852	numbers_dates_time	April ___	0		15	2025-12-21 17:04:35.050243+03	6
5853	numbers_dates_time	New Year is January ___.	0		16	2025-12-21 17:04:35.050243+03	6
5854	numbers_dates_time	The deadline is ___ March 15th.	1		17	2025-12-21 17:04:35.050243+03	6
5855	numbers_dates_time	June ___	0		18	2025-12-21 17:04:35.050243+03	6
5856	numbers_dates_time	I was born ___ May 5th.	1		19	2025-12-21 17:04:35.050243+03	6
5857	numbers_dates_time	What time is it? It's 5:00.	0		0	2025-12-21 17:04:35.050243+03	7
5858	numbers_dates_time	The meeting is ___ 3 o'clock.	2		1	2025-12-21 17:04:35.050243+03	7
5859	numbers_dates_time	12:00 PM is ___.	1		2	2025-12-21 17:04:35.050243+03	7
5860	numbers_dates_time	I wake up ___ 7 o'clock.	2		3	2025-12-21 17:04:35.050243+03	7
5861	numbers_dates_time	12:00 AM is ___.	1		4	2025-12-21 17:04:35.050243+03	7
5862	numbers_dates_time	What time is it? 10:00.	0		5	2025-12-21 17:04:35.050243+03	7
5863	numbers_dates_time	The class starts ___ 9 o'clock.	2		6	2025-12-21 17:04:35.050243+03	7
5864	numbers_dates_time	I have lunch ___ noon.	2		7	2025-12-21 17:04:35.050243+03	7
5865	numbers_dates_time	8:00 PM means ___.	1		8	2025-12-21 17:04:35.050243+03	7
5866	numbers_dates_time	I go to bed ___ midnight.	2		9	2025-12-21 17:04:35.050243+03	7
5867	numbers_dates_time	What time is it? 6:00.	0		10	2025-12-21 17:04:35.050243+03	7
5868	numbers_dates_time	The store opens ___ 10 o'clock.	2		11	2025-12-21 17:04:35.050243+03	7
5869	numbers_dates_time	7:00 AM means ___.	1		12	2025-12-21 17:04:35.050243+03	7
5870	numbers_dates_time	We meet ___ 5 o'clock.	2		13	2025-12-21 17:04:35.050243+03	7
5871	numbers_dates_time	What time is it? 1:00.	0		14	2025-12-21 17:04:35.050243+03	7
5872	numbers_dates_time	Dinner is ___ 6 o'clock.	2		15	2025-12-21 17:04:35.050243+03	7
5873	numbers_dates_time	2:00 PM is ___ in the afternoon.	0		16	2025-12-21 17:04:35.050243+03	7
5874	numbers_dates_time	I finish work ___ 5 o'clock.	2		17	2025-12-21 17:04:35.050243+03	7
5875	numbers_dates_time	What time is it? 11:00.	0		18	2025-12-21 17:04:35.050243+03	7
5876	numbers_dates_time	The movie starts ___ 8 o'clock.	2		19	2025-12-21 17:04:35.050243+03	7
5877	numbers_dates_time	3:15 = ___	0		0	2025-12-21 17:04:35.050243+03	8
5878	numbers_dates_time	4:30 = ___	0		1	2025-12-21 17:04:35.050243+03	8
5879	numbers_dates_time	5:45 = ___	2		2	2025-12-21 17:04:35.050243+03	8
5880	numbers_dates_time	2:10 = ___	0		3	2025-12-21 17:04:35.050243+03	8
5881	numbers_dates_time	6:50 = ___	2		4	2025-12-21 17:04:35.050243+03	8
5882	numbers_dates_time	I arrive ___ half past three.	2		5	2025-12-21 17:04:35.050243+03	8
5883	numbers_dates_time	7:15 = ___	0		6	2025-12-21 17:04:35.050243+03	8
5884	numbers_dates_time	The meeting is ___ quarter to five.	2		7	2025-12-21 17:04:35.050243+03	8
5885	numbers_dates_time	9:30 = ___	0		8	2025-12-21 17:04:35.050243+03	8
5886	numbers_dates_time	I leave ___ ten to six.	2		9	2025-12-21 17:04:35.050243+03	8
5887	numbers_dates_time	8:45 = ___	2		10	2025-12-21 17:04:35.050243+03	8
5888	numbers_dates_time	1:20 = ___	0		11	2025-12-21 17:04:35.050243+03	8
5889	numbers_dates_time	The bus comes ___ twenty past five.	2		12	2025-12-21 17:04:35.050243+03	8
5890	numbers_dates_time	11:30 = ___	0		13	2025-12-21 17:04:35.050243+03	8
5891	numbers_dates_time	4:55 = ___	1		14	2025-12-21 17:04:35.050243+03	8
5892	numbers_dates_time	I wake up ___ quarter past six.	2		15	2025-12-21 17:04:35.050243+03	8
5893	numbers_dates_time	10:15 = ___	0		16	2025-12-21 17:04:35.050243+03	8
5894	numbers_dates_time	3:40 = ___	1		17	2025-12-21 17:04:35.050243+03	8
5895	numbers_dates_time	The class ends ___ twenty to four.	2		18	2025-12-21 17:04:35.050243+03	8
5896	numbers_dates_time	12:30 = ___	0		19	2025-12-21 17:04:35.050243+03	8
5897	numbers_dates_time	9:00 AM is ___.	0		0	2025-12-21 17:04:35.050243+03	9
5898	numbers_dates_time	9:00 PM is ___.	1		1	2025-12-21 17:04:35.050243+03	9
5899	numbers_dates_time	I have breakfast ___ 8 AM.	2		2	2025-12-21 17:04:35.050243+03	9
5900	numbers_dates_time	Midnight is ___.	0		3	2025-12-21 17:04:35.050243+03	9
5901	numbers_dates_time	Noon is ___.	1		4	2025-12-21 17:04:35.050243+03	9
5902	numbers_dates_time	I go to bed ___ 11 PM.	2		5	2025-12-21 17:04:35.050243+03	9
5903	numbers_dates_time	6:00 AM means ___.	0		6	2025-12-21 17:04:35.050243+03	9
5904	numbers_dates_time	6:00 PM means ___.	1		7	2025-12-21 17:04:35.050243+03	9
5905	numbers_dates_time	I work ___ the morning.	0		8	2025-12-21 17:04:35.050243+03	9
5906	numbers_dates_time	The store closes ___ 9 PM.	2		9	2025-12-21 17:04:35.050243+03	9
5907	numbers_dates_time	I study ___ the evening.	0		10	2025-12-21 17:04:35.050243+03	9
5908	numbers_dates_time	3:00 AM is ___.	0		11	2025-12-21 17:04:35.050243+03	9
5909	numbers_dates_time	I have lunch ___ the afternoon.	0		12	2025-12-21 17:04:35.050243+03	9
5910	numbers_dates_time	The party starts ___ 7 PM.	2		13	2025-12-21 17:04:35.050243+03	9
5911	numbers_dates_time	I sleep ___ night.	3		14	2025-12-21 17:04:35.050243+03	9
5912	numbers_dates_time	4:00 PM is ___.	1		15	2025-12-21 17:04:35.050243+03	9
5913	numbers_dates_time	I wake up early ___ the morning.	0		16	2025-12-21 17:04:35.050243+03	9
5914	numbers_dates_time	The meeting is ___ 10 AM.	2		17	2025-12-21 17:04:35.050243+03	9
5915	numbers_dates_time	I watch TV ___ the evening.	0		18	2025-12-21 17:04:35.050243+03	9
5916	numbers_dates_time	11:00 PM is ___.	1		19	2025-12-21 17:04:35.050243+03	9
5917	numbers_dates_time	How do you say '25'?	0		0	2025-12-21 17:04:35.050243+03	10
5918	numbers_dates_time	The ___ of June	0		1	2025-12-21 17:04:35.050243+03	10
5919	numbers_dates_time	I wake up ___ 7 o'clock.	2		2	2025-12-21 17:04:35.050243+03	10
5920	numbers_dates_time	___ comes after Tuesday.	1		3	2025-12-21 17:04:35.050243+03	10
5921	numbers_dates_time	I was born ___ May.	0		4	2025-12-21 17:04:35.050243+03	10
5922	numbers_dates_time	3:30 = ___	0		5	2025-12-21 17:04:35.050243+03	10
5923	numbers_dates_time	How do you say '12'?	1		6	2025-12-21 17:04:35.050243+03	10
5924	numbers_dates_time	My birthday is ___ June 15th.	1		7	2025-12-21 17:04:35.050243+03	10
5925	numbers_dates_time	The third month is ___.	1		8	2025-12-21 17:04:35.050243+03	10
5926	numbers_dates_time	I have lunch ___ noon.	2		9	2025-12-21 17:04:35.050243+03	10
5927	numbers_dates_time	How do you say '50'?	1		10	2025-12-21 17:04:35.050243+03	10
5928	numbers_dates_time	___ is the last month.	1		11	2025-12-21 17:04:35.050243+03	10
5929	numbers_dates_time	4:15 = ___	0		12	2025-12-21 17:04:35.050243+03	10
5930	numbers_dates_time	I work ___ Monday.	1		13	2025-12-21 17:04:35.050243+03	10
5931	numbers_dates_time	January ___	0		14	2025-12-21 17:04:35.050243+03	10
5932	numbers_dates_time	9:00 PM means ___.	1		15	2025-12-21 17:04:35.050243+03	10
5933	numbers_dates_time	How do you say '33'?	0		16	2025-12-21 17:04:35.050243+03	10
5934	numbers_dates_time	The meeting is ___ May 10th.	1		17	2025-12-21 17:04:35.050243+03	10
5935	numbers_dates_time	___ comes before Saturday.	1		18	2025-12-21 17:04:35.050243+03	10
5936	numbers_dates_time	I finish work ___ 5 PM.	2		19	2025-12-21 17:04:35.050243+03	10
5937	present_continuous	work → ___	0		0	2025-12-21 17:04:35.311167+03	1
5938	present_continuous	play → ___	1		1	2025-12-21 17:04:35.311167+03	1
5939	present_continuous	read → ___	0		2	2025-12-21 17:04:35.311167+03	1
5940	present_continuous	watch → ___	2		3	2025-12-21 17:04:35.311167+03	1
5941	present_continuous	study → ___	1		4	2025-12-21 17:04:35.311167+03	1
5942	present_continuous	sleep → ___	0		5	2025-12-21 17:04:35.311167+03	1
5943	present_continuous	talk → ___	0		6	2025-12-21 17:04:35.311167+03	1
5944	present_continuous	listen → ___	0		7	2025-12-21 17:04:35.311167+03	1
5945	present_continuous	walk → ___	0		8	2025-12-21 17:04:35.311167+03	1
5946	present_continuous	eat → ___	0		9	2025-12-21 17:04:35.311167+03	1
5947	present_continuous	drink → ___	0		10	2025-12-21 17:04:35.311167+03	1
5948	present_continuous	cook → ___	0		11	2025-12-21 17:04:35.311167+03	1
5949	present_continuous	clean → ___	0		12	2025-12-21 17:04:35.311167+03	1
5950	present_continuous	teach → ___	1		13	2025-12-21 17:04:35.311167+03	1
5951	present_continuous	learn → ___	0		14	2025-12-21 17:04:35.311167+03	1
5952	present_continuous	help → ___	0		15	2025-12-21 17:04:35.311167+03	1
5953	present_continuous	wait → ___	0		16	2025-12-21 17:04:35.311167+03	1
5954	present_continuous	call → ___	0		17	2025-12-21 17:04:35.311167+03	1
5955	present_continuous	start → ___	0		18	2025-12-21 17:04:35.311167+03	1
5956	present_continuous	finish → ___	0		19	2025-12-21 17:04:35.311167+03	1
5957	present_continuous	make → ___	1		0	2025-12-21 17:04:35.311167+03	2
5958	present_continuous	write → ___	1		1	2025-12-21 17:04:35.311167+03	2
5959	present_continuous	come → ___	1		2	2025-12-21 17:04:35.311167+03	2
5960	present_continuous	take → ___	1		3	2025-12-21 17:04:35.311167+03	2
5961	present_continuous	have → ___	1		4	2025-12-21 17:04:35.311167+03	2
5962	present_continuous	live → ___	1		5	2025-12-21 17:04:35.311167+03	2
5963	present_continuous	give → ___	1		6	2025-12-21 17:04:35.311167+03	2
5964	present_continuous	use → ___	1		7	2025-12-21 17:04:35.311167+03	2
5965	present_continuous	dance → ___	1		8	2025-12-21 17:04:35.311167+03	2
5966	present_continuous	drive → ___	1		9	2025-12-21 17:04:35.311167+03	2
5967	present_continuous	ride → ___	1		10	2025-12-21 17:04:35.311167+03	2
5968	present_continuous	smile → ___	1		11	2025-12-21 17:04:35.311167+03	2
5969	present_continuous	leave → ___	1		12	2025-12-21 17:04:35.311167+03	2
5970	present_continuous	arrive → ___	1		13	2025-12-21 17:04:35.311167+03	2
5971	present_continuous	close → ___	1		14	2025-12-21 17:04:35.311167+03	2
5972	present_continuous	hope → ___	1		15	2025-12-21 17:04:35.311167+03	2
5973	present_continuous	save → ___	1		16	2025-12-21 17:04:35.311167+03	2
5974	present_continuous	move → ___	1		17	2025-12-21 17:04:35.311167+03	2
5975	present_continuous	change → ___	1		18	2025-12-21 17:04:35.311167+03	2
5976	present_continuous	lose → ___	1		19	2025-12-21 17:04:35.311167+03	2
5977	present_continuous	run → ___	1		0	2025-12-21 17:04:35.311167+03	3
5978	present_continuous	sit → ___	1		1	2025-12-21 17:04:35.311167+03	3
5979	present_continuous	stop → ___	1		2	2025-12-21 17:04:35.311167+03	3
5980	present_continuous	swim → ___	1		3	2025-12-21 17:04:35.311167+03	3
5981	present_continuous	get → ___	1		4	2025-12-21 17:04:35.311167+03	3
5982	present_continuous	put → ___	1		5	2025-12-21 17:04:35.311167+03	3
5983	present_continuous	cut → ___	1		6	2025-12-21 17:04:35.311167+03	3
5984	present_continuous	plan → ___	1		7	2025-12-21 17:04:35.311167+03	3
5985	present_continuous	begin → ___	1		8	2025-12-21 17:04:35.311167+03	3
5986	present_continuous	forget → ___	1		9	2025-12-21 17:04:35.311167+03	3
5987	present_continuous	НО: open → ___	0		10	2025-12-21 17:04:35.311167+03	3
5988	present_continuous	НО: happen → ___	0		11	2025-12-21 17:04:35.311167+03	3
5989	present_continuous	НО: listen → ___	0		12	2025-12-21 17:04:35.311167+03	3
5990	present_continuous	НО: visit → ___	0		13	2025-12-21 17:04:35.311167+03	3
5991	present_continuous	win → ___	1		14	2025-12-21 17:04:35.311167+03	3
5992	present_continuous	set → ___	1		15	2025-12-21 17:04:35.311167+03	3
5993	present_continuous	let → ___	1		16	2025-12-21 17:04:35.311167+03	3
5994	present_continuous	shop → ___	1		17	2025-12-21 17:04:35.311167+03	3
5995	present_continuous	drop → ___	1		18	2025-12-21 17:04:35.311167+03	3
5996	present_continuous	НО: enter → ___	0		19	2025-12-21 17:04:35.311167+03	3
5997	present_continuous	I ___ working now.	0		0	2025-12-21 17:04:35.311167+03	4
5998	present_continuous	You ___ studying English.	2		1	2025-12-21 17:04:35.311167+03	4
5999	present_continuous	We ___ watching TV.	2		2	2025-12-21 17:04:35.311167+03	4
6000	present_continuous	They ___ playing football.	2		3	2025-12-21 17:04:35.311167+03	4
6001	present_continuous	I ___ reading a book.	0		4	2025-12-21 17:04:35.311167+03	4
6002	present_continuous	You ___ eating lunch.	2		5	2025-12-21 17:04:35.311167+03	4
6003	present_continuous	We ___ learning English.	2		6	2025-12-21 17:04:35.311167+03	4
6004	present_continuous	They ___ sleeping now.	2		7	2025-12-21 17:04:35.311167+03	4
6005	present_continuous	I ___ cooking dinner.	0		8	2025-12-21 17:04:35.311167+03	4
6006	present_continuous	You ___ listening to music.	2		9	2025-12-21 17:04:35.311167+03	4
6007	present_continuous	We ___ doing homework.	2		10	2025-12-21 17:04:35.311167+03	4
6008	present_continuous	They ___ talking.	2		11	2025-12-21 17:04:35.311167+03	4
6009	present_continuous	I ___ drinking coffee.	0		12	2025-12-21 17:04:35.311167+03	4
6010	present_continuous	You ___ writing an email.	2		13	2025-12-21 17:04:35.311167+03	4
6011	present_continuous	We ___ having fun.	2		14	2025-12-21 17:04:35.311167+03	4
6012	present_continuous	They ___ waiting for the bus.	2		15	2025-12-21 17:04:35.311167+03	4
6013	present_continuous	I ___ sitting here.	0		16	2025-12-21 17:04:35.311167+03	4
6014	present_continuous	You ___ standing there.	2		17	2025-12-21 17:04:35.311167+03	4
6015	present_continuous	We ___ going home.	2		18	2025-12-21 17:04:35.311167+03	4
6016	present_continuous	They ___ coming now.	2		19	2025-12-21 17:04:35.311167+03	4
6017	present_continuous	He ___ working now.	1		0	2025-12-21 17:04:35.311167+03	5
6018	present_continuous	She ___ studying English.	1		1	2025-12-21 17:04:35.311167+03	5
6019	present_continuous	It ___ raining.	1		2	2025-12-21 17:04:35.311167+03	5
6020	present_continuous	He ___ playing football.	1		3	2025-12-21 17:04:35.311167+03	5
6021	present_continuous	She ___ reading a book.	1		4	2025-12-21 17:04:35.311167+03	5
6022	present_continuous	It ___ snowing.	1		5	2025-12-21 17:04:35.311167+03	5
6023	present_continuous	He ___ eating lunch.	1		6	2025-12-21 17:04:35.311167+03	5
6024	present_continuous	She ___ sleeping now.	1		7	2025-12-21 17:04:35.311167+03	5
6025	present_continuous	It ___ working well.	1		8	2025-12-21 17:04:35.311167+03	5
6026	present_continuous	He ___ cooking dinner.	1		9	2025-12-21 17:04:35.311167+03	5
6027	present_continuous	She ___ listening to music.	1		10	2025-12-21 17:04:35.311167+03	5
6028	present_continuous	It ___ getting dark.	1		11	2025-12-21 17:04:35.311167+03	5
6029	present_continuous	He ___ doing homework.	1		12	2025-12-21 17:04:35.311167+03	5
6030	present_continuous	She ___ talking on the phone.	1		13	2025-12-21 17:04:35.311167+03	5
6031	present_continuous	It ___ starting now.	1		14	2025-12-21 17:04:35.311167+03	5
6032	present_continuous	He ___ drinking water.	1		15	2025-12-21 17:04:35.311167+03	5
6033	present_continuous	She ___ writing a letter.	1		16	2025-12-21 17:04:35.311167+03	5
6034	present_continuous	It ___ getting better.	1		17	2025-12-21 17:04:35.311167+03	5
6035	present_continuous	He ___ sitting there.	1		18	2025-12-21 17:04:35.311167+03	5
6036	present_continuous	She ___ coming here.	1		19	2025-12-21 17:04:35.311167+03	5
6037	present_continuous	I ___ not working.	0		0	2025-12-21 17:04:35.311167+03	6
6038	present_continuous	He ___ not studying.	1		1	2025-12-21 17:04:35.311167+03	6
6039	present_continuous	They ___ not playing.	2		2	2025-12-21 17:04:35.311167+03	6
6040	present_continuous	She ___ not reading.	1		3	2025-12-21 17:04:35.311167+03	6
6041	present_continuous	We ___ not eating.	2		4	2025-12-21 17:04:35.311167+03	6
6042	present_continuous	You ___ not sleeping.	2		5	2025-12-21 17:04:35.311167+03	6
6043	present_continuous	It ___ not raining.	1		6	2025-12-21 17:04:35.311167+03	6
6044	present_continuous	I'm ___ watching TV.	1		7	2025-12-21 17:04:35.311167+03	6
6045	present_continuous	He ___ listening.	0		8	2025-12-21 17:04:35.311167+03	6
6046	present_continuous	They ___ talking.	1		9	2025-12-21 17:04:35.311167+03	6
6047	present_continuous	She ___ cooking.	0		10	2025-12-21 17:04:35.311167+03	6
6048	present_continuous	We ___ waiting.	1		11	2025-12-21 17:04:35.311167+03	6
6049	present_continuous	You ___ working.	1		12	2025-12-21 17:04:35.311167+03	6
6050	present_continuous	It ___ working.	0		13	2025-12-21 17:04:35.311167+03	6
6051	present_continuous	I ___ going.	0		14	2025-12-21 17:04:35.311167+03	6
6052	present_continuous	He ___ coming.	1		15	2025-12-21 17:04:35.311167+03	6
6053	present_continuous	They ___ leaving.	2		16	2025-12-21 17:04:35.311167+03	6
6054	present_continuous	She ___ sitting.	1		17	2025-12-21 17:04:35.311167+03	6
6055	present_continuous	We ___ standing.	2		18	2025-12-21 17:04:35.311167+03	6
6056	present_continuous	You ___ running.	2		19	2025-12-21 17:04:35.311167+03	6
6057	present_continuous	___ you working?	2		0	2025-12-21 17:04:35.311167+03	7
6058	present_continuous	___ he studying?	1		1	2025-12-21 17:04:35.311167+03	7
6059	present_continuous	___ they playing?	2		2	2025-12-21 17:04:35.311167+03	7
6060	present_continuous	___ she reading?	1		3	2025-12-21 17:04:35.311167+03	7
6061	present_continuous	___ I doing it right?	0		4	2025-12-21 17:04:35.311167+03	7
6062	present_continuous	___ we eating now?	2		5	2025-12-21 17:04:35.311167+03	7
6063	present_continuous	___ it raining?	1		6	2025-12-21 17:04:35.311167+03	7
6064	present_continuous	___ you listening?	2		7	2025-12-21 17:04:35.311167+03	7
6065	present_continuous	___ he coming?	1		8	2025-12-21 17:04:35.311167+03	7
6066	present_continuous	___ they waiting?	2		9	2025-12-21 17:04:35.311167+03	7
6067	present_continuous	___ she sleeping?	1		10	2025-12-21 17:04:35.311167+03	7
6068	present_continuous	___ I late?	0		11	2025-12-21 17:04:35.311167+03	7
6069	present_continuous	___ we going?	2		12	2025-12-21 17:04:35.311167+03	7
6070	present_continuous	___ it working?	1		13	2025-12-21 17:04:35.311167+03	7
6071	present_continuous	___ you watching TV?	2		14	2025-12-21 17:04:35.311167+03	7
6072	present_continuous	___ he talking?	1		15	2025-12-21 17:04:35.311167+03	7
6073	present_continuous	___ they leaving?	2		16	2025-12-21 17:04:35.311167+03	7
6074	present_continuous	___ she writing?	1		17	2025-12-21 17:04:35.311167+03	7
6075	present_continuous	___ I bothering you?	0		18	2025-12-21 17:04:35.311167+03	7
6076	present_continuous	___ we staying here?	2		19	2025-12-21 17:04:35.311167+03	7
6077	present_continuous	I ___ English every day.	0		0	2025-12-21 17:04:35.311167+03	8
6078	present_continuous	I ___ English now.	1		1	2025-12-21 17:04:35.311167+03	8
6079	present_continuous	He ___ football on Sundays.	3		2	2025-12-21 17:04:35.311167+03	8
6080	present_continuous	He ___ football at the moment.	1		3	2025-12-21 17:04:35.311167+03	8
6081	present_continuous	They ___ in London.	0		4	2025-12-21 17:04:35.311167+03	8
6082	present_continuous	They ___ in a hotel this week.	1		5	2025-12-21 17:04:35.311167+03	8
6083	present_continuous	She ___ to school every day.	3		6	2025-12-21 17:04:35.311167+03	8
6084	present_continuous	She ___ to school now.	1		7	2025-12-21 17:04:35.311167+03	8
6085	present_continuous	We ___ English.	0		8	2025-12-21 17:04:35.311167+03	8
6086	present_continuous	We ___ dinner now.	1		9	2025-12-21 17:04:35.311167+03	8
6087	present_continuous	I ___ tea every morning.	0		10	2025-12-21 17:04:35.311167+03	8
6088	present_continuous	I ___ tea right now.	1		11	2025-12-21 17:04:35.311167+03	8
6089	present_continuous	He ___ TV every evening.	3		12	2025-12-21 17:04:35.311167+03	8
6090	present_continuous	He ___ TV at the moment.	1		13	2025-12-21 17:04:35.311167+03	8
6091	present_continuous	They usually ___ at 7 AM.	0		14	2025-12-21 17:04:35.311167+03	8
6092	present_continuous	They ___ up right now.	1		15	2025-12-21 17:04:35.311167+03	8
6093	present_continuous	She always ___ to music.	3		16	2025-12-21 17:04:35.311167+03	8
6094	present_continuous	She ___ to music now.	1		17	2025-12-21 17:04:35.311167+03	8
6095	present_continuous	I often ___ books.	0		18	2025-12-21 17:04:35.311167+03	8
6096	present_continuous	I ___ a book right now.	1		19	2025-12-21 17:04:35.311167+03	8
6097	present_continuous	I'm working ___.	0		0	2025-12-21 17:04:35.311167+03	9
6098	present_continuous	She studies ___.	1		1	2025-12-21 17:04:35.311167+03	9
6099	present_continuous	They are playing ___.	2		2	2025-12-21 17:04:35.311167+03	9
6100	present_continuous	He goes to school ___.	3		3	2025-12-21 17:04:35.311167+03	9
6101	present_continuous	We ___ watching TV now.	2		4	2025-12-21 17:04:35.311167+03	9
6102	present_continuous	I ___ like pizza.	3		5	2025-12-21 17:04:35.311167+03	9
6103	present_continuous	Look! It ___ raining.	0		6	2025-12-21 17:04:35.311167+03	9
6104	present_continuous	She ___ works on Monday.	3		7	2025-12-21 17:04:35.311167+03	9
6105	present_continuous	Listen! He ___ singing.	0		8	2025-12-21 17:04:35.311167+03	9
6106	present_continuous	They usually ___ at home.	3		9	2025-12-21 17:04:35.311167+03	9
6107	present_continuous	I'm ___ a book right now.	1		10	2025-12-21 17:04:35.311167+03	9
6108	present_continuous	She ___ English every day.	2		11	2025-12-21 17:04:35.311167+03	9
6109	present_continuous	We're ___ lunch at the moment.	1		12	2025-12-21 17:04:35.311167+03	9
6110	present_continuous	He always ___ breakfast.	2		13	2025-12-21 17:04:35.311167+03	9
6111	present_continuous	They're ___ to school now.	1		14	2025-12-21 17:04:35.311167+03	9
6112	present_continuous	I ___ coffee every morning.	0		15	2025-12-21 17:04:35.311167+03	9
6113	present_continuous	She's ___ on the phone now.	1		16	2025-12-21 17:04:35.311167+03	9
6114	present_continuous	We often ___ football.	0		17	2025-12-21 17:04:35.311167+03	9
6115	present_continuous	He's ___ his homework right now.	1		18	2025-12-21 17:04:35.311167+03	9
6116	present_continuous	They never ___ late.	0		19	2025-12-21 17:04:35.311167+03	9
6117	present_continuous	What ___ you doing?	2		0	2025-12-21 17:04:35.311167+03	10
6118	present_continuous	I ___ working now.	0		1	2025-12-21 17:04:35.311167+03	10
6119	present_continuous	She ___ reading a book.	1		2	2025-12-21 17:04:35.311167+03	10
6120	present_continuous	They ___ playing football.	2		3	2025-12-21 17:04:35.311167+03	10
6121	present_continuous	He ___ not listening.	1		4	2025-12-21 17:04:35.311167+03	10
6122	present_continuous	___ it raining?	1		5	2025-12-21 17:04:35.311167+03	10
6123	present_continuous	We ___ studying English.	2		6	2025-12-21 17:04:35.311167+03	10
6124	present_continuous	I ___ not sleeping.	0		7	2025-12-21 17:04:35.311167+03	10
6125	present_continuous	___ you watching TV?	2		8	2025-12-21 17:04:35.311167+03	10
6126	present_continuous	She ___ cooking dinner.	1		9	2025-12-21 17:04:35.311167+03	10
6127	present_continuous	make → ___	1		10	2025-12-21 17:04:35.311167+03	10
6128	present_continuous	run → ___	1		11	2025-12-21 17:04:35.311167+03	10
6129	present_continuous	I ___ like pizza.	2		12	2025-12-21 17:04:35.311167+03	10
6130	present_continuous	He ___ to school every day.	2		13	2025-12-21 17:04:35.311167+03	10
6131	present_continuous	They're ___ now.	1		14	2025-12-21 17:04:35.311167+03	10
6132	present_continuous	She always ___ early.	2		15	2025-12-21 17:04:35.311167+03	10
6133	present_continuous	Look! He ___ coming.	0		16	2025-12-21 17:04:35.311167+03	10
6134	present_continuous	We ___ tea every morning.	0		17	2025-12-21 17:04:35.311167+03	10
6135	present_continuous	I'm ___ a letter right now.	1		18	2025-12-21 17:04:35.311167+03	10
6136	present_continuous	They usually ___ at 8 PM.	0		19	2025-12-21 17:04:35.311167+03	10
6138	future_simple	I ___ go to the park tomorrow.	0		0	2025-12-23 01:55:47.951388+03	1
6139	future_simple	She ___ call you later.	0		1	2025-12-23 01:55:47.951388+03	1
6140	future_simple	They ___ help us with the project.	0		2	2025-12-23 01:55:47.951388+03	1
6141	future_simple	We ___ travel next summer.	0		3	2025-12-23 01:55:47.951388+03	1
6142	future_simple	He ___ study English next year.	0		4	2025-12-23 01:55:47.951388+03	1
6143	future_simple	You ___ see her soon.	0		5	2025-12-23 01:55:47.951388+03	1
6144	future_simple	It ___ rain tomorrow.	0		6	2025-12-23 01:55:47.951388+03	1
6145	future_simple	I ___ work hard next week.	0		7	2025-12-23 01:55:47.951388+03	1
6146	future_simple	She ___ come to the party tonight.	0		8	2025-12-23 01:55:47.951388+03	1
6147	future_simple	They ___ buy a new car.	0		9	2025-12-23 01:55:47.951388+03	1
6148	future_simple	We ___ finish the work soon.	0		10	2025-12-23 01:55:47.951388+03	1
6149	future_simple	He ___ visit his parents next month.	0		11	2025-12-23 01:55:47.951388+03	1
6150	future_simple	You ___ learn a lot.	0		12	2025-12-23 01:55:47.951388+03	1
6151	future_simple	It ___ be sunny tomorrow.	0		13	2025-12-23 01:55:47.951388+03	1
6152	future_simple	I ___ make dinner tonight.	0		14	2025-12-23 01:55:47.951388+03	1
6153	future_simple	She ___ write a book.	0		15	2025-12-23 01:55:47.951388+03	1
6154	future_simple	They ___ move to a new house.	0		16	2025-12-23 01:55:47.951388+03	1
6155	future_simple	We ___ meet at 5 pm.	0		17	2025-12-23 01:55:47.951388+03	1
6156	future_simple	He ___ get a new job.	0		18	2025-12-23 01:55:47.951388+03	1
6157	future_simple	You ___ be happy.	0		19	2025-12-23 01:55:47.951388+03	1
6158	future_simple	I ___ not go to school tomorrow.	0		20	2025-12-23 01:55:47.951388+03	2
6159	future_simple	She ___ not call you today.	0		21	2025-12-23 01:55:47.951388+03	2
6160	future_simple	They ___ not help us.	0		22	2025-12-23 01:55:47.951388+03	2
6161	future_simple	We ___ not travel this year.	0		23	2025-12-23 01:55:47.951388+03	2
6162	future_simple	He ___ not study tonight.	0		24	2025-12-23 01:55:47.951388+03	2
6163	future_simple	You ___ not see her tomorrow.	0		25	2025-12-23 01:55:47.951388+03	2
6164	future_simple	It ___ not rain today.	0		26	2025-12-23 01:55:47.951388+03	2
6165	future_simple	I ___ not work on Sunday.	0		27	2025-12-23 01:55:47.951388+03	2
6166	future_simple	She ___ not come to the party.	0		28	2025-12-23 01:55:47.951388+03	2
6167	future_simple	They ___ not buy a car.	0		29	2025-12-23 01:55:47.951388+03	2
6168	future_simple	We ___ not finish today.	0		30	2025-12-23 01:55:47.951388+03	2
6169	future_simple	He ___ not visit them.	0		31	2025-12-23 01:55:47.951388+03	2
6170	future_simple	You ___ not learn Spanish.	0		32	2025-12-23 01:55:47.951388+03	2
6171	future_simple	It ___ not be cold.	0		33	2025-12-23 01:55:47.951388+03	2
6172	future_simple	I ___ not make dinner.	0		34	2025-12-23 01:55:47.951388+03	2
6173	future_simple	She ___ not write today.	0		35	2025-12-23 01:55:47.951388+03	2
6174	future_simple	They ___ not move next month.	0		36	2025-12-23 01:55:47.951388+03	2
6175	future_simple	We ___ not meet tomorrow.	0		37	2025-12-23 01:55:47.951388+03	2
6176	future_simple	He ___ not get a job.	0		38	2025-12-23 01:55:47.951388+03	2
6177	future_simple	You ___ not be late.	0		39	2025-12-23 01:55:47.951388+03	2
6178	future_simple	I ___ visit my grandparents next week.	0		40	2025-12-23 01:55:47.951388+03	4
6179	future_simple	She ___ not eat meat.	1		41	2025-12-23 01:55:47.951388+03	4
6180	future_simple	They ___ help us tomorrow.	0		42	2025-12-23 01:55:47.951388+03	4
6181	future_simple	We ___ not go to the cinema.	1		43	2025-12-23 01:55:47.951388+03	4
6182	future_simple	He ___ study hard.	0		44	2025-12-23 01:55:47.951388+03	4
6183	future_simple	You ___ not see him today.	1		45	2025-12-23 01:55:47.951388+03	4
6184	future_simple	It ___ be hot tomorrow.	0		46	2025-12-23 01:55:47.951388+03	4
6185	future_simple	I ___ not work tonight.	1		47	2025-12-23 01:55:47.951388+03	4
6186	future_simple	She ___ come to the meeting.	0		48	2025-12-23 01:55:47.951388+03	4
6187	future_simple	They ___ not buy a new phone.	1		49	2025-12-23 01:55:47.951388+03	4
6188	future_simple	We ___ finish the project.	0		50	2025-12-23 01:55:47.951388+03	4
6189	future_simple	He ___ not visit us.	1		51	2025-12-23 01:55:47.951388+03	4
6190	future_simple	You ___ learn quickly.	0		52	2025-12-23 01:55:47.951388+03	4
6191	future_simple	It ___ not rain today.	1		53	2025-12-23 01:55:47.951388+03	4
6192	future_simple	I ___ make a cake.	0		54	2025-12-23 01:55:47.951388+03	4
6193	future_simple	She ___ not write an email.	1		55	2025-12-23 01:55:47.951388+03	4
6194	future_simple	They ___ move next year.	0		56	2025-12-23 01:55:47.951388+03	4
6195	future_simple	We ___ not meet them.	1		57	2025-12-23 01:55:47.951388+03	4
6196	future_simple	He ___ get a promotion.	0		58	2025-12-23 01:55:47.951388+03	4
6197	future_simple	You ___ not be sad.	1		59	2025-12-23 01:55:47.951388+03	4
6198	future_simple	I will see you ___.	0		60	2025-12-23 01:55:47.951388+03	5
6199	future_simple	She will call ___.	0		61	2025-12-23 01:55:47.951388+03	5
6200	future_simple	They will travel ___ summer.	0		62	2025-12-23 01:55:47.951388+03	5
6201	future_simple	We will meet ___ 2 hours.	0		63	2025-12-23 01:55:47.951388+03	5
6202	future_simple	He will finish ___ week.	0		64	2025-12-23 01:55:47.951388+03	5
6203	future_simple	You will see her ___.	0		65	2025-12-23 01:55:47.951388+03	5
6204	future_simple	It will rain ___.	0		66	2025-12-23 01:55:47.951388+03	5
6205	future_simple	I will work ___ Monday.	0		67	2025-12-23 01:55:47.951388+03	5
6206	future_simple	She will come ___ the future.	0		68	2025-12-23 01:55:47.951388+03	5
6207	future_simple	They will buy a car ___ year.	0		69	2025-12-23 01:55:47.951388+03	5
6208	future_simple	We will study ___ month.	0		70	2025-12-23 01:55:47.951388+03	5
6209	future_simple	He will visit ___ 3 days.	0		71	2025-12-23 01:55:47.951388+03	5
6210	future_simple	You will learn ___.	0		72	2025-12-23 01:55:47.951388+03	5
6211	future_simple	It will be sunny ___.	0		73	2025-12-23 01:55:47.951388+03	5
6212	future_simple	I will call you ___.	0		74	2025-12-23 01:55:47.951388+03	5
6213	future_simple	She will write ___ week.	0		75	2025-12-23 01:55:47.951388+03	5
6214	future_simple	They will move ___ 6 months.	0		76	2025-12-23 01:55:47.951388+03	5
6215	future_simple	We will finish ___.	0		77	2025-12-23 01:55:47.951388+03	5
6216	future_simple	He will arrive ___.	0		78	2025-12-23 01:55:47.951388+03	5
6217	future_simple	You will see ___ Friday.	0		79	2025-12-23 01:55:47.951388+03	5
6218	future_simple	Will you help me? — Yes, I ___.	0		80	2025-12-23 01:55:47.951388+03	6
6219	future_simple	Will she come? — No, she ___.	0		81	2025-12-23 01:55:47.951388+03	6
6220	future_simple	Will they travel? — Yes, they ___.	0		82	2025-12-23 01:55:47.951388+03	6
6221	future_simple	Will we finish? — No, we ___.	0		83	2025-12-23 01:55:47.951388+03	6
6222	future_simple	Will he study? — Yes, he ___.	0		84	2025-12-23 01:55:47.951388+03	6
6223	future_simple	Will you go? — No, I ___.	0		85	2025-12-23 01:55:47.951388+03	6
6224	future_simple	Will it rain? — Yes, it ___.	0		86	2025-12-23 01:55:47.951388+03	6
6225	future_simple	Will I work? — No, you ___.	0		87	2025-12-23 01:55:47.951388+03	6
6226	future_simple	Will she call? — Yes, she ___.	0		88	2025-12-23 01:55:47.951388+03	6
6227	future_simple	Will they buy? — No, they ___.	0		89	2025-12-23 01:55:47.951388+03	6
6228	future_simple	Will we meet? — Yes, we ___.	0		90	2025-12-23 01:55:47.951388+03	6
6229	future_simple	Will he visit? — No, he ___.	0		91	2025-12-23 01:55:47.951388+03	6
6230	future_simple	Will you learn? — Yes, I ___.	0		92	2025-12-23 01:55:47.951388+03	6
6231	future_simple	Will it be cold? — No, it ___.	0		93	2025-12-23 01:55:47.951388+03	6
6232	future_simple	Will I make dinner? — Yes, you ___.	0		94	2025-12-23 01:55:47.951388+03	6
6233	future_simple	Will she write? — No, she ___.	0		95	2025-12-23 01:55:47.951388+03	6
6234	future_simple	Will they move? — Yes, they ___.	0		96	2025-12-23 01:55:47.951388+03	6
6235	future_simple	Will we meet? — No, we ___.	0		97	2025-12-23 01:55:47.951388+03	6
6236	future_simple	Will he get the job? — Yes, he ___.	0		98	2025-12-23 01:55:47.951388+03	6
6237	future_simple	Will you be there? — No, I ___.	0		99	2025-12-23 01:55:47.951388+03	6
6238	future_simple	I will ___ to the park.	0		100	2025-12-23 01:55:47.951388+03	7
6239	future_simple	She will ___ you tomorrow.	0		101	2025-12-23 01:55:47.951388+03	7
6240	future_simple	They will ___ us.	0		102	2025-12-23 01:55:47.951388+03	7
6241	future_simple	We will ___ next year.	0		103	2025-12-23 01:55:47.951388+03	7
6242	future_simple	He will ___ English.	0		104	2025-12-23 01:55:47.951388+03	7
6243	future_simple	You will ___ her soon.	0		105	2025-12-23 01:55:47.951388+03	7
6244	future_simple	It will ___ tomorrow.	0		106	2025-12-23 01:55:47.951388+03	7
6245	future_simple	I will ___ hard.	0		107	2025-12-23 01:55:47.951388+03	7
6246	future_simple	She will ___ to the party.	0		108	2025-12-23 01:55:47.951388+03	7
6247	future_simple	They will ___ a car.	0		109	2025-12-23 01:55:47.951388+03	7
6248	future_simple	We will ___ the project.	0		110	2025-12-23 01:55:47.951388+03	7
6249	future_simple	He will ___ his parents.	0		111	2025-12-23 01:55:47.951388+03	7
6250	future_simple	You will ___ a lot.	0		112	2025-12-23 01:55:47.951388+03	7
6251	future_simple	It will ___ sunny.	0		113	2025-12-23 01:55:47.951388+03	7
6252	future_simple	I will ___ dinner.	0		114	2025-12-23 01:55:47.951388+03	7
6253	future_simple	She will ___ a book.	0		115	2025-12-23 01:55:47.951388+03	7
6254	future_simple	They will ___ to London.	0		116	2025-12-23 01:55:47.951388+03	7
6255	future_simple	We will ___ at 5 pm.	0		117	2025-12-23 01:55:47.951388+03	7
6256	future_simple	He will ___ a job.	0		118	2025-12-23 01:55:47.951388+03	7
6257	future_simple	You will ___ happy.	0		119	2025-12-23 01:55:47.951388+03	7
6258	future_simple	I will to go to school. — Правильно:	0		120	2025-12-23 01:55:47.951388+03	8
6259	future_simple	She will calls you. — Правильно:	0		121	2025-12-23 01:55:47.951388+03	8
6260	future_simple	They will helps us. — Правильно:	0		122	2025-12-23 01:55:47.951388+03	8
6261	future_simple	He won't goes there. — Правильно:	0		123	2025-12-23 01:55:47.951388+03	8
6262	future_simple	Will she comes? — Правильно:	0		124	2025-12-23 01:55:47.951388+03	8
6263	future_simple	I will not to work. — Правильно:	0		125	2025-12-23 01:55:47.951388+03	8
6264	future_simple	They will traveling. — Правильно:	0		126	2025-12-23 01:55:47.951388+03	8
6265	future_simple	Will he goes? — Правильно:	0		127	2025-12-23 01:55:47.951388+03	8
6266	future_simple	She won't coming. — Правильно:	0		128	2025-12-23 01:55:47.951388+03	8
6267	future_simple	We will meets you. — Правильно:	0		129	2025-12-23 01:55:47.951388+03	8
6268	future_simple	I will studying. — Правильно:	0		130	2025-12-23 01:55:47.951388+03	8
6269	future_simple	He will to visit. — Правильно:	0		131	2025-12-23 01:55:47.951388+03	8
6270	future_simple	You will be goes. — Правильно:	0		132	2025-12-23 01:55:47.951388+03	8
6271	future_simple	It will rains. — Правильно:	0		133	2025-12-23 01:55:47.951388+03	8
6272	future_simple	Will they helps? — Правильно:	0		134	2025-12-23 01:55:47.951388+03	8
6273	future_simple	She will not comes. — Правильно:	0		135	2025-12-23 01:55:47.951388+03	8
6274	future_simple	I will seeing you. — Правильно:	0		136	2025-12-23 01:55:47.951388+03	8
6275	future_simple	They won't to help. — Правильно:	0		137	2025-12-23 01:55:47.951388+03	8
6276	future_simple	Will you going? — Правильно:	0		138	2025-12-23 01:55:47.951388+03	8
6277	future_simple	He will be coming. — Правильно (для Future Simple):	0		139	2025-12-23 01:55:47.951388+03	8
6278	future_simple	Tomorrow I ___ to the beach.	0		140	2025-12-23 01:55:47.951388+03	9
6279	future_simple	She ___ call you later.	0		141	2025-12-23 01:55:47.951388+03	9
6280	future_simple	We ___ travel next summer.	0		142	2025-12-23 01:55:47.951388+03	9
6281	future_simple	He ___ study tonight.	0		143	2025-12-23 01:55:47.951388+03	9
6282	future_simple	It ___ rain tomorrow.	0		144	2025-12-23 01:55:47.951388+03	9
6283	future_simple	I ___ work on Sunday.	0		145	2025-12-23 01:55:47.951388+03	9
6284	future_simple	They ___ buy a house next year.	0		146	2025-12-23 01:55:47.951388+03	9
6285	future_simple	We ___ meet tomorrow.	0		147	2025-12-23 01:55:47.951388+03	9
6286	future_simple	You ___ learn a lot.	0		148	2025-12-23 01:55:47.951388+03	9
6287	future_simple	It ___ be cold.	0		149	2025-12-23 01:55:47.951388+03	9
6288	future_simple	She ___ write a letter.	0		150	2025-12-23 01:55:47.951388+03	9
6289	future_simple	They ___ move to London.	0		151	2025-12-23 01:55:47.951388+03	9
6290	future_simple	He ___ get the job.	0		152	2025-12-23 01:55:47.951388+03	9
6291	future_simple	You ___ be late.	0		153	2025-12-23 01:55:47.951388+03	9
6292	future_simple	I ___ ___ to the cinema tomorrow.	0		154	2025-12-23 01:55:47.951388+03	10
6293	future_simple	She ___ not ___ you today.	0		155	2025-12-23 01:55:47.951388+03	10
6294	future_simple	___ they ___ us with the project?	0		156	2025-12-23 01:55:47.951388+03	10
6295	future_simple	We ___ ___ next month.	0		157	2025-12-23 01:55:47.951388+03	10
6296	future_simple	He ___ ___ English next year.	0		158	2025-12-23 01:55:47.951388+03	10
6297	future_simple	___ you ___ her soon?	0		159	2025-12-23 01:55:47.951388+03	10
6298	future_simple	It ___ ___ tomorrow.	0		160	2025-12-23 01:55:47.951388+03	10
6299	future_simple	I ___ ___ hard tonight.	0		161	2025-12-23 01:55:47.951388+03	10
6300	future_simple	___ she ___ to the party?	0		162	2025-12-23 01:55:47.951388+03	10
6301	future_simple	They ___ ___ a new car.	0		163	2025-12-23 01:55:47.951388+03	10
6302	future_simple	We ___ ___ the project on time.	0		164	2025-12-23 01:55:47.951388+03	10
6303	future_simple	___ he ___ his parents next week?	0		165	2025-12-23 01:55:47.951388+03	10
6304	future_simple	You ___ ___ a lot from this.	0		166	2025-12-23 01:55:47.951388+03	10
6305	future_simple	It ___ ___ sunny tomorrow.	0		167	2025-12-23 01:55:47.951388+03	10
6306	future_simple	___ I ___ lunch?	0		168	2025-12-23 01:55:47.951388+03	10
6307	future_simple	She ___ ___ a book next year.	0		169	2025-12-23 01:55:47.951388+03	10
6308	future_simple	They ___ ___ to a new house.	0		170	2025-12-23 01:55:47.951388+03	10
6309	future_simple	___ we ___ at 6 pm?	0		171	2025-12-23 01:55:47.951388+03	10
6310	future_simple	He ___ ___ a new job.	0		172	2025-12-23 01:55:47.951388+03	10
6311	future_simple	You ___ ___ happy about this.	0		173	2025-12-23 01:55:47.951388+03	10
\.


--
-- Data for Name: rule_examples; Type: TABLE DATA; Schema: public; Owner: doc
--

COPY public.rule_examples (id, rule_section_id, example_text, display_order) FROM stdin;
1	2	кто → что делает → всё остальное	0
2	2	I work here.	1
3	2	She likes coffee.	2
4	2	They live in London.	3
5	3	I am a student. (не просто 'student')	0
6	3	I am at home. (не просто 'at home')	1
7	3	It is cold. (не просто 'cold')	2
8	5	I work.	0
9	5	She is tired.	1
10	5	It is cold.	2
11	6	I am	0
12	6	You are	1
13	6	He / She / It is	2
14	6	We / They are	3
15	7	I am a student. (не просто 'student')	0
16	7	She is a doctor. (не просто 'doctor')	1
17	7	I work here. (не просто 'work')	2
18	8	I am learning English.	0
19	9	I do not work.	0
20	9	She is not ready.	1
412	135	I — я	0
413	135	You — ты / вы	1
414	135	He — он	2
415	135	She — она	3
416	135	It — оно	4
417	135	We — мы	5
418	135	They — они	6
419	135	❌ Go to work.	7
420	135	✔ I go to work.	8
421	135	❌ Is student.	9
422	135	✔ She is a student.	10
423	137	me — меня / мне	0
424	137	you — тебя / тебе	1
425	137	him — его / ему	2
426	137	her — её / ей	3
427	137	it — его / её (не человек)	4
428	137	us — нас / нам	5
429	137	them — их / им	6
430	137	She sees me.	7
431	137	I like him.	8
432	137	They help us.	9
433	137	❌ She sees I.	10
434	137	✔ She sees me.	11
435	138	my — мой	0
436	138	your — твой / ваш	1
305	115	✅ a big house	0
306	115	✅ an interesting idea	1
307	115	✅ my old friend	2
308	115	✅ The house is big	3
309	115	✅ She is smart	4
310	115	❌ She is a beautiful — ошибка	5
311	115	✅ She is beautiful — правильно	6
312	116	big → bigger → the biggest	0
313	116	fast → faster → the fastest	1
314	116	interesting → more interesting → the most interesting	2
315	116	good → better → the best	3
316	116	bad → worse → the worst	4
317	116	the best day	5
318	116	the worst idea	6
319	117	very interesting	0
320	117	really boring	1
321	117	quite nice	2
322	118	❌ a house big	0
323	118	✅ a big house	1
324	118	❌ beautifuls houses	2
325	118	✅ beautiful houses	3
326	118	❌ she is a beautiful	4
327	118	✅ she is beautiful	5
328	118	❌ more better	6
329	118	✅ better	7
437	138	his — его	2
438	138	her — её	3
439	138	its — его / её (для предметов и животных)	4
440	138	our — наш	5
441	138	their — их	6
442	138	✔ my phone	7
443	138	✔ her bag	8
444	138	✔ their house	9
445	138	❌ mine phone	10
446	138	❌ her is bag	11
447	139	mine — мой	0
448	139	yours — твой	1
449	139	his — его	2
450	139	hers — её	3
451	139	its — его / её	4
452	139	ours — наш	5
453	139	theirs — их	6
454	139	✔ This phone is mine.	7
455	139	✔ The bag is hers.	8
456	139	❌ mine phone	9
457	139	❌ hers bag	10
458	140	this — это (близко, одно)	0
459	140	that — то (далеко, одно)	1
460	140	these — эти (близко, много)	2
461	140	those — те (далеко, много)	3
462	140	This book is interesting.	4
463	140	That car is expensive.	5
222	97	❌ I student	0
223	97	❌ She teacher	1
224	97	❌ Information are important	2
225	97	✔ I am a student	3
226	97	✔ She is a teacher	4
227	97	✔ Information is important	5
464	140	These shoes are new.	6
465	140	Those houses are old.	7
466	141	❌ She loves I	0
467	141	✔ She loves me	1
468	141	❌ This are my friends	2
469	141	✔ These are my friends	3
470	141	❌ This is mine bag	4
471	141	✔ This is my bag	5
472	142	1️⃣ В английском всегда есть подлежащее	0
473	142	2️⃣ I ≠ me	1
474	142	3️⃣ my ≠ mine	2
475	142	4️⃣ this / that зависит от расстояния и количества	3
476	144	I am — я есть	0
477	144	You are — ты / вы есть	1
478	144	He is — он есть	2
479	144	She is — она есть	3
480	144	It is — это есть	4
481	144	We are — мы есть	5
482	144	They are — они есть	6
483	144	I am a student.	7
484	144	She is at home.	8
485	144	They are happy.	9
486	144	👉 Без am / is / are эти предложения просто сломаются.	10
487	144	❌ I a student	11
488	144	❌ She at home	12
489	145	Полная форма: I am → Краткая: I'm	0
490	145	Полная форма: You are → Краткая: You're	1
491	145	Полная форма: He is → Краткая: He's	2
330	120	a book, a car, a friend	0
331	120	an apple, an idea, an hour	1
332	120	I saw a dog in the park. (любой пес, не конкретный)	2
333	120	She wants an apple. (любое яблоко, не определённое)	3
334	121	I saw the dog again. (мы уже говорили про этого пса)	0
335	121	The sun rises in the east. (единственный в своём роде)	1
336	122	I like coffee. (вообще кофе как напиток, не конкретное)	0
337	122	Children like to play. (дети вообще, не конкретные)	1
338	122	I go to school. (про заведение как категорию, не конкретную школу)	2
339	123	❌ I saw dog. → нет артикля	0
340	123	❌ I want apple. → нет a/an	1
341	123	❌ The coffee is good. (когда говорим про кофе вообще — нужен нулевой артикль)	2
342	123	✔ I saw a dog.	3
343	123	✔ I want an apple.	4
344	123	✔ I like coffee.	5
345	124	A / An = один, любой, впервые упоминаем	0
346	124	The = конкретный, известный, уникальный	1
347	124	Нулевой артикль = вообще, категория, абстракция	2
492	145	Полная форма: She is → Краткая: She's	3
493	145	Полная форма: It is → Краткая: It's	4
494	145	Полная форма: We are → Краткая: We're	5
495	145	Полная форма: They are → Краткая: They're	6
496	145	I'm tired.	7
497	145	She's a doctor.	8
498	145	We're ready.	9
499	145	👉 В речи и обычном тексте краткие формы — норма.	10
500	146	I am not (I'm not)	0
501	146	You are not (you aren't)	1
502	146	He is not (he isn't)	2
503	146	She is not (she isn't)	3
504	146	It is not (it isn't)	4
505	146	We are not (we aren't)	5
506	146	They are not (they aren't)	6
507	146	I'm not hungry.	7
508	146	She isn't at work.	8
509	146	They aren't students.	9
510	147	You are ready. → Are you ready?	0
511	147	She is here. → Is she here?	1
512	147	They are friends. → Are they friends?	2
513	147	Am I late?	3
514	147	Is he your brother?	4
515	147	Are we okay?	5
516	148	Are you tired? — Yes, I am. / No, I'm not.	0
517	148	Is she at home? — Yes, she is. / No, she isn't.	1
518	149	I am a student. (кто?)	0
519	149	She is in London. (где?)	1
520	149	They are happy. (какие?)	2
521	150	❌ I student.	0
522	150	✔ I am a student.	1
523	150	❌ She happy.	2
524	150	✔ She is happy.	3
525	150	❌ They at home.	4
526	150	✔ They are at home.	5
527	151	1️⃣ В английском всегда нужен глагол	0
528	151	2️⃣ To be — самый базовый глагол	1
529	151	3️⃣ В настоящем времени: am / is / are	2
530	151	4️⃣ Без него предложения не работают	3
531	153	I play football. (Я играю в футбол — обычно, каждый день)	0
532	153	She plays tennis. (Она играет в теннис — не прямо сейчас, а регулярно)	1
533	153	They live in London.	2
534	153	💡 Совет: Не забудь добавить -s / -es к глаголу, если подлежащее he / she / it.	3
535	153	He works, She watches, It rains	4
536	154	I don't like coffee.	0
537	154	She doesn't watch TV.	1
538	154	They don't play basketball.	2
539	154	💡 Совет: Не ставим -s на глагол после doesn't!	3
540	154	❌ She doesn't likes → правильно: She doesn't like	4
541	155	Do you play football?	0
542	155	Does she like pizza?	1
543	155	Do they live here?	2
544	155	💡 Совет: В вопросах и отрицаниях глагол не получает -s, если используется does.	3
545	156	Перед глаголом (кроме to be):	0
546	156	I usually go to school by bus.	1
547	156	She always drinks coffee in the morning.	2
548	156	После to be:	3
549	156	He is always happy.	4
550	157	❌ She play tennis. → забыли -s	0
551	157	❌ He doesn't likes pizza. → лишнее -s	1
552	157	❌ Do he work here? → должно быть Does he work here?	2
553	157	✔ She plays tennis.	3
554	157	✔ He doesn't like pizza.	4
555	157	✔ Does he work here?	5
556	158	Для I/You/We/They — глагол без -s	0
557	158	Для He/She/It — глагол + -s / -es	1
558	158	Отрицания и вопросы строятся через do / does	2
559	158	Наречия частоты показывают, как часто что-то происходит	3
2300	283	Future Simple — это будущее время, которое используется для:	0
2301	283	Предсказаний о будущем	1
2302	283	Обещаний	2
2303	283	Спонтанных решений (принятых в момент речи)	3
2304	283	Предложений помощи	4
2305	283	Формула: will + базовая форма глагола (без to)	5
2306	283	Примеры:	6
2307	283	I will go to the park tomorrow. (Я пойду в парк завтра)	7
2308	283	She will call you later. (Она позвонит тебе позже)	8
2309	283	They will help us. (Они помогут нам)	9
2310	283	💡 Совет:	10
2311	283	Will используется со ВСЕМИ местоимениями: I, you, he, she, it, we, they — всегда will.	11
2312	283	Никаких изменений глагола!	12
2313	285	Подлежащее + will + глагол (базовая форма)	0
2314	285	Примеры:	1
2315	285	I will work tomorrow. (Я буду работать завтра)	2
2316	285	You will see her soon. (Ты увидишь её скоро)	3
2317	285	He will come to the party. (Он придёт на вечеринку)	4
2318	285	She will study English. (Она будет учить английский)	5
2319	285	It will rain tomorrow. (Завтра будет дождь)	6
2320	285	We will travel next year. (Мы поедем в путешествие в следующем году)	7
2321	285	They will buy a car. (Они купят машину)	8
2322	285	💡 Совет:	9
2323	285	Сокращённая форма: I'll, you'll, he'll, she'll, we'll, they'll	10
2324	285	I will = I'll	11
2325	285	She will = She'll	12
2326	287	Подлежащее + will not (won't) + глагол	0
2327	287	Примеры:	1
2328	287	I will not go to school tomorrow. (Я не пойду в школу завтра)	2
2329	287	I won't go to school tomorrow. (сокращённая форма)	3
2330	287	She will not call you. (Она не позвонит тебе)	4
2331	287	They won't help us. (Они не помогут нам)	5
2332	287	He won't come to the party. (Он не придёт на вечеринку)	6
2333	287	It won't rain today. (Сегодня не будет дождя)	7
2334	287	💡 Совет:	8
2335	287	won't = will not (это сокращение очень популярно!)	9
2336	287	После won't глагол всегда в базовой форме (без to, без -s, без -ed)	10
2337	289	Will + подлежащее + глагол?	0
2338	289	Примеры:	1
2339	289	Will you help me? (Ты поможешь мне?)	2
2340	289	Will she come tomorrow? (Она придёт завтра?)	3
2341	289	Will they buy a house? (Они купят дом?)	4
2342	289	Will it rain? (Будет дождь?)	5
2343	289	Will we see you later? (Мы увидим тебя позже?)	6
2344	289	💡 Совет:	7
2345	289	В вопросах порядок слов: Will + подлежащее + глагол	8
2346	289	Глагол всегда в базовой форме!	9
2347	291	It will rain tomorrow. (Завтра будет дождь)	0
2348	291	She will be a doctor. (Она станет доктором)	1
2349	291	Обещания:	2
2350	291	I will call you. (Я позвоню тебе)	3
2351	291	We will help you. (Мы поможем тебе)	4
2352	292	I'm hungry. I'll make a sandwich. (Я голоден. Я сделаю бутерброд)	0
2353	292	The phone is ringing. I'll answer it. (Телефон звонит. Я отвечу)	1
2354	292	Предложения помощи:	2
2355	292	I'll help you with your homework. (Я помогу тебе с домашней работой)	3
2356	292	Shall I open the window? (Мне открыть окно?)	4
2357	292	💡 Совет:	5
2358	292	Если решение запланировано заранее, используем be going to, а не will!	6
2359	292	Но если решение принято прямо сейчас — will.	7
2360	293	С Future Simple часто используются эти слова:	0
2361	293	tomorrow (завтра)	1
2362	293	next week / next month / next year (на следующей неделе / в следующем месяце / в следующем году)	2
2363	293	in the future (в будущем)	3
2364	293	soon (скоро)	4
2365	293	later (позже)	5
2366	293	tonight (сегодня вечером)	6
2367	293	in 2 days / in 5 years (через 2 дня / через 5 лет)	7
2368	293	Примеры:	8
2369	293	I will see you tomorrow. (Я увижу тебя завтра)	9
2370	293	She will call you later. (Она позвонит тебе позже)	10
2371	293	We will travel next summer. (Мы поедем в путешествие следующим летом)	11
2372	293	They will finish in 3 hours. (Они закончат через 3 часа)	12
2373	293	💡 Совет:	13
2374	293	Наречия времени обычно ставятся в конец предложения.	14
2375	294	❌ I will to go to the park. → лишнее "to"	0
2376	294	✔ I will go to the park.	1
2377	294	❌ She will goes to school. → лишнее -s	2
2378	294	✔ She will go to school.	3
2379	294	❌ Will he goes there? → лишнее -s	4
2380	294	✔ Will he go there?	5
2381	294	❌ I will not to help. → лишнее "to"	6
2382	294	✔ I will not help.	7
2383	294	❌ He won't goes. → лишнее -s	8
2384	294	✔ He won't go.	9
2385	294	❌ Tomorrow I go to the park. → нет will для будущего	10
2386	294	✔ Tomorrow I will go to the park.	11
2387	294	💡 Совет:	12
2388	294	После will всегда идёт глагол в базовой форме — без to, без окончаний!	13
2389	295	Will — спонтанное решение, обещание, предсказание:	0
2390	295	I'll help you. (Я помогу тебе — решение принято сейчас)	1
2391	295	It will rain. (Будет дождь — предсказание)	2
2392	295	Be going to — запланированное действие, намерение:	3
2393	295	I'm going to visit my friend tomorrow. (Я собираюсь навестить друга завтра — уже запланировано)	4
2394	295	It's going to rain. (Будет дождь — видим облака, есть признаки)	5
2395	295	💡 Совет:	6
2396	295	Will — когда решение ТОЛЬКО что принято.	7
2397	295	Be going to — когда решение уже было принято раньше.	8
2398	296	1️⃣ Формула: will + базовая форма глагола	0
2399	296	2️⃣ Работает со всеми местоимениями одинаково	1
2400	296	3️⃣ Отрицание: will not (won't)	2
2401	296	4️⃣ Вопрос: Will + подлежащее + глагол?	3
2402	296	5️⃣ Используем для: предсказаний, обещаний, спонтанных решений	4
2403	297	7️⃣ После will НИКОГДА не ставим to!	0
1447	232	Модальные глаголы — это помощники, которые работают с другими глаголами.	0
1448	232	Они показывают:	1
1449	232	- способность (can — могу)	2
1450	232	- необходимость (must — должен)	3
1451	232	- совет (should — следует)	4
1452	232	- запрет (mustn't — нельзя)	5
1453	232	Три правила работы с модальными глаголами:	6
1454	232	1️⃣ После модального глагола идёт обычный глагол БЕЗ частицы to	7
1455	232	2️⃣ Модальные глаголы НЕ меняются по лицам (нет -s для he/she/it)	8
1456	232	3️⃣ Отрицания и вопросы строятся БЕЗ do/does	9
1457	233	Can — это про способность, умение, возможность.	0
1458	233	Переводится как «могу», «умею», «можешь».	1
1459	233	Утверждения:	2
1460	233	I can swim. — Я умею плавать.	3
1461	233	She can speak English. — Она может говорить по-английски.	4
1462	233	They can help you. — Они могут тебе помочь.	5
1463	233	Отрицания (can't / cannot):	6
1464	233	I can't drive. — Я не умею водить.	7
1465	233	He can't come today. — Он не может прийти сегодня.	8
1466	233	We can't understand. — Мы не можем понять.	9
1467	233	Вопросы:	10
1468	233	Can you swim? — Ты умеешь плавать?	11
1469	233	Can she help me? — Она может мне помочь?	12
1470	233	Can they come? — Они могут прийти?	13
1471	233	💡 Совет:	14
1472	233	Can't = cannot (сокращённая форма)	15
1473	233	В разговорной речи почти всегда используют can't.	16
1474	233	Примеры использования:	17
1475	233	I can play guitar. (умение)	18
1476	233	Can I use your phone? (разрешение)	19
1477	233	We can go tomorrow. (возможность)	20
1478	234	Must — это про необходимость, обязанность.	0
1479	234	Переводится как «должен», «нужно», «обязан».	1
1480	234	Утверждения:	2
1481	234	I must go. — Я должен идти.	3
1482	234	You must study. — Ты должен учиться.	4
1483	234	He must work. — Он должен работать.	5
1484	234	Отрицания (mustn't):	6
1485	235	You mustn't smoke here. — Тебе нельзя здесь курить.	0
1486	235	He mustn't be late. — Ему нельзя опаздывать.	1
1487	235	They mustn't leave. — Им нельзя уходить.	2
1488	235	💡 Совет:	3
1489	235	Mustn't ≠ «не должен»	4
1490	235	Mustn't = «нельзя», «запрещено»	5
1491	235	Если хочешь сказать «не обязан», используй don't have to:	6
1492	235	You don't have to come. — Тебе не обязательно приходить.	7
1493	235	Вопросы:	8
1494	235	Must I go? — Я должен идти?	9
1495	235	Must we wait? — Мы должны ждать?	10
1496	235	Must she stay? — Она должна остаться?	11
1497	236	Should — это про совет, рекомендацию.	0
1498	236	Переводится как «следует», «стоит», «должен бы».	1
1499	236	Утверждения:	2
1500	236	You should rest. — Тебе следует отдохнуть.	3
1501	236	He should study more. — Ему следует больше учиться.	4
1502	236	We should help them. — Нам следует им помочь.	5
1503	236	Отрицания (shouldn't):	6
1504	236	You shouldn't eat this. — Тебе не следует это есть.	7
1505	236	He shouldn't drive fast. — Ему не следует ездить быстро.	8
1506	236	They shouldn't worry. — Им не следует волноваться.	9
1507	236	Вопросы:	10
1508	236	Should I call her? — Мне следует ей позвонить?	11
1509	236	Should we go? — Нам следует идти?	12
1510	236	Should they wait? — Им следует подождать?	13
1511	236	💡 Совет:	14
1512	236	Should — это мягкий совет, не приказ.	15
1513	236	Must — строгая обязанность.	16
1514	236	Should — дружеская рекомендация.	17
1515	237	Can — могу (способность, возможность):	0
1516	237	I can swim. — Я умею плавать.	1
1517	237	Must — должен (строгая необходимость):	2
1518	237	I must study. — Я должен учиться.	3
1519	237	Should — следует (совет):	4
1520	237	I should rest. — Мне следует отдохнуть.	5
1521	237	Примеры в контексте:	6
1522	237	Can you help me? — Ты можешь мне помочь? (способность)	7
1523	237	You must help me! — Ты должен мне помочь! (обязанность)	8
1524	237	You should help me. — Тебе следует мне помочь. (совет)	9
1525	238	❌ He cans swim. → лишнее -s	0
1526	238	✔ He can swim.	1
1527	238	❌ I must to go. → лишнее to	2
1528	238	✔ I must go.	3
1529	238	❌ Do you can help? → неправильный порядок	4
1530	238	✔ Can you help?	5
1531	238	❌ He don't must come. → неправильное отрицание	6
1532	238	✔ He mustn't come.	7
1533	238	❌ She shoulds study. → лишнее -s	8
1534	238	✔ She should study.	9
1535	239	1️⃣ Can — способность и возможность	0
1536	239	2️⃣ Must — строгая необходимость и запрет (mustn't)	1
1537	239	3️⃣ Should — совет и рекомендация	2
1538	239	4️⃣ После модальных глаголов — обычный глагол БЕЗ to	3
1539	239	5️⃣ Модальные глаголы НЕ изменяются по лицам	4
1540	241	Не переводи «there» как «там»!	0
1541	241	There is a book on the table. — На столе есть книга (не «там книга»).	1
1542	241	Два правила:	2
1543	241	1️⃣ There is — для единственного числа	3
1544	241	2️⃣ There are — для множественного числа	4
1545	242	There is — используем, когда говорим об ОДНОМ предмете.	0
1546	242	Утверждения:	1
1547	242	There is a cat in the garden. — В саду (есть) кошка.	2
1548	242	There is a book on the desk. — На столе (есть) книга.	3
1549	242	There is a problem. — Есть проблема.	4
1550	242	There is milk in the fridge. — В холодильнике есть молоко.	5
1551	242	💡 Совет:	6
1552	242	Можно сокращать: there's	7
1553	242	There's a cat. = There is a cat.	8
1554	242	Примеры:	9
1555	242	There is a pen on the table.	10
1556	242	There is a car outside.	11
1557	242	There is a doctor here.	12
1558	243	There are — используем, когда говорим о НЕСКОЛЬКИХ предметах.	0
1559	243	Утверждения:	1
1560	243	There are two cats in the garden. — В саду (есть) две кошки.	2
1561	243	There are books on the desk. — На столе (есть) книги.	3
1562	243	There are some problems. — Есть несколько проблем.	4
1563	243	There are apples in the basket. — В корзине есть яблоки.	5
1564	243	Примеры:	6
1565	243	There are three pens on the table.	7
1566	243	There are cars outside.	8
1567	243	There are many people here.	9
1568	243	💡 Совет:	10
1569	243	There are нельзя сокращать до there're в письменной речи (хотя в речи так иногда говорят).	11
1570	243	Отрицания	12
1571	243	Отрицание строится очень просто: добавляем not или no.	13
1572	243	There is not (isn't):	14
1573	243	There isn't a cat. — Нет кошки.	15
1574	243	There isn't any milk. — Нет молока.	16
1575	243	There isn't a problem. — Нет проблемы.	17
1576	243	There are not (aren't):	18
1577	243	There aren't cats. — Нет кошек.	19
1578	243	There aren't any apples. — Нет яблок.	20
1579	243	There aren't people here. — Здесь нет людей.	21
1580	243	Можно использовать no:	22
1581	243	There is no milk. = There isn't any milk.	23
1582	243	There are no apples. = There aren't any apples.	24
1583	243	💡 Совет:	25
1584	243	No + существительное БЕЗ артикля	26
1585	243	There is no book. (не "no a book")	27
1586	243	Вопросы	28
1587	243	Вопросы строятся очень просто: меняем порядок слов.	29
1588	243	Is there...?	30
1589	243	Is there a cat? — Есть кошка?	31
1590	243	Is there milk? — Есть молоко?	32
1591	243	Is there a problem? — Есть проблема?	33
1592	243	Are there...?	34
1593	243	Are there cats? — Есть кошки?	35
1594	243	Are there apples? — Есть яблоки?	36
1595	243	Are there people? — Есть люди?	37
1596	243	Короткие ответы:	38
1597	243	Is there a book? — Yes, there is. / No, there isn't.	39
1598	243	Are there books? — Yes, there are. / No, there aren't.	40
1599	243	Примеры в контексте:	41
1600	243	Is there a bank near here? — Здесь поблизости есть банк?	42
1601	243	Are there any questions? — Есть вопросы?	43
1602	243	There с предлогами места	44
1603	243	There is / there are часто используются с предлогами места:	45
1604	243	in (в):	46
1605	243	There is a book in the bag.	47
1606	243	on (на):	48
1607	243	There are plates on the table.	49
1608	243	under (под):	50
1609	243	There is a cat under the bed.	51
1610	243	next to (рядом):	52
1611	243	There is a shop next to my house.	53
1612	243	between (между):	54
1613	243	There is a park between two buildings.	55
1614	243	Примеры:	56
1615	243	There is a pen in my pocket.	57
1616	243	There are flowers on the balcony.	58
1617	243	There is a dog under the tree.	59
1618	243	There are people in the room.	60
1619	243	Разница: There is/are vs It is/They are	61
1620	243	Важное различие!	62
1621	243	There is/are — когда вводим новую информацию (что-то существует):	63
1622	243	There is a cat in the garden. — В саду есть кошка.	64
1623	243	It is/They are — когда говорим о чём-то известном:	65
1624	243	It is black. — Она чёрная (та самая кошка).	66
1625	243	Примеры:	67
1626	243	There is a book. It is interesting. — Есть книга. Она интересная.	68
1627	243	There are people. They are students. — Есть люди. Они студенты.	69
1628	244	❌ There are a book. → неправильное число	0
1629	244	✔ There is a book.	1
1630	244	❌ There is books. → неправильное число	2
1631	244	✔ There are books.	3
1632	244	❌ Is there cats? → неправильное число	4
1633	244	✔ Are there cats?	5
1634	244	❌ There not is a cat. → неправильный порядок	6
1635	244	✔ There isn't a cat.	7
1636	244	❌ There is no a book. → лишний артикль	8
1637	244	✔ There is no book.	9
1638	244	❌ It is a cat in the garden. → используем It вместо There	10
1639	244	✔ There is a cat in the garden.	11
1640	245	1️⃣ There is — для единственного числа	0
1641	245	2️⃣ There are — для множественного числа	1
1642	245	3️⃣ Используем, чтобы сказать, что что-то существует или находится	2
1643	245	4️⃣ Отрицание: isn't / aren't или no	3
1644	245	5️⃣ Вопросы: Is there...? / Are there...?	4
1645	246	Предлоги места отвечают на вопрос: ГДЕ?	0
1646	246	Where is the book? — It's ON the table.	1
1647	246	Основные предлоги:	2
1648	246	- in (в)	3
1649	246	- on (на)	4
1650	246	- under (под)	5
1651	246	- next to (рядом с)	6
1652	246	- between (между)	7
1653	246	Запомни: предлог идёт ПЕРЕД существительным.	8
1654	246	in (в, внутри)	9
1655	246	in — используем, когда что-то ВНУТРИ чего-то.	10
1656	246	The book is in the bag. — Книга в сумке.	11
1657	246	The cat is in the box. — Кошка в коробке.	12
1658	246	I live in Moscow. — Я живу в Москве.	13
1659	246	The keys are in my pocket. — Ключи в моём кармане.	14
1660	246	💡 Совет:	15
1661	246	in = внутри, в пространстве	16
1662	246	Примеры:	17
1663	246	The milk is in the fridge.	18
1664	246	She is in the room.	19
1665	246	There are people in the building.	20
1666	246	The pen is in the drawer.	21
1667	246	on (на, на поверхности)	22
1668	246	on — используем, когда что-то НА ПОВЕРХНОСТИ.	23
1669	246	The book is on the table. — Книга на столе.	24
1670	246	The picture is on the wall. — Картина на стене.	25
1671	246	The cat is on the roof. — Кошка на крыше.	26
1672	246	Your phone is on the sofa. — Твой телефон на диване.	27
1673	246	💡 Совет:	28
1674	246	on = на поверхности, сверху	29
1675	246	Примеры:	30
1676	246	The cup is on the desk.	31
1677	246	There are plates on the table.	32
1678	246	The bag is on the chair.	33
1679	246	The hat is on your head.	34
1680	246	under (под)	35
1681	246	under — используем, когда что-то ПОД чем-то.	36
1682	246	The cat is under the table. — Кошка под столом.	37
1683	246	The ball is under the bed. — Мяч под кроватью.	38
1684	246	The shoes are under the chair. — Туфли под стулом.	39
1685	246	The dog is under the tree. — Собака под деревом.	40
1686	246	💡 Совет:	41
1687	246	under = ниже чего-то, внизу	42
1688	246	Примеры:	43
1689	246	The pen is under the book.	44
1690	246	There's a box under the desk.	45
1691	246	The keys are under the newspaper.	46
1692	246	The cat sleeps under the blanket.	47
1693	246	next to (рядом с, около)	48
1694	246	next to — используем, когда что-то РЯДОМ, ОКОЛО.	49
1695	246	The bank is next to the shop. — Банк рядом с магазином.	50
1696	246	The chair is next to the table. — Стул рядом со столом.	51
1697	246	She sits next to me. — Она сидит рядом со мной.	52
1698	246	The cat is next to the dog. — Кошка рядом с собакой.	53
1699	246	💡 Совет:	54
1700	246	next to = близко, рядом	55
1701	246	Можно также сказать: near, beside	56
1702	246	Примеры:	57
1703	246	The cafe is next to my house.	58
1704	246	The lamp is next to the bed.	59
1705	246	He stands next to his friend.	60
1706	246	The park is next to the school.	61
1707	246	between (между)	62
1708	246	between — используем, когда что-то МЕЖДУ двумя объектами.	63
1709	246	The cat is between the boxes. — Кошка между коробками.	64
1710	246	I sit between Tom and Mary. — Я сижу между Томом и Мэри.	65
1711	246	The shop is between the bank and the cafe. — Магазин между банком и кафе.	66
1712	246	The ball is between the chairs. — Мяч между стульями.	67
1713	246	💡 Совет:	68
1714	246	between = между (двумя или более предметами)	69
1715	246	Примеры:	70
1716	246	The park is between two buildings.	71
1717	246	The pen is between the books.	72
1718	246	She stands between her parents.	73
1719	246	The table is between two chairs.	74
1720	246	Другие важные предлоги	75
1721	246	in front of (перед):	76
1722	246	The car is in front of the house. — Машина перед домом.	77
1723	246	behind (за, позади):	78
1724	246	The cat is behind the door. — Кошка за дверью.	79
1725	246	above (над):	80
1726	246	The lamp is above the table. — Лампа над столом.	81
1727	246	below (под, ниже):	82
1728	246	The temperature is below zero. — Температура ниже нуля.	83
1729	246	Сравнение предлогов	84
1730	246	in vs on:	85
1731	246	in the box (внутри коробки)	86
1732	246	on the box (на коробке, сверху)	87
1733	246	under vs below:	88
1734	246	under the table (прямо под столом)	89
1735	246	below the surface (ниже поверхности)	90
1736	246	next to vs between:	91
1737	246	next to the chair (рядом со стулом)	92
1738	246	between two chairs (между двумя стульями)	93
1739	247	❌ The book is the table. → пропущен предлог	0
1740	247	✔ The book is ON the table.	1
1741	247	❌ In the table → неправильный предлог	2
1742	247	✔ On the table.	3
1743	247	❌ The cat is on the box (когда кошка внутри) → неправильный предлог	4
1744	247	✔ The cat is IN the box.	5
1745	247	❌ Between the chair → нужно два объекта	6
1746	247	✔ Between the chairs / Next to the chair.	7
1747	247	❌ The picture is in the wall → неправильный предлог	8
1748	247	✔ The picture is ON the wall.	9
1749	248	1️⃣ in — внутри	0
1750	248	2️⃣ on — на поверхности	1
1751	248	3️⃣ under — под	2
1752	248	4️⃣ next to — рядом с	3
1753	248	5️⃣ between — между	4
1754	248	6️⃣ Предлог идёт ПЕРЕД существительным	5
1755	249	Вопросительные слова ставятся В НАЧАЛЕ вопроса.	0
1756	249	What do you do? — Что ты делаешь?	1
1757	249	Where do you live? — Где ты живёшь?	2
1758	249	Основные вопросительные слова (5W + 1H):	3
1759	249	- What (что)	4
1760	249	- Where (где)	5
1761	249	- Who (кто)	6
1762	249	- When (когда)	7
1763	249	- Why (почему)	8
1764	249	- How (как)	9
1765	250	What — используем, чтобы узнать информацию о вещах, действиях.	0
1766	250	What is this? — Что это?	1
1767	250	What do you do? — Что ты делаешь? (Чем занимаешься?)	2
1768	250	What is your name? — Как тебя зовут?	3
1769	250	What time is it? — Который час?	4
1770	250	💡 Совет:	5
1771	250	What = что, какой	6
1772	250	Примеры:	7
1773	250	What do you like? — Что тебе нравится?	8
1774	250	What is your job? — Какая у тебя работа?	9
1775	250	What are you doing? — Что ты делаешь?	10
1776	250	What colour is it? — Какого это цвета?	11
1777	251	Where — используем, чтобы узнать МЕСТО.	0
1778	251	Where do you live? — Где ты живёшь?	1
1779	251	Where is the bank? — Где банк?	2
1780	251	Where are you? — Где ты?	3
1781	251	Where are you going? — Куда ты идёшь?	4
1782	251	💡 Совет:	5
1783	251	Where = где, куда (про место)	6
1784	251	Примеры:	7
1785	251	Where is the book? — Где книга?	8
1786	251	Where do you work? — Где ты работаешь?	9
1787	251	Where are my keys? — Где мои ключи?	10
1788	251	Where is he from? — Откуда он?	11
1789	251	Who (кто)	12
1790	251	Who — используем, чтобы узнать о ЛЮДЯХ.	13
1791	251	Who is this? — Кто это?	14
1792	251	Who are you? — Кто ты?	15
1793	251	Who is your friend? — Кто твой друг?	16
1794	251	Who lives here? — Кто здесь живёт?	17
1795	251	💡 Совет:	18
1796	251	Who = кто (про людей)	19
1797	251	После who глагол часто в 3-м лице:	20
1798	251	Who lives here? (не "who live")	21
1799	251	Примеры:	22
1800	251	Who is she? — Кто она?	23
1801	251	Who do you love? — Кого ты любишь?	24
1802	251	Who called me? — Кто мне звонил?	25
1803	251	Who works here? — Кто здесь работает?	26
1804	252	When — используем, чтобы узнать о ВРЕМЕНИ.	0
1805	252	When is your birthday? — Когда твой день рождения?	1
1806	252	When do you work? — Когда ты работаешь?	2
1807	252	When did you arrive? — Когда ты приехал?	3
1808	252	When is the meeting? — Когда встреча?	4
1809	252	💡 Совет:	5
1810	252	When = когда (про время)	6
1811	252	Примеры:	7
1812	252	When do you wake up? — Когда ты просыпаешься?	8
1813	252	When is the exam? — Когда экзамен?	9
1814	252	When did you see her? — Когда ты её видел?	10
1815	252	When can you come? — Когда ты можешь прийти?	11
1816	253	Why — используем, чтобы узнать ПРИЧИНУ.	0
1817	253	Why are you sad? — Почему ты грустный?	1
1818	253	Why do you study English? — Почему ты учишь английский?	2
1819	253	Why is she late? — Почему она опоздала?	3
1820	253	Why not? — Почему нет?	4
1821	253	💡 Совет:	5
1822	253	Why = почему (про причину)	6
1823	253	Ответ часто начинается с Because (потому что):	7
1824	253	Why are you late? — Because I missed the bus.	8
1825	253	Примеры:	9
1826	253	Why do you like it? — Почему тебе это нравится?	10
1827	253	Why is he angry? — Почему он злой?	11
1828	253	Why did you leave? — Почему ты ушёл?	12
1829	253	Why don't you try? — Почему ты не попробуешь?	13
1830	254	How — используем, чтобы узнать СПОСОБ, СОСТОЯНИЕ.	0
1831	254	How are you? — Как дела?	1
1832	254	How do you do this? — Как ты это делаешь?	2
1833	254	How old are you? — Сколько тебе лет?	3
1834	254	How much is it? — Сколько это стоит?	4
1835	254	💡 Совет:	5
1836	254	How = как, каким образом	6
1837	254	How + прилагательное = более специфичный вопрос:	7
1838	254	How old? (сколько лет)	8
1839	254	How much? (сколько, цена)	9
1840	254	How many? (сколько, количество)	10
1841	254	Примеры:	11
1842	254	How do you know? — Откуда ты знаешь?	12
1843	254	How is your mother? — Как твоя мама?	13
1844	254	How did you learn? — Как ты научился?	14
1845	254	How far is it? — Как далеко это?	15
1846	255	Со всеми вопросительными словами структура похожая:	0
1847	255	Вопросительное слово + вспомогательный глагол + подлежащее + глагол?	1
1848	255	What do you like?	2
1849	255	Where do you live?	3
1850	255	When does she work?	4
1851	255	Why are you sad?	5
1852	255	How do they know?	6
1853	255	С to be:	7
1854	255	Вопросительное слово + to be + подлежащее?	8
1855	255	Where is she?	9
1856	255	Who are you?	10
1857	255	How is he?	11
1858	256	How much (сколько — для неисчисляемых):	0
1859	256	How much water? — Сколько воды?	1
1860	256	How many (сколько — для исчисляемых):	2
1861	256	How many books? — Сколько книг?	3
1862	256	How old (сколько лет):	4
1863	256	How old are you? — Сколько тебе лет?	5
1864	256	How far (как далеко):	6
1865	256	How far is it? — Как далеко это?	7
1866	256	How long (как долго):	8
1867	256	How long does it take? — Сколько времени это занимает?	9
1868	257	❌ What you do? → пропущен вспомогательный глагол	0
1869	257	✔ What do you do?	1
1870	257	❌ Where you live? → пропущен do	2
1871	257	✔ Where do you live?	3
1872	257	❌ How you are? → неправильный порядок	4
1873	257	✔ How are you?	5
1874	257	❌ Who you are? → неправильный порядок с to be	6
1875	257	✔ Who are you?	7
1876	257	❌ When is your birthday? — On Monday. → путаница when/what	8
1877	257	✔ When is your birthday? — On June 5th.	9
1878	258	1️⃣ What — что, какой	0
1879	258	2️⃣ Where — где, куда	1
1880	258	3️⃣ Who — кто	2
1881	258	4️⃣ When — когда	3
1882	258	5️⃣ Why — почему	4
1883	258	6️⃣ How — как	5
1884	259	Числа в английском делятся на:	0
1885	259	- Количественные (one, two, three) — сколько	1
2001	260	on the first of January — первого января	8
1886	259	- Порядковые (first, second, third) — какой по счёту	2
1887	259	Даты читаются особым образом.	3
1888	259	Время — тоже со своими правилами.	4
1889	259	Числа от 1 до 20	5
1890	259	Эти числа нужно просто запомнить:	6
1891	259	1 — one	7
1892	259	2 — two	8
1893	259	3 — three	9
1894	259	4 — four	10
1895	259	5 — five	11
1896	259	6 — six	12
1897	259	7 — seven	13
1898	259	8 — eight	14
1899	259	9 — nine	15
1900	259	10 — ten	16
1901	259	11 — eleven	17
1902	259	12 — twelve	18
1903	259	13 — thirteen	19
1904	259	14 — fourteen	20
1905	259	15 — fifteen	21
1906	259	16 — sixteen	22
1907	259	17 — seventeen	23
1908	259	18 — eighteen	24
1909	259	19 — nineteen	25
1910	259	20 — twenty	26
1911	259	💡 Совет:	27
1912	259	От 13 до 19 добавляем -teen	28
1913	259	Десятки	29
1914	259	20 — twenty	30
1915	259	30 — thirty	31
1916	259	40 — forty	32
1917	259	50 — fifty	33
1918	259	60 — sixty	34
1919	259	70 — seventy	35
1920	259	80 — eighty	36
1921	259	90 — ninety	37
1922	259	💡 Совет:	38
1923	259	Десятки заканчиваются на -ty	39
1924	259	Двузначные числа:	40
1925	259	21 — twenty-one	41
1926	259	35 — thirty-five	42
1927	259	47 — forty-seven	43
1928	259	99 — ninety-nine	44
1929	259	Сотни и тысячи	45
1930	259	100 — one hundred / a hundred	46
1931	259	200 — two hundred	47
1932	259	1,000 — one thousand / a thousand	48
1933	259	10,000 — ten thousand	49
1934	259	Примеры:	50
1935	259	256 — two hundred fifty-six	51
1936	259	1,543 — one thousand five hundred forty-three	52
1937	259	💡 Совет:	53
1938	259	В английском НЕ используют "and" после сотен:	54
1939	259	256 = two hundred fifty-six (не two hundred AND fifty-six)	55
1940	259	Порядковые числительные	56
1941	259	Порядковые числительные — это «первый», «второй», «третий».	57
1942	259	Особые формы (нужно запомнить):	58
1943	259	1st — first	59
1944	259	2nd — second	60
1945	259	3rd — third	61
1946	259	Остальные: добавляем -th:	62
1947	259	4th — fourth	63
1948	259	5th — fifth	64
1949	259	6th — sixth	65
1950	259	7th — seventh	66
1951	259	8th — eighth	67
1952	259	9th — ninth	68
1953	259	10th — tenth	69
1954	259	11th — eleventh	70
1955	259	12th — twelfth	71
1956	259	20th — twentieth	72
1957	259	21st — twenty-first	73
1958	259	30th — thirtieth	74
1959	259	100th — one hundredth	75
1960	259	Дни недели	76
1961	259	Monday — понедельник	77
1962	259	Tuesday — вторник	78
1963	259	Wednesday — среда	79
1964	259	Thursday — четверг	80
1965	259	Friday — пятница	81
1966	259	Saturday — суббота	82
1967	259	Sunday — воскресенье	83
1968	259	💡 Совет:	84
1969	259	Дни недели ВСЕГДА пишутся с большой буквы.	85
1970	259	Предлог: on	86
1971	259	on Monday — в понедельник	87
1972	259	on Friday — в пятницу	88
1973	259	Месяцы	89
1974	259	January — январь	90
1975	259	February — февраль	91
1976	259	March — март	92
1977	259	April — апрель	93
1978	259	May — май	94
1979	259	June — июнь	95
1980	259	July — июль	96
1981	259	August — август	97
1982	259	September — сентябрь	98
1983	259	October — октябрь	99
1984	259	November — ноябрь	100
1985	259	December — декабрь	101
1986	259	💡 Совет:	102
1987	259	Месяцы ВСЕГДА пишутся с большой буквы.	103
1988	259	Предлог: in	104
1989	259	in January — в январе	105
1990	259	in May — в мае	106
1991	259	Даты	107
1992	259	Даты в английском говорятся с порядковыми числительными:	108
1993	260	1 January = the first of January / January first	0
1994	260	22 March = the twenty-second of March / March twenty-second	1
1995	260	Как писать:	2
1996	260	5th June 2024	3
1997	260	June 5th, 2024	4
1998	260	5/6/2024 (осторожно: в США месяц/день/год!)	5
1999	260	Предлог: on	6
2000	260	on June 5th — 5-го июня	7
2002	260	Время по часам	9
2003	260	Который час? — What time is it?	10
2004	260	Целые часы:	11
2005	260	1:00 — one o'clock	12
2006	260	2:00 — two o'clock	13
2007	260	12:00 — twelve o'clock	14
2008	260	После часа (минуты):	15
2009	260	2:10 — ten past two	16
2010	260	3:15 — quarter past three / three fifteen	17
2011	260	4:30 — half past four / four thirty	18
2012	260	5:45 — quarter to six / five forty-five	19
2013	260	6:50 — ten to seven / six fifty	20
2014	260	💡 Совет:	21
2015	260	past = после (для первых 30 минут)	22
2016	260	to = до (для последних 30 минут)	23
2017	260	AM / PM:	24
2018	260	AM — утро (с полуночи до полудня)	25
2019	260	PM — день/вечер (с полудня до полуночи)	26
2020	260	9:00 AM — 9 утра	27
2021	260	9:00 PM — 9 вечера	28
2022	260	Предлог: at	29
2023	260	at 5 o'clock — в 5 часов	30
2024	260	at half past three — в половине четвёртого	31
2025	260	at noon — в полдень	32
2026	260	at midnight — в полночь	33
2027	261	❌ In Monday → неправильный предлог	0
2028	261	✔ On Monday	1
2029	261	❌ At January → неправильный предлог	2
2030	261	✔ In January	3
2031	261	❌ Five and thirty → так не говорят	4
2032	261	✔ Thirty-five	5
2033	261	❌ The five June → неправильный порядок	6
2034	261	✔ June fifth / the fifth of June	7
2035	261	❌ In 5 o'clock → неправильный предлог	8
2036	261	✔ At 5 o'clock	9
2037	262	1️⃣ Числа: one, two, three... twenty, thirty...	0
2038	262	2️⃣ Порядковые: first, second, third, fourth...	1
2039	262	3️⃣ Дни: on Monday, on Friday	2
2040	262	4️⃣ Месяцы: in January, in May	3
2041	262	5️⃣ Даты: on June 5th	4
2042	262	6️⃣ Время: at 5 o'clock, at half past three	5
2043	263	Present Continuous = действие происходит СЕЙЧАС, В ДАННЫЙ МОМЕНТ.	0
2044	263	Формула: to be + глагол с -ing	1
2045	263	I am reading. — Я читаю (сейчас).	2
2046	263	She is sleeping. — Она спит (сейчас).	3
2047	263	They are playing. — Они играют (сейчас).	4
2048	263	Как образуется Present Continuous	5
2049	263	Берём три составляющих:	6
2050	263	1️⃣ Подлежащее (I, you, he, she...)	7
2051	263	2️⃣ Форму to be (am, is, are)	8
2052	263	3️⃣ Глагол + окончание -ing	9
2053	263	Формула: подлежащее + am/is/are + глагол-ing	10
2054	263	Примеры:	11
2055	263	I am working. — Я работаю (сейчас).	12
2056	263	You are studying. — Ты учишься (сейчас).	13
2057	263	He is eating. — Он ест (сейчас).	14
2058	263	She is sleeping. — Она спит (сейчас).	15
2059	263	We are watching. — Мы смотрим (сейчас).	16
2060	263	They are playing. — Они играют (сейчас).	17
2061	263	Как добавить -ing к глаголу	18
2062	264	work → working	0
2063	264	play → playing	1
2064	264	read → reading	2
2065	264	watch → watching	3
2066	264	Глаголы на -e: убираем -e, добавляем -ing	4
2067	264	make → making	5
2068	264	write → writing	6
2069	264	come → coming	7
2070	264	take → taking	8
2071	264	Короткие глаголы (согласная-гласная-согласная): удваиваем последнюю букву	9
2072	264	run → running	10
2073	264	sit → sitting	11
2074	264	stop → stopping	12
2075	264	swim → swimming	13
2076	264	НО: если ударение не на последнем слоге, НЕ удваиваем:	14
2077	264	open → opening (не openning)	15
2078	264	visit → visiting (не visitting)	16
2079	264	💡 Совет:	17
2080	264	Большинство глаголов — просто +ing	18
2081	264	Только некоторые требуют изменений	19
2082	264	Утверждения в Present Continuous	20
2083	264	Полные формы:	21
2084	264	I am working.	22
2085	264	You are studying.	23
2086	264	He is reading.	24
2087	264	She is cooking.	25
2088	264	It is raining.	26
2089	264	We are eating.	27
2090	264	They are playing.	28
2091	264	Краткие формы (чаще используются):	29
2092	264	I'm working.	30
2093	264	You're studying.	31
2094	264	He's reading.	32
2095	264	She's cooking.	33
2096	264	It's raining.	34
2097	264	We're eating.	35
2098	264	They're playing.	36
2099	264	Примеры:	37
2100	264	I'm watching TV now. — Я смотрю телевизор сейчас.	38
2101	264	She's talking on the phone. — Она разговаривает по телефону.	39
2102	264	They're having lunch. — Они обедают.	40
2103	264	Отрицания в Present Continuous	41
2104	264	Отрицание строится просто: добавляем not после to be.	42
2105	264	I am not working. → I'm not working.	43
2106	264	You are not studying. → You aren't studying.	44
2107	264	He is not reading. → He isn't reading.	45
2108	264	She is not cooking. → She isn't cooking.	46
2109	264	We are not eating. → We aren't eating.	47
2110	264	They are not playing. → They aren't playing.	48
2111	264	💡 Совет:	49
2112	264	Две формы сокращения:	50
2113	264	You're not / You aren't	51
2114	264	He's not / He isn't	52
2115	264	Примеры:	53
2116	264	I'm not watching TV. — Я не смотрю телевизор.	54
2117	264	She isn't talking. — Она не разговаривает.	55
2118	264	They aren't playing. — Они не играют.	56
2119	265	Вопросы: ставим to be ПЕРЕД подлежащим.	0
2120	265	Am I working?	1
2121	265	Are you studying?	2
2122	265	Is he reading?	3
2123	265	Is she cooking?	4
2124	265	Are we eating?	5
2125	265	Are they playing?	6
2126	265	Примеры:	7
2127	265	Are you watching TV? — Ты смотришь телевизор?	8
2128	265	Is she talking on the phone? — Она разговаривает по телефону?	9
2129	265	Are they having lunch? — Они обедают?	10
2130	265	Короткие ответы:	11
2131	265	Are you working? — Yes, I am. / No, I'm not.	12
2132	265	Is she reading? — Yes, she is. / No, she isn't.	13
2133	265	Are they playing? — Yes, they are. / No, they aren't.	14
2134	265	Когда используем Present Continuous	15
2135	265	1. Действие происходит СЕЙЧАС, в момент речи:	16
2136	265	I'm reading a book (right now). — Я читаю книгу (прямо сейчас).	17
2137	265	She's sleeping (at the moment). — Она спит (в данный момент).	18
2138	265	2. Временная ситуация:	19
2139	265	I'm staying at a hotel this week. — Я живу в отеле на этой неделе.	20
2140	265	He's working in Moscow this month. — Он работает в Москве в этом месяце.	21
2141	265	3. Планы на будущее (с указанием времени):	22
2142	265	I'm meeting her tomorrow. — Я встречаюсь с ней завтра.	23
2143	265	We're flying to Paris next week. — Мы летим в Париж на следующей неделе.	24
2144	265	Слова-указатели Present Continuous	25
2145	265	now — сейчас	26
2146	265	at the moment — в данный момент	27
2147	265	right now — прямо сейчас	28
2148	265	currently — в настоящее время	29
2149	265	today — сегодня	30
2150	265	this week — на этой неделе	31
2151	265	this month — в этом месяце	32
2152	265	Look! — Смотри!	33
2153	265	Listen! — Слушай!	34
2154	265	Примеры:	35
2155	265	I'm working now. — Я работаю сейчас.	36
2156	265	Look! It's raining! — Смотри! Идёт дождь!	37
2157	265	She's studying at the moment. — Она учится в данный момент.	38
2158	265	Present Simple vs Present Continuous	39
2159	265	Это важное различие!	40
2160	265	Present Simple — привычка, регулярное действие:	41
2161	265	I work every day. — Я работаю каждый день.	42
2162	265	Present Continuous — действие происходит сейчас:	43
2163	265	I'm working now. — Я работаю сейчас.	44
2164	265	Сравни:	45
2165	265	He plays football (regularly). — Он играет в футбол (регулярно).	46
2166	265	He is playing football (now). — Он играет в футбол (сейчас).	47
2167	265	They live in London (permanently). — Они живут в Лондоне (постоянно).	48
2168	265	They are staying in London (temporarily). — Они живут в Лондоне (временно).	49
2169	265	Глаголы, которые НЕ используются в Continuous	50
2170	265	Некоторые глаголы почти НИКОГДА не используются в Continuous:	51
2171	265	like, love, hate, want, need, know, understand, believe, remember, forget, prefer, see, hear	52
2172	265	❌ I am liking pizza. (неправильно)	53
2173	265	✔ I like pizza. (правильно)	54
2174	265	❌ She is knowing the answer. (неправильно)	55
2175	265	✔ She knows the answer. (правильно)	56
2176	265	💡 Совет:	57
2177	265	Эти глаголы описывают состояния, а не действия.	58
2178	266	❌ I working now. → пропущен to be	0
2179	266	✔ I am working now.	1
2180	266	❌ She is work. → пропущено -ing	2
2181	266	✔ She is working.	3
2182	266	❌ He playing football. → пропущен is	4
2183	266	✔ He is playing football.	5
2184	266	❌ Are you work? → неправильная форма глагола	6
2185	266	✔ Are you working?	7
2186	266	❌ I am liking pizza. → этот глагол не используется в Continuous	8
2187	266	✔ I like pizza.	9
2188	266	❌ They are stoping. → неправильное написание	10
2189	266	✔ They are stopping.	11
2190	267	1️⃣ Формула: am/is/are + глагол-ing	0
2191	267	2️⃣ Используется для действий, происходящих СЕЙЧАС	1
2192	267	3️⃣ Большинство глаголов: просто +ing	2
2193	267	4️⃣ Отрицание: am/is/are + not + глагол-ing	3
2194	267	5️⃣ Вопрос: Am/Is/Are + подлежащее + глагол-ing?	4
2195	267	6️⃣ Некоторые глаголы (like, know, want) НЕ используются в Continuous	5
\.


--
-- Data for Name: rule_sections; Type: TABLE DATA; Schema: public; Owner: doc
--

COPY public.rule_sections (id, topic_id, title, content, display_order, created_at) FROM stdin;
1	alphabet-pronunciation	Давай сразу договоримся об одной вещи	Английский не сложный. Он просто не русский. И почти все проблемы начинаются ровно в тот момент, когда ты пытаешься обращаться с английским так, как привык с русским: переставлять слова как хочется, додумывать формы, переводить предложение «по смыслу». Английский так не работает. Зато он работает логично. И если ты поймёшь эту логику сейчас — дальше будет реально легко.	0	2025-12-19 02:18:57.534142+03
2	alphabet-pronunciation	Английский — это язык структуры	В русском языке смысл часто живёт в окончаниях. Мы можем менять слова местами, играться формами — и всё равно друг друга понимать. В английском всё держится на другом. Там смысл создаётся порядком слов. Есть чёткий скелет, и если ты его соблюдаешь — предложение работает. Если нет — разваливается, как бы правильно ни были выбраны слова.	1	2025-12-19 02:18:57.534142+03
3	alphabet-pronunciation	Почему в английском нельзя говорить «как по-русски»	По-русски мы спокойно говорим: «Я студент», «Я дома», «Холодно». В английском такие предложения просто не существуют. Там нельзя оставить фразу без глагола. Никогда. Поэтому появляется то, чего мы не привыкли замечать: глагол to be, который в русском чаще всего «прячется», а в английском — выходит на сцену.	2	2025-12-19 02:18:57.534142+03
4	alphabet-pronunciation	Если коротко: глагол — это всё	Если очень сильно упростить английский язык, получится одна мысль: вся грамматика крутится вокруг глаголов. Времена — это про глаголы. Вопросы — это про глаголы. Отрицания — это тоже глаголы. Даже когда кажется, что «действия нет», глагол всё равно есть. Просто он означает не действие, а состояние.	3	2025-12-19 02:18:57.534142+03
5	alphabet-pronunciation	Минимум, без которого предложение не живёт	Чтобы английское предложение вообще считалось предложением, ему нужны две вещи: Кто-то. И то, что с ним происходит — или кем он является. Всё. Даже это уже полноценные, правильные предложения. Убери одну часть — и фраза перестаёт существовать.	4	2025-12-19 02:18:57.534142+03
6	alphabet-pronunciation	Фундамент: глагол to be	Глагол to be — это не просто ещё один глагол. Это фундамент. Он нужен, когда ты: говоришь, кто ты; где ты; в каком ты состоянии; какой ты. И у него есть формы, которые просто надо принять как есть. Без философии. Без «почему так». Просто так устроен язык.	5	2025-12-19 02:18:57.534142+03
7	alphabet-pronunciation	Почему нельзя сказать просто «student»	Это один из самых частых ступоров. Почему нельзя сказать просто: student, doctor, work? Потому что английский не любит недосказанность. Ему важно, кто это и что именно происходит. Не потому что «так красивее», а потому что иначе язык не работает.	6	2025-12-19 02:18:57.534142+03
8	alphabet-pronunciation	Английский — это конструктор, а не угадайка	Хорошая новость: тебе не нужно чувствовать язык интуитивно, чтобы начать говорить правильно. Ты просто собираешь предложение из блоков. Подлежащее. Глагол. Дополнение. Ты не переводишь. Ты не подбираешь «похожее». Ты просто собираешь конструкцию. И это одна из самых сильных сторон английского языка.	7	2025-12-19 02:18:57.534142+03
9	alphabet-pronunciation	Вопросы и отрицания — тоже по схеме	В русском вопрос — это интонация. В английском — это структура. Появляются вспомогательные глаголы, меняется порядок слов — и всё, вопрос готов. То же самое с отрицаниями. Нельзя просто вставить «not» куда хочется. Это не «исключения». Это система. И она повторяется снова и снова.	8	2025-12-19 02:18:57.534142+03
10	alphabet-pronunciation	Самая важная смена мышления	Пока ты думаешь: «Как это перевести с русского?» — будет тяжело. Как только ты начинаешь думать: «Какую структуру я сейчас использую?» — всё встаёт на места. Английский не переводят. Им оперируют.	9	2025-12-19 02:18:57.534142+03
11	alphabet-pronunciation	Если вынести одну главную мысль	Английский — это не хаос правил. Это система повторяющихся моделей. И ты только что познакомился с самой базовой из них. Дальше будет: проще, логичнее, и, что важно, гораздо интереснее. Потому что фундамент у тебя уже есть.	10	2025-12-19 02:18:57.534142+03
232	modal_verbs	Главное про модальные глаголы		0	2025-12-23 01:54:43.80199+03
233	modal_verbs	Can / Can't		1	2025-12-23 01:54:43.80199+03
234	modal_verbs	Must / Mustn't		2	2025-12-23 01:54:43.80199+03
235	modal_verbs	ВАЖНО: mustn't = ЗАПРЕТ (нельзя!)		3	2025-12-23 01:54:43.80199+03
236	modal_verbs	Should / Shouldn't		4	2025-12-23 01:54:43.80199+03
237	modal_verbs	Разница между can, must, should		5	2025-12-23 01:54:43.80199+03
238	modal_verbs	Типичные ошибки русскоговорящих		6	2025-12-23 01:54:43.80199+03
239	modal_verbs	Главное про модальные глаголы		7	2025-12-23 01:54:43.80199+03
240	there_is_are	Главное про there is / there are		0	2025-12-23 01:54:43.851442+03
241	there_is_are	There is / there are = «есть», «находится», «существует»		1	2025-12-23 01:54:43.851442+03
242	there_is_are	There is (единственное число)		2	2025-12-23 01:54:43.851442+03
243	there_is_are	There are (множественное число)		3	2025-12-23 01:54:43.851442+03
244	there_is_are	Типичные ошибки русскоговорящих		4	2025-12-23 01:54:43.851442+03
245	there_is_are	Главное про there is / there are		5	2025-12-23 01:54:43.851442+03
246	prepositions_place	Главное про предлоги места		0	2025-12-23 01:54:43.866509+03
247	prepositions_place	Типичные ошибки русскоговорящих		1	2025-12-23 01:54:43.866509+03
248	prepositions_place	Главное про предлоги места		2	2025-12-23 01:54:43.866509+03
249	question_words	Главное про вопросительные слова		0	2025-12-23 01:54:43.879328+03
250	question_words	What (что, какой)		1	2025-12-23 01:54:43.879328+03
251	question_words	Where (где, куда)		2	2025-12-23 01:54:43.879328+03
252	question_words	When (когда)		3	2025-12-23 01:54:43.879328+03
253	question_words	Why (почему)		4	2025-12-23 01:54:43.879328+03
254	question_words	How (как, каким образом)		5	2025-12-23 01:54:43.879328+03
255	question_words	Структура вопросов		6	2025-12-23 01:54:43.879328+03
256	question_words	Специальные конструкции с How		7	2025-12-23 01:54:43.879328+03
257	question_words	Типичные ошибки русскоговорящих		8	2025-12-23 01:54:43.879328+03
258	question_words	Главное про вопросительные слова		9	2025-12-23 01:54:43.879328+03
259	numbers_dates_time	Главное про числа, даты и время		0	2025-12-23 01:54:43.901426+03
260	numbers_dates_time	5 June = the fifth of June / June fifth		1	2025-12-23 01:54:43.901426+03
261	numbers_dates_time	Типичные ошибки русскоговорящих		2	2025-12-23 01:54:43.901426+03
262	numbers_dates_time	Главное про числа, даты и время		3	2025-12-23 01:54:43.901426+03
263	present_continuous	Главное про Present Continuous		0	2025-12-23 01:54:43.920276+03
264	present_continuous	Большинство глаголов: просто добавляем -ing		1	2025-12-23 01:54:43.920276+03
265	present_continuous	Вопросы в Present Continuous		2	2025-12-23 01:54:43.920276+03
266	present_continuous	Типичные ошибки русскоговорящих		3	2025-12-23 01:54:43.920276+03
267	present_continuous	Главное про Present Continuous		4	2025-12-23 01:54:43.920276+03
114	adjectives	Прилагательные в английском — неизменяемые стикеры	Прилагательное — это стикер, который ты просто прилепляешь к предмету. И всё. Оно никогда не меняется. Ни при каких обстоятельствах.\n\nВ английском прилагательное:\n— не меняется по роду\n— не меняется по числу\n— не меняется по падежам\n\nВообще. Никогда. Совсем.\n\nРусский мозг такой: «красивая девушка / красивый дом / красивые дома»\n\nА английский отвечает:\nbeautiful girl\nbeautiful house\nbeautiful houses\n\nОдно слово. Всегда.	0	2025-12-20 16:17:42.579705+03
115	adjectives	Позиция прилагательного в предложении	В 90% случаев прилагательное СТОИТ ПЕРЕД существительным.\n\nНе после. Не «дом красивый». А «красивый дом».\n\nЭто железное правило. Если ты ставишь прилагательное после существительного — ты почти всегда ошибаешься.\n\nНо есть второй вариант: прилагательное может стоять ПОСЛЕ глагола to be.\n\nФормула простая: subject + to be + adjective\n\nИ вот тут важный момент: после to be НЕТ существительного, только прилагательное.	1	2025-12-20 16:17:42.579705+03
116	adjectives	Степени сравнения прилагательных	Если прилагательное короткое (1 слог): добавляем -er/-est\n\nЕсли длинное (2+ слога): используем more/most\n\nЛогика простая:\n— короткие → меняются\n— длинные → через more / most\n\nИ да, the в превосходной степени — почти всегда обязателен.\n\nЕсть неправильные формы. Их мало, но они суперчастые. Их не надо понимать. Их надо принять, как факт жизни.	2	2025-12-20 16:17:42.579705+03
117	adjectives	Усиление прилагательных наречиями	В английском нельзя сказать "очень красиво" через окончание. Нет «красивее» через форму слова, если это не сравнение.\n\nЧтобы усилить прилагательное, ты используешь наречия: very, really, quite\n\nПрилагательное само по себе — нейтральное, эмоции добавляются отдельными словами.	3	2025-12-20 16:17:42.579705+03
118	adjectives	Типичные ошибки русскоговорящих	Вот самые частые ошибки, которые делают русскоговорящие студенты при изучении прилагательных.	4	2025-12-20 16:17:42.579705+03
283	future_simple	1. Что такое Future Simple		0	2025-12-23 01:55:47.924616+03
284	future_simple	2. Утверждения (Affirmative)		1	2025-12-23 01:55:47.924616+03
285	future_simple	Структура очень простая:		2	2025-12-23 01:55:47.924616+03
286	future_simple	3. Отрицания (Negative)		3	2025-12-23 01:55:47.924616+03
287	future_simple	Чтобы сказать, что что-то НЕ произойдёт, используем will not или won't:		4	2025-12-23 01:55:47.924616+03
288	future_simple	4. Вопросы (Questions)		5	2025-12-23 01:55:47.924616+03
289	future_simple	Чтобы спросить о будущем, ставим will перед подлежащим:		6	2025-12-23 01:55:47.924616+03
290	future_simple	5. Когда используем Future Simple		7	2025-12-23 01:55:47.924616+03
291	future_simple	Предсказания (то, что мы думаем произойдёт):		8	2025-12-23 01:55:47.924616+03
292	future_simple	Спонтанные решения (принятые в момент речи):		9	2025-12-23 01:55:47.924616+03
293	future_simple	6. Наречия времени (Time expressions)		10	2025-12-23 01:55:47.924616+03
294	future_simple	7. Типичные ошибки русскоговорящих		11	2025-12-23 01:55:47.924616+03
295	future_simple	8. Will vs Be Going To		12	2025-12-23 01:55:47.924616+03
296	future_simple	9. Главное про Future Simple		13	2025-12-23 01:55:47.924616+03
297	future_simple	6️⃣ Наречия времени: tomorrow, next week, soon, later, in the future		14	2025-12-23 01:55:47.924616+03
119	articles	Что такое артикли и зачем они нужны	Артикли — это почти всегда головная боль для русскоговорящих. Но давай сразу разберёмся без паники: на самом деле всё логично.\n\nАнглийский любит уточнять, о чём идёт речь. Артикль — это как ярлык на существительном:\n- этот конкретный предмет?\n- любой из множества?\n- вообще про категорию?\n\nИменно это «ярлык» и называется артиклем.	0	2025-12-21 01:19:50.649691+03
120	articles	A / An — один из множества	Когда ты говоришь о чём-то одном, но не конкретном, используй a или an.\n\nПростое правило:\n- a перед словами, которые начинаются на согласный звук\n- an перед словами, которые начинаются на гласный звук (звук важнее буквы!)\n\nГлавная мысль: ты говоришь о ком-то или о чём-то в общем, впервые упоминая это.	1	2025-12-21 01:19:50.649691+03
121	articles	The — конкретный, известный, уникальный	Когда мы говорим о чём-то конкретном, уже известном собеседнику, ставим the.\n\nГлавная мысль: the = мы оба знаем, о чём речь.	2	2025-12-21 01:19:50.649691+03
122	articles	Нулевой артикль	Да, иногда артикль вообще не нужен. Это называется нулевой артикль, и он тоже имеет свою логику.\n\nПравило простое: нет ярлыка = говорим про что-то в общем, категорию, абстракцию.	3	2025-12-21 01:19:50.649691+03
123	articles	Типичные ошибки русскоговорящих	Вот самые частые ошибки, которые делают русскоговорящие студенты при изучении артиклей.	4	2025-12-21 01:19:50.649691+03
124	articles	Главное, что нужно понять про артикли	Если запомнишь это, большая часть ошибок в английском будет уже закрыта.	5	2025-12-21 01:19:50.649691+03
134	pronouns	Местоимения — зачем они вообще нужны	Давай сразу честно: если убрать местоимения, английский развалится.\n\nТы не сможешь сказать:\n- кто делает действие\n- на кого оно направлено\n- кому что принадлежит\n\nПоэтому местоимения — это не «дополнение», а скелет речи.	0	2025-12-21 01:38:05.126776+03
135	pronouns	Личные местоимения (Subject Pronouns)	Это кто выполняет действие.\n\nГлавное правило, которое нужно вбить в голову:\n👉 в английском предложение без подлежащего почти не существует.	1	2025-12-21 01:38:05.126776+03
136	pronouns	Очень важный момент для русскоговорящих	В русском можно сказать: "Пошёл в магазин."\n\nВ английском так нельзя. Ты обязан сказать, кто пошёл.	2	2025-12-21 01:38:05.126776+03
137	pronouns	Объектные местоимения (Object Pronouns)	Теперь смотри: если личные местоимения — кто делает, то объектные — на кого направлено действие.	3	2025-12-21 01:38:05.126776+03
138	pronouns	Притяжательные местоимения — часть 1 (my, your…)	Это чей? чья? чьё?\n\nОни всегда стоят перед существительным.	4	2025-12-21 01:38:05.126776+03
139	pronouns	Притяжательные местоимения — часть 2 (mine, yours…)	А теперь внимание, здесь часто ломаются.\n\n👉 после них НЕТ существительного.	5	2025-12-21 01:38:05.126776+03
140	pronouns	Указательные местоимения (this / that)	Они показывают где и сколько.	6	2025-12-21 01:38:05.126776+03
141	pronouns	Типичные ошибки русскоговорящих	Вот самые частые ошибки при использовании местоимений.	7	2025-12-21 01:38:05.126776+03
142	pronouns	Что важно вынести из этого топика	Если ты это понял — ты уже говоришь намного чище, чем большинство beginners.	8	2025-12-21 01:38:05.126776+03
143	to_be	Что такое to be	To be — это глагол «быть».\n\nНо он никогда не выглядит одинаково.\nВ настоящем времени он меняется в зависимости от лица.	0	2025-12-21 13:08:53.039059+03
144	to_be	Am / Is / Are	Запоминаем простую таблицу:	1	2025-12-21 13:08:53.039059+03
145	to_be	Полные и краткие формы	В английском почти всегда используют краткие формы — так звучит естественно.	2	2025-12-21 13:08:53.039059+03
146	to_be	Отрицания с to be	Чтобы сделать отрицание, просто добавь not.	3	2025-12-21 13:08:53.039059+03
147	to_be	Вопросы с to be	С to be всё просто: меняем местами глагол и подлежащее.\n\n👉 Никаких do / does здесь не нужно.	4	2025-12-21 13:08:53.039059+03
148	to_be	Короткие ответы	Вопросы с to be любят короткие ответы.	5	2025-12-21 13:08:53.039059+03
90	greetings-introductions	Что такое существительное на самом деле	Существительное — это не «часть речи из учебника».\n\nЭто имя всего, о чём ты можешь говорить.\n\nЛюди, предметы, места, идеи, состояния — всё это существительные.\n\nstudent\n\ncoffee\n\ncity\n\njob\n\ntime\n\nidea\n\nЕсли ты можешь задать вопрос кто? или что? — перед тобой существительное.	0	2025-12-20 02:57:32.282549+03
91	greetings-introductions	Почему существительные так важны в английском	Потому что в английском предложении существительное чаще всего:\n\nстоит до глагола\n\nвыполняет роль подлежащего\n\nопределяет, о ком или о чём вообще речь\n\nПример:\n\nI work here.\n\nShe is a doctor.\n\nThis city is beautiful.\n\nБез существительного предложение либо не существует, либо превращается в обрывок.	1	2025-12-20 02:57:32.282549+03
92	greetings-introductions	Исчисляемые и неисчисляемые — без заумных слов	Вот тут русскоговорящие часто напрягаются. А зря.\n\nСуть простая.	2	2025-12-20 02:57:32.282549+03
93	greetings-introductions	Исчисляемые существительные	Это то, что можно посчитать поштучно.\n\none book\n\ntwo books\n\nthree chairs\n\nЕсли можно сказать «один / два / три» — значит, существительное исчисляемое.\n\nПримеры:\n\nbook\n\nstudent\n\ncar\n\nidea	3	2025-12-20 02:57:32.282549+03
94	greetings-introductions	Неисчисляемые существительные	Это то, что не считают поштучно, а воспринимают как массу, процесс или абстракцию.\n\nwater\n\ninformation\n\nmoney\n\nmusic\n\nТы не скажешь two informations или three musics.\n\nНе потому что «нельзя», а потому что английский видит это как единое целое.\n\nЕсли нужно посчитать — добавляют контейнер:\n\na piece of information\n\na glass of water\n\nМножественное число: всё не так страшно\n\nВ большинстве случаев всё максимально просто.	4	2025-12-20 02:57:32.282549+03
149	to_be	Где to be используется	Ты используешь to be, когда говоришь о том, кто ты есть, где ты находишься, и какой ты.	6	2025-12-21 13:08:53.039059+03
150	to_be	Типичные ошибки русскоговорящих	Самые частые ошибки при использовании to be.	7	2025-12-21 13:08:53.039059+03
151	to_be	Главное про to be	Ключевые моменты, которые нужно запомнить:	8	2025-12-21 13:08:53.039059+03
95	greetings-introductions	Базовое правило	Добавляешь -s.\n\nbook → books\n\nstudent → students\n\nКогда появляется -es\n\nЕсли слово заканчивается на:\n\ns / ss / sh / ch / x\n\nbus → buses\n\nclass → classes\n\nКогда -y превращается в -ies\n\nЕсли перед -y стоит согласная:\n\ncity → cities\n\nbaby → babies\n\nДа, есть неправильные формы (man → men),\n\nно на старте важно не они, а принцип.\n\nПритяжательный ’s — это не падеж\n\nОчень важный момент.\n\nВ английском нет падежей как в русском.\n\nЕсть способ показать владельца.\n\nИ он выглядит так:\n\nsomeone’s + thing\n\nJohn’s car\n\nmy friend’s house\n\nЭто не «родительный падеж».\n\nЭто просто маркер: кому принадлежит.	5	2025-12-20 02:57:32.282549+03
96	greetings-introductions	Где существительные стоят в предложении	Самые частые позиции:\n\n1️⃣ В начале — как подлежащее\n\nThe student is tired.\n\n2️⃣ После глагола — как дополнение\n\nI like coffee.\n\n3️⃣ После to be\n\nShe is a teacher.\n\nИ да — очень часто рядом с существительным появляется артикль.\n\nНо артикли — это следующий топик, и мы к нему подойдём спокойно.	6	2025-12-20 02:57:32.282549+03
97	greetings-introductions	Типичные ошибки русскоговорящих	Почему?\n\nПотому что:\n\nсуществительное само по себе — не предложение\n\nнеисчисляемые существительные считаются как единственное число\n\nГлавное, что нужно понять про существительные\n\nЕсли вынести одну мысль:\n\nСуществительные в английском — это якоря.\n\nОни держат предложение на месте.\n\nТы уже:\n\nпонимаешь, что они обозначают\n\nзнаешь, что не всё можно посчитать\n\nумеешь делать множественное число\n\nумеешь показывать принадлежность\n\nЭтого более чем достаточно для старта.	7	2025-12-20 02:57:32.282549+03
152	present_simple	Что такое Present Simple	Слушай, Present Simple — это время, которое рассказывает о том, что происходит обычно, а не прямо сейчас.\nРусскоговорящим оно сначала кажется странным, потому что в русском мы часто просто говорим глаголом без окончания, а в английском нужно внимательно следить за формой глагола.\n\nГлавная идея: Present Simple = факты, привычки, рутина.	0	2025-12-21 13:20:37.35672+03
153	present_simple	Утверждения	Правило простое:\n\nI / You / We / They + глагол в обычной форме\n\nHe / She / It + глагол + -s / -es	1	2025-12-21 13:20:37.35672+03
154	present_simple	Отрицания	Чтобы сказать, что что-то не происходит, используем do not / does not:\n\nI / You / We / They → do not (don't) + глагол\n\nHe / She / It → does not (doesn't) + глагол	2	2025-12-21 13:20:37.35672+03
155	present_simple	Вопросы	Чтобы спросить, что кто-то делает обычно, меняем порядок:\n\nDo + I/you/we/they + глагол?\n\nDoes + he/she/it + глагол?	3	2025-12-21 13:20:37.35672+03
156	present_simple	Наречия частоты	Наречия частоты показывают как часто что-то происходит:\n\nalways (всегда)\nusually (обычно)\noften (часто)\nsometimes (иногда)\nnever (никогда)\n\nПоложение в предложении:	4	2025-12-21 13:20:37.35672+03
157	present_simple	Типичные ошибки русскоговорящих	Самые частые ошибки при использовании Present Simple.	5	2025-12-21 13:20:37.35672+03
158	present_simple	Главное про Present Simple	Ключевые моменты, которые нужно запомнить:	6	2025-12-21 13:20:37.35672+03
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: doc
--

COPY public.topics (id, title, description, difficulty, total_questions, display_order, created_at, updated_at) FROM stdin;
greetings-introductions	Существительные	Исчисляемые и неисчисляемые существительные, множественное число	beginner	8	1	2025-12-19 01:39:11.713953+03	2025-12-20 02:55:44.391857+03
alphabet-pronunciation	Закладываем фундамент	Базовые принципы английского языка: структура, глаголы и конструкции	beginner	14	0	2025-12-19 01:39:11.713953+03	2025-12-19 02:31:31.784783+03
articles	Артикли	Артикли a, an, the и нулевой артикль	beginner	200	2	2025-12-19 01:39:11.713953+03	2025-12-20 02:57:21.27753+03
adjectives	Прилагательные	Позиция прилагательных, степени сравнения и формы	beginner	200	4	2025-12-20 16:07:48.063538+03	2025-12-20 16:17:42.675045+03
to_be	Глагол to be	Глагол to be (am/is/are) - самый базовый глагол английского языка	beginner	173	5	2025-12-21 13:08:53.039059+03	2025-12-21 13:15:44.289097+03
present_simple	Present Simple	Настоящее простое время - факты, привычки и рутина	beginner	200	6	2025-12-21 13:20:37.35672+03	2025-12-21 13:20:37.35672+03
modal_verbs	Модальные глаголы	Can, must, should - модальные глаголы для выражения способности, необходимости и совета	beginner	200	7	2025-12-21 17:04:33.156028+03	2025-12-21 17:04:33.156028+03
there_is_are	There is / There are	Конструкция для описания наличия предметов и людей	beginner	200	8	2025-12-21 17:04:34.081445+03	2025-12-21 17:04:34.081445+03
prepositions_place	Предлоги места	Предлоги in, on, under, next to, between для описания местоположения	beginner	200	9	2025-12-21 17:04:34.354873+03	2025-12-21 17:04:34.354873+03
question_words	Вопросительные слова	What, where, who, when, why, how - основные вопросительные слова	beginner	200	10	2025-12-21 17:04:34.76891+03	2025-12-21 17:04:34.76891+03
numbers_dates_time	Числа, даты и время	Как называть числа, даты и время по-английски	beginner	200	11	2025-12-21 17:04:35.050243+03	2025-12-21 17:04:35.050243+03
pronouns	Местоимения	Личные, объектные, притяжательные и указательные местоимения	beginner	200	3	2025-12-20 02:47:47.051181+03	2025-12-20 02:52:53.760212+03
present_continuous	Present Continuous	Настоящее продолженное время для действий, происходящих сейчас	beginner	200	12	2025-12-21 17:04:35.311167+03	2025-12-21 17:04:35.311167+03
future_simple	Future Simple (Will)	Будущее простое время — предсказания, обещания, спонтанные решения	beginner	174	14	2025-12-23 01:55:47.922637+03	2025-12-23 01:55:47.922637+03
\.


--
-- Name: question_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doc
--

SELECT pg_catalog.setval('public.question_options_id_seq', 25236, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doc
--

SELECT pg_catalog.setval('public.questions_id_seq', 6311, true);


--
-- Name: rule_examples_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doc
--

SELECT pg_catalog.setval('public.rule_examples_id_seq', 2403, true);


--
-- Name: rule_sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doc
--

SELECT pg_catalog.setval('public.rule_sections_id_seq', 297, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: question_options question_options_pkey; Type: CONSTRAINT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.question_options
    ADD CONSTRAINT question_options_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: rule_examples rule_examples_pkey; Type: CONSTRAINT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.rule_examples
    ADD CONSTRAINT rule_examples_pkey PRIMARY KEY (id);


--
-- Name: rule_sections rule_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.rule_sections
    ADD CONSTRAINT rule_sections_pkey PRIMARY KEY (id);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: ix_question_options_question_id; Type: INDEX; Schema: public; Owner: doc
--

CREATE INDEX ix_question_options_question_id ON public.question_options USING btree (question_id);


--
-- Name: ix_questions_topic_id; Type: INDEX; Schema: public; Owner: doc
--

CREATE INDEX ix_questions_topic_id ON public.questions USING btree (topic_id);


--
-- Name: ix_rule_examples_rule_section_id; Type: INDEX; Schema: public; Owner: doc
--

CREATE INDEX ix_rule_examples_rule_section_id ON public.rule_examples USING btree (rule_section_id);


--
-- Name: ix_rule_sections_topic_id; Type: INDEX; Schema: public; Owner: doc
--

CREATE INDEX ix_rule_sections_topic_id ON public.rule_sections USING btree (topic_id);


--
-- Name: ix_topics_difficulty; Type: INDEX; Schema: public; Owner: doc
--

CREATE INDEX ix_topics_difficulty ON public.topics USING btree (difficulty);


--
-- Name: ix_topics_display_order; Type: INDEX; Schema: public; Owner: doc
--

CREATE INDEX ix_topics_display_order ON public.topics USING btree (display_order);


--
-- Name: question_options question_options_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.question_options
    ADD CONSTRAINT question_options_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: questions questions_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON DELETE CASCADE;


--
-- Name: rule_examples rule_examples_rule_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.rule_examples
    ADD CONSTRAINT rule_examples_rule_section_id_fkey FOREIGN KEY (rule_section_id) REFERENCES public.rule_sections(id) ON DELETE CASCADE;


--
-- Name: rule_sections rule_sections_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doc
--

ALTER TABLE ONLY public.rule_sections
    ADD CONSTRAINT rule_sections_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict y9Ab7PPSdpRX6KIPHLfHGQt8tzsRgRgldeCkjK0jqFN8hIqFgcB3IaT1OepKHJF

