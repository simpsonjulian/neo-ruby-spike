Neo4j::Session.open(:server_db, 'http://localhost:7474', {basic_auth: {username: 'neo4j', password: 'secret'}})