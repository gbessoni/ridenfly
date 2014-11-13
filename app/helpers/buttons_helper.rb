module ButtonsHelper
  def submit_tag(name, opts = {})
    opts[:class] ||= 'btn btn-primary'
    super(name, opts)
  end

  def primary_btn_to(text, url, options = {})
    link_to url, {class: 'btn btn-primary'}.merge(options) do 
      text
    end
  end

  def btn_to(text, url, options = {})
    link_to url, {class: 'btn btn-default'}.merge(options) do 
      text
    end
  end
end
