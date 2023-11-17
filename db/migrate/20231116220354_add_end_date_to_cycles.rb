class AddEndDateToCycles < ActiveRecord::Migration[7.0]
  def change
    add_column :cycles, :end_date, :string
  end
end
