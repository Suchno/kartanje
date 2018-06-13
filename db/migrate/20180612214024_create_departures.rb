class CreateDepartures < ActiveRecord::Migration[5.2]
  def change
    create_table :departures do |t|
      t.string :from
      t.string :to
      t.date :departureDate
      t.date :arrival
      t.integer :numberOfTickets
      t.integer :idCompany

      t.timestamps
    end
  end
end
