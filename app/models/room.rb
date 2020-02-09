class Room < ApplicationRecord
  has_many :messages
  has_and_belongs_to_many :users # TODO: add require
end
