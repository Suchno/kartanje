#-Controller for departures
class DeparturesController < ApplicationController
  before_action :find_departure, only: [:show,:update,:edit,:destroy]
  #-action for pressenting all departures. It shows only departurese that have date of departure greater than current time
  def index
    @time = DateTime.now
    @departures = Departure.paginate(:page => params[:page], :per_page => 10).where("numberOfTickets > 0").where("departureDate >= ?",DateTime.now.in_time_zone("Berlin"))
    @companies = Company.all
  end
  #-action for creating a new departure. it cannot be accesses if company is not logined
  def new
    if company_signed_in?
      @departure = Departure.new
    else
      redirect_to root_path
    end
  end
  #- action for getting company input and sasving new departure to database. If input is nt valid it redirects to error view with proper message
  def create
      @departure = Departure.new(departure_params)
      if(@departure.departureDate >= @departure.arrival or @departure.numberOfTickets <= 0 or @departure.price <= 0)
        flash[:danger] = "Your date of departure must be larger than you arrival date. Your price must be greater then 0 so as your number of tickets. Try again :)"
        redirect_to new_departure_path
      else
        if @departure.save
          redirect_to root_path
        else
          render "new"
        end
      end
  end
  #- action to represent what user is trying to buy. If user is not logined it will redirect him to root_path
  def show
    if user_signed_in?
      @card = Card.new
      @departure = Departure.find(params[:id])
      @company = Company.find(@departure.idCompany)
    else
      redirect_to root_path
    end
  end
  #-action used by companies to edit their departures
  def edit
    if company_signed_in?
    else
      redirect_to root_path
    end
  end
  #- Action for user when he tries to buy a ticket. If user is not loggined it redirects to root_path. If everything is ok it save changes to database and redirects to root_path
  # with message. If there was a problem( there are no tickets) it redrects to error view with proper message.
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
        flash[:danger] = "You cannot buy a ticket couse there are 0 tickets left :(."
      end
    else
      redirect_to root_path
    end
  end
  # action used by companies when they want to delete their departure. Only possible if users have not bought any tickets.
  def destroy
    if( @histories = History.where(idDeparture: params[:id])).count > 0
      flash[:danger] = "You cannot delete departure for which people have already have bought tickets :(."
    else
      @departure.destroy
    end
    redirect_to root_path
  end
  # action used by companies when they want to edit their departure. Only possible if users have not bought any tickets.
  def update
    if( @histories = History.where(idDeparture: params[:id])).count > 0
      flash[:danger] = "You cannot edit departure for which people have already have bought tickets :(."
      redirect_to root_path
    else
      if @departure.update(departure_params)
        redirect_to departure_path(@departure)
      else
        render "edit"
      end
    end
  end
  #private methods for getting entered parameters, and find_departure used before_action so that we have actual departure that is shown.
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
