import React from 'react';

const ItemDetail = props => {
  return (
    <div className="item-detail">
      <h4>{props.item.name}</h4>
      <div>
        <div>
          <img src={props.item.image_url} />
        </div>
        <div>
          <span>☺ {props.item.happiness}</span>
          <span>${props.item.price}</span>
        </div>
      </div>
    </div>
  );
};

export default ItemDetail;
