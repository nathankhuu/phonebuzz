class AddDelayToCall < ActiveRecord::Migration[5.0]
  def change
    add_column :calls, :delay, :integer
  end
end
