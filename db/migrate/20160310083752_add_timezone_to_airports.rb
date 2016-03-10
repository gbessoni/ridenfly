class AddTimezoneToAirports < ActiveRecord::Migration
  def change
    add_column :airports, :timezone, :string

    require 'yaml'
    data = YAML.load_file(Rails.root.join('config/timezones.yml'))

    data['airport_timezones'].each do |code, zone|
      Airport.where(code: code).update_all(timezone: zone)
    end
  end
end
