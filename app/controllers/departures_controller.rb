class DeparturesController < ApplicationController
  before_action :find_departure, only: [:show,:update,:edit,:destroy]
  def index
    @departures = Departure.where("numberOfTickets > 0")
    @companies = Company.all
  end
  def new
    if company_signed_in?
      @departure = Departure.new
    else
      redirect_to root_path
    end
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
    if user_signed_in?
      @card = Card.new
      @companies = Company.all
      @departure = Departure.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def edit
    if company_signed_in?
    else
      redirect_to root_path
    end
  end
  def buy
    if user_signed_in?
      @departure = Departure.find(params[:format])
      if @departure.numberOfTickets > 0
        @card = Card.new(card_params)
        numberOfTickets = @departure.numberOfTickets
        numberOfTickets -=1
        atributes = {"idUser" => current_user.id,"idDeparture" => @departure.id}
        @history = History.new(atributes)
        if @departure.update(numberOfTickets:numberOfTickets) and @history.save and @card.save
          redirect_to root_path
        else
          render "show"
        end
      else
        render "error"
      end
    else
      redirect_to root_path
    end
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
      params.require(:departure).permit(:from,:to,:departureDate,:arrival,:numberOfTickets,:idCompany,:price)
    end
    def find_departure
      @departure = Departure.find(params[:id])
    end
    def history_params
      params.require(:history).permit(:idUser,:idDeparture)
    end
    def card_params
      params.require(:card).permit(:idUser,:cardNumber)
    end
end
