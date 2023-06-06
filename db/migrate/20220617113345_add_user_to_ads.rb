class AddUserToAds < ActiveRecord::Migration[6.0]
  def change
    add_reference :ads, :user, null: false, foreign_key: true
  end
end
