module LinksHelper
  def link_to_new(text, url, options = {})
    link_to url, {class: 'btn btn-primary'}.merge(options) do 
      text
    end
  end
end
