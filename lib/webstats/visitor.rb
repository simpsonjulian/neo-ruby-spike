class Visitor
  include Neo4j::ActiveNode
  property :address, constraint: :unique
  property :version, default: 4
end