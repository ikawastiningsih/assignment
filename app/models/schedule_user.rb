class ScheduleUser
  include Mongoid::Document
  include Mongoid::Timestamps
  field :user_id, type: String
  field :schedule_id, type: String
  field :nama_user, type: String
  field :keluhan, type: String
end
