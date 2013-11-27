# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :project_file do
    status 'upload'
    attachment { fixture_file_upload("#{Rails.root}/spec/files/style.css", "text/css") }
  end
end
