require 'spec_helper'

describe ProjectFile do
  it { should have_attached_file(:attachment) }
  it { should validate_attachment_presence(:attachment) }
  it { should validate_attachment_content_type(:attachment).allowing('text/css').rejecting('image/png', 'image/gif', 'image/jpeg') }
  it { should validate_attachment_size(:attachment).less_than(10.megabytes) }
end
