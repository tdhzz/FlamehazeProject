# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180202142148) do

  create_table "article_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "article_id", null: false
    t.bigint "creator_id", null: false
    t.string "content", limit: 200, null: false
    t.bigint "parent_comment_id"
    t.boolean "enabled", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "fk_article_comments_reference_article_id"
    t.index ["creator_id"], name: "fk_article_comments_reference_creator_id"
    t.index ["parent_comment_id"], name: "fk_article_comments_reference_parent_comment_id"
  end

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "creator_id", null: false
    t.text "content", null: false
    t.boolean "enabled", default: true, null: false
    t.integer "read_times", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "fk_articles_reference_creator_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 20, null: false
    t.boolean "enabled", default: true, null: false
    t.integer "uid", null: false
    t.integer "level", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "article_comments", "article_comments", column: "parent_comment_id", name: "fk_article_comments_reference_parent_comment_id"
  add_foreign_key "article_comments", "articles", name: "fk_article_comments_reference_article_id"
  add_foreign_key "article_comments", "users", column: "creator_id", name: "fk_article_comments_reference_creator_id"
  add_foreign_key "articles", "users", column: "creator_id", name: "fk_articles_reference_creator_id"
end
