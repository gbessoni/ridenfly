class Availability::Collection
  include Virtus.model

  attribute :search, Availability::Search

  def items
    Availability::Item.by_search(search).map do |avl|
      avl.tap{|a| a.search = search}
    end
  end
end
