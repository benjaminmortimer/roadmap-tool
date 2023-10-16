class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.belongs_to :roadmap
      t.belongs_to :cycle
    end
  end
end
