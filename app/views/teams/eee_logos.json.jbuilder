json.extract! @logos_arr

json.set! :logo_url do
  json.array! @logos_arr do |logo|
    json.set! :url, rails_representation_url(logo)
  end
end