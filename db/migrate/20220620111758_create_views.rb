class CreateViews < ActiveRecord::Migration[6.0]
  def change
    create_table :views do |t|
      t.integer :total , :default => 0
      t.string :plateforms
      t.string :useragents

      t.timestamps
    end
  end
end
