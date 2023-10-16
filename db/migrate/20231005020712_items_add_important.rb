class ItemsAddImportant < ActiveRecord::Migration[7.0]
  def change
    change_table :items do |t|
      t.string :important
    end
  end
end
