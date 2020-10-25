class Doctor
  include Mongoid::Document
  include Mongoid::Timestamps
  field :nama, type: String
  field :nohp, type: String
  field :email, type: String
  field :jenis_kelamin, type: String
  field :spesialis, type: String
end
