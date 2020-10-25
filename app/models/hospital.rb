class Hospital
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :schedule
  has_many :doctor, through: :schedule

  field :nama, type: String
  field :alamat, type: String
  field :notelp, type: String
end
