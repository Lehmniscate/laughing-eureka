class Api::PokemonController < ApplicationController
  def index
    @pokemon = Pokemon.all
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    if @pokemon.save
      render json: @pokemon
    else
      puts "We failed!!!"
      render json: @pokemon.errors.full_messages, status: 406
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :attack, :defense, :poke_type,
                                    :image_url, moves: [])
  end

end
