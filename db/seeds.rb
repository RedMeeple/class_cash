# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Instructor.create(first_name: "Teacher", last_name: "Teacher", email: "test@test.com", password: "password")

3.times do |n|

  period = Period.create(name: "Test Period #{n+1}", payscale: 20, instructor_id: 1)

  10.times do
    Student.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
        cash: (100..500).to_a.sample, period_id: period.id,
        password: "password")

  end
end

Student.all.each do |student|
  student.update(email: Faker::Internet.safe_email(student.first_name))
end

15.times do
  Job.create(payscale: [20,25,30].sample, student_id: (1..30).to_a.sample,
      description: Faker::Name.title)
end

50.times do |n|
  Student.all.each do |student|
    DailyBalance.create(student_id: student.id, amount: (100..500).to_a.sample,
        date: (Date.today - n))
  end
end

AwardType.create(name: "The Richest", picture: "fa fa-bug")
AwardType.create(name: "Perfect Score Award", picture: "fa fa-graduation-cap")
AwardType.create(name: "The Einstein Award", picture: "fa fa-flask")
AwardType.create(name: "The Peacemaker Award", picture: "fa fa-flag-o")
AwardType.create(name: "The Helping Hands Award", picture: "fa fa-users")

20.times do
  Award.create(student_id: (1..30).to_a.sample, payment: (100..1000).to_a.sample,
  award_type_id: [1, 2, 3, 4, 5].sample, reason: "because")
end

30.times do |n|
  Behavior.create(date: Date.today, well_behaved: [true, false].sample, student_id: n+1)
end

10.times do
  Extra.create(student_id: (1..30).to_a.sample, amount: [100, 150, 200].sample,
      instructor_id: 1, reason: "behaving well")
end

4.times do
  Bonus.create(period_id: [1, 2, 3].sample, reason: "being awesome", amount: 1000)
end

50.times do
  Transaction.create(sender_id: (1..30).to_a.sample, recipient_id: (1..30).to_a.sample,
      amount: (1..10).to_a.sample, reason: "helping me out")
end
