SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: boost_options; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE boost_options AS ENUM (
    'MASTO_BOOST_DO_NOT_POST',
    'MASTO_BOOST_POST_AS_LINK'
);


--
-- Name: masto_mention_options; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE masto_mention_options AS ENUM (
    'MASTO_MENTION_DO_NOT_POST'
);


--
-- Name: masto_reply_options; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE masto_reply_options AS ENUM (
    'MASTO_REPLY_DO_NOT_POST'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: authorizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE authorizations (
    id bigint NOT NULL,
    provider character varying,
    uid character varying,
    user_id integer,
    token character varying,
    secret character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: authorizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE authorizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE authorizations_id_seq OWNED BY authorizations.id;


--
-- Name: mastodon_clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mastodon_clients (
    id integer NOT NULL,
    domain character varying,
    client_id character varying,
    client_secret character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: mastodon_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mastodon_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mastodon_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mastodon_clients_id_seq OWNED BY mastodon_clients.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    last_toot integer,
    last_tweet bigint,
    twitter_last_check timestamp without time zone DEFAULT now(),
    mastodon_last_check timestamp without time zone DEFAULT now(),
    boost_options boost_options DEFAULT 'MASTO_BOOST_DO_NOT_POST'::boost_options,
    masto_reply_options masto_reply_options DEFAULT 'MASTO_REPLY_DO_NOT_POST'::masto_reply_options,
    masto_mention_options masto_mention_options DEFAULT 'MASTO_MENTION_DO_NOT_POST'::masto_mention_options,
    masto_should_post_private boolean DEFAULT false,
    masto_should_post_unlisted boolean DEFAULT false,
    posting_from_mastodon boolean DEFAULT false,
    posting_from_twitter boolean DEFAULT false,
    masto_fix_cross_mention boolean DEFAULT false
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
-- Name: authorizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY authorizations ALTER COLUMN id SET DEFAULT nextval('authorizations_id_seq'::regclass);


--
-- Name: mastodon_clients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mastodon_clients ALTER COLUMN id SET DEFAULT nextval('mastodon_clients_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: authorizations authorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY authorizations
    ADD CONSTRAINT authorizations_pkey PRIMARY KEY (id);


--
-- Name: mastodon_clients mastodon_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mastodon_clients
    ADD CONSTRAINT mastodon_clients_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_authorizations_on_provider_and_uid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_authorizations_on_provider_and_uid ON authorizations USING btree (provider, uid);


--
-- Name: index_mastodon_clients_on_domain; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_mastodon_clients_on_domain ON mastodon_clients USING btree (domain);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20170808112347'),
('20170808113938'),
('20170808114609'),
('20170809135336'),
('20170809151828'),
('20170810091710'),
('20170810094031'),
('20170810103418'),
('20170810105204'),
('20170810105214'),
('20170812195419'),
('20170817073406');

