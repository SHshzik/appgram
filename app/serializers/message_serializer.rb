class MessageSerializer
  include FastJsonapi::ObjectSerializer
  set_type :message
  attributes :msg, :status, :sender_id, :created_at, :updated_at
end
