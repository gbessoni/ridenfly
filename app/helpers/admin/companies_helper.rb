module Admin::CompaniesHelper
  def payment_options
    ['check', 'direct deposit', 'credit card'].map do |name|
      [name.titleize, name]
    end
  end
end
