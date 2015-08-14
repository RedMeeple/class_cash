# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

instructor = Instructor.create(first_name: "Teacher", last_name: "Teacher", email: "test@test.com", password: "password")

3.times do |n|

  period = Period.create(name: "Test Period #{n+1}", payscale: 20, instructor_id: instructor.id)

  10.times do
    Student.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
        cash: (100..500).to_a.sample, period_id: period.id,
        password: "password", can_loan: true, email: Faker::Internet.email)

  end
end

15.times do
  Job.create(payscale: [20,25,30].sample, student_id: (2..31).to_a.sample,
      description: Faker::Name.title)
end

Student.all.each do |student|
  50.times do |n|
    DailyBalance.create(student_id: student.id, amount: (100..500).to_a.sample,
        date: (Date.today - n))
    Behavior.create(date: Date.today - n, well_behaved: [true, false].sample, student_id: student.id)
  end
  student.update(email: Faker::Internet.safe_email(student.first_name))
  Transaction.create(student_id: student.id, recipient_id: (2..31).to_a.sample,
      amount: (1..10).to_a.sample, reason: "helping me out")
end

AwardType.create(name: "The Richest", picture: "fa fa-trophy")
AwardType.create(name: "Perfect Score Award", picture: "fa fa-graduation-cap")
AwardType.create(name: "The Einstein Award", picture: "fa fa-flask")
AwardType.create(name: "The Peacemaker Award", picture: "fa fa-flag-o")
AwardType.create(name: "The Helping Hands Award", picture: "fa fa-users")

20.times do
  Award.create(student_id: (2..31).to_a.sample, payment: (100..1000).to_a.sample,
  award_type_id: [1, 2, 3, 4, 5].sample, reason: "because")
end

10.times do
  Extra.create(student_id: (2..31).to_a.sample, amount: [100, 150, 200].sample,
      instructor_id: 1, reason: "behaving well")
end

4.times do
  Bonus.create(period_id: [1, 2, 3].sample, reason: "being awesome", amount: 1000)
end

5.times do
  Loan.create(student_id: (2..31).to_a.sample, recipient_id: (2..31).to_a.sample,
  amount: 50, end_date: Date.today+30, balance: 50, accepted: true, interest: 5)
end

Right.create(description: "Eating in class")
Right.create(description: "Drinking in class")
Right.create(description: "Chewing gum in class")
Right.create(description: "Be at the beginning of the line for lunch")


StudentRightAssignment.create(student_id: 2, right_id: 1, cash_level: 1000)
