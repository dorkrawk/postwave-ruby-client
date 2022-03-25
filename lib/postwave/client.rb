require_relative "post"
require_relative "errors"
require_relative "blog_utilities"

require "csv"
require "date"

module Postwave
  class Client
    include BlogUtilities

    PostStub = Struct.new(:date, :title, :stub)
    Tag = Struct.new(:tag, :count)

    def initialize(config_path, preload: false)
      raise MissingConfigError unless is_valid_config?(config_path)
      
      @blog_root = File.dirname(config_path)
      raise InvalidBlogError unless is_set_up?(@blog_root)

      if preload
        @all_posts = get_all_posts if preload
    end

    # returns: an array of PostStub Structs - [<struct PostStub date=Time, title="", stub="">]
    def index(offset: 0, limit: nil)
      working_index = @full_index || get_full_index
      count = limit || working_index.size
      working_index[offset, count]
    end

    # returns: a post - Postwave::Post
    def post(slug)
      post_file_path = File.join(@blog_root, POSTS_DIR, "#{slug}.md")
      raise PostNotFoundError unless File.exist?(post_file_path)

      Postwave::Post.new_from_file_path(post_file_path)
    end

    # returns: an array of posts - [Postwave::Post]
    def posts(offset: 0, limit: nil, tag: nil)
      posts = @all_posts || get_all_posts
      posts = posts.select { |post| post.tags.include?(tag) } if tag
      count = limit || count.size
      posts[offset, count]
    end

    # returns: an array of tags - [<struct Tag tag="", count=1>]
    def tags
      
    end

    private

    def is_valid_config?(config_path)
      File.exist?(config_path)
    end

    def get_all_posts
      posts = []
      Dir.glob(File.join(@blog_root, POSTS_DIR, "*.md")) do |post_file_path|
        posts << Postwave::Post.new_from_file_path(post_file_path)
      end
      posts
    end

    def get_full_index
      full_index = []                  
      CSV.foreach(File.join(@blog_root, POSTS_DIR, META_DIR, INDEX_FILE_NAME)) do |post|
        full_index << PostStub.new(Date.parse(post[1]), post[2], post[0][...-3])
      end
      full_index
    end
  end
end
