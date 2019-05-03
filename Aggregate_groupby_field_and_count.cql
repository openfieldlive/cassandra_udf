use mykeyspace;

-- Permet de compter le nombre d'item par groupés par un autre champ
-- Prend en entrée un champ de type text 
CREATE OR REPLACE function state_groupby_field_and_count(state map<text, int>, field text)
    called on null input
    returns map<text, int>
    language java as
    '
      Integer count = (Integer) state.get(field);
      if (count == null) count = 1;
      else count++;
      state.put(field, count);
      return state; ';

CREATE OR REPLACE aggregate groupby_field_and_count(timestamp)
    sfunc state_groupby_field_and_count
    stype map<text, int>
    initcond {};