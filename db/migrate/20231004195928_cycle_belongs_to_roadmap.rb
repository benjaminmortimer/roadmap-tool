class CycleBelongsToRoadmap < ActiveRecord::Migration[7.0]
  def change
    change_table :cycles do |t|
      t.belongs_to :roadmap
    end
  end
end
