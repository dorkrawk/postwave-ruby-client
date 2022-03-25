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
post = postwave_client.post("my-great-post")

puts post
# <Postwave::Post title="My Great Post", date=<Date ...>, tags=["tag1"], body="bla bla bla..">
```

### Get a Collection of Posts

### Get an Index of Posts

## Want To Know More About Postwave?

Check out the [Postwave](https://github.com/dorkrawk/postwave) repo.
