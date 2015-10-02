# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


instructor = Instructor.create(first_name: "Teacher", last_name: "Teacher", email: "test@test.com", password: "password")

3.times do |n|

  period = Period.new(name: "Test Period #{n+1}", payscale: 20, instructor_id: instructor.id)

  10.times do
    Student.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
        cash: (100..500).to_a.sample, period_id: n+1,
        password: "password", can_loan: true, email: Faker::Internet.email)

  end

  period.save(validate: false)
end



Student.all.each do |student|
  10.times do |n|
    DailyBalance.create(student_id: student.id, amount: (1000..5000).to_a.sample / (n + 1),
        date: (Date.today - n))
    Behavior.create(date: Date.today - n, well_behaved: [true, false].sample, student_id: student.id)
  end
  student.update(email: Faker::Internet.safe_email(student.first_name))
  Transaction.create(student_id: student.id, recipient_id: student.id + 1,
      amount: (1..10).to_a.sample, reason: "helping me out")
  Extra.create(student_id: student.id, amount: [100, 150, 200].sample,
      instructor_id: 1, reason: "behaving well")
  Loan.create(student_id: student.id, recipient_id: student.id + 1, amount: 50, weeks: 8, end_date: Date.today + 56, balance: 50, accepted: true, interest: 5)
end

4.times do
  Bonus.create(period_id: [1, 2, 3].sample, reason: "being awesome", amount: 1000)
end
