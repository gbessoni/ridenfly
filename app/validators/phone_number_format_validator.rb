class PhoneNumberFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record[attribute] = clean_numer(value)
    unless record[attribute].squeeze(' ') =~ /\A[0-9]{10,}\z/
      record.errors.add attribute, :invalid_format
    end
  end

  def clean_numer(number)
    number.to_s.strip.gsub(/[\s,\-]+/, '')
  end
end
