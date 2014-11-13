module HtmlResponse
  def html_success_response(resource, message)
    if request.xhr?
      render partial: 'shared/success_message', locals: {message: message}
    else
      redirect_to [:admin, resource], notice: message
    end
  end

  def html_error_response(resource, action)
    if request.xhr?
      render(
        partial: 'form',
        resource.to_s.parameterize.underscore => resource,
        layout: false
      )
    else
      render action: action
    end
  end
end
