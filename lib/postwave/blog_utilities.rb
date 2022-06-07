module Postwave
  module BlogUtilities
    CONFIG_FILE_NAME = "postwave.yaml"
    INDEX_FILE_NAME = "index.csv"
    SUMMARY_FILE_NAME = "summary.yaml"
    POSTS_DIR = "_posts"
    META_DIR = "meta"
    TAGS_DIR = "tags"

    def is_set_up?(blog_root)
      missing_paths = find_missing_paths(blog_root)
      missing_paths.empty?
    end

    def file_paths(blog_root)
      [
        File.join(blog_root, CONFIG_FILE_NAME),
        File.join(blog_root, POSTS_DIR, META_DIR, INDEX_FILE_NAME),
        File.join(blog_root, POSTS_DIR, META_DIR, SUMMARY_FILE_NAME),
      ]
    end

    def directory_paths(blog_root)
      [
        File.join(blog_root, POSTS_DIR),
        File.join(blog_root, POSTS_DIR, META_DIR),
        File.join(blog_root, POSTS_DIR, META_DIR, TAGS_DIR),
      ]
    end

    def find_missing_paths(blog_root)
      paths_to_check = directory_paths(blog_root) + file_paths(blog_root)
      missing_paths = []
      paths_to_check.each do |path|
        missing_paths << path if !FileTest.exist?(path)
      end
      missing_paths
    end
  end
end
