json.array!(@loans) do |loan|
  json.extract! loan, :id, :lender_id, :recipient_id, :amount, :interest, :end_date, :accepted
  json.url loan_url(loan, format: :json)
end
