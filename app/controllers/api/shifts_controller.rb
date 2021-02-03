class Api::ShiftsController < ApplicationController

  def update
    @shift = Shift.find(params[:id])
    if @shift.update(shift_params)
      unless !@shift.errors.messages.empty?
        render :json => {
          'status' => 'ok',
          'csrf_token' => form_authenticity_token,
        } and return
      end
    else
      render :json => {
        'status' => 401,
        'errors'=> @shift.errors
      } and return
    end
  end

  def all_shifts
    @shifts = Shift.includes([:pattern, :type])
    render json: @shifts, each_serializer: ShiftSerializer
  end

  def my_shift
    @shifts = Shift.where(user_id: current_user.id).includes([:pattern, :type])
    render json: @shifts, each_serializer: ShiftSerializer
  end

  def dep_shifts
    @user = User.where(department_main_id: current_user.department_main_id)
    @shifts = Shift.where(user_id: @user).includes([:pattern, :type])
    render json: @shifts
  end

  private
  def shift_params
    params.require(:shift).permit(:date, :user_id, :pattern_id, :type_id)
  end
end
