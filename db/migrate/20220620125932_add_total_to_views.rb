class AddTotalToViews < ActiveRecord::Migration[6.0]
  def change
    add_column :views, :total_views, :integer, :default => 0
  end
end
