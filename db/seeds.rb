# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Instructor.create(first_name: "Teacher", last_name: "Teacher", email: "test@test.com", password: "password")

10.times do
  Student.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
      email: Faker::Internet.email, cash: (1..100).to_a.sample, period_id: 1,
      password: "password")

end

Period.create(name: "Test", payscale: 20, instructor_id: 1)

10.times do
  Job.create(payscale: [20,25,30].sample, student_id: (1..10).to_a.sample,
      description: "Class Job")
end
