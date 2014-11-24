module JsonResponseLogger
  def log_json_response
    Rails.logger.info "RESPONSE: #{response.body}"
  end
end
