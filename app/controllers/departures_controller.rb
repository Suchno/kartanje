class DeparturesController < ApplicationController
  before_action :find_departure, only: [:show,:update,:edit,:destroy]
  def index
    @time = DateTime.now
    @departures = Departure.paginate(:page => params[:page], :per_page => 10).where("numberOfTickets > 0").where("departureDate >= ?",DateTime.now.in_time_zone("Berlin"))
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
      if(@departure.departureDate >= @departure.arrival or @departure.numberOfTickets <= 0 or @departure.price <= 0)
        render "error",:locals => {:errorType =>  "c"}
        return
      end
      if @departure.save
        redirect_to root_path
      else
        render "new"
      end
  end
  def show
    if user_signed_in?
      @card = Card.new
      @departure = Departure.find(params[:id])
      @company = Company.find(@departure.idCompany)
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
          flash[:success] = "Your have successfully booked your reservation for this departure. You can see it in your history. Enjoy your trip :)"
          redirect_to root_path
        else
          render "show"
        end
      else
        render "error",:locals => {:errorType =>  "n"}
      end
    else
      redirect_to root_path
    end
  end
  def destroy
    if( @histories = History.where(idDeparture: params[:id])).count > 0
      render "error",:locals => {:errorType =>  "d"}
      return
    end
    @departure.destroy
    redirect_to root_path
  end
  def update
    if( @histories = History.where(idDeparture: params[:id])).count > 0
      render "error",:locals => {:errorType =>  "b"}
      return
    end
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
