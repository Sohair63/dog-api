class DogApi::GenerateImage < ApplicationService
  API_URL = 'https://dog.ceo/api/breed/%s/images/random'

  attr_reader :breed_name

  def initialize(breed_name)
    @breed_name = breed_name
  end

  def call
    api_url = API_URL % breed_name
    response = api_request(api_url, :get)

    parsed_response = JSON.parse(response.body)
    if response.message == 'OK'
      Result.new(parsed_response)
    else
      Result.new(parsed_response, status: :not_found)
    end
  end
end
