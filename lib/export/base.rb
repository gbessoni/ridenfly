class Export::Base
  include Virtus.model

  class << self
    attr_accessor :columns
  end
end
