module ModelPaginator
  protected

  def paginate_model(model, options = {})
    model.paginate(page: params[:page], per_page: 20)
  end
end
