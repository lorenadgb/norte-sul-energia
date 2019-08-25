class StatesController < ApplicationController

  def state_by_city
    city = City.find(params[:id])

    render json: {state: city.state}.as_json
  end

end
