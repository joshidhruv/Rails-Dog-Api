class BreedFetcher
  def initialize
  end

  def fetch
    fetch_info
  end

  def fetch_info
    begin
      JSON.parse(RestClient.get("https://dog.ceo/api/breeds/list/all").body)
    rescue Object => e
      default_body
    end
  end
  
  def default_body
    {
      "status"  => "failure",
      "message" => "Please refresh or Check the api response"
    }
  end
end
