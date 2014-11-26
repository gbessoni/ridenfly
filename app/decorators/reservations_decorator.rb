class ReservationsDecorator < Draper::CollectionDecorator
  delegate :total_entries, :total_pages, :current_page
end