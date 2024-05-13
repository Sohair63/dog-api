# frozen_string_literal: true

class DogsController < ApplicationController
  def new; end

  def create
    @dog = Dog.new(dog_params)

    if @dog.valid?
      @result = DogApi::GenerateImage.call(@dog.breed)

      render turbo_stream: turbo_stream.update('dog-image-container', partial: 'response')
    else
      render turbo_stream: turbo_stream.update('dog-image-container', partial: 'error_message')
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:breed)
  end
end
