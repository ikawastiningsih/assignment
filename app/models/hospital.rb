class Hospital
  include Mongoid::Document
  include Mongoid::Timestamps
  field :nama, type: String
  field :alamat, type: String
  field :notelp, type: String
end
