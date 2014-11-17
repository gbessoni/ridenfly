class Availability::Item < Rate
  scope :by_search, ->(search) do
    where({})
  end

  def rate_id
    id
  end
end
