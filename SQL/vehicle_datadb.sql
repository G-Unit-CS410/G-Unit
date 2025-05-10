CREATE TABLE IF NOT EXISTS vehicle_models (
        MAKE_ID INT,
        MAKE_NAME VARCHAR(255),
        MODEL_ID INT,
        MODEL_NAME VARCHAR(255),
        PRIMARY KEY (MAKE_ID, MODEL_ID)
    );
-- create table if not exists vehicle_models (
--     make_id int, -- integer id for the vehicle make
--     make_name varchar(255), -- name of the vehicle make, up to 255 characters
--     model_id int, -- integer id for the vehicle model
--     model_name varchar(255), -- name of the vehicle model, up to 255 characters
--     primary key (make_id, model_id) -- composite primary key to ensure each make and model combination is unique
-- );


-- ? create table for model years if it doesn't already exist
CREATE TABLE IF NOT EXISTS vehicle_model_years (
        MAKE_ID INT,
        MODEL_ID INT,
        YEAR VARCHAR(4),
        PRIMARY KEY (MAKE_ID, MODEL_ID, YEAR),
        FOREIGN KEY (MAKE_ID, MODEL_ID)
            REFERENCES vehicle_models (MAKE_ID, MODEL_ID)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );
-- create table if not exists vehicle_model_years (
--     make_id int, -- integer id for the vehicle make, should match the one in vehicle_models
--     model_id int, -- integer id for the vehicle model, should match the one in vehicle_models
--     year varchar(4), -- the model year as a string of 4 characters
--     primary key (make_id, model_id, year), -- composite primary key to ensure no duplicate year for the same model
--     foreign key (make_id, model_id) -- foreign key linking back to vehicle_models table
--         references vehicle_models (make_id, model_id)
--         on delete cascade, -- if a record in vehicle_models is deleted, related years are deleted automatically
--         on update cascade  -- if the keys in vehicle_models are updated, related years are updated automatically
-- );


-- ? create table for vehicle recalls if it doesn't already exist
CREATE TABLE IF NOT EXISTS vehicle_recall (
    id int auto_increment PRIMARY KEY,
    manufacturer varchar(255),
    nhtsa_campaign_number varchar(50),
    park_it boolean,
    park_outside boolean,
    over_the_air_update boolean,
    report_received_date date,
    component varchar(255),
    summary text,
    consequence text,
    remedy text,
    notes text,
    model_year varchar(10),
    make varchar(50),
    model varchar(50),
    make_id int,
    model_id int,
    FOREIGN KEY (make_id, model_id)
        REFERENCES vehicle_models (MAKE_ID, MODEL_ID)
        ON DELETE SET null ON UPDATE CASCADE
);
-- create table if not exists vehicle_recall (
--     id int auto_increment primary key,                  -- unique id for each recall record
--     manufacturer varchar(255),                           -- manufacturer name from the recall api
--     nhtsa_campaign_number varchar(50),                   -- recall campaign number from nhtsa
--     park_it boolean,                                     -- flag indicating if parkIt is true or false
--     park_outside boolean,                                -- flag indicating if parkOutSide is true or false
--     over_the_air_update boolean,                         -- flag indicating if overTheAirUpdate is true or false
--     report_received_date date,                           -- date the recall report was received (format: yyyy-mm-dd)
--     component varchar(255),                              -- affected component details
--     summary text,                                        -- detailed summary of the recall
--     consequence text,                                    -- description of the potential consequence
--     remedy text,                                         -- remedy information provided by the manufacturer
--     notes text,                                          -- additional notes and contact info
--     model_year varchar(10),                              -- model year of the affected vehicle
--     make varchar(50),                                    -- make of the affected vehicle (text)
--     model varchar(50),                                   -- model of the affected vehicle (text)
--     make_id int,                                         -- foreign key part 1: references vehicle_models.make_id
--     model_id int,                                        -- foreign key part 2: references vehicle_models.model_id
--     foreign key (make_id, model_id)                      -- establish link to vehicle_models table
--         references vehicle_models (MAKE_ID, MODEL_ID)
--         on delete set null on update cascade
-- );

CREATE TABLE vehicle_rate (
  id                     INT AUTO_INCREMENT PRIMARY KEY,
  make                   VARCHAR(50)  NOT NULL,
  model                  VARCHAR(50)  NOT NULL,
  model_year             VARCHAR(10)  NOT NULL,
  recall_count           INT          NOT NULL,
  rate_increase_percent  DECIMAL(5,2) NOT NULL,
  computed_at            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX(make, model, model_year)
);
