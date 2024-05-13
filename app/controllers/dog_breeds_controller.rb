# frozen_string_literal: true

class DogBreedsController < ApplicationController
  def new
    @dog_breed = DogBreed.new
  end

  def create
    @dog_breed = DogBreed.new(dog_breed_params)

    if @dog_breed.valid?
      @result = DogApi::GenerateImage.call(@dog_breed.name)

      render turbo_stream: turbo_stream.update('dog-image-container', partial: 'response')
    else
      render turbo_stream: turbo_stream.update('dog-image-container', partial: 'error_message')
    end
  end

  private

  def dog_breed_params
    params.require(:dog_breed).permit(:name)
  end
end
