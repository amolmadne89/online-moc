class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
    	t.string :full_name
    	t.string :email
    	t.string :mobile
    	t.text :comment
      t.timestamps null: false
    end
  end
end
