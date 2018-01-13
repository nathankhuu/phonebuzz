class CreateCalls < ActiveRecord::Migration[5.0]
  def change
    create_table :calls do |t|
      t.string :phone_number
      t.integer :input

      t.timestamps
    end
  end
end
