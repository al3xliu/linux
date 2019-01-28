# logstash

Here's a example of logstash pipeline configuration file

- json filter

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

- grok filter

```
input {
	file {
		type => "json"
		path => "/tmp/listener.log"
		sincedb_path => "/dev/null"
		start_position => "beginning"
	}
}

## Add your filters / logstash plugins configuration here
filter {
	grok {
		#2019-01-02T17:49:31.107+08:00 9104 main - media_process.go:106 VideoCombination - DEBU combine video successfully!
		match => { "message" => "%{TIMESTAMP_ISO8601:hh} %{NUMBER:process} %{WORD:package} - %{DATA:file}:%{NUMBER:line} %{WORD:func} - %{WORD:level} %{GREEDYDATA:message}" }
		add_field => {
			"level2": "%{level}"
		}
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
