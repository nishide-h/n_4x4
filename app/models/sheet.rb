# frozen_string_literal: true

class Sheet < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
end
