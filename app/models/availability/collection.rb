class Availability::Collection
  include Virtus.model

  attribute :search, Availability::Search

  def items
    Availability::Item.by_search(search)
  end
end
