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
    "size":0, // return only aggregations results.
    "aggs" : {
        "Total plays" : {
            "cardinality" : {
                "field" : "play_name.keyword"
            }
        }
    }
}
```

https://www.elastic.co/guide/en/elasticsearch/reference/current/common-options.html#date-math



### Case

- Date Histogram Aggregations

https://www.elastic.co/guide/cn/elasticsearch/guide/current/_looking_at_time.html

Statics amount by date, and we could set interval.

min_doc_count: only showed when reach the minimal threshold.

other_bucket_keys

```json
{
  "size": 0,
  "aggs" : {
    "messages" : {
      "filters" : {
        "other_bucket_key": "other_messages",
        "filters" : {
          "errors" :   { "match" : { "body" : "error"   }},
          "warnings" : { "match" : { "body" : "warning" }}
        }
      }
    }
  }
}
```

## Basic Concepts

References: https://www.elastic.co/guide/en/elasticsearch/reference/6.2/_basic_concepts.html
https://www.elastic.co/blog/how-many-shards-should-i-have-in-my-elasticsearch-cluster
https://thoughts.t37.net/how-we-reindexed-36-billions-documents-in-5-days-within-the-same-elasticsearch-cluster-cd9c054d1db8

### Shards & Replicas

An index can potentially store a large amount of data that can exceed the hardware limits of a single node. For example, a single index of a billion documents taking up 1TB of disk space may not fit on the disk of a single node or may be too slow to serve search requests from a single node alone.

To solve this problem, Elasticsearch provides the ability to subdivide your index into multiple pieces called shards. When you create an index, you can simply define the number of shards that you want. Each shard is in itself a fully-functional and independent "index" that can be hosted on any node in the cluster.

Sharding is important for two primary reasons:

- It allows you to horizontally split/scale your content volume
- It allows you to distribute and parallelize operations across shards (potentially on multiple nodes) thus increasing performance/throughput

The mechanics of how a shard is distributed and also how its documents are aggregated back into search requests are completely managed by Elasticsearch and is transparent to you as the user.

In a network/cloud environment where failures can be expected anytime, it is very useful and highly recommended to have a failover mechanism in case a shard/node somehow goes offline or disappears for whatever reason. To this end, Elasticsearch allows you to make one or more copies of your index’s shards into what are called replica shards, or replicas for short.

Replication is important for two primary reasons:

It provides high availability in case a shard/node fails. For this reason, it is important to note that a replica shard is never allocated on the same node as the original/primary shard that it was copied from.
It allows you to scale out your search volume/throughput since searches can be executed on all replicas in parallel.
To summarize, each index can be split into multiple shards. An index can also be replicated zero (meaning no replicas) or more times. Once replicated, each index will have primary shards (the original shards that were replicated from) and replica shards (the copies of the primary shards).

The number of shards and replicas can be defined per index at the time the index is created. After the index is created, you may also change the number of replicas dynamically anytime. You can change the number of shards for an existing index using the `_shrink` and `_split` APIs, however this is not a trivial task and pre-planning for the correct number of shards is the optimal approach.

By default, each index in Elasticsearch is allocated 5 primary shards and 1 replica which means that if you have at least two nodes in your cluster, your index will have 5 primary shards and another 5 replica shards (1 complete replica) for a total of 10 shards per index.

### Segment

Each shard contains multiple "segments", where a segment is an inverted index. A search in a shard will search each segment in turn, then combine their results into the final results for that shard.

While you are indexing documents, Elasticsearch collects them in memory (and in the transaction log, for safety) then every second or so, writes a new small segment to disk, and "refreshes" the search.

This makes the data in the new segment visible to search (ie they are "searchable"), but the segment has not been fsync'ed to disk, so is still at risk of data loss.

Every so often, Elasticsearch will "flush", which means fsync'ing the segments, (they are now "committed") and clearing out the transaction log, which is no longer needed because we know that the new data has been written to disk.

The more segments there are, the longer each search takes. So Elasticsearch will merge a number of segments of a similar size ("tier") into a single bigger segment, through a background merge process. Once the new bigger segment is written, the old segments are dropped. This process is repeated on the bigger segments when there are too many of the same size.

Segments are immutable. When a document is updated, it actually just marks the old document as deleted, and indexes a new document. The merge process also expunges these old deleted documents.
