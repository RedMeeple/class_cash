json.array!(@students) do |student|
  json.extract! student, :id, :first_name, :last_name, :email, :cash, :period_id, :password_digest, :good_behevior, :richest
  json.url student_url(student, format: :json)
end
