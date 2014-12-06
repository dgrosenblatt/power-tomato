class CreateCritics < ActiveRecord::Migration
  def change
    create_table :critics do |t|
      t.string  :name
      t.string  :publication
      t.integer :agree, default: 0
      t.integer :disagree, default: 0
    end
  end
end
