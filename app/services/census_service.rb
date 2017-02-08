class CensusService
  def initialize(token)
    @token = token
    @conn = Faraday.new(url: "https://census-app-staging.herokuapp.com/api/v1") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params[:access_token] = token
    end
  end

  def get_users
    response = conn.get("/users")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def get_one_user(id)
    response = conn.get("/users/#{id}")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  private
  attr_reader :token, :conn
end
