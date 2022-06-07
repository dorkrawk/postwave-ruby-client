require_relative "postwave/client"

module Postwave
  PostStub = Struct.new(:date, :title, :slug)
  Tag = Struct.new(:name, :count, :post_slugs)
end
