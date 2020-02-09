class Message < ApplicationRecord
  belongs_to :room
  attribute :status, :bool, default: false
  # status, default = false
end
