class CreateResources < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter_name
      t.string :commenter_url
      t.string :commenter_email
      t.string :user_ip
      t.string :user_agent
      t.string :referrer
      t.text :content
      t.boolean :approved
      t.belongs_to :article, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
