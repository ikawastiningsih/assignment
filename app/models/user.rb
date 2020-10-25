class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :nama, type: String
  field :jenis_kelamin, type: String
  field :nohp, type: String
  field :email, type: String
  field :tempat_lahir, type: String
  field :tanggal_lahir, type: String
  field :username, type: String
  field :password, type: String
end
