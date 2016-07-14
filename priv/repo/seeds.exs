# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Scanner.Repo.insert!(%Scanner.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

lorem = """
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"""

alias Scanner.{Repo, News}
for i <- 1..20, type <- ~w(policies notifications services) do
  Repo.insert! %News{content: lorem, title: "测试新闻 #{i}", subtitle: "测试新闻副标题 #{i}", type: type, author: "Theo", thumbnail_url: "http://placehold.it/200x150"}
end


