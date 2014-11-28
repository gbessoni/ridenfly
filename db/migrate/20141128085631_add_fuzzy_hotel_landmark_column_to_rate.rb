class AddFuzzyHotelLandmarkColumnToRate < ActiveRecord::Migration
  def change
    enable_extension 'fuzzystrmatch'

    add_column :rates, :hl_words, :string
    add_index :rates, :hl_words
  end
end
