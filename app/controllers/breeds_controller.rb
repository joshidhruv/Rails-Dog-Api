class BreedsController < ApplicationController

  def index
    @breedTypes = BreedFetcher.new.fetch
    @breedJson = convertToJson(getBreedFetcher['message'])
    @breed = DogBreedFetcher.fetch
  end

  def getImage
    @breedTypes = 
    @breedJson = convertToJson(getBreedFetcher['message'])
    @selected_breed_type = params[:breedType]
    @breed = DogBreedFetcher.fetch(@selected_breed_type)
    render :index
  end

  def convertToJson(json_array)
    array = []
    json_array.each do |object|
      new_json = {"id" => object[0], "value" => object[0]}
      array.push(new_json)
    end
    return array
  end

  def getBreedFetcher
    BreedFetcher.new.fetch
  end

end
