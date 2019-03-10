# Elasticsearch

references: https://www.elastic.co/blog/a-practical-introduction-to-elasticsearch, https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html

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

Run this command: `curl -H "Content-Type: application/json" -d '{"name":"John", "lastname":"Doe", "job_description":"Systems administrator and Linux specialit"}' -X POST http://localhost:9200/accounts/person/1` and you'll see:

```json
{"_index":"accounts","_type":"persion","_id":"1","_version":1,"result":"created","_shards":{"total":2,"successful":1,"failed":0},"_seq_no":0,"_primary_term":1}
```

The index is `accounts`, the type is `person` and the id is `1`.

One index only includes one type

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

```json
{
  "took":148,
  "timed_out":false,
  "_shards":{
    "total":5,
    "successful":5,
    "skipped":0,
    "failed":0
  },
  "hits":{
    "total":2,
    "max_score":0.2876821,
    "hits":[
      {
        "_index":"accounts",
        "_type":"person",
        "_id":"2",
        "_score":0.2876821,
        "_source":{
          "name":"John",
          "lastname":"Smith",
          "job_description":"System administrator"
        }
      },
      {
        "_index":"accounts",
        "_type":"person",
        "_id":"1",
        "_score":0.2876821,
        "_source":{
          "name":"John",
          "lastname":"Doe",
          "job_description":"Systems administrator and Linux specialist"
        }
      }
    ]
  }
}
```

This mode restrict the query field to only `_id`
`curl localhost:9200/_search?q=_id:1`

- Query String syntax

reference: https://www.elastic.co/guide/en/elasticsearch/reference/5.5/query-dsl-query-string-query.html#query-string-syntax

Query String example

```json
{
    "query": {
        "query_string" : {
            "fields" : ["content", "name"],
            "query" : "this AND that"
        }
    }
}
```

`curl -H 'Content-type: application/json' -X POST -d '{"query":{"query_string":{"fields":["name"],"query":"john OR Smith"}}}' localhost:9200/_search`

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

load bulk data:
```
curl -XPOST 'localhost:9200/shakespeare/_bulk?pretty' --data-binary @shakespeare.json
```


```json
GET localhost:9200/shakespeare/_search
{
    "query": {
            "match_all": {}
    }
}
```

`curl -H 'Content-type:application/json' -XPOST -d '{"query":{"match_all":{}}}' localhost:9200/shakespeare/_search`

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

reference: https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-bool-query.html


## Aggregations

Aggregations is for data analytics

references: https://www.elastic.co/guide/en/elasticsearch/reference/5.5/mapping.html, https://www.elastic.co/guide/en/elasticsearch/reference/5.5/search-aggregations.html

By default we cannot do aggregations in analyzed fields.

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
