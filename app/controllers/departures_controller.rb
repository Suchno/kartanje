class DeparturesController < ApplicationController
  before_action :find_departure, only: [:show,:update,:edit,:destroy]
  def index
    @departures = Departure.all.order("created_at DESC")
  end
  def new
    @departure = Departure.new
  end
  def create
    @departure = Departure.new(departure_params)

    if @departure.save
      redirect_to root_path
    else
      render "new"
    end
  end
  def show
    @departure = Departure.find(params[:id])
  end

  def edit

  end
  def destroy
    @departure.destroy
    redirect_to root_path
  end
  def update
    if @departure.update(departure_params)
      redirect_to departure_path(@departure)
    else
      render "edit"

    end
  end

  private
    def departure_params
      params.require(:departure).permit(:from,:to,:departureDate,:arrival,:numberOfTickets,:idCompany)
    end
    def find_departure
      @departure = Departure.find(params[:id])
    end
end
