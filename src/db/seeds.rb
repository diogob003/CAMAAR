# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Answer.delete_all
Option.delete_all
Question.delete_all
AnsweredForm.delete_all
ClassForm.delete_all
Form.delete_all
Template.delete_all
ClassStudent.delete_all
ClassProfessor.delete_all
ClassGroup.delete_all
Subject.delete_all
User.delete_all

teachers = User.create!([
  {
    name: "Alice Johnson",
    registration: "T1001",
    email: "alice.johnson@example.com",
    role: "professor",
    password: "alice_jabberwock_password"
  },
  {
    name: "Bob Smith",
    registration: "T1002",
    email: "bob.smith@example.com",
    role: "professor",
    password: "bob_horse_password"
  }
])

students = User.create!([
  {
    name: "Charlie Brown",
    registration: "S2001",
    email: "charlie.brown@example.com",
    role: "student",
    password: "charlie_bettery_password"
  },
  {
    name: "Diana Prince",
    registration: "S2002",
    email: "diana.prince@example.com",
    role: "student",
    password: "diana_scorpion_password"
  }
])

subject_names = [
  "Mathematics",
  "Physics",
  "Chemistry",
  "Biology",
  "History"
]

subjects = []
class_groups = []

subject_names.each_with_index do |name, i|
  subject = Subject.create!(name: name, code: "SUB#{i+1}00")
  subjects << subject
  class_group = ClassGroup.create!(subject: subject, number: 1, semester: "2025.1")
  class_groups << class_group

  ClassProfessor.create!(professor: teachers[i % teachers.size], class_group: class_group)
end

class_groups.each do |cg|
  students.each do |student|
    ClassStudent.create!(student: student, class_group: cg)
  end
end

template1 = Template.create!(title: "Template 1", description: "Desc template1", creator: teachers[0]) # TODO: usar um admin
template2 = Template.create!(title: "Template 2", description: "Desc template2", creator: teachers[1]) # TODO: usar um admin

q1 = Question.create!(template: template1, title: "How do you rate the class environment?", order: 1)
q2 = Question.create!(template: template1, title: "Was the material clear?", order: 2)
q3 = Question.create!(template: template1, title: "Any suggestions for improvement?", order: 3)

Option.create!([
                 { question: q1, description: "Excellent", order: 1 },
                 { question: q1, description: "Good", order: 2 },
                 { question: q1, description: "Average", order: 3 },
                 { question: q1, description: "Poor", order: 4 }
               ])

Option.create!([
                 { question: q2, description: "Yes", order: 1 },
                 { question: q2, description: "No", order: 2 }
               ])

q4 = Question.create!(template: template2, title: "How engaging was the teacher?", order: 1)
q5 = Question.create!(template: template2, title: "Rate the difficulty of the subject.", order: 2)
q6 = Question.create!(template: template2, title: "Comments about the class?", order: 3)

Option.create!([
                 { question: q4, description: "Very engaging", order: 1 },
                 { question: q4, description: "Somewhat engaging", order: 2 },
                 { question: q4, description: "Not engaging", order: 3 }
               ])

Option.create!([
                 { question: q5, description: "Easy", order: 1 },
                 { question: q5, description: "Moderate", order: 2 },
                 { question: q5, description: "Hard", order: 3 }
               ])

form1 = Form.create!(template: template1, publisher: teachers[0]) # TODO: usar um admin
form2 = Form.create!(template: template2, publisher: teachers[1]) # TODO: usar um admin

class_groups.each_with_index do |cg, idx|
  form = idx.even? ? form1 : form2
  ClassForm.create!(class_group: cg, form: form)
end

answered_form1 = AnsweredForm.create!(user: students[0], form: form1)
answered_form2 = AnsweredForm.create!(user: students[1], form: form2)

Answer.create!([
  {
    answered_form: answered_form1,
    question: q1,
    option_id: q1.options.first.id,
    justification: nil
  },
  {
    answered_form: answered_form1,
    question: q2,
    option_id: nil,
    justification: "The material was very clear and easy to follow."
  },
  {
    answered_form: answered_form1,
    question: q3,
    option_id: nil,
    justification: "More group activities would be great."
  }
])

Answer.create!([
  {
    answered_form: answered_form2,
    question: q4,
    option_id: q4.options.last.id,
    justification: nil
  },
  {
    answered_form: answered_form2,
    question: q5,
    option_id: q5.options[1].id,
    justification: nil
  },
  {
    answered_form: answered_form2,
    question: q6,
    option_id: nil,
    justification: "The class was interesting, but could use more examples."
  }
])

puts "Seeding completed successfully!"
