require 'test_helper'

class ArticleCreationTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "joe", email: "joe@example.com", password: "password")
  end

  test "get new article form and create article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: "Test Article", description: "Test Description"}
    end
    assert_template 'articles/show'
    assert_match "Test Article", response.body
  end

  test "invalid article submission results in failure" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post_via_redirect articles_path, article: {title: "T", description: "Test Description"}
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
