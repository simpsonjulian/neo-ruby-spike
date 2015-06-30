
class Page
  include Neo4j::ActiveNode
  property :url, constraint: :unique
  has_many :in, :visitors, unique: true, type: :VISITED
end