# frozen_string_literal: true

class Dog
  include ActiveModel::API

  attr_accessor :breed

  validates :breed, presence: true
end
