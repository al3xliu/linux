# logstash

Here's a example of logstash pipeline configuration file

```
input {
	file {
		type => "json"
		path => "/tmp/2019-01-16-traffic-api.log"
		sincedb_path => "/dev/null"
		start_position => "beginning"
	}
}

## Add your filters / logstash plugins configuration here
filter {
	json {
	  skip_on_invalid_json => true
		source => "message"
	}
}

output {
	elasticsearch {
		hosts => "elasticsearch:9200"
	}
}
```

Here're something I learned:

1. the output-> elasticsearch filed will use "logstash-{timestamp}" as the default index, I should create related index such as "logstash-*" in kibana before I search data.
