class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.integer :idUser
      t.integer :idDeparture

      t.timestamps
    end
  end
end
