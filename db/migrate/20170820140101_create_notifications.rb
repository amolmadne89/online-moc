class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.string :notifiable_type
    	t.integer :notifiable_id
    	t.boolean :is_checked
    	t.integer :branch_id
      t.timestamps null: false
    end
  end
end
