class CreateAds < ActiveRecord::Migration[6.0]
  def change
    create_table :ads do |t|
      t.string :title
      t.string :featured
      t.string :brand_name
      t.string :location
      t.string :transmission_type
      t.integer :price
      t.string :leased

      t.timestamps
    end
  end
end
