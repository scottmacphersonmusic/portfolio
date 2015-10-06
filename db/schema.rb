ActiveRecord::Schema.define(version: 20150928023919) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "author_id"
    t.boolean  "published"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "commenter_name"
    t.string   "commenter_url"
    t.string   "commenter_email"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.text     "content"
    t.boolean  "approved",         default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "commentable_id"
    t.string   "commentable_type"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "technologies_used"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "image_url"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "role"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
