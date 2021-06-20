class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super do
      if request.format.json?
        render json: {
          'status' => 'ok',
          'csrf_token' => form_authenticity_token,
          'result' => {
            'user' => {
              'id' => @user.id,
              'email' => @user.email,
              'first_name' => @user.first_name,
              'last_name' => @user.last_name
            }
          }
        } and return
      end
    end
  end

  def destroy
    super do
      if request.format.json?
        render json: {
          'csrf_param' => request_forgery_protection_token,
          'csrf_token' => form_authenticity_token
        }
        return
      end
    end
  end
end
