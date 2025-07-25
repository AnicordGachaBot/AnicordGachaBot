BEGIN;

CREATE TABLE IF NOT EXISTS Errors (
    id SERIAL PRIMARY KEY,
    command TEXT NOT NULL,
    user_id BIGINT NOT NULL,
    guild BIGINT,
    error TEXT NOT NULL,
    full_error TEXT NOT NULL,
    message_url TEXT NOT NULL,
    occured_when TIMESTAMP NOT NULL,
    fixed BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS ErrorReminders (
    id BIGINT references Errors (id),
    user_id BIGINT NOT NULL,
    PRIMARY KEY (id, user_id)
);

CREATE TABLE IF NOT EXISTS Feature (
    feature_type FeatureTypes NOT NULL,
    user_id BIGINT,
    guild_id BIGINT,
    allowed BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS Timers (
    id SERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    reserved_type INTEGER,
    expires TIMESTAMP WITH TIME ZONE NOT NULL,
    data JSONB
);

COMMIT;

-- The tables above are for the bot base. They help the bot run its internals
-- The tables below are solely for Anicord Gacha.
BEGIN;

CREATE TABLE IF NOT EXISTS Cards (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    rarity INTEGER NOT NULL,
    theme TEXT NOT NULL,
    -- Basic properties
    is_obtainable BOOLEAN DEFAULT true,
    -- Image proprties
    -- Misc
    notes TEXT
);

CREATE TABLE IF NOT EXISTS CardInventory (
    user_id BIGINT NOT NULL,
    id INTEGER NOT NULL references Cards(id),
    is_locked BOOLEAN DEFAULT false,
    -- Shop
    shop_listing_id INTEGER,
    -- Misc
    notes TEXT
);

CREATE TABLE IF NOT EXISTS CardInventoryNotes (
    user_id BIGINT NOT NULL,
    id INTEGER NOT NULL,
    tag TEXT NOT NULL,
    PRIMARY KEY (user_id, id, tag)
);

COMMIT;
