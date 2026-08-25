-- Create the PostgreSQL tables for the prepared AFL project data.


-- One record per standardised AFL team.
CREATE TABLE IF NOT EXISTS staging.team_reference (
    team_id SMALLINT PRIMARY KEY,
    team_name TEXT NOT NULL UNIQUE,
    team_abbreviation TEXT NOT NULL UNIQUE
);


-- One record per standardised match venue.
CREATE TABLE IF NOT EXISTS staging.venue_reference (
    venue_name TEXT PRIMARY KEY,
    venue_city TEXT NOT NULL,
    state_code TEXT,
    country_code TEXT NOT NULL,
    school_holiday_city TEXT
);


-- One record per capital city and calendar date.
CREATE TABLE IF NOT EXISTS staging.school_holidays_daily (
    city TEXT NOT NULL,
    state_code TEXT NOT NULL,
    calendar_date DATE NOT NULL,
    is_school_holiday BOOLEAN NOT NULL,
    source_name TEXT NOT NULL,

    PRIMARY KEY (city, calendar_date)
);


-- One record per completed historical AFL match.
CREATE TABLE IF NOT EXISTS staging.historical_matches (
    match_id TEXT PRIMARY KEY,
    source_game_id TEXT NOT NULL,
    season_year SMALLINT NOT NULL,
    source_round_label TEXT NOT NULL,
    round_label TEXT NOT NULL,
    match_date DATE NOT NULL,
    start_time TIME NOT NULL,
    home_team_id SMALLINT NOT NULL,
    home_team TEXT NOT NULL,
    away_team_id SMALLINT NOT NULL,
    away_team TEXT NOT NULL,
    venue_name TEXT NOT NULL,
    venue_city TEXT NOT NULL,
    state_code TEXT,
    country_code TEXT NOT NULL,
    school_holiday_city TEXT,
    attendance INTEGER NOT NULL,
    home_score INTEGER NOT NULL,
    away_score INTEGER NOT NULL,

    FOREIGN KEY (home_team_id)
        REFERENCES staging.team_reference (team_id),

    FOREIGN KEY (away_team_id)
        REFERENCES staging.team_reference (team_id),

    FOREIGN KEY (venue_name)
        REFERENCES staging.venue_reference (venue_name)
);


-- One record per Squiggle match and API snapshot.
CREATE TABLE IF NOT EXISTS staging.squiggle_matches_2026_snapshot (
    match_id TEXT,
    source_game_id INTEGER NOT NULL,
    snapshot_date DATE NOT NULL,
    season_year SMALLINT NOT NULL,
    round_number SMALLINT NOT NULL,
    round_label TEXT NOT NULL,
    source_datetime TIMESTAMP,
    source_local_datetime TIMESTAMP,
    source_utc_offset TEXT,
    source_unix_time BIGINT,
    source_home_team_id SMALLINT,
    source_home_team TEXT,
    source_away_team_id SMALLINT,
    source_away_team TEXT,
    source_venue_name TEXT,
    completion_percentage SMALLINT NOT NULL,
    finals_type_code SMALLINT NOT NULL,
    source_home_score INTEGER,
    source_away_score INTEGER,
    source_updated_at TIMESTAMP,
    home_team_id SMALLINT,
    home_team TEXT,
    away_team_id SMALLINT,
    away_team TEXT,
    venue_name TEXT,
    venue_city TEXT,
    state_code TEXT,
    country_code TEXT,
    school_holiday_city TEXT,
    match_datetime_utc TIMESTAMPTZ,
    match_date DATE NOT NULL,
    start_time TIME NOT NULL,
    completion_status TEXT NOT NULL,
    home_score INTEGER,
    away_score INTEGER,
    is_finals_match BOOLEAN NOT NULL,
    snapshot_record_type TEXT NOT NULL,

    PRIMARY KEY (snapshot_date, source_game_id),

    FOREIGN KEY (home_team_id)
        REFERENCES staging.team_reference (team_id),

    FOREIGN KEY (away_team_id)
        REFERENCES staging.team_reference (team_id),

    FOREIGN KEY (venue_name)
        REFERENCES staging.venue_reference (venue_name)
);