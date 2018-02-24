class CreateRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :rounds do |t|
      t.integer :repitition
      t.references :workout_plan, foreign_key: true, index: true
      t.timestamps
    end
  end
end
