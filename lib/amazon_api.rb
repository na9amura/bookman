module AmazonApi
  ACCESS_KEY_ID = Rails.application.secrets.amazon_associate_access_key
  SECRET_KEY = Rails.application.secrets.amazon_associate_secret_key
  ENDPOINT = 'webservices.amazon.co.jp'
  REQUEST_URI = '/onca/xml'

  def self.find_books(keywords)
    open(build_url(keywords)) do |file|
      Hash.from_xml(file.read).to_json
    end
  end

  def self.build_url(keywords)
    params = {
      Service: 'AWSECommerceService',
      Operation: 'ItemSearch',
      AWSAccessKeyId: ACCESS_KEY_ID,
      AssociateTag: 'queue00-22',
      SearchIndex: 'Books',
      Keywords: keywords,
      ResponseGroup: 'Images,ItemAttributes,Offers',
      Timestamp: Time.now.gmtime.iso8601,
    }

    # Generate the canonical query
    canonical_query_string = params.sort.collect do |key, value|
      [
        URI.escape(
          key.to_s,
          Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")
        ),
        URI.escape(
          value.to_s,
          Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")
        )
      ].join('=')
    end.join('&')

    # Generate the string to be signed
    string_to_sign = "GET\n#{ENDPOINT}\n#{REQUEST_URI}\n#{canonical_query_string}"

    # Generate the signature required by the Product Advertising API
    signature =
      Base64.encode64(
        OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'),
        SECRET_KEY, string_to_sign)
      ).strip()

    # Generate the signed URL
    "http://#{ENDPOINT}#{REQUEST_URI}?#{canonical_query_string}&Signature=#{URI.escape(signature, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"
  end
end
