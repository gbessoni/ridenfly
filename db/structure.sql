--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: airports; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE airports (
    id integer NOT NULL,
    name character varying(255),
    street_address character varying(255),
    city character varying(255),
    state character varying(2),
    zipcode character varying(5),
    code character varying(3),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: airports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE airports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: airports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE airports_id_seq OWNED BY airports.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE companies (
    id integer NOT NULL,
    user_id integer,
    name character varying(255),
    contact_first_name character varying(255),
    contact_last_name character varying(255),
    street character varying(255),
    state character varying(255),
    zipcode character varying(255),
    phone character varying(255),
    mobile character varying(255),
    dispatch_phone character varying(255),
    website character varying(255),
    description text,
    reservation_notification hstore,
    blackout_dates text,
    airports text,
    hours_of_operation character varying(255),
    hours_in_advance_to_accept_rez character varying(255),
    pickup_info text,
    after_hours_info text,
    excess_luggage_charge character varying(255),
    luggage_insured boolean DEFAULT false,
    child_rate character varying(255),
    child_car_seats_included boolean DEFAULT false,
    luggage_limitation_policy text,
    company_reservation_policy text,
    company_cancellation_policy text,
    child_safety_policy text,
    pet_car_seat_policy text,
    other_vehicle_types text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    vehicle_types hstore[],
    fax character varying(255),
    city character varying(255),
    active boolean DEFAULT true,
    image_file_name character varying(255),
    image_content_type character varying(255),
    image_file_size integer,
    image_updated_at timestamp without time zone,
    no_pickup_message character varying
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE companies_id_seq OWNED BY companies.id;


--
-- Name: oauth_access_grants; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE oauth_access_grants (
    id integer NOT NULL,
    resource_owner_id integer NOT NULL,
    application_id integer NOT NULL,
    token character varying(255) NOT NULL,
    expires_in integer NOT NULL,
    redirect_uri text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    scopes character varying(255)
);


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oauth_access_grants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE oauth_access_grants_id_seq OWNED BY oauth_access_grants.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE oauth_access_tokens (
    id integer NOT NULL,
    resource_owner_id integer,
    application_id integer,
    token character varying(255) NOT NULL,
    refresh_token character varying(255),
    expires_in integer,
    revoked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    scopes character varying(255)
);


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oauth_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE oauth_access_tokens_id_seq OWNED BY oauth_access_tokens.id;


--
-- Name: oauth_applications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE oauth_applications (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    redirect_uri text NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer,
    owner_type character varying(255)
);


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oauth_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE oauth_applications_id_seq OWNED BY oauth_applications.id;


--
-- Name: rate_pickup_times; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rate_pickup_times (
    id integer NOT NULL,
    pickup integer,
    rate_id integer
);


--
-- Name: rate_pickup_times_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rate_pickup_times_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rate_pickup_times_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rate_pickup_times_id_seq OWNED BY rate_pickup_times.id;


--
-- Name: rates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rates (
    id integer NOT NULL,
    airport_id integer,
    vehicle_type_passenger character varying(255),
    service_type character varying(255),
    base_rate numeric(8,2),
    additional_passenger numeric(8,2) DEFAULT 0.0,
    zipcode character varying(255),
    hotel_landmark_name character varying(255),
    hotel_landmark_street character varying(255),
    hotel_landmark_city character varying(255),
    hotel_landmark_state character varying(255),
    trip_duration integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    company_id integer,
    lat double precision,
    lng double precision,
    hl_words character varying(255),
    hotel_by_zipcode boolean DEFAULT false
);


--
-- Name: rates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rates_id_seq OWNED BY rates.id;


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE reservations (
    id integer NOT NULL,
    flight_datetime timestamp without time zone,
    pickup_datetime timestamp without time zone,
    passenger_name character varying(255),
    phone character varying(255),
    adults integer,
    net_fare numeric(8,2),
    gratuity numeric(8,2) DEFAULT 0.0,
    address character varying(255),
    cross_street character varying(255),
    airline character varying(255),
    luggage integer DEFAULT 0,
    cancelation_reason character varying(255),
    flight_number character varying(255),
    status character varying(255) DEFAULT 'active'::character varying,
    trip_direction character varying(255) DEFAULT 'to_airport'::character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    sibling_id integer,
    rate_id integer,
    children integer DEFAULT 0,
    email character varying(255),
    flight_type character varying(255) DEFAULT 'domestic'::character varying
);


--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE reservations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE reservations_id_seq OWNED BY reservations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    roles character varying(255) DEFAULT '[]'::character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY airports ALTER COLUMN id SET DEFAULT nextval('airports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies ALTER COLUMN id SET DEFAULT nextval('companies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth_access_grants ALTER COLUMN id SET DEFAULT nextval('oauth_access_grants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth_access_tokens ALTER COLUMN id SET DEFAULT nextval('oauth_access_tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth_applications ALTER COLUMN id SET DEFAULT nextval('oauth_applications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rate_pickup_times ALTER COLUMN id SET DEFAULT nextval('rate_pickup_times_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rates ALTER COLUMN id SET DEFAULT nextval('rates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY reservations ALTER COLUMN id SET DEFAULT nextval('reservations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: airports_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY airports
    ADD CONSTRAINT airports_pkey PRIMARY KEY (id);


--
-- Name: companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_grants_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oauth_applications
    ADD CONSTRAINT oauth_applications_pkey PRIMARY KEY (id);


--
-- Name: rate_pickup_times_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rate_pickup_times
    ADD CONSTRAINT rate_pickup_times_pkey PRIMARY KEY (id);


--
-- Name: rates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rates
    ADD CONSTRAINT rates_pkey PRIMARY KEY (id);


--
-- Name: reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_airports_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_airports_on_name ON airports USING btree (name);


--
-- Name: index_airports_on_state_and_code; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_airports_on_state_and_code ON airports USING btree (state, code);


--
-- Name: index_oauth_access_grants_on_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_grants_on_token ON oauth_access_grants USING btree (token);


--
-- Name: index_oauth_access_tokens_on_refresh_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_refresh_token ON oauth_access_tokens USING btree (refresh_token);


--
-- Name: index_oauth_access_tokens_on_resource_owner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_oauth_access_tokens_on_resource_owner_id ON oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: index_oauth_access_tokens_on_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_token ON oauth_access_tokens USING btree (token);


--
-- Name: index_oauth_applications_on_owner_id_and_owner_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_oauth_applications_on_owner_id_and_owner_type ON oauth_applications USING btree (owner_id, owner_type);


--
-- Name: index_oauth_applications_on_uid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_applications_on_uid ON oauth_applications USING btree (uid);


--
-- Name: index_rates_on_hl_words; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rates_on_hl_words ON rates USING btree (hl_words);


--
-- Name: index_rates_on_lat_and_lng; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rates_on_lat_and_lng ON rates USING gist (ll_to_earth(lat, lng));


--
-- Name: index_rates_on_vehicle_type_passenger; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rates_on_vehicle_type_passenger ON rates USING btree (vehicle_type_passenger);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: companies_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies
    ADD CONSTRAINT companies_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: rate_pickup_times_rate_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rate_pickup_times
    ADD CONSTRAINT rate_pickup_times_rate_id_fk FOREIGN KEY (rate_id) REFERENCES rates(id) ON DELETE CASCADE;


--
-- Name: rates_airport_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rates
    ADD CONSTRAINT rates_airport_id_fk FOREIGN KEY (airport_id) REFERENCES airports(id) ON DELETE CASCADE;


--
-- Name: rates_company_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rates
    ADD CONSTRAINT rates_company_id_fk FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE;


--
-- Name: reservations_rate_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY reservations
    ADD CONSTRAINT reservations_rate_id_fk FOREIGN KEY (rate_id) REFERENCES rates(id) ON DELETE CASCADE;


--
-- Name: reservations_sibling_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY reservations
    ADD CONSTRAINT reservations_sibling_id_fk FOREIGN KEY (sibling_id) REFERENCES reservations(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

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

