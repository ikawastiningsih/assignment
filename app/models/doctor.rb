class Doctor
  include Mongoid::Document
  include Mongoid::Timestamps
  # belongs_to :schedules, foreign_key: :doctor_id
  # has_many :hospital, through: :schedule

  field :nama, type: String
  field :nohp, type: String
  field :email, type: String
  field :jenis_kelamin, type: String
  field :spesialis, type: String
end
