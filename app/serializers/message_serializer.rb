class MessageSerializer
  include FastJsonapi::ObjectSerializer
  set_type :message
  attributes :created_at, :updated_at  # , :last_message
end
