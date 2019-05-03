use mykeyspace;

-- Permet de compter le nombre d'item par jour
-- Prend en entrée un champ de type DateTime 
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


-- Permet de compter le nombre d'item par jour
-- Prend en entrée un champ de type Date
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