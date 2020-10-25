class Schedule
  include Mongoid::Document
  include Mongoid::Timestamps
  field :doctor_id, type: String
  field :hospital_id, type: String
  field :jam_mulai, type: String
  field :jam_selesai, type: String
end
