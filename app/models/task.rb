class Task < ApplicationRecord
  belongs_to :sheet
  
  validates :name, presence: true
end
