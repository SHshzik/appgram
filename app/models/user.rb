class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :phone, uniqueness: true, presence: true
  has_and_belongs_to_many :rooms
  # mount_uploader :attachment, AttachmentUploader
end
