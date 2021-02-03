class Api::PatternsController < ApplicationController
  def index
    @patterns = Pattern.all
    render json: @patterns ,each_serializer: PatternSerializer
  end
end
