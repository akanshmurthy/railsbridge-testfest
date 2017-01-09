class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :body
      t.string :post_id
      t.string :user_id

      t.timestamps null: false
    end
  end
end
