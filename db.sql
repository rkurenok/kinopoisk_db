CREATE TABLE film
(
    film_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    title text NOT NULL,
    creation_year integer NOT NULL,
    slogan text,
    budget numeric,
    marketing numeric,
    fees_usa numeric,
    fees_world numeric,
    dvd_release date,
    age_limit smallint NOT NULL,
    mpaa_ration text,
    duration time without time zone NOT NULL,
    CONSTRAINT film_pkey PRIMARY KEY (film_id)
);

CREATE TABLE genre
(
    genre_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    title text NOT NULL,
    CONSTRAINT genre_pkey PRIMARY KEY (genre_id)
);

CREATE TABLE film_genre 
(
	film_id bigint NOT NULL REFERENCES film(film_id),
	genre_id bigint NOT NULL REFERENCES genre(genre_id),
	CONSTRAINT film_genre_pk PRIMARY KEY (film_id, genre_id)
);

CREATE TABLE country
(
    country_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    title text NOT NULL,
    CONSTRAINT country_pkey PRIMARY KEY (country_id)
);

CREATE TABLE film_country 
(
	film_id bigint NOT NULL REFERENCES film(film_id),
	country_id bigint NOT NULL REFERENCES country(country_id),
	CONSTRAINT film_country_pk PRIMARY KEY (film_id, country_id)
);

CREATE TABLE viewer 
(
	viewer_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
	country_id bigint NOT NULL REFERENCES country(country_id),
	count_viewers numeric,
	film_id bigint NOT NULL REFERENCES film(film_id),
	CONSTRAINT viewer_pkey PRIMARY KEY (viewer_id)
);

CREATE TABLE person
(
    person_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    first_name text NOT NULL,
    last_name text NOT NULL,
    CONSTRAINT person_pkey PRIMARY KEY (person_id)
);

CREATE TABLE film_person 
(
	film_id bigint NOT NULL REFERENCES film(film_id),
	person_id bigint NOT NULL REFERENCES person(person_id),
	starring boolean NOT NULL DEFAULT false,
	understudy boolean NOT NULL DEFAULT false,
	CONSTRAINT film_person_pk PRIMARY KEY (film_id, person_id)
);

CREATE TABLE premiere
(
    premiere_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    country_id bigint NOT NULL,
    film_id bigint NOT NULL,
    premiere_date date NOT NULL,
    CONSTRAINT premiere_pkey PRIMARY KEY (premiere_id),
    CONSTRAINT country_id_fkey FOREIGN KEY (country_id)
        REFERENCES country (country_id),
    CONSTRAINT film_id_fkey FOREIGN KEY (film_id)
        REFERENCES film (film_id)
);

ALTER TABLE film ADD COLUMN film_director bigint NOT NULL;
ALTER TABLE film ADD CONSTRAINT film_director_fkey FOREIGN KEY (film_director)
    REFERENCES person (person_id);
ALTER TABLE film ADD COLUMN screenwriter bigint NOT NULL;
ALTER TABLE film ADD CONSTRAINT screenwriter_fkey FOREIGN KEY (screenwriter)
    REFERENCES person (person_id);
ALTER TABLE film ADD COLUMN producer bigint NOT NULL;
ALTER TABLE film ADD CONSTRAINT producer_fkey FOREIGN KEY (producer)
    REFERENCES person (person_id);
ALTER TABLE film ADD COLUMN film_operator bigint NOT NULL;
ALTER TABLE film ADD CONSTRAINT film_operator_fkey FOREIGN KEY (operator)
    REFERENCES person (person_id);
ALTER TABLE film ADD COLUMN composer bigint NOT NULL;
ALTER TABLE film ADD CONSTRAINT composer_fkey FOREIGN KEY (composer)
    REFERENCES person (person_id);
ALTER TABLE film ADD COLUMN artist bigint NOT NULL;
ALTER TABLE film ADD CONSTRAINT artist_fkey FOREIGN KEY (artist)
    REFERENCES person (person_id);
ALTER TABLE film ADD COLUMN film_editor bigint NOT NULL;
ALTER TABLE film ADD CONSTRAINT film_editor_fkey FOREIGN KEY (film_editor)
    REFERENCES person (person_id);