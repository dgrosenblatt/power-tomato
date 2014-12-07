class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :rt_id
    end
  end
end
