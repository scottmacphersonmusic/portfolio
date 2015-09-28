class AddDefaultValueToCommentApproved < ActiveRecord::Migration
  def change
    change_column :comments, :approved, :boolean, default: false
  end
end
