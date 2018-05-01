class ChangeDataTypeForRestTime < ActiveRecord::Migration[5.1]
  def change
    change_column :rests, :rest_time, :float
  end
end
