json.availabilities do
  json.array! @std_items, partial: 'item', as: :item
end
json.scheduled do
  json.array! @schd_items, partial: 'item', as: :item
end
