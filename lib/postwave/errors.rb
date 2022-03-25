module Postwave
  class PostwaveError < StandardError
  end

  class MissingConfigError < PostwaveError
  end

  class InvalidBlogError < PostwaveError
  end

  class PostNotFoundError < PostwaveError
  end
end
