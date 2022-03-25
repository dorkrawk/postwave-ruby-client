require_relative "blog_utilities"

module Postwave
   class Post
    include BlogUtilities

    MEATADATA_DELIMTER = "---"

    attr_reader :file_name

    def self.new_from_file_path(path)
      metadata_delimter_count = 0
      field_content = { "body" => "" }

      File.readlines(path).each do |line|
        clean_line = line.strip
        if clean_line == MEATADATA_DELIMTER
          metadata_delimter_count += 1
          next
        end

        if metadata_delimter_count == 0
          next
        elsif metadata_delimter_count == 1
          field, value = clean_line.split(":", 2).map(&:strip)
          field_content[field] = value
        else
          next if clean_line.empty?
          field_content["body"] += line
        end
      end

      # turn "tags" into an array
      if field_content["tags"]
        field_content["tags"] = field_content["tags"].split(",").map do |tag|
          tag.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
        end
      end

      self.new(path, field_content)
    end
    
    def initialize(file_name, field_content = {})
      @file_name = file_name

      field_content.each do |field, value|
        instance_variable_set("@#{field}", value)
        self.class.send(:attr_reader, field)
      end
    end
  end
end

