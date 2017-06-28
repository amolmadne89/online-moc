class AddBranchIdToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :branch_id, :integer
  end
end
