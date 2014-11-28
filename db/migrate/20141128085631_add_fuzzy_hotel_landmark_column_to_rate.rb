class AddFuzzyHotelLandmarkColumnToRate < ActiveRecord::Migration
  def change
    enable_extension 'fuzzystrmatch'

    add_column :reservations, :hl_words, :string
    add_index :reservations, :hl_words
  end
end
