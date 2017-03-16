class Photo < ActiveRecord::Base
  has_many :comments

  validates :name, presence: true #model validation, ensures every photo will have a name
                                 #and name will not be an empty string

end
