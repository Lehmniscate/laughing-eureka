import { connect } from 'react-redux';
import { selectPokemonItem } from "../../reducers/selectors.js";
import { fetchOnePokemon } from "../../actions/pokemon_actions.js";
import ItemDetail from "./item_detail.jsx";

const mapStateToProps = (state, ownProps ) => ({
  item: selectPokemonItem(state, ownProps.params.itemId)
});

export default connect(
  mapStateToProps,
  null
)(ItemDetail);
