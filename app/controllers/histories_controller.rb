#controller for user history. Bought reservations
class HistoriesController < ApplicationController
  before_action :find_entry, only: [:destroy]
  # action for showing user reservation.
  def index
    if user_signed_in?
      @histories = History.where(idUser: current_user.id).order("")
      @departuresId = {}
      @histories.each  do  |x|
        @departuresId[x.id] = x.idDeparture
      end
      @departures = {}
      @departuresId.each do |key,value|
        @departures[key] = Departure.find(value)
      end
      @companies = Company.all
    else
      redirect_to root_path
    end

  end
  #action for deleting user registration.
  def destroy
    @departure = Departure.find(@history.idDeparture)
    numberOfTickets = @departure.numberOfTickets
    numberOfTickets +=1
    @departure.update(numberOfTickets:numberOfTickets)
    @history.destroy
    flash[:success] = "Your have successfully removed your reservation"
    redirect_to action: "index"
  end
  #private method for fing the actual entry in History model(user can have many reservations for same departure)to have it deleted.
  private

    def find_entry
      @history = History.find(params[:id])
    end
end
