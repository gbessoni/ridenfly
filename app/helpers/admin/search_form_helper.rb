module Admin::SearchFormHelper
  def search_form_for(object, options = {}, &blk)
    options.reverse_merge!(method: :get, html: {class: 'search'})
    simple_form_for(object, options, &blk)
  end
end
