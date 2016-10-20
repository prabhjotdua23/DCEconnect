class AddSelectedToWeight < ActiveRecord::Migration
  def change
    add_column :weights, :selected, :boolean
  end
end
