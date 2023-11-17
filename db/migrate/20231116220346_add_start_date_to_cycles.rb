class AddStartDateToCycles < ActiveRecord::Migration[7.0]
  def change
    add_column :cycles, :start_date, :string
  end
end
