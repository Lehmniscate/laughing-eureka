json.partial! 'api/parties/party', party: @party
json.guests do
  json.array! @party.guests.includes([:gifts]) do |guest|
    json.name guest.name
    json.age guest.age
    json.favorite_color guest.favorite_color
    json.gifts do
      json.array! guest.gifts do |gift|
        json.title gift.title
        json.description gift.description
      end
    end
  end
end
