# cassandra_udf

Ce repository contient un ensemble de "User define function" permettant d'enrichir le comportement de cassandra.

# Usage

```cql
select birthdate, timestamp_as_date_string(birthdate) from superheros;
```

```cql
select groupby_date_and_count(birthdate) from superheros;
```