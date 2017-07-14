class AddLatLongToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :latitude, :float
  	add_column :orders, :longitude, :float
  	add_column :branches, :latitude, :float
  	add_column :branches, :longitude, :float
  end
end
