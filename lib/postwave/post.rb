require_relative "blog_utilities"

module Postwave
  class Post
    include BlogUtilities

    MEATADATA_DELIMTER = "---"

    attr_reader :file_name, :slug

    def self.new_from_file_path(path)
      metadata_delimter_count = 0
      body_buffer_count = 0
      field_content = { "body" => "" }

      File.readlines(path).each do |line|
        clean_line = line.chomp
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
          if body_buffer_count == 0
            body_buffer_count += 1
            next if clean_line.empty?
          end

          field_content["body"] += "#{line}\n"
        end
      end

      # turn "date" into a Time object
      field_content["date"] = Time.parse(field_content["date"])

      # turn "tags" into an array
      if field_content["tags"]
        field_content["tags"] = field_content["tags"].split(",").map do |tag|
          tag.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
        end
      end

      # turn "draft" into boolean
      if field_content["draft"]
        field_content["draft"] = field_content["draft"].downcase == "true"
      end

      self.new(path, field_content)
    end
    
    def initialize(file_name, field_content = {})
      @file_name = file_name
      @slug = file_name.split("/").last[...-3] # cut off ".md"

      field_content.each do |field, value|
        instance_variable_set("@#{field}", value) unless self.instance_variables.include?("@#{field}".to_sym)
        self.class.send(:attr_reader, field) unless self.public_methods.include?(field.to_sym)
      end
    end
  end
end

