require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "joe", email: "joe@example.com", password: "password")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "user name should be present" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "username should be unique" do
    @user.save
    @user2 = User.new(username: "joe", email: "joe_fake@example.com", password: "password")
    assert_not @user2.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should be unique" do
    @user.save
    @user2 = User.new(username: "joe_fake", email: "joe@example.com", password: "password")
    assert_not @user2.valid?
  end

  test "email should be valid" do
    @user.email = "joe.com"
    assert_not @user.valid?
  end

end