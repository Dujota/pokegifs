class PokemonController < ApplicationController

  def show
    pokemon_api_result = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    pokemon_api_body = JSON.parse(pokemon_api_result.body)
    # binding.pry
    # poke_data = {
    # name = pokemon_api_body["name"],
    # id = pokemon_api_body["id"],
    # type = pokemon_api_body["types"].map { |type| type["type"]["name"] }}

    # assign the output of the pokemon info to a variable to be called on when we render the json
    pokemon_info = {
      id: pokemon_api_body["id"],
      name: pokemon_api_body["name"],
      types: pokemon_api_body["types"].map { |type|
               type["type"]["name"]
             }
    }

    giphy_results = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{pokemon_api_body["name"]}&rating=g")

    giphy_body = JSON.parse(giphy_results.body)

    giphy_url = giphy_body["data"].sample["url"] # look at the data array, get a random object and get its url

    # binding.pry
    render json: { pokemon: pokemon_info, "gif": giphy_url } # creates a pokemon hash with the nested hash containing the polemon_info
  end
end
