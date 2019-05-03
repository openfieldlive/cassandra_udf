use mykeyspace;

-- Permet de compter le nombre d'item par heure
-- Prend en entrée un champ de type DateTime 

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

