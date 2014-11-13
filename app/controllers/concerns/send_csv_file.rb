module SendCsvFile
  def send_csv_file(model, scope)
    options = {filename: "#{model.underscore.pluralize}.csv", type: :csv}
    send_data(
      "::Export::#{model}".constantize.new(scope.all).to_csv,
      options
    )
  end
end
