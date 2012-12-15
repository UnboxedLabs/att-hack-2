class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :description
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
