class CreateWorkoutPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :workout_plans do |t|
      t.string :name
      t.text :description
      t.integer :score
      t.datetime :published_at
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
  end
end
