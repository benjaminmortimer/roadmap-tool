# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_16_220354) do
  create_table "cycles", force: :cascade do |t|
    t.string "title"
    t.integer "roadmap_id"
    t.string "start_date"
    t.string "end_date"
    t.index ["roadmap_id"], name: "index_cycles_on_roadmap_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "roadmap_id"
    t.integer "cycle_id"
    t.string "important"
    t.index ["cycle_id"], name: "index_items_on_cycle_id"
    t.index ["roadmap_id"], name: "index_items_on_roadmap_id"
  end

  create_table "roadmaps", force: :cascade do |t|
    t.string "title"
  end

end
