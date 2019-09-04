json.array! @player do |player|
  json.partial! 'player', player: player
end