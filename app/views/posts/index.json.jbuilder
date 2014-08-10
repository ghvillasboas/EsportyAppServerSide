json.array!(@posts) do |post|
  json.extract! post, :id, :imagem, :data_hora, :autor, :comments
  json.url post_url(post, format: :json)
end
