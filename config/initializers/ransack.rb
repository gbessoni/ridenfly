Ransack.configure do |config|
  config.add_predicate 'start_date_gteq',
    arel_predicate: 'gteq',
    formatter: proc { |v| Date.parse(v).beginning_of_day },
    validator: proc { |v| v.present? },
    type: :string
  config.add_predicate 'end_date_lteq',
    arel_predicate: 'lteq',
    formatter: proc { |v| Date.parse(v).end_of_day },
    validator: proc { |v| v.present? },
    type: :string
end
