json.array!(@jobs) do |job|
  json.extract! job, :id, :student_id, :description, :payscale
  json.url job_url(job, format: :json)
end
