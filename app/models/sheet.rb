# frozen_string_literal: true

class Sheet < ApplicationRecord
  enum status: [
    :make_task,
    :select_1,
    :select_2,
    :select_3,
    :finished
  ]

  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
end
