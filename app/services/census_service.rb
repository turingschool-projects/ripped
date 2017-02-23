class CensusService
  def initialize(token)
    @token = token
    @conn = Faraday.new(url: "https://turing-census.herokuapp.com") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params[:access_token] = token
    end
  end

  def get_users
    response = conn.get("/api/v1/users")
    if response.status == 200
      parsed = JSON.parse(response.body, symbolize_names: true)
    else
      parsed = "Error."
    end
  end

  def get_one_user(id)
    response = conn.get("/api/v1/users/#{id}")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  private
  attr_reader :token, :conn
end
