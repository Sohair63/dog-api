class DogBreed
  include ActiveModel::API

  attr_accessor :name

  validates :name, presence: true
end
