--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5 (Ubuntu 11.5-3.pgdg18.04+1)
-- Dumped by pg_dump version 11.5 (Ubuntu 11.5-3.pgdg18.04+1)

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
-- Name: cube; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


--
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;


--
-- Name: EXTENSION earthdistance; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: airports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.airports (
    id integer NOT NULL,
    name character varying,
    street_address character varying,
    city character varying,
    state character varying(2),
    zipcode character varying(5),
    code character varying(3),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    timezone character varying
);


--
-- Name: airports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.airports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: airports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.airports_id_seq OWNED BY public.airports.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies (
    id integer NOT NULL,
    user_id integer,
    name character varying,
    contact_first_name character varying,
    contact_last_name character varying,
    street character varying,
    state character varying,
    zipcode character varying,
    phone character varying,
    mobile character varying,
    dispatch_phone character varying,
    website character varying,
    description text,
    reservation_notification public.hstore,
    blackout_dates text,
    airports text,
    hours_of_operation character varying,
    hours_in_advance_to_accept_rez character varying,
    pickup_info text,
    after_hours_info text,
    excess_luggage_charge character varying,
    luggage_insured boolean DEFAULT false,
    child_rate character varying,
    child_car_seats_included boolean DEFAULT false,
    luggage_limitation_policy text,
    company_reservation_policy text,
    company_cancellation_policy text,
    child_safety_policy text,
    pet_car_seat_policy text,
    other_vehicle_types text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    vehicle_types public.hstore[],
    fax character varying,
    city character varying,
    active boolean DEFAULT true,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size integer,
    image_updated_at timestamp without time zone,
    no_pickup_message character varying,
    active_to_airport boolean DEFAULT true,
    active_from_airport boolean DEFAULT true,
    commission numeric(8,2) DEFAULT 0.0,
    payment_type character varying,
    airport_pickup_fee numeric(8,2) DEFAULT 0.0,
    confirmation_emails character varying
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: company_vehicle_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_vehicle_types (
    id integer NOT NULL,
    company_id integer,
    name character varying,
    how_many character varying,
    num_of_passengers integer
);


--
-- Name: company_vehicle_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_vehicle_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_vehicle_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_vehicle_types_id_seq OWNED BY public.company_vehicle_types.id;


--
-- Name: oauth_access_grants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_access_grants (
    id integer NOT NULL,
    resource_owner_id integer NOT NULL,
    application_id integer NOT NULL,
    token character varying NOT NULL,
    expires_in integer NOT NULL,
    redirect_uri text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    scopes character varying
);


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_access_grants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_access_grants_id_seq OWNED BY public.oauth_access_grants.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_access_tokens (
    id integer NOT NULL,
    resource_owner_id integer,
    application_id integer,
    token character varying NOT NULL,
    refresh_token character varying,
    expires_in integer,
    revoked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    scopes character varying
);


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_access_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_access_tokens_id_seq OWNED BY public.oauth_access_tokens.id;


--
-- Name: oauth_applications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_applications (
    id integer NOT NULL,
    name character varying NOT NULL,
    uid character varying NOT NULL,
    secret character varying NOT NULL,
    redirect_uri text NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer,
    owner_type character varying
);


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_applications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_applications_id_seq OWNED BY public.oauth_applications.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    company_id integer,
    "from" timestamp without time zone,
    "to" timestamp without time zone,
    amount numeric(8,2),
    paid boolean DEFAULT false,
    net_commission numeric(8,2),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: rate_pickup_times; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rate_pickup_times (
    id integer NOT NULL,
    pickup integer,
    rate_id integer,
    direction character varying DEFAULT 'to_airport'::character varying
);


--
-- Name: rate_pickup_times_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rate_pickup_times_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rate_pickup_times_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rate_pickup_times_id_seq OWNED BY public.rate_pickup_times.id;


--
-- Name: rates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rates (
    id integer NOT NULL,
    airport_id integer,
    vehicle_type_passenger character varying,
    service_type character varying,
    base_rate numeric(8,2),
    additional_passenger numeric(8,2) DEFAULT 0.0,
    zipcode character varying,
    hotel_landmark_name character varying,
    hotel_landmark_street character varying,
    hotel_landmark_city character varying,
    hotel_landmark_state character varying,
    trip_duration integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    company_id integer,
    lat double precision,
    lng double precision,
    hl_words character varying,
    hotel_by_zipcode boolean DEFAULT false,
    vehicle_capacity_type_id integer
);


--
-- Name: rates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rates_id_seq OWNED BY public.rates.id;


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reservations (
    id integer NOT NULL,
    flight_datetime timestamp without time zone,
    pickup_datetime timestamp without time zone,
    passenger_name character varying,
    phone character varying,
    adults integer,
    net_fare numeric(8,2),
    gratuity numeric(8,2) DEFAULT 0.0,
    address character varying,
    cross_street character varying,
    airline character varying,
    luggage integer DEFAULT 0,
    cancelation_reason character varying,
    flight_number character varying,
    status character varying DEFAULT 'active'::character varying,
    trip_direction character varying DEFAULT 'to_airport'::character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    sibling_id integer,
    rate_id integer,
    children integer DEFAULT 0,
    email character varying,
    flight_type character varying DEFAULT 'domestic'::character varying,
    additional_notes character varying,
    sub_status character varying,
    notes character varying
);


--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reservations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reservations_id_seq OWNED BY public.reservations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    roles character varying DEFAULT '[]'::character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: airports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.airports ALTER COLUMN id SET DEFAULT nextval('public.airports_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: company_vehicle_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_vehicle_types ALTER COLUMN id SET DEFAULT nextval('public.company_vehicle_types_id_seq'::regclass);


--
-- Name: oauth_access_grants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_grants ALTER COLUMN id SET DEFAULT nextval('public.oauth_access_grants_id_seq'::regclass);


--
-- Name: oauth_access_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.oauth_access_tokens_id_seq'::regclass);


--
-- Name: oauth_applications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_applications ALTER COLUMN id SET DEFAULT nextval('public.oauth_applications_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: rate_pickup_times id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_pickup_times ALTER COLUMN id SET DEFAULT nextval('public.rate_pickup_times_id_seq'::regclass);


--
-- Name: rates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rates ALTER COLUMN id SET DEFAULT nextval('public.rates_id_seq'::regclass);


--
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: airports airports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.airports
    ADD CONSTRAINT airports_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: company_vehicle_types company_vehicle_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_vehicle_types
    ADD CONSTRAINT company_vehicle_types_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_grants oauth_access_grants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_applications oauth_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_applications
    ADD CONSTRAINT oauth_applications_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: rate_pickup_times rate_pickup_times_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_pickup_times
    ADD CONSTRAINT rate_pickup_times_pkey PRIMARY KEY (id);


--
-- Name: rates rates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rates
    ADD CONSTRAINT rates_pkey PRIMARY KEY (id);


--
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_airports_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_airports_on_name ON public.airports USING btree (name);


--
-- Name: index_airports_on_state_and_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_airports_on_state_and_code ON public.airports USING btree (state, code);


--
-- Name: index_company_vehicle_types_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_vehicle_types_on_company_id ON public.company_vehicle_types USING btree (company_id);


--
-- Name: index_company_vehicle_types_on_num_of_passengers; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_vehicle_types_on_num_of_passengers ON public.company_vehicle_types USING btree (num_of_passengers);


--
-- Name: index_oauth_access_grants_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_grants_on_token ON public.oauth_access_grants USING btree (token);


--
-- Name: index_oauth_access_tokens_on_refresh_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_refresh_token ON public.oauth_access_tokens USING btree (refresh_token);


--
-- Name: index_oauth_access_tokens_on_resource_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_access_tokens_on_resource_owner_id ON public.oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: index_oauth_access_tokens_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_token ON public.oauth_access_tokens USING btree (token);


--
-- Name: index_oauth_applications_on_owner_id_and_owner_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_applications_on_owner_id_and_owner_type ON public.oauth_applications USING btree (owner_id, owner_type);


--
-- Name: index_oauth_applications_on_uid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_applications_on_uid ON public.oauth_applications USING btree (uid);


--
-- Name: index_rates_on_hl_words; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rates_on_hl_words ON public.rates USING btree (hl_words);


--
-- Name: index_rates_on_lat_and_lng; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rates_on_lat_and_lng ON public.rates USING gist (public.ll_to_earth(lat, lng));


--
-- Name: index_rates_on_vehicle_capacity_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rates_on_vehicle_capacity_type_id ON public.rates USING btree (vehicle_capacity_type_id);


--
-- Name: index_rates_on_vehicle_type_passenger; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rates_on_vehicle_type_passenger ON public.rates USING btree (vehicle_type_passenger);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON public.schema_migrations USING btree (version);


--
-- Name: companies companies_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_user_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: company_vehicle_types company_vehicle_types_company_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_vehicle_types
    ADD CONSTRAINT company_vehicle_types_company_id_fk FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: payments payments_company_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_company_id_fk FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: rate_pickup_times rate_pickup_times_rate_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_pickup_times
    ADD CONSTRAINT rate_pickup_times_rate_id_fk FOREIGN KEY (rate_id) REFERENCES public.rates(id) ON DELETE CASCADE;


--
-- Name: rates rates_airport_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rates
    ADD CONSTRAINT rates_airport_id_fk FOREIGN KEY (airport_id) REFERENCES public.airports(id) ON DELETE CASCADE;


--
-- Name: rates rates_company_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rates
    ADD CONSTRAINT rates_company_id_fk FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: reservations reservations_rate_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_rate_id_fk FOREIGN KEY (rate_id) REFERENCES public.rates(id) ON DELETE CASCADE;


--
-- Name: reservations reservations_sibling_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_sibling_id_fk FOREIGN KEY (sibling_id) REFERENCES public.reservations(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20141031075156');

INSERT INTO schema_migrations (version) VALUES ('20141031100627');

INSERT INTO schema_migrations (version) VALUES ('20141104104401');

INSERT INTO schema_migrations (version) VALUES ('20141104124720');

INSERT INTO schema_migrations (version) VALUES ('20141104125523');

INSERT INTO schema_migrations (version) VALUES ('20141105131018');

INSERT INTO schema_migrations (version) VALUES ('20141106064252');

INSERT INTO schema_migrations (version) VALUES ('20141106070422');

INSERT INTO schema_migrations (version) VALUES ('20141106093634');

INSERT INTO schema_migrations (version) VALUES ('20141107095629');

INSERT INTO schema_migrations (version) VALUES ('20141107114735');

INSERT INTO schema_migrations (version) VALUES ('20141107115423');

INSERT INTO schema_migrations (version) VALUES ('20141107115732');

INSERT INTO schema_migrations (version) VALUES ('20141112131542');

INSERT INTO schema_migrations (version) VALUES ('20141113134701');

INSERT INTO schema_migrations (version) VALUES ('20141117084801');

INSERT INTO schema_migrations (version) VALUES ('20141117100217');

INSERT INTO schema_migrations (version) VALUES ('20141124110316');

INSERT INTO schema_migrations (version) VALUES ('20141124120835');

INSERT INTO schema_migrations (version) VALUES ('20141125084912');

INSERT INTO schema_migrations (version) VALUES ('20141125090603');

INSERT INTO schema_migrations (version) VALUES ('20141125130046');

INSERT INTO schema_migrations (version) VALUES ('20141126130818');

INSERT INTO schema_migrations (version) VALUES ('20141127114236');

INSERT INTO schema_migrations (version) VALUES ('20141127141636');

INSERT INTO schema_migrations (version) VALUES ('20141128070054');

INSERT INTO schema_migrations (version) VALUES ('20141128085631');

INSERT INTO schema_migrations (version) VALUES ('20141201072743');

INSERT INTO schema_migrations (version) VALUES ('20141210133743');

INSERT INTO schema_migrations (version) VALUES ('20141216110314');

INSERT INTO schema_migrations (version) VALUES ('20150112125329');

INSERT INTO schema_migrations (version) VALUES ('20150114122912');

INSERT INTO schema_migrations (version) VALUES ('20150323132328');

INSERT INTO schema_migrations (version) VALUES ('20150421113308');

INSERT INTO schema_migrations (version) VALUES ('20150505124513');

INSERT INTO schema_migrations (version) VALUES ('20150720064254');

INSERT INTO schema_migrations (version) VALUES ('20150720120031');

INSERT INTO schema_migrations (version) VALUES ('20150810095448');

INSERT INTO schema_migrations (version) VALUES ('20160310083752');

INSERT INTO schema_migrations (version) VALUES ('20190302165152');

INSERT INTO schema_migrations (version) VALUES ('20190303114352');

INSERT INTO schema_migrations (version) VALUES ('20190408013011');

INSERT INTO schema_migrations (version) VALUES ('20190408020411');

INSERT INTO schema_migrations (version) VALUES ('20190527142211');

INSERT INTO schema_migrations (version) VALUES ('20190527164811');

INSERT INTO schema_migrations (version) VALUES ('20191213141600');

INSERT INTO schema_migrations (version) VALUES ('20200108055948');

