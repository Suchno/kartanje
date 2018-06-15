class HistoriesController < ApplicationController
  before_action :find_entry, only: [:destroy]
  def index
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
  end
  def destroy
    @departure = Departure.find(@history.idDeparture)
    numberOfTickets = @departure.numberOfTickets
    numberOfTickets +=1
    @departure.update(numberOfTickets:numberOfTickets)
    @history.destroy
    redirect_to root_path
  end
  private

    def find_entry
      @history = History.find(params[:id])
    end
end
