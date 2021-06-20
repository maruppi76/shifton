class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    @user = build_resource(new_user_params)
    if @user.save
      if @user.errors.messages.empty?
        render json: {
          'status' => 'ok',
          'csrf_token' => form_authenticity_token,
          'result' => {
            'user' => {
              'id' => @user.id,
              'email' => @user.email
            }
          }
        } and return
      end
    else
      render json: {
        'status' => 401,
        'errors' => @user.errors
      } and return
    end
  end

  def update
    @user = User.find(params[:user][:id])
    if @user.update(new_user_params)
      if @user.errors.messages.empty?
        render json: {
          'status' => 'ok',
          'csrf_token' => form_authenticity_token,
          'result' => {
            'user' => {
              'id' => @user.id,
              'email' => @user.email
            }
          }
        } and return
      end
    else
      render json: {
        'status' => 401,
        'errors' => @user.errors
      } and return
    end
  end

  def new_user_params
    params.require(:user).permit(:id,
                                 :status,
                                 :first_name,
                                 :last_name,
                                 :first_name_kana,
                                 :last_name_kana,
                                 :email,
                                 :password,
                                 :staff_code,
                                 :company_id,
                                 :department_main_id,
                                 :department_sub_id,
                                 :role,
                                 :admin,
                                 :avatar)
  end
end
