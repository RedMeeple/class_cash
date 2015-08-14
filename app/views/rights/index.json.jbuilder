json.array!(@rights) do |right|
  json.extract! right, :id, :cash_level, :description, :teacher_id
  json.url right_url(right, format: :json)
end
