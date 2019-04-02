# frozen_string_literal: true

class Sheet < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
end
