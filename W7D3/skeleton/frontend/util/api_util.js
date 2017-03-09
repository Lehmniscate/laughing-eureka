export const fetchAllPokemon = () => {
  return $.ajax({
    url: "api/pokemon",
    method: "GET"
  });
};

export const fetchOnePokemon = (pokemonId) => {
  let urlId = `api/pokemon/${pokemonId}`;
  return $.ajax({
    url: urlId,
    method: "GET"
  });
};

export const createPokemon = (pokemon) => {
  return $.ajax({
    url: "/api/pokemon/",
    method: "POST",
    data: pokemon
  });
};
