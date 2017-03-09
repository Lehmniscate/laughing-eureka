import React from "react";
import { Link } from 'react-router';

const PokemonIndexItem = ({ pokemon: p }) => {
  return (
    <li className="all-pokemon-name" key={p.name}>
      <Link to={`/pokemon/${p.id}`}>
        <span>
          {p.id}
        </span>
        <img className="all-pokemon-image" src={p.image_url} />
        {p.name}
      </Link>
    </li>
  );
};

export default PokemonIndexItem;
