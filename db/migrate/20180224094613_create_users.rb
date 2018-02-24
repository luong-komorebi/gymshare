class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.float :weight
      t.float :height
      t.integer :age
      t.timestamps
    end
  end
end
