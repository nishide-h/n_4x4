# frozen_string_literal: true

class Sheet < ApplicationRecord
  enum status: {
    make_task: 0,
    select_1: 1,
    select_2: 2,
    select_3: 3,
    finished: 4
  }

  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
end
