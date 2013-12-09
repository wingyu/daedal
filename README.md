Daedal
======
[![Build Status](https://travis-ci.org/cschuch/daedal.png?branch=master)](https://travis-ci.org/cschuch/daedal)
[![Coverage Status](https://coveralls.io/repos/cschuch/daedal/badge.png)](https://coveralls.io/r/cschuch/daedal)

This repository contains a set of Ruby classes designed to make ElasticSearch
query creation simpler and easier to debug. The goal is to reproduce all
components of the ElasticSearch [Query DSL](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl.html)
to aid in the construction of complex queries. Type checking and attribute
coercion are handled using [Virtus](https://github.com/solnic/virtus) to make
it harder to construct invalid ElasticSearch queries before sending them to the server.

The ElasticSearch Query DSL is huge! There are also a ton of different options within each
component. My goal is to include as much of that functionality and flexibility as possible, but
also maintain as high of test coverage as possible. That means it'll take some time for this project
to reach full coverage of the Query DSL, so please feel free to contribute or be patient :)

Installation
------------

``` terminal
$ gem install daedal
```

or in your `Gemfile`

``` ruby
gem 'daedal'
```

Usage
--------

### ElasticSearch Query DSL

Other Ruby packages for ElasticSearch allow you to create queries either as
hashes or by constructing raw JSON:

``` ruby
match_query = {'match' => {'foo' => {'query' => 'bar'}}}
```

For more complicated queries, dealing with the resulting large nested hash can be
frustrating. Inspired by ElasticSearch's built in 
[Java API](http://www.elasticsearch.org/guide/en/elasticsearch/client/java-api/current/),
Daedal contains Ruby classes designed to make query construction more Ruby-like.

### Queries

Queries are contained within the `Queries` module. You can construct query components like:

``` ruby
require 'daedal'

# creates the basic match query
match_query = Daedal::Queries::MatchQuery.new(field: 'foo', query: 'bar')
```
Each query object has `#to_json` defined for easy conversion for use with any of the Ruby
ElasticSearch clients out there:
``` ruby
match_query.to_json # => "{\"match\":{\"foo\":{\"query\":\"bar\"}}}"
```

To date (12/8/2013), I have implemented the following queries:
* [bool query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-bool-query.html)
* [constant score query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-constant-score-query.html)
* [dis max query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-dis-max-query.html)
* [filtered query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-filtered-query.html)
* [match all query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-match-all-query.html)
* [match query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-match-query.html)
* [multi match query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-multi-match-query.html)
* [nested query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-nested-query.html)
* [prefix query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-prefix-query.html)

To be implemented next:
* [function score query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-function-score-query.html)
* [fuzzy query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-fuzzy-query.html)
* [query string query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html)
* [range query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-range-query.html)
* [regexp query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-regexp-query.html)
* [term query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-term-query.html)
* [terms query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-terms-query.html)
* [wildcard query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-wildcard-query.html)

Queries I'm not planning on implementing at all, since they're deprecated:
* [custom filters score query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-custom-filters-score-query.html)
* [custom score query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-custom-score-query.html)
* [custom boost factor query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-custom-boost-factor-query.html)
* [text query](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-text-query.html)


### Filters

Filters are contained within the `Filters` module. You can construct filter components
in the same way as queries:

``` ruby
require 'daedal'

term_filter = Daedal::Filters::TermFilter.new(field: 'foo', term: 'bar')

term_filter.to_json # => "{\"term\":{\"foo\":\"bar\"}}"
```

To date (12/8/2013), I have implemented the following filters:
* [and filter](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-and-filter.html)
* [geo distance filter](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-geo-distance-filter.html)
* [range filter](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-range-filter.html)
* [term filter](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-term-filter.html)
* [terms filter](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-terms-filter.html)

To be implemented next:
* [bool filter](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-bool-filter.html)
* [nested filter](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-nested-filter.html)
* [or filter](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-or-filter.html)

### Type checking and attribute coercion

When creating ElasticSearch queries via nested hashes, it is all too easy to
assign an invalid value to a specific field, which would then result in
an error response when sending the query to the server. For instance, the query:

``` ruby
constant_score_query = {'constant_score' => {'boost' => 'foo', 'query' => {'match_all' => {}}}}
```

would yield a server error, since the `boost` parameter must be a number.

Daedal uses [Virtus](https://github.com/solnic/virtus) to perform data-type coercions. 
That way, invalid query parameters are surfaced at runtime, making debugging easier.
The previous `constant_score_query` example in Daedal would raise an error:

``` ruby
match_all_query = Daedal::Queries::MatchAllQuery.new()
constant_score_query = Daedal::Queries::ConstantScoreQuery.new(boost: 'foo', query: match_all_query)

# Virtus::CoercionError: Failed to coerce "foo" into Float
```

### Creating your own queries

Currently, I've only made it through a fraction of the entire Query DSL, but will be working to
achieve complete coverage as quickly as possible. If you need to use a query that
I haven't gotten to yet, or if you want to create your own more specialized queries within
your own project, defining the query classes is relatively straightforward - just make
your new class a sublass of the `Daedal::Queries::BaseQuery` or `Daedal::Filters::BaseFilter`
classes, and define the `to_hash` method. All methods made available by including `Virtus.model` in your
class will be available to you, as well.

Example:
``` ruby
class MyQuery < Daedal::Queries::BaseQuery
  
  # define the attributes that you need in your query
  attribute :foo, String
  attribute :bar, String

  # define the to_hash method to convert for use in ElasticSearch 
  def to_hash
    ...
  end
end
```

Contributing
-------------

The ElasticSearch Query DSL is pretty large and includes a ton of nuance. I'm starting with the
most basic parts of the DSL (and the parts I use for work), so if you want to help out with the project
to meet your needs please feel free to contribute! I just ask that you:

* Fork the project.
* Make your changes or additions.
* Add tests! My goal is complete test coverage, so please take the effort to make them pretty comprehensive.
* Send me a pull request.

Feedback or suggestions are also always welcome. 

License
-------

The MIT License (MIT)

Copyright (c) 2013 Christopher Schuch

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.