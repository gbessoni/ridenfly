module JsonResponse
  extend ActiveSupport::Concern

  included do
    def json_response_success opts={}
      respond_to do |format|
        format.json{ render json:
          {
            status: 'success',
          }.merge!(opts)
        }
      end
    end

    def json_response_error opts={}
      respond_to do |format|
        format.json{
          render json:{
            status: 'error',
          }.merge!(opts),
          status: :unprocessable_entity
        }
      end
    end
  end
end
