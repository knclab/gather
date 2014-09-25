json.array!(@categories) do |category|
  json.extract! category, :id
  json.url test_url(category, format: :json)
end
