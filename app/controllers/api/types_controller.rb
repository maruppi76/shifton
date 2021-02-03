class Api::TypesController < ApplicationController
  def index
    @types = Type.all
    render json: @types, each_serializer: TypeSerializer
  end
end
