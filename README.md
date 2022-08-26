# Postwave Ruby Client 🌊

A Ruby client for displaying [Postwave](https://github.com/dorkrawk/postwave) blogs.

## Installation 

todo

## Usage

### Create a Postwave Client
```ruby
postwave_client = Postwave::Client.new("path/to/config/postwave.yaml")
```

If you'd like to preload all the posts:
```ruby
postwave_client = Postwave::Client.new("path/to/config/postwave.yaml", preload: true)
```

### Get a Single Post

Pass in the stub (the filename without '.md') for the post.
```ruby
post = postwave_client.post("2022-my-great-post")

# <Postwave::Post title="My Great Post", date=<Time ...>, tags=["tag1"], body="bla bla bla..">

puts post.title
# "My Great Post"
```

### Get a Collection of Posts

This will give you a list of posts for displaying on a page.

You can also filter by tags and specify offsets and limits (useful for pagination).

```ruby
posts = postwave_client.posts

# [<Postwave::Post ...>, <Postwave::Post ...>, ...]

tagged_posts = postwave_client.posts(tag: "lizards")

page2_posts = postwave_client.posts(offset: 10, limit: 10)
```
Posts will be in reverse chronological order.

### Get an Index of Posts

This will give you a quick list of post summaries containing the title, date, and stub, useful for building an archive page or quick index of posts.

You can also specify offsets and limits (useful for pagination).
```ruby
index = postwave_client(index)

# [<Postwave::PostStub title="My Great Post", date=<Time ...>, stub="2022-06-06-my-great-post">, <Postwave::PostStub ...>, ...]

puts index.first.stub
# 2022-06-06-my-great-post

page2_index = postwave_client.index(offset: 10, limit: 10)
```
Index will be in reverse chronological order.

### Get Tags Used In the Blog

```ruby
tags = postwave_client.tags

# ["tag1", "tag2", "another-tag"]
```

### Get Details For A Tag

```ruby
tag = postwave_clinet.tag("tag1")

# <Postwave::Tag tile="tag1", count=1, post_slugs=[""2022-06-06-my-great-post"]>
```

## Want To Know More About Postwave?

Check out the [Postwave](https://github.com/dorkrawk/postwave) repo.

## Development

### Run the Tests!

```
rake test
```
