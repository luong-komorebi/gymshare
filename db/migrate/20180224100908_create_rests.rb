class CreateRests < ActiveRecord::Migration[5.1]
  def change
    create_table :rests do |t|
      t.time :rest_time
      t.references :round, foreign_key: true, index: true
      t.timestamps
    end
  end
end
