-- Create the core database schemas for the AFL project

CREATE SCHEMA IF NOT EXISTS raw
AUTHORIZATION afl_app;

CREATE SCHEMA IF NOT EXISTS staging
AUTHORIZATION afl_app;

CREATE SCHEMA IF NOT EXISTS analytics
AUTHORIZATION afl_app;