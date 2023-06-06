class View < ApplicationRecord
  validates :plateforms, presence: true 
  validates :useragents, presence: true

  
  belongs_to :ad
end
