json.array!(@awards) do |award|
  json.extract! award, :id, :student_id, :award_type, :reason, :payment
  json.url award_url(award, format: :json)
end
