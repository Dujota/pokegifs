class PokemonController < ApplicationController

  def show
    pokemon_api_result = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    pokemon_api_body = JSON.parse(pokemon_api_result.body)
    # binding.pry
    # poke_data = {
    # name = pokemon_api_body["name"],
    # id = pokemon_api_body["id"],
    # type = pokemon_api_body["types"].map { |type| type["type"]["name"] }}

    pokemon_info = {
      id: pokemon_api_body["id"],
      name: pokemon_api_body["name"],
      types: pokemon_api_body["types"].map { |type|
               type["type"]["name"]
             }
    }

    render json: { pokemon: pokemon_info }
  end
end
