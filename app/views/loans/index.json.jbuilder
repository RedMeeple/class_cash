json.array!(@loans) do |loan|
  json.extract! loan, :id, :student_id, :recipient_id, :amount, :interest, :end_date, :accepted, :weeks
  json.url loan_url(loan, format: :json)
end
