json.array!(@periods) do |period|
  json.extract! period, :id, :instructor_id, :payscale, :name
  json.url period_url(period, format: :json)
end
