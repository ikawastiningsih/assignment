class Hospital
  include Mongoid::Document
  include Mongoid::Timestamps
  # has_many :schedules
  # has_many :doctors, through: :schedules

  field :nama, type: String
  field :alamat, type: String
  field :notelp, type: String
end
