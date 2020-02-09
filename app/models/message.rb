class Message < ApplicationRecord
  belongs_to :room
  attribute :status, :boolean, default: false
  # status, default = false
end
