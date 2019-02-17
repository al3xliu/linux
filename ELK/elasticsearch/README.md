# Elasticsearch

## CRUD

### Create

```json
POST localhost:9200/accounts/person/1
{
    "name" : "John",
    "lastname" : "Doe",
    "job_description" : "Systems administrator and Linux specialit"
}
```

Run this command: `curl -H "Content-Type: application/json" -d '{"name":"John", "lastname":"Doe", "job_description":"Systems administrator and Linux specialit"}' -X POST http://localhost:9200/accounts/person/1`

The index is `accounts`, the type is `person` and the id is `1`.

### Get

- Basic

Run `curl http://localhost:9200/accounts/person/1` and you'll get

```json
{
    "_index": "accounts",
    "_type": "person",
    "_id": "1",
    "_version": 1,
    "found": true,
    "_source": {
        "name": "John",
        "lastname": "Doe",
        "job_description": "Systems administrator and Linux specialit"
    }
}
```

Data is showed in `_source` field.

- Query

Run `curl localhost:9200/_search?q=john`
`curl localhost:9200/_search?q=_id:1`

### Update

```json
POST localhost:9200/accounts/person/1/_update
{
      "doc":{
       "job_description" : "Systems administrator and Linux specialist"
     }
}
```

Run `curl -H "Content-Type: application/json" -d '{"doc":{ "job_description" : "Systems administrator and Linux specialist"}}' -X POST http://localhost:9200/accounts/person/1/_update`


### Delete

Run `curl -X DELETE localhost:9200/accounts`


## Query DSL

```json
GET localhost:9200/shakespeare/_search
{
    "query": {
            "match_all": {}
    }
}
```

```json
POST localhost:9200/shakespeare/scene/_search/
{
    "query":{
     "bool": {
         "must" : [
             {
                 "match" : {
                     "play_name" : "Antony"
                 }
             },
             {
                 "match" : {
                     "speaker" : "Demetrius"
                 }
             }
         ]
     }
    }
}
```

## Aggregations

Aggregations is for data analytics

```json
GET localhost:9200/shakespeare/_search
{
    "size":0,
    "aggs" : {
        "Total plays" : {
            "cardinality" : {
                "field" : "play_name.keyword"
            }
        }
    }
}
```
