# frozen_string_literal: true

module DogApi
  class GenerateImage < ApplicationService
    API_URL = 'https://dog.ceo/api/breed/%s%s/images/random'

    attr_reader :breed, :sub_breed

    def initialize(breed)
      @breed, @sub_breed =
        breed
        .to_s
        .humanize
        .parameterize
        .split('-')
        .collect(&:downcase)
    end

    def call
      response = api_request(api_url, :get)

      parsed_response = JSON.parse(response.body)
      if response.message == 'OK'
        Result.new(parsed_response)
      else
        Result.new(parsed_response, status: :not_found)
      end
    end

    private

    def api_url
      @api_url ||= API_URL % (sub_breed.present? ? [breed, "/#{sub_breed}"] : [breed, ''])
    end
  end
end
