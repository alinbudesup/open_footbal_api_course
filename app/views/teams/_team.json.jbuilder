# frozen_string_literal: true

json.extract! team, :id, :name
json.set! :manager do
  json.set! :first_name, team&.manager&.first_name
  json.set! :last_name, team&.manager&.last_name
  json.set! :age, team&.manager&.age
end

json.set! :players do
  json.array! team.players do |player|
    json.set! :name, player&.name
    json.set! :age, player&.age
  end
end

json.set! :logo_url do
  json.array! team.logos do |logo|
    json.set! :url, rails_blob_url(logo)
  end
end


# json.set! :logo_url, rails_blob_url(team.logo)
