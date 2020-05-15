# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
if Rails.env.development?
  User.find_or_create_by!(email: 'admin@example.com') do |admin|
    admin.identity_number = '77777777'
    admin.name = 'Magic Admin'
    admin.gender = 0
    admin.birth_date = DateTime.civil_from_format :local, 2007, 07, 07
    admin.password = 'password'
    admin.admin = true
  end
end

Question.create(title: "How can i do a question?", description: "Question body ....")