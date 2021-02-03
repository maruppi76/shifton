class Api::DepartmentsController < ApplicationController

  def index
    @departments = Department.order(:ancestry)
    render json: @departments
  end
end
