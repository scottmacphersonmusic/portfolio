class ChangeCommentToCommentable < ActiveRecord::Migration
  def change
    remove_column :comments, :article_id, :integer
    add_column :comments, :commentable_id, :integer
    add_index :comments, :commentable_id
    add_column :comments, :commentable_type, :string
  end
end
