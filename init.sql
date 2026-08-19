-- Initial database schema for the game project
-- This script runs automatically when PostgreSQL container starts for the first time

-- Enable UUID extension for generating unique IDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table: stores user accounts
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Levels table: stores game levels created by users
CREATE TABLE levels (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(100) NOT NULL,
    grid_json JSONB NOT NULL,
    difficulty VARCHAR(20) CHECK (difficulty IN ('easy', 'medium', 'hard', 'expert')),
    created_by UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Runs table: stores game playthroughs/runs by users on levels
CREATE TABLE runs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    level_id UUID NOT NULL REFERENCES levels(id) ON DELETE CASCADE,
    completion_time_ms BIGINT NOT NULL,
    deaths INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for common query patterns
CREATE INDEX idx_runs_user_id ON runs(user_id);
CREATE INDEX idx_runs_level_id ON runs(level_id);
CREATE INDEX idx_runs_created_at ON runs(created_at);
CREATE INDEX idx_levels_created_by ON levels(created_by);
CREATE INDEX idx_levels_difficulty ON levels(difficulty);

-- Comments for documentation
COMMENT ON TABLE users IS 'Stores user account information';
COMMENT ON TABLE levels IS 'Stores game levels with grid data in JSON format';
COMMENT ON TABLE runs IS 'Stores individual game run/playthrough records';
COMMENT ON COLUMN levels.grid_json IS 'Level grid layout stored as JSONB for flexible structure';
COMMENT ON COLUMN runs.completion_time_ms IS 'Time to complete level in milliseconds';
COMMENT ON COLUMN runs.deaths IS 'Number of deaths during the run';