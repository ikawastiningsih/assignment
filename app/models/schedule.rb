class Schedule
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :doctor
  belongs_to :hospital

  field :doctor_id, type: String
  field :hospital_id, type: String
  field :hari, type: String
  field :jam_mulai, type: String
  field :jam_selesai, type: String
end
