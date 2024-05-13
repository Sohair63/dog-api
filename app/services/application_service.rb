# frozen_string_literal: true

class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def api_request(api_url, method, body = {})
    url = URI(api_url)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = set_request(url, method)

    # Set headers
    request['Content-Type'] = 'application/json'

    request.body = JSON.dump(body) if body.present?

    https.request(request)
  end

  private

  def set_request(url, method)
    if method.eql?(:post)
      Net::HTTP::Post.new(url)
    else
      Net::HTTP::Get.new(url)
    end
  end
end
