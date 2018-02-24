class CreateExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :description
      t.float :weight
      t.integer :reps
      t.references :round, index: true, foreign_key: true
      t.timestamps
    end
  end
end
