class Import::RateDecorator < Draper::Decorator
  delegate_all

  def import_success_message
    "#{valid_objects.size} rate(s) successfully imported."
  end

  def import_error_message
    "#{invalid_objects.size} rate(s) where not imported! Check errors."
  end
end
