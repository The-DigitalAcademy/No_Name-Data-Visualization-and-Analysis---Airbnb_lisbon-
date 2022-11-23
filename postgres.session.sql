
DROP TABLE IF EXISTS airbnb_lisbon CASCADE;
CREATE TABLE  airbnb_lisbon (
   room_id int primary key not null,
   survey_id int,
   host_id INT,
   room_type VARCHAR(55),
   country varchar(2),
   city varchar(222),
   borough varchar(2),
   neighborhood VARCHAR(55),
   reviews int ,
   overall_satisfaction float,
   accommodates INT,
   bedrooms int,
   bathrooms float,
   price float,
   minstay float,
   name VARCHAR(556) ,
   last_modified TIMESTAMP,
   latitude FLOAT,
   longitude float,
   location VARCHAR(1000)
);


COPY airbnb_lisbon
FROM '/Users/dslearner23/Downloads/airbnb_lisbon2.csv' 
CSV HEADER;