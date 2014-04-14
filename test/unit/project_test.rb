require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  should 'have an original language' do
    p = Project.new :name => 'test', :language_id => 1, :owner_id => 1
    p.valid?
    assert p.errors[:original_language_id.to_s].present?

    p.original_language_id = 2
    assert ! p.errors[:original_language_id.to_s].present?
  end

  should 'not have same original and destination languages' do
    p = Project.new :name => 'test', :language_id => 1, :original_language_id => 1, :owner_id => 1
    p.valid?
    assert p.errors[:original_language_id.to_s].present? or p.errors[:language_id.to_s].present?

    p.language_id = 2
    assert ! p.errors[:original_language_id.to_s].present? and ! p.errors[:language_id.to_s].present?
  end
end
