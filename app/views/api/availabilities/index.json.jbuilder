json.availabilities do
  json.array! @items, partial: 'item', as: :item
end
