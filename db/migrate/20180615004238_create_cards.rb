class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :idUser
      t.string :cardNumber

      t.timestamps
    end
  end
end
