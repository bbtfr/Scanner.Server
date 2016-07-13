defmodule Scanner.NewsTest do
  use Scanner.ModelCase

  alias Scanner.News

  @valid_attrs %{author: "some content", content: "some content", thumbnail_url: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = News.changeset(%News{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = News.changeset(%News{}, @invalid_attrs)
    refute changeset.valid?
  end
end
