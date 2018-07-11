class DogBreedFetcher
  attr_reader :breed

  def initialize(name=nil)
    @name  = name || "random"
    @breed = Breed.find_or_initialize_by(name: name)
  end

  def fetch
    return @breed if @breed.pic_url.present?

    @breed.pic_url = fetch_info["message"]
    @breed.save && @breed
  end

  def self.fetch(name=nil)
    name ||= "random"
    DogBreedFetcher.new(name).fetch
  end

private
  def fetch_info
    begin
      JSON.parse(RestClient.get("https://dog.ceo/api/breeds/image/#{ @name }").body)
    rescue Object => e
      default_body
    end
  end

  def default_body
    {
      "status"  => "success",
      "message" => "https://images.dog.ceo/breeds/cattledog-australian/IMG_2432.jpg"
    }
  end
end
