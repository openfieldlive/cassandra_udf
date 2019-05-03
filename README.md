# cassandra_udf

Ce repository contient un ensemble de "User define function" permettant d'enrichir le comportement de cassandra.

# prerequis
Activez dans le fichier de configuration cassandra (cassandra.yaml) le parametre **enable_user_defined_functions**:

# Usage

```cql
select birthdate, timestamp_as_date_string(birthdate) from superheros;
```

```cql
select groupby_date_and_count(birthdate) from superheros;
```

# documentation officielle

https://docs.datastax.com/en/dse/6.0/cql/cql/cql_using/useCreateUDF.html