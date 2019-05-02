use api;

CREATE OR REPLACE function state_groupby_date_and_count(state map<text, int>, dtime timestamp)
    called on null input
    returns map<text, int>
    language java as
    '
      java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
      String date = sdf.format(dtime);
      Integer count = (Integer) state.get(date);
      if (count == null) count = 1;
      else count++;
      state.put(date, count);
      return state; ';

CREATE OR REPLACE aggregate groupby_date_and_count(timestamp)
    sfunc state_groupby_date_and_count
    stype map<text, int>
    initcond {};

CREATE OR REPLACE function state_groupby_date_and_count(state map<text, int>, date date)
    called on null input
    returns map<text, int>
    language java as
    '
      Integer count = (Integer) state.get(date.toString());
      if (count == null) count = 1;
      else count++;
      state.put(date.toString(), count);
      return state; ';

CREATE OR REPLACE aggregate groupby_date_and_count(date)
    sfunc state_groupby_date_and_count
    stype map<text, int>
    initcond {};


CREATE OR REPLACE function state_groupby_hour_and_count(state map<text, int>, dtime timestamp)
    called on null input
    returns map<text, int>
    language java as
    '
      java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:00:00");
      String date = sdf.format(dtime);
      Integer count = (Integer) state.get(date);
      if (count == null) count = 1;
      else count++;
      state.put(date, count);
      return state; ';

CREATE OR REPLACE aggregate groupby_hour_and_count(timestamp)
    sfunc state_groupby_hour_and_count
    stype map<text, int>
    initcond {};








select groupby_date_and_count(dataplatformcreationdate) from product;
select groupby_date_and_count(day) from api.sitedaily;





use api;
CREATE OR REPLACE FUNCTION ts2datestr ( input timestamp )
RETURNS NULL ON NULL INPUT
RETURNS text
LANGUAGE java
AS '
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:00:00");
		return sdf.format(input);
';

select dataplatformcreationdate, ts2datestr(dataplatformcreationdate) from product;


create materialized view api.sitedailyview
AS SELECT clientid, siteid, day
FROM api.sitedaily
WHERE clientid IS NOT NULL AND siteid IS NOT NULL AND day IS NOT NULL
PRIMARY KEY (clientid, siteid, day);

select clientid, siteid, day, count(*) from api.sitedailyview group by clientid, siteid, day
